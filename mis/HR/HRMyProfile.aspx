<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRMyProfile.aspx.cs" Inherits="mis_HR_HRMyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <!-- FontAwesome & Icon Fallbacks -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../assets/css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="../assets/css/vendors/icofont.css" />
    <link rel="stylesheet" type="text/css" href="../assets/css/vendors/themify.css" />
    <link rel="stylesheet" type="text/css" href="../assets/css/vendors/feather-icon.css" />

    <style>
        /* ==========================================================================
           ULTRA-MODERN EMPLOYEE PROFILE STYLES (SFA PORTAL CUBA THEME)
           ========================================================================== */
        .profile-container {
            padding-bottom: 35px;
        }

        /* RESET ASP.NET DATA CONTROLS TO RENDER MODERN DIV/FLEX LAYOUTS */
        #DVPersonalDetail, #DVPersonalDetail > tbody, #DVPersonalDetail > tbody > tr, #DVPersonalDetail > tbody > tr > td,
        #DVOfficialDetail, #DVOfficialDetail > tbody, #DVOfficialDetail > tbody > tr, #DVOfficialDetail > tbody > tr > td,
        #GVBankDetail, #GVBankDetail > tbody, #GVBankDetail > tbody > tr, #GVBankDetail > tbody > tr > td,
        #GVNomineeDetail, #GVNomineeDetail > tbody, #GVNomineeDetail > tbody > tr, #GVNomineeDetail > tbody > tr > td,
        #GVChildDetail, #GVChildDetail > tbody, #GVChildDetail > tbody > tr, #GVChildDetail > tbody > tr > td,
        #GVFixedAssetsDetail, #GVFixedAssetsDetail > tbody, #GVFixedAssetsDetail > tbody > tr, #GVFixedAssetsDetail > tbody > tr > td,
        #GVOtherDetail, #GVOtherDetail > tbody, #GVOtherDetail > tbody > tr, #GVOtherDetail > tbody > tr > td {
            display: block !important;
            width: 100% !important;
            padding: 0 !important;
            margin: 0 !important;
            border: none !important;
            background: transparent !important;
        }

        /* 1. HERO PROFILE BANNER */
        .hero-profile-card {
            background: linear-gradient(135deg, #1e293b 0%, #2e384d 40%, #7366ff 100%);
            border-radius: 20px;
            padding: 35px 30px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
            box-shadow: 0 12px 30px rgba(115, 102, 255, 0.22);
            margin-bottom: 25px;
        }

        .hero-profile-card::before {
            content: "";
            position: absolute;
            top: -60px;
            right: -60px;
            width: 260px;
            height: 260px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.07);
            pointer-events: none;
        }

        .hero-profile-card::after {
            content: "";
            position: absolute;
            bottom: -90px;
            left: 25%;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.04);
            pointer-events: none;
        }

        .hero-avatar-wrapper {
            position: relative;
            display: inline-block;
        }

        .hero-avatar {
            width: 125px;
            height: 125px;
            border-radius: 50%;
            border: 4px solid #ffffff;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            object-fit: cover;
            background-color: #ffffff;
            transition: transform 0.3s ease;
        }

        .hero-avatar:hover {
            transform: scale(1.05);
        }

        .hero-online-status {
            position: absolute;
            bottom: 8px;
            right: 8px;
            width: 20px;
            height: 20px;
            background-color: #54ba4a;
            border: 3.5px solid #ffffff;
            border-radius: 50%;
            box-shadow: 0 2px 6px rgba(0,0,0,0.25);
        }

        .hero-emp-name {
            font-size: 1.85rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.3px;
            margin-bottom: 8px;
        }

        .hero-badge-pill {
            display: inline-flex;
            align-items: center;
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 0.88rem;
            font-weight: 600;
            margin-right: 8px;
            margin-bottom: 8px;
            backdrop-filter: blur(8px);
        }

        .hero-badge-primary {
            background-color: #ffffff;
            color: #7366ff !important;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }

        .hero-badge-translucent {
            background-color: rgba(255, 255, 255, 0.18);
            color: #ffffff !important;
            border: 1px solid rgba(255, 255, 255, 0.25);
        }

        .hero-chip-row {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }

        .hero-chip {
            display: inline-flex;
            align-items: center;
            background: rgba(0, 0, 0, 0.22);
            padding: 7px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.14);
        }

        .hero-chip i {
            margin-right: 7px;
        }

        .btn-profile-action {
            background: #ffffff;
            color: #7366ff;
            border: none;
            padding: 10px 22px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.18);
            transition: all 0.25s ease;
        }

        .btn-profile-action:hover {
            background: #f8faff;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.25);
            color: #5142f5;
        }

        /* 2. SALARY KPI STAT CARDS */
        .salary-stat-card {
            border: none;
            border-radius: 18px;
            padding: 24px 22px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
            height: 100%;
        }

        .salary-stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.08);
        }

        .stat-card-earnings {
            background: linear-gradient(135deg, #f0fdf4 0%, #e1fae7 100%);
            border: 1px solid #bbf7d0;
        }

        .stat-card-deductions {
            background: linear-gradient(135deg, #fef2f2 0%, #ffe4e6 100%);
            border: 1px solid #fecdd3;
        }

        .stat-card-net {
            background: linear-gradient(135deg, #7366ff 0%, #5949fc 100%);
            color: #ffffff;
            box-shadow: 0 8px 25px rgba(115, 102, 255, 0.32);
        }

        .stat-icon-bubble {
            width: 46px;
            height: 46px;
            border-radius: 13px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-bubble-earnings {
            background: #dcfce7;
            color: #16a34a;
        }

        .stat-bubble-deductions {
            background: #fee2e2;
            color: #dc2626;
        }

        .stat-bubble-net {
            background: rgba(255, 255, 255, 0.22);
            color: #ffffff;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            line-height: 1.2;
            margin: 10px 0 4px 0;
            font-family: 'Outfit', sans-serif;
        }

        .stat-title {
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        /* 3. SECTION CARDS & MODERN INFO TILES */
        .profile-card {
            background: #ffffff;
            border: 1px solid #e9edf4;
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
            margin-bottom: 25px;
            overflow: hidden;
            transition: box-shadow 0.25s ease;
        }

        .profile-card:hover {
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.06);
        }

        .profile-card-header {
            padding: 18px 24px;
            background: #ffffff;
            border-bottom: 1px solid #f1f4f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .profile-card-header h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .profile-card-body {
            padding: 22px;
        }

        /* MODERN ATTRIBUTE TILES */
        .info-tile {
            display: flex;
            align-items: center;
            background: #ffffff;
            border: 1px solid #eef2f7;
            border-radius: 14px;
            padding: 14px 16px;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            height: 100%;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.015);
        }

        .info-tile:hover {
            transform: translateY(-2px);
            border-color: #7366ff;
            box-shadow: 0 6px 18px rgba(115, 102, 255, 0.1);
        }

        .info-tile-icon {
            width: 44px;
            height: 44px;
            min-width: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            margin-right: 14px;
        }

        .tile-icon-purple { background: #f3f0ff; color: #7366ff; }
        .tile-icon-blue   { background: #e8f4fd; color: #1d8cf8; }
        .tile-icon-green  { background: #e6f9ed; color: #00b074; }
        .tile-icon-orange { background: #fff4e5; color: #ff8e29; }
        .tile-icon-pink   { background: #ffe8ee; color: #f73164; }
        .tile-icon-cyan   { background: #e0f7fa; color: #00acc1; }
        .tile-icon-indigo { background: #e8eaf6; color: #3f51b5; }
        .tile-icon-red    { background: #ffebee; color: #e53935; }

        .info-tile-body {
            flex-grow: 1;
            min-width: 0;
        }

        .info-tile-label {
            display: block;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: #8c98a9;
            margin-bottom: 2px;
        }

        .info-tile-value {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: #24292f;
            word-break: break-word;
        }

        /* 4. BANK PASSBOOK CARDS */
        .bank-passbook-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8faff 100%);
            border: 1px solid #dbeafe;
            border-radius: 16px;
            padding: 22px;
            position: relative;
            overflow: hidden;
            margin-bottom: 16px;
            box-shadow: 0 4px 16px rgba(30, 64, 175, 0.05);
            transition: all 0.3s ease;
        }

        .bank-passbook-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(30, 64, 175, 0.12);
            border-color: #7366ff;
        }

        .bank-passbook-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, #7366ff, #3b82f6);
        }

        .bank-avatar-bubble {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: #eef2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }

        .bank-acc-box {
            background: #f1f5f9;
            border: 1px dashed #cbd5e1;
        }

        .bank-acc-display {
            font-family: 'Consolas', 'Courier New', monospace;
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: #1e293b;
        }

        .bank-chip-sim {
            width: 40px;
            height: 30px;
            background: linear-gradient(135deg, #ffd700 0%, #eab308 100%);
            border-radius: 6px;
            box-shadow: inset 0 1px 2px rgba(255,255,255,0.7);
        }

        /* 5. ITEM CARDS FOR NOMINEE, CHILDREN, ASSETS */
        .sub-item-card {
            background: #ffffff;
            border: 1px solid #eef2f7;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 14px;
            transition: all 0.25s ease;
            box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        }

        .sub-item-card:hover {
            border-color: #7366ff;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(115, 102, 255, 0.08);
        }

        /* PRINT STYLES */
        @media print {
            .page-title, .breadcrumb, .btn-profile-action, .sidebar-wrapper, .page-header {
                display: none !important;
            }
            .hero-profile-card {
                background: #f8fafc !important;
                color: #000 !important;
                box-shadow: none !important;
                border: 1px solid #ccc !important;
            }
            .hero-emp-name {
                color: #000 !important;
            }
            .salary-stat-card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid profile-container pt-3">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

        <!-- 2. HERO PROFILE BANNER CARD -->
        <div class="hero-profile-card">
            <div class="row align-items-center">
                <div class="col-md-auto text-center text-md-start mb-3 mb-md-0">
                    <div class="hero-avatar-wrapper">
                        <asp:Image ID="imgHeroProfile" runat="server" CssClass="hero-avatar" ImageUrl="ProfileImg/male.jpg" onerror="this.src='ProfileImg/male.jpg';" />
                        <span class="hero-online-status" title="Active Employee"></span>
                    </div>
                </div>
                <div class="col-md">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
                        <div>
                            <h3 class="hero-emp-name">
                                <asp:Label ID="lblHeroEmpName" runat="server" Text="Employee Name"></asp:Label>
                            </h3>
                            <div class="d-flex flex-wrap align-items-center mt-1">
                                <span class="hero-badge-pill hero-badge-primary">
                                    <i class="fa fa-briefcase me-1"></i>
                                    <asp:Label ID="lblHeroDesignation" runat="server" Text="Designation"></asp:Label>
                                </span>
                                <span class="hero-badge-pill hero-badge-translucent">
                                    <i class="fa fa-building-o me-1"></i>
                                    <asp:Label ID="lblHeroDepartment" runat="server" Text="Department"></asp:Label>
                                </span>
                                <span class="hero-badge-pill hero-badge-translucent">
                                    <i class="fa fa-map-marker me-1"></i>
                                    <asp:Label ID="lblHeroOffice" runat="server" Text="Head Office"></asp:Label>
                                </span>
                            </div>
                        </div>
                        <div>
                            <button type="button" class="btn btn-profile-action" onclick="window.print();">
                                <i class="fa fa-print me-1"></i> Print Profile
                            </button>
                        </div>
                    </div>

                    <!-- Hero Contact & Code Chips -->
                    <div class="hero-chip-row">
                        <span class="hero-chip">
                            <i class="fa fa-id-badge text-warning"></i>
                            User ID: <strong class="ms-1 font-monospace"><asp:Label ID="lblHeroUserName" runat="server" Text="-"></asp:Label></strong>
                        </span>
                        <span class="hero-chip">
                            <i class="fa fa-phone text-success"></i>
                            <asp:Label ID="lblHeroMobile" runat="server" Text="-"></asp:Label>
                        </span>
                        <span class="hero-chip">
                            <i class="fa fa-envelope text-info"></i>
                            <asp:Label ID="lblHeroEmail" runat="server" Text="-"></asp:Label>
                        </span>
                        <span class="hero-chip">
                            <i class="fa fa-birthday-cake text-danger"></i>
                            DOB: <asp:Label ID="lblHeroDOB" runat="server" Text="-"></asp:Label>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 3. SALARY OVERVIEW KPI STAT CARDS -->
        <div class="mb-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between mb-3">
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-primary p-2 rounded-3 text-white"><i class="fa fa-credit-card"></i></span>
                    <h5 class="fw-bold mb-0 text-dark">Latest Salary Overview</h5>
                </div>
                <div>
                    <span class="badge bg-light text-primary border px-3 py-2 rounded-pill fw-semibold">
                        <i class="fa fa-calendar-check-o me-1"></i>
                        Salary Period: 
                        <asp:Label ID="lblSalaryMonth" runat="server" Text="August" CssClass="fw-bold"></asp:Label> 
                        <asp:Label ID="lblSalaryYear" runat="server" Text="2026" CssClass="fw-bold"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="row g-3">
                <!-- Total Earnings -->
                <div class="col-md-4">
                    <div class="salary-stat-card stat-card-earnings">
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="stat-title text-success">Total Earnings</span>
                            <span class="stat-icon-bubble stat-bubble-earnings"><i class="fa fa-arrow-up"></i></span>
                        </div>
                        <h3 class="stat-value text-success">
                            &#8377; <asp:Label ID="lblTotalEarnings" runat="server" Text="0.00"></asp:Label>
                        </h3>
                        <div class="text-muted small">
                            <i class="fa fa-check-circle text-success me-1"></i> Gross basic salary & allowances
                        </div>
                    </div>
                </div>

                <!-- Total Deductions -->
                <div class="col-md-4">
                    <div class="salary-stat-card stat-card-deductions">
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="stat-title text-danger">Total Deductions</span>
                            <span class="stat-icon-bubble stat-bubble-deductions"><i class="fa fa-arrow-down"></i></span>
                        </div>
                        <h3 class="stat-value text-danger">
                            &#8377; <asp:Label ID="lblTotalDeductions" runat="server" Text="0.00"></asp:Label>
                        </h3>
                        <div class="text-muted small">
                            <i class="fa fa-shield text-danger me-1"></i> EPF, Insurance, Taxes & Deductions
                        </div>
                    </div>
                </div>

                <!-- Net In-Hand Salary -->
                <div class="col-md-4">
                    <div class="salary-stat-card stat-card-net">
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="stat-title text-white-50">Net Disbursed Salary</span>
                            <span class="stat-icon-bubble stat-bubble-net"><i class="fa fa-money"></i></span>
                        </div>
                        <h3 class="stat-value text-white">
                            &#8377; <asp:Label ID="lblNetSalary" runat="server" Text="0.00"></asp:Label>
                        </h3>
                        <div class="text-white-50 small">
                            <i class="fa fa-bank text-white me-1"></i> Net take-home credited to bank
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 4. TWO-COLUMN MAIN DETAILS -->
        <div class="row">
            <!-- Left Column: Personal Information & Family -->
            <div class="col-lg-6">
                <!-- Personal Details Card -->
                <div class="profile-card">
                    <div class="profile-card-header">
                        <h5>
                            <i class="fa fa-user-circle text-primary"></i>
                            Personal Information
                        </h5>
                        <span class="badge bg-light text-primary border px-3 py-1.5 rounded-pill fw-semibold">
                            <i class="fa fa-id-card-o me-1"></i>KYC & Bio
                        </span>
                    </div>
                    <div class="profile-card-body">
                        <asp:DetailsView ID="DVPersonalDetail" runat="server" AutoGenerateRows="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                            <Fields>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="row g-3">
                                            <!-- Date of Birth -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-purple">
                                                        <i class="fa fa-birthday-cake"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Date of Birth</span>
                                                        <span class="info-tile-value"><%# Eval("Emp_Dob") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Gender -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-blue">
                                                        <i class="fa fa-venus-mars"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Gender</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Emp_Gender") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Father / Husband Name -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-indigo">
                                                        <i class="fa fa-user"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Father / Husband Name</span>
                                                        <span class="info-tile-value"><%# Eval("Emp_FatherHusbandName") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Marital Status -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-pink">
                                                        <i class="fa fa-heart"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Marital Status</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Emp_MaritalStatus") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Blood Group -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-red">
                                                        <i class="fa fa-tint"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Blood Group</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-danger text-white px-3 py-1 rounded-pill fw-bold"><i class="fa fa-tint me-1"></i><%# Eval("Emp_BloodGroup") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Category & Religion -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-orange">
                                                        <i class="fa fa-shield"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Category & Religion</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2.5 py-1 rounded-pill me-1"><%# Eval("Emp_Category") %></span>
                                                            <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Emp_Religion") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Aadhar Number -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-cyan">
                                                        <i class="fa fa-id-card-o"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Aadhar Number</span>
                                                        <span class="info-tile-value font-monospace fw-bold text-dark"><%# Eval("Emp_AadharNo") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- PAN Card Number -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-green">
                                                        <i class="fa fa-credit-card"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">PAN Card Number</span>
                                                        <span class="info-tile-value font-monospace fw-bold text-dark"><%# Eval("Emp_PanCardNo") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Email Address -->
                                            <div class="col-12">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-blue">
                                                        <i class="fa fa-envelope-o"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Personal Email Address</span>
                                                        <span class="info-tile-value text-primary"><%# Eval("Emp_Email") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Spouse Information -->
                                            <div class="col-12">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-pink">
                                                        <i class="fa fa-users"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Spouse Details (Name / Job / Dept)</span>
                                                        <span class="info-tile-value">
                                                            <strong><%# string.IsNullOrEmpty(Eval("Emp_HusbWifeName").ToString()) ? "N/A" : Eval("Emp_HusbWifeName") %></strong>
                                                            <%# string.IsNullOrEmpty(Eval("Emp_HusbWifeJob").ToString()) ? "" : " &bull; " + Eval("Emp_HusbWifeJob") %>
                                                            <%# string.IsNullOrEmpty(Eval("Emp_HusbWifeDep").ToString()) ? "" : " (" + Eval("Emp_HusbWifeDep") + ")" %>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Disability -->
                                            <div class="col-12">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-purple">
                                                        <i class="fa fa-wheelchair"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Specially Abled / Disability</span>
                                                        <span class="info-tile-value">
                                                            <%# Eval("Emp_Disability") != null && Eval("Emp_Disability").ToString() == "Yes" ? "<span class='badge bg-warning text-dark px-2.5 py-1 rounded-pill'>Yes - " + Eval("Emp_DisabilityType") + "</span>" : "<span class='badge bg-light text-muted border px-2.5 py-1 rounded-pill'>None</span>" %>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Current Address -->
                                            <div class="col-12">
                                                <div class="info-tile" style="background: linear-gradient(135deg, #ffffff 0%, #fbfcfe 100%); border-left: 4px solid #7366ff;">
                                                    <div class="info-tile-icon tile-icon-indigo">
                                                        <i class="fa fa-map-marker text-danger"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Current Residential Address</span>
                                                        <span class="info-tile-value" style="line-height: 1.5;"><%# Eval("Emp_CurrentAddress") %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </div>
                </div>

                <!-- Nominee Details Card -->
                <div id="divNomineeDetail" runat="server">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <h5>
                                <i class="fa fa-shield text-info"></i>
                                Nominee Information
                            </h5>
                            <span class="badge bg-info-subtle text-info border border-info-subtle px-3 py-1.5 rounded-pill">
                                <i class="fa fa-heart me-1"></i>Family Security
                            </span>
                        </div>
                        <div class="profile-card-body">
                            <asp:GridView ID="GVNomineeDetail" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="sub-item-card d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center gap-3">
                                                    <div class="info-tile-icon tile-icon-cyan" style="margin-right: 0;">
                                                        <i class="fa fa-user-circle-o"></i>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-1 fw-bold text-dark"><%# Eval("Nominee_Name") %></h6>
                                                        <span class="text-muted small">Registered Nominee</span>
                                                    </div>
                                                </div>
                                                <div>
                                                    <span class="badge bg-primary text-white px-3 py-1.5 rounded-pill fw-semibold">
                                                        <i class="fa fa-link me-1"></i><%# Eval("Nominee_Relation") %>
                                                    </span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Children Details Card -->
                <div id="divChildDetail" runat="server">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <h5>
                                <i class="fa fa-users text-success"></i>
                                Children & Family Details
                            </h5>
                            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1.5 rounded-pill">
                                <i class="fa fa-child me-1"></i>Dependents
                            </span>
                        </div>
                        <div class="profile-card-body">
                            <asp:GridView ID="GVChildDetail" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="sub-item-card">
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="info-tile-icon tile-icon-green" style="margin-right: 0; width: 38px; height: 38px;">
                                                            <i class="fa fa-child"></i>
                                                        </div>
                                                        <h6 class="mb-0 fw-bold text-dark"><%# Eval("Child_Name") %></h6>
                                                    </div>
                                                    <div>
                                                        <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Child_Type") %></span>
                                                        <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill ms-1"><%# Eval("Child_MaritalStatus") %></span>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 small text-muted pt-2 border-top">
                                                    <span><i class="fa fa-calendar-o me-1"></i>DOB: <strong><%# Eval("Child_Dob") %></strong></span>
                                                    <span><i class="fa fa-graduation-cap me-1"></i>Education: <strong><%# Eval("Child_Education") %></strong></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Official Details, Bank, Assets & Others -->
            <div class="col-lg-6">
                <!-- Official & Employment Details Card -->
                <div class="profile-card">
                    <div class="profile-card-header">
                        <h5>
                            <i class="fa fa-id-card-o text-primary"></i>
                            Official & Employment Details
                        </h5>
                        <span class="badge bg-light text-primary border px-3 py-1.5 rounded-pill fw-semibold">
                            <i class="fa fa-briefcase me-1"></i>Service Book
                        </span>
                    </div>
                    <div class="profile-card-body">
                        <asp:DetailsView ID="DVOfficialDetail" runat="server" AutoGenerateRows="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                            <Fields>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="row g-3">
                                            <!-- Present Posting -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-purple">
                                                        <i class="fa fa-building"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Present Posting</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-primary text-white px-3 py-1.5 rounded-pill fw-semibold"><i class="fa fa-map-marker me-1"></i><%# Eval("OfficeType_Title") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Employee ID / Code -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-indigo">
                                                        <i class="fa fa-id-badge"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Employee Code / User Name</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-dark text-white px-3 py-1.5 rounded-pill font-monospace"><%# Eval("UserName") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Basic Salary (Prominent Card) -->
                                            <div class="col-12">
                                                <div class="info-tile" style="background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); border: 1px solid #86efac;">
                                                    <div class="info-tile-icon" style="background: #22c55e; color: #ffffff;">
                                                        <i class="fa fa-money"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label text-success" style="font-weight: 700;">Approved Basic Salary</span>
                                                        <span class="info-tile-value text-success" style="font-size: 1.35rem; font-weight: 700;">
                                                            &#8377; <%# Eval("Emp_BasicSalery") %>
                                                        </span>
                                                    </div>
                                                    <div class="ms-auto text-end">
                                                        <span class="badge bg-success text-white px-3 py-1.5 rounded-pill"><i class="fa fa-check-circle me-1"></i>Active Scale</span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Joining Date -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-green">
                                                        <i class="fa fa-calendar-check-o"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Initial Joining Date</span>
                                                        <span class="info-tile-value text-dark fw-bold"><%# Eval("Emp_JoiningDate") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Posting Date on Present Post -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-cyan">
                                                        <i class="fa fa-calendar-o"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Date On Current Post</span>
                                                        <span class="info-tile-value text-dark fw-bold"><%# Eval("Emp_PostingDate") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Retirement Date -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-orange">
                                                        <i class="fa fa-hourglass-end"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Date of Superannuation</span>
                                                        <span class="info-tile-value text-dark fw-bold"><%# Eval("Emp_RetirementDate") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Type of Initial Recruitment -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-blue">
                                                        <i class="fa fa-briefcase"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Recruitment Type</span>
                                                        <span class="info-tile-value">
                                                            <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Emp_TypeOfRecruitment") %></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- EPF Number -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-purple">
                                                        <i class="fa fa-shield"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">EPF Account Number</span>
                                                        <span class="info-tile-value">
                                                            <code class="bg-primary-subtle text-primary px-2.5 py-1 rounded font-monospace fw-bold"><%# Eval("Emp_EpfNumber") %></code>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Group Insurance Number -->
                                            <div class="col-sm-6">
                                                <div class="info-tile">
                                                    <div class="info-tile-icon tile-icon-pink">
                                                        <i class="fa fa-umbrella"></i>
                                                    </div>
                                                    <div class="info-tile-body">
                                                        <span class="info-tile-label">Group Insurance No.</span>
                                                        <span class="info-tile-value">
                                                            <code class="bg-danger-subtle text-danger px-2.5 py-1 rounded font-monospace fw-bold"><%# Eval("Emp_GINumber") %></code>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </div>
                </div>

                <!-- Bank Details Card -->
                <div id="divBankDetail" runat="server">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <h5>
                                <i class="fa fa-university text-primary"></i>
                                Bank Account Information
                            </h5>
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill">
                                <i class="fa fa-credit-card me-1"></i>Direct Deposit
                            </span>
                        </div>
                        <div class="profile-card-body">
                            <asp:GridView ID="GVBankDetail" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="bank-passbook-card">
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="bank-avatar-bubble">
                                                            <i class="fa fa-university text-primary fs-5"></i>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0 fw-bold text-dark"><%# Eval("Bank_Name") %></h5>
                                                            <span class="text-muted small"><i class="fa fa-map-marker me-1"></i><%# Eval("Bank_BranchName") %> Branch</span>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <span class="badge bg-success text-white px-3 py-1.5 rounded-pill fw-semibold">
                                                            <i class="fa fa-check-circle me-1"></i>Salary Disbursed
                                                        </span>
                                                    </div>
                                                </div>

                                                <!-- Account Number Box -->
                                                <div class="bank-acc-box p-3 my-3 rounded-3 d-flex align-items-center justify-content-between">
                                                    <div>
                                                        <span class="small text-muted d-block text-uppercase fw-bold" style="font-size: 0.7rem; letter-spacing: 0.8px;">Bank Account Number</span>
                                                        <span class="bank-acc-display mb-0">
                                                            <i class="fa fa-credit-card text-primary me-2"></i><%# Eval("Bank_AccountNo") %>
                                                        </span>
                                                    </div>
                                                    <div class="bank-chip-sim d-none d-sm-block"></div>
                                                </div>

                                                <!-- Bottom Details Bar -->
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 pt-2 border-top">
                                                    <div>
                                                        <span class="text-muted small me-2">Account Type:</span>
                                                        <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill"><%# Eval("Bank_AccountType") %></span>
                                                    </div>
                                                    <div>
                                                        <span class="text-muted small me-2">IFSC Code:</span>
                                                        <span class="badge bg-dark text-white font-monospace px-3 py-1.5 rounded-pill"><i class="fa fa-code me-1"></i><%# Eval("Bank_IfscCode") %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Fixed Assets & Property Card -->
                <div id="divFixedAssetsDetail" runat="server">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <h5>
                                <i class="fa fa-home text-secondary"></i>
                                Fixed Assets & Property Details
                            </h5>
                            <span class="badge bg-light text-secondary border px-3 py-1.5 rounded-pill">
                                <i class="fa fa-building-o me-1"></i>Declarations
                            </span>
                        </div>
                        <div class="profile-card-body">
                            <asp:GridView ID="GVFixedAssetsDetail" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="sub-item-card">
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="info-tile-icon tile-icon-indigo" style="margin-right: 0; width: 38px; height: 38px;">
                                                            <i class="fa fa-home"></i>
                                                        </div>
                                                        <h6 class="mb-0 fw-bold text-dark"><%# Eval("Property_Type") %></h6>
                                                    </div>
                                                    <div>
                                                        <span class="badge bg-light text-dark border px-2.5 py-1 rounded-pill">Year: <%# Eval("Property_PurchaseYear") %></span>
                                                    </div>
                                                </div>
                                                <div class="small text-muted mb-2">
                                                    <i class="fa fa-map-marker text-danger me-1"></i>Location: <strong><%# Eval("Property_Location") %></strong>
                                                </div>
                                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 pt-2 border-top small">
                                                    <span>Purchase Price: <strong class="text-dark">&#8377; <%# Eval("Property_PurchasePrice") %></strong></span>
                                                    <span>Current Valuation: <strong class="text-success">&#8377; <%# Eval("Property_CurrentRate") %></strong></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Other Details & Achievements Card -->
                <div id="divOtherDetail" runat="server">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <h5>
                                <i class="fa fa-trophy text-warning"></i>
                                Special Trainings & Achievements
                            </h5>
                            <span class="badge bg-warning-subtle text-warning border border-warning-subtle px-3 py-1.5 rounded-pill">
                                <i class="fa fa-certificate me-1"></i>Honors
                            </span>
                        </div>
                        <div class="profile-card-body">
                            <asp:GridView ID="GVOtherDetail" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" CssClass="w-100 border-0 p-0 m-0">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="sub-item-card">
                                                <div class="row g-2">
                                                    <div class="col-md-6">
                                                        <div class="p-2 rounded-3 bg-light">
                                                            <span class="text-primary fw-bold small d-block mb-1"><i class="fa fa-graduation-cap me-1"></i>Training Completed</span>
                                                            <span class="text-dark small"><%# Eval("Other_Training") %></span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="p-2 rounded-3 bg-light">
                                                            <span class="text-warning fw-bold small d-block mb-1"><i class="fa fa-trophy me-1"></i>Special Achievement</span>
                                                            <span class="text-dark small"><%# Eval("Other_Achievement") %></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
</asp:Content>
