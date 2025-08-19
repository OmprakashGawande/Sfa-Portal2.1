<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="assets/images/favicon.png" type="image/x-icon" />
    <title>Log in</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Google font-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css" asp-append-version="true">
    <!-- ico-font-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/icofont.css" asp-append-version="true">
    <!-- Themify icon-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/themify.css" asp-append-version="true">
    <!-- Flag icon-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/flag-icon.css" asp-append-version="true">
    <!-- Feather icon-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/feather-icon.css" asp-append-version="true">
    <!-- Bootstrap css-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/bootstrap.css" asp-append-version="true">
    <!-- App css-->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" asp-append-version="true">
    <link id="color" rel="stylesheet" href="assets/css/color-1.css" media="screen" asp-append-version="true">
    <!-- Responsive css-->
    <link rel="stylesheet" type="text/css" href="assets/css/responsive.css" asp-append-version="true">
    <style>
        body {
            background-image: url('assets/images/login/SFA_LOGIN.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .login-card {
            border-radius: 10px;
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        .login-main {
            text-align: left;
            background-color: #ffffffde;
            backdrop-filter: blur(10px);
            border: 1px solid white;
        }

        .logo img {
            height: 80px;
            max-width: 100%;
        }

        .input-group {
            display: flex;
            align-items: center;
        }

        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-right: none;
            border-radius: 0.25rem 0.25rem 0.25rem 0.25rem;
            padding: 0.55rem 0.75rem;
        }

        .input-group .form-control {
            border-radius: 0 0.25rem 0.25rem 0;
        }

        .toggle-password {
            cursor: pointer;
            margin-left: -30px;
        }

        /* Media queries for responsiveness */
        @media (max-width: 576px) {
            body {
                background-position: top center;
            }

            .login-card {
                max-width: 100%;
                border-radius: 0;
                margin: 0;
                padding: 15px;
            }

            h4 {
                font-size: 1.25rem;
            }

            .form-group label {
                font-size: 0.875rem;
            }

            .btn {
                font-size: 0.875rem;
            }

            .logo img {
                height: 60px;
            }

            .mt-4, .mt-5 {
                margin-top: 1rem !important;
            }

            .mb-0 {
                margin-bottom: 0.5rem !important;
            }
        }

        @media (max-width: 768px) {
            .login-card .login-main {
                padding: 30px;
                width: 350px;
            }
        }
    </style>
</head>
<body>
    <form id="form2" class="theme-form" runat="server">
        <div class="login-card login-dark">
            <div>
                <div class="login-main">
                    <div>
                        <a class="logo text-center">
                            <img class="img-fluid for-dark" src="assets/images/logo/logoNew.png" alt="loginpage">
                            <img class="img-fluid for-light" src="assets/images/logo/logo_darkNew-1.png" alt="loginpage">
                        </a>
                    </div>

                    <h4>ERP LOGIN</h4>

                    <p>
                        <asp:Label ID="LblMsg" runat="server" ForeColor="red"></asp:Label>
                    </p>
                    <!-- User ID Input Field with Icon -->
                    <div class="form-group">
                        <label class="col-form-label">User ID</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-user"></i>
                            </span>
                            <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="MY ERP CODE" MaxLength="50"></asp:TextBox>
                        </div>
                        <span class="float-end">
                            <asp:RequiredFieldValidator ID="rfvUserId" runat="server" Display="Dynamic" ControlToValidate="txtUserName" Text="<i class='fa fa-exclamation-circle' title='Required to Fill User Name!'></i>" ErrorMessage="Required to Fill User Name!" SetFocusOnError="true" ForeColor="Red" ValidationGroup="Login"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" runat="server" Text="<i class='fa fa-exclamation-circle' title='Invalid UserName Exp. XX0001!'></i>" ControlToValidate="txtUserName" ValidationExpression="^[a-zA-Z0-9]*$" ErrorMessage="Invalid UserName Exp. XX0001" SetFocusOnError="true" ValidationGroup="Login"></asp:RegularExpressionValidator>
                        </span>
                    </div>
                    <!-- Password Input Field with Icon -->
                    <div class="form-group">
                        <label class="col-form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa fa-lock"></i>
                            </span>
                            <asp:TextBox ID="txtUserPassword" runat="server" class="form-control" placeholder="ERP PASSWORD" TextMode="Password" MaxLength="50"></asp:TextBox>
                            <span class="input-group-text toggle-password" onclick="togglePasswordVisibility()">
                                <i id="togglePasswordIcon" class="fa fa-eye"></i>
                            </span>
                        </div>
                        <div class="form-input position-relative">
                            <span class="float-end">
                                <asp:RequiredFieldValidator ID="rfvpass" runat="server" Display="Dynamic" ControlToValidate="txtUserPassword" ErrorMessage="Required to Fill Password!" Text="<i class='fa fa-exclamation-circle' title='Required to Fill Password!'></i>" SetFocusOnError="true" ForeColor="Red" ValidationGroup="Login"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" Display="Dynamic" runat="server" ControlToValidate="txtUserPassword" ValidationExpression="^[a-zA-Z0-9-_@#!*$&^]+$" Text="<i class='fa fa-exclamation-circle' title='Special Character allowed only (-_@#!*$&^).!'></i>" ErrorMessage="Special Character allowed only (-_@#!*$&^)." SetFocusOnError="true" ValidationGroup="Login"></asp:RegularExpressionValidator>
                            </span>
                        </div>
                    </div>
                    <div class="form-group mb-0 mt-5">
                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-block w-100" AccessKey="L" ToolTip="" OnClientClick="return ValidatePage();" OnClick="btnLogin_Click" Text="Login" />
                    </div>
                    <div class="social mt-4">
                        <!-- Social media links commented out -->
                    </div>
                    <p class="mt-4 mb-0 text-center"><a class="ms-2" href="ForgetPassword.aspx">Forgot Password?</a></p>
                </div>
            </div>
        </div>
        <!-- latest jquery-->
        <script src="assets/js/jquery.min.js" asp-append-version="true"></script>
        <!-- Bootstrap js-->
        <script src="assets/js/bootstrap/bootstrap.bundle.min.js" asp-append-version="true"></script>
        <!-- feather icon js-->
        <script src="assets/js/icons/feather-icon/feather.min.js" asp-append-version="true"></script>
        <script src="assets/js/icons/feather-icon/feather-icon.js" asp-append-version="true"></script>
        <!-- Sidebar jquery-->
        <script src="assets/js/config.js" asp-append-version="true"></script>
        <!-- Theme js-->
        <script src="assets/js/script.js" asp-append-version="true"></script>
        <script src="js/sha512.js" asp-append-version="true"></script>
    </form>

    <script>
        function ValidatePage() {
            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate('Login');
            }
            if (Page_IsValid) {
                if (document.getElementById('<%= txtUserPassword.ClientID %>').value.length != 128) {
                    document.getElementById('<%= txtUserPassword.ClientID %>').value =
                        SHA512(SHA512(document.getElementById('<%= txtUserPassword.ClientID %>').value) +
      '<%= ViewState["RandomText"].ToString() %>');
                }
            }
            else {
                if (document.getElementById('<%= txtUserName.ClientID %>').value == "") {
                    $("input[name='txtUserName']").removeClass('TextBoxSuccess');
                    $("input[name='txtUserName']").addClass('TextBoxError');
                }
                else {
                    $("input[name='txtUserName']").removeClass('TextBoxError');
                    $("input[name='txtUserName']").addClass('TextBoxSuccess');
                }
                if (document.getElementById('<%= txtUserPassword.ClientID %>').value == "") {
                    $("input[name='txtUserPassword']").removeClass('TextBoxSuccess');
                    $("input[name='txtUserPassword']").addClass('TextBoxError');
                }
                else {
                    $("input[name='txtUserPassword']").removeClass('TextBoxError');
                    $("input[name='txtUserPassword']").addClass('TextBoxSuccess');
                }
                return false;
            }
        }


    </script>
    <script>
        $(document).ready(function () {
            localStorage.setItem('Cal_Val', "");
        });

        function togglePasswordVisibility() {
            var txtBox = document.getElementById('<%= txtUserPassword.ClientID %>');
            var toggleIcon = document.getElementById('togglePasswordIcon');
            if (txtBox.type === "password") {
                txtBox.type = "text";
                toggleIcon.className = "fa fa-eye-slash";
            } else {
                txtBox.type = "password";
                toggleIcon.className = "fa fa-eye";
            }
        }

    </script>
</body>
</html>
