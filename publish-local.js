const http = require('http');
const net = require('net');
const os = require('os');
const path = require('path');
const { spawn } = require('child_process');

const PROXY_PORT = process.env.PORT || 8080;
const BACKEND_PORT = 53696;
const PROJECT_DIR = __dirname;

// Detect active local IPv4 addresses
function getLocalIPs() {
    const interfaces = os.networkInterfaces();
    const ips = [];
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                ips.push({ name, address: iface.address });
            }
        }
    }
    return ips;
}

// Check if a port is currently open
function isPortOpen(port, host = '127.0.0.1') {
    return new Promise((resolve) => {
        const socket = new net.Socket();
        socket.setTimeout(1500);
        socket.on('connect', () => {
            socket.destroy();
            resolve(true);
        });
        socket.on('timeout', () => {
            socket.destroy();
            resolve(false);
        });
        socket.on('error', () => {
            resolve(false);
        });
        socket.connect(port, host);
    });
}

// Find iisexpress.exe
function getIISExpressPath() {
    const candidates = [
        'C:\\Program Files\\IIS Express\\iisexpress.exe',
        'C:\\Program Files (x86)\\IIS Express\\iisexpress.exe'
    ];
    const fs = require('fs');
    for (const p of candidates) {
        if (fs.existsSync(p)) return p;
    }
    return 'iisexpress.exe';
}

// Ensure IIS Express is running
async function ensureBackend() {
    const open = await isPortOpen(BACKEND_PORT);
    if (open) {
        console.log(`[Backend] IIS Express is already running on port ${BACKEND_PORT}`);
        return null;
    }

    console.log(`[Backend] Starting IIS Express on port ${BACKEND_PORT}...`);
    const iisPath = getIISExpressPath();
    const args = [`/path:${PROJECT_DIR}`, `/port:${BACKEND_PORT}`, `/clr:v4.0`];

    const child = spawn(iisPath, args, {
        cwd: PROJECT_DIR,
        stdio: 'ignore',
        detached: false
    });

    child.on('error', (err) => {
        console.error('[Backend Error] Failed to start IIS Express:', err.message);
    });

    // Wait until port is open
    for (let i = 0; i < 20; i++) {
        await new Promise((r) => setTimeout(r, 500));
        if (await isPortOpen(BACKEND_PORT)) {
            console.log(`[Backend] IIS Express successfully started on port ${BACKEND_PORT}`);
            return child;
        }
    }

    console.warn('[Backend] Warning: Timed out waiting for IIS Express port to open.');
    return child;
}

// Start Proxy Server
async function startServer() {
    const backendProcess = await ensureBackend();

    const server = http.createServer((req, res) => {
        const clientHost = req.headers.host || `localhost:${PROXY_PORT}`;

        const options = {
            hostname: '127.0.0.1',
            port: BACKEND_PORT,
            path: req.url,
            method: req.method,
            headers: {
                ...req.headers,
                host: `localhost:${BACKEND_PORT}` // Crucial for IIS Express
            }
        };

        const proxyReq = http.request(options, (proxyRes) => {
            const headers = { ...proxyRes.headers };

            // Rewrite redirect Location header so client stays on LAN IP
            if (headers.location) {
                headers.location = headers.location.replace(
                    /https?:\/\/(localhost|127\.0\.0\.1):53696/gi,
                    `http://${clientHost}`
                );
            }

            // Remove cookie Domain attribute so cookies bind to the access host
            if (headers['set-cookie']) {
                headers['set-cookie'] = headers['set-cookie'].map((c) =>
                    c.replace(/Domain=[^;]+;?\s*/gi, '')
                );
            }

            res.writeHead(proxyRes.statusCode, headers);
            proxyRes.pipe(res);
        });

        proxyReq.on('error', (err) => {
            console.error(`[Proxy Error] ${req.method} ${req.url}:`, err.message);
            if (!res.headersSent) {
                res.writeHead(502, { 'Content-Type': 'text/html; charset=utf-8' });
                res.end(`<h3>502 Bad Gateway</h3><p>Could not connect to SFA Portal backend on port ${BACKEND_PORT}. Please ensure IIS Express is running.</p>`);
            }
        });

        req.pipe(proxyReq);
    });

    server.listen(PROXY_PORT, '0.0.0.0', () => {
        const ips = getLocalIPs();
        const primaryIP = ips.length > 0 ? ips[0].address : '127.0.0.1';

        console.log('\n============================================================');
        console.log('       SFA-PORTAL 2.1 LOCAL NETWORK SERVER ACTIVE          ');
        console.log('============================================================');
        console.log(`\n> Local Machine URL:`);
        console.log(`  http://localhost:${PROXY_PORT}/mis/Login.aspx`);
        console.log(`\n> Network IP (Mobile / Laptop / LAN URL):`);
        console.log(`  http://${primaryIP}:${PROXY_PORT}/mis/Login.aspx`);
        console.log(`\n> Home Page:`);
        console.log(`  http://${primaryIP}:${PROXY_PORT}/`);

        if (ips.length > 1) {
            console.log(`\n> Other Network Adapters:`);
            ips.slice(1).forEach((ip) => {
                console.log(`  - ${ip.name}: http://${ip.address}:${PROXY_PORT}/mis/Login.aspx`);
            });
        }

        console.log('\n------------------------------------------------------------');
        console.log('Server is running. Press Ctrl+C to stop.');
        console.log('============================================================\n');
    });

    function cleanExit() {
        console.log('\nStopping server...');
        server.close();
        if (backendProcess) {
            try {
                backendProcess.kill();
            } catch (e) {}
        }
        process.exit(0);
    }

    process.on('SIGINT', cleanExit);
    process.on('SIGTERM', cleanExit);
}

startServer();
