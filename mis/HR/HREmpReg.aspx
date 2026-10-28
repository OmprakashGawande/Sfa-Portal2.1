<%@ Page Title="Employee Registration (कर्मचारी जोड़ें) | SFA Portal" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HREmpReg.aspx.cs" Inherits="mis_HR_HREmpReg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../assets/css/vendors/flatpickr/flatpickr.min.css" />
    <style>
        .emp-nav-tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            padding: 6px 0 14px 0;
            border-bottom: 2px solid #eef2f5;
        }
        .emp-nav-tabs .btn {
            flex: 1 1 auto;
            min-width: 140px;
            padding: 9px 14px !important;
            font-size: 13.5px !important;
            font-weight: 600 !important;
            border-radius: 6px !important;
            transition: all 0.25s ease-in-out;
            border: 1px solid #dcdfe3 !important;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .emp-nav-tabs .btn.btn-danger {
            background: linear-gradient(135deg, #d32f2f 0%, #b71c1c 100%) !important;
            color: #ffffff !important;
            border-color: #b71c1c !important;
            box-shadow: 0 4px 12px rgba(211, 47, 47, 0.35) !important;
        }
        .emp-nav-tabs .btn.btn-default {
            background: #ffffff !important;
            color: #475569 !important;
            border-color: #cbd5e1 !important;
        }
        .emp-nav-tabs .btn.btn-default:hover {
            background: #f1f5f9 !important;
            color: #0f172a !important;
            border-color: #94a3b8 !important;
            transform: translateY(-1px);
        }
        .form-actions {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 14px;
            padding: 16px 0 6px 0;
            margin-top: 15px;
            border-top: 1px dashed #e2e8f0;
        }
        .form-actions .btn {
            min-width: 140px;
            padding: 9px 24px !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            border-radius: 6px !important;
            transition: all 0.2s ease-in-out;
            box-shadow: 0 2px 5px rgba(0,0,0,0.08);
        }
        .form-actions .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.14);
        }
        .btn-final-submit {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%) !important;
            border: 1px solid #059669 !important;
            color: #ffffff !important;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.35) !important;
            font-weight: 600 !important;
            padding: 8px 20px !important;
            border-radius: 6px !important;
            transition: all 0.2s ease-in-out;
        }
        .btn-final-submit:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%) !important;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.45) !important;
        }
        .flatpickr-calendar {
            box-shadow: 0 10px 25px rgba(0,0,0,0.15) !important;
            border: 1px solid #e2e8f0 !important;
            border-radius: 8px !important;
        }
        .box-comment {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            margin-bottom: 20px;
        }
        .box-comment .box-header {
            border-bottom: 1px solid #edf2f7;
            padding: 12px 18px;
            background: #fafbfc;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
        }
        .box-comment .box-header .box-title {
            font-size: 17px;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
        }
        .info-notice {
            font-size: 13px;
            font-weight: 500;
            color: #b91c1c;
            background: #fef2f2;
            padding: 6px 14px;
            border-radius: 5px;
            border-left: 3px solid #dc2626;
            display: inline-block;
        }
        .form-group label {
            font-weight: 600;
            font-size: 13px;
            color: #334155;
            margin-bottom: 4px;
        }
        fieldset {
            border: 1px solid #e2e8f0 !important;
            padding: 14px !important;
            border-radius: 6px !important;
            background: #fcfdfe;
            margin-bottom: 15px;
        }
        fieldset legend {
            font-size: 13px !important;
            font-weight: 700 !important;
            color: #1d4ed8 !important;
            width: auto !important;
            padding: 2px 10px !important;
            border-bottom: none !important;
            background: #eff6ff;
            border-radius: 4px;
            border: 1px solid #bfdbfe;
            margin-bottom: 8px !important;
        }
        .input-group-addon {
            background-color: #f1f5f9;
            border: 1px solid #cbd5e1;
            padding: 6px 12px;
            color: #64748b;
            display: flex;
            align-items: center;
            border-top-left-radius: 6px;
            border-bottom-left-radius: 6px;
        }
        .table thead th {
            background-color: #f8fafc;
            color: #1e293b;
            font-weight: 600;
            border-bottom: 2px solid #e2e8f0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="row align-items-center mb-2">
                <div class="col-sm-9">
                    <h3 class="box-title" style="font-weight: 700; color: #1e293b; margin: 0;">Employee Registration (कर्मचारी जोड़ें)</h3>
                </div>
                <div class="col-sm-3 text-end">
                    <asp:Button ID="btnFinalSubmit" runat="server" CssClass="btn btn-final-submit" Text="✓ Final Submit Registration" OnClick="btnFinalSubmit_Click" OnClientClick="return confirm('Are you sure you want to finalize employee registration?');" />
                </div>
            </div>
        </section>
        <!-- Main content -->
        <section class="content">
            <!-- Default box -->
            <div class="box box-success">
                <div class="box-header">
                    <div class="emp-nav-tabs">
                        <asp:Button ID="btnPersonalDetail" runat="server" CssClass="btn btn-danger" Text="1. Personal Details" OnClick="btnPersonalDetail_Click" />
                        <asp:Button ID="btnOfficialDetail" runat="server" CssClass="btn btn-default" Text="2. Official Details" OnClick="btnOfficialDetail_Click" />
                        <asp:Button ID="btnBankDetail" runat="server" CssClass="btn btn-default" Text="3. Bank Details" OnClick="btnBankDetail_Click" />
                        <asp:Button ID="btnFixedAssetsDetail" runat="server" CssClass="btn btn-default" Text="4. Fixed Assets Details" OnClick="btnFixedAssetsDetail_Click" />
                        <asp:Button ID="btnChildrenDetail" runat="server" CssClass="btn btn-default" Text="5. Children Details" OnClick="btnChildrenDetail_Click" />
                        <asp:Button ID="btnNomineeDetail" runat="server" CssClass="btn btn-default" Text="6. Nominee Details" OnClick="btnNomineeDetail_Click" />
                        <asp:Button ID="btnOtherDetail" runat="server" CssClass="btn btn-default" Text="7. Other Details" OnClick="btnOtherDetail_Click" />
                    </div>
                </div>
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="box-body">
                    <div id="boxPersonalDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Personal Details</h3>
                            <span class="info-notice"><i class="fa fa-info-circle"></i> After saving Personal Details, you will automatically be guided to Official Details.</span>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="form-group"></div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Employee Name (कर्मचारी का नाम)<span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtEmp_Name" runat="server" placeholder="Enter Employee Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Gender (लिंग)<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_Gender" runat="server" class="form-control">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Date of birth (जन्म की तारीख)<span style="color: red;">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-white" style="cursor: pointer;" onclick="openFlatpickr('txtEmp_Dob');">
                                                        <i class="fa fa-calendar text-primary"></i>
                                                    </span>
                                                    <asp:TextBox ID="txtEmp_Dob" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                                        data-date-format="dd/mm/yyyy" data-date-autoclose="true"
                                                        CssClass="form-control datetime-local dob-picker" ClientIDMode="Static" onchange="RetirementDate();"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Father / Husband Name (पिता / पति का नाम)<span style="color: red;">*</span></label>
                                                <div class="row g-2">
                                                    <div class="col-4">
                                                        <asp:DropDownList ID="ddlEmp_Relation" runat="server" class="form-control">
                                                            <asp:ListItem>Select</asp:ListItem>
                                                            <asp:ListItem Value="Father">Father</asp:ListItem>
                                                            <asp:ListItem Value="Husband">Husband</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-8">
                                                        <asp:TextBox ID="txtEmp_FatherHusbandName" runat="server" placeholder="Enter Father/Husband Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Marital Status (वैवाहिक स्थिति)<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_MaritalStatus" runat="server" class="form-control" onchange="Validation();">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Value="Unmarried (अविवाहित)">Unmarried (अविवाहित)</asp:ListItem>
                                                    <asp:ListItem Value="Married (विवाहित)">Married (विवाहित)</asp:ListItem>
                                                    <asp:ListItem Value="Divorced (तलाकशुदा)">Divorced (तलाकशुदा)</asp:ListItem>
                                                    <asp:ListItem Value="Widowed (विधवा)">Widowed (विधवा)</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Blood Group (ब्लड ग्रुप)<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_BloodGroup" runat="server" class="form-control">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Value="A+">A+</asp:ListItem>
                                                    <asp:ListItem Value="A-">A-</asp:ListItem>
                                                    <asp:ListItem Value="AB+">AB+</asp:ListItem>
                                                    <asp:ListItem Value="AB-">AB-</asp:ListItem>
                                                    <asp:ListItem Value="B+">B+</asp:ListItem>
                                                    <asp:ListItem Value="B-">B-</asp:ListItem>
                                                    <asp:ListItem Value="O+">O+</asp:ListItem>
                                                    <asp:ListItem Value="O-">O-</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Mobile no. (मोबाइल नंबर)<span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtEmp_MobileNo" runat="server" placeholder="Enter Mobile No" class="MobileNo form-control" MaxLength="10" onkeypress="return validateNum(event)"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Aadhaar no. (आधार नंबर)<span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtEmp_AadharNo" runat="server" placeholder="Enter Aadhaar No" class="AadharNo form-control" MaxLength="12" onkeypress="return validateNum(event)"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>PAN Card no. (पैन कार्ड नंबर )<span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtEmp_PanCardNo" runat="server" placeholder="Enter PAN Card No" class="PanCard form-control" MaxLength="10" onkeypress="tbx_fnAlphaNumericOnly(event, this);"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Email ID (ईमेल आईडी)<span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtEmp_Email" runat="server" placeholder="Enter Email ID" class="form-control" MaxLength="50" onkeypress="return validateusername(event);"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group text-center">
                                        <label>Profile Image<span style="color: red;"></span></label><br />
                                        <asp:Image ID="imgProfileImage" runat="server" ImageUrl="../image/boxed-bg.jpg" Style="height: 150px; width: 120px;" ClientIDMode="Static"></asp:Image>
                                    </div>
                                    <div class="form-group">
                                        <asp:FileUpload ID="FU_Emp_ProfileImage" runat="server" class="form-control" ClientIDMode="Static" onchange="UploadControlValidationForLenthAndFileFormat(100, 'JPEG*PNG*JPG', this),ValidateFileSize(this,1024*1024*1),previewProfileImage()" />
                                    </div>
                                </div>
                            </div>
                            <%-- ASTRIC REMOVED BY ROHIT--%>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Husband/Wife Name (का नाम)<span class="ValidateMaritalStatus"></span></label>
                                        <asp:TextBox ID="txtEmp_HusbWifeName" runat="server" placeholder="Enter Husband / Wife Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Husband/Wife Job/Business (नौकरी/व्यवसाय)<span class="ValidateMaritalStatus"></span></label>
                                        <asp:TextBox ID="txtEmp_HusbWifeJob" runat="server" placeholder="Enter Husband / Wife Job/Business..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Husband/Wife Designation/Department (पद/विभाग)<span class="ValidateMaritalStatus"></span></label>
                                        <asp:TextBox ID="txtEmp_HusbWifeDep" runat="server" placeholder="Enter Husband/Wife Designation/Department..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <asp:UpdatePanel ID="updatedisability" runat="server">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Category (वर्ग)<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_Category" runat="server" class="form-control">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Value="Scheduled Caste (अनुसूचित जाति)">Scheduled Caste (अनुसूचित जाति)</asp:ListItem>
                                                    <asp:ListItem Value="Scheduled Tribe (अनुसूचित जनजाति)">Scheduled Tribe (अनुसूचित जनजाति)</asp:ListItem>
                                                    <asp:ListItem Value="Other Backward Class (अन्य पिछड़ा वर्ग)">Other Backward Class (अन्य पिछड़ा वर्ग)</asp:ListItem>
                                                    <asp:ListItem Value="General (सामान्य)">General (सामान्य)</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Religion (धर्म)<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_Religion" runat="server" class="form-control">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Value="HINDU">HINDU</asp:ListItem>
                                                    <asp:ListItem Value="MUSLIM">MUSLIM</asp:ListItem>
                                                    <asp:ListItem Value="JAIN">JAIN</asp:ListItem>
                                                    <asp:ListItem Value="CHRISTIAN">CHRISTIAN</asp:ListItem>
                                                    <asp:ListItem Value="BUDDHISM">BUDDHISM</asp:ListItem>
                                                    <asp:ListItem Value="SIKHISM">SIKHISM</asp:ListItem>
                                                    <asp:ListItem Value="ZOROASTRIANISM">ZOROASTRIANISM</asp:ListItem>
                                                    <asp:ListItem Value="JUDAISM">JUDAISM</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>Physical Disability(शारीरिक विकलांगता)<span id="spnEmp_Disability" style="color: red;">*</span></label>
                                                <asp:RadioButtonList ID="rbtEmp_Disability" runat="server" ClientIDMode="Static" RepeatColumns="2" AutoPostBack="true" OnSelectedIndexChanged="rbtEmp_Disability_SelectedIndexChanged1">
                                                    <asp:ListItem Value="Yes">&nbsp;Yes&nbsp;&nbsp;</asp:ListItem>
                                                    <asp:ListItem Value="No" Selected="True">&nbsp;No</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label id="lblEmp_Disability">Disability Type(विकलांगता का प्रकार )<span id="spnDisability" style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlEmp_DisabilityType" runat="server" class="form-control" ClientIDMode="Static" Enabled="false">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                    <asp:ListItem Selected="True" Value="NA/लागू नहीं">NA/लागू नहीं</asp:ListItem>
                                                    <asp:ListItem Value="Vision Impaired (दृष्टि बाधित)">Vision Impaired (दृष्टि बाधित)</asp:ListItem>
                                                    <asp:ListItem Value="Hearing Interrupted (श्रवण बाधित)">Hearing Interrupted (श्रवण बाधित)</asp:ListItem>
                                                    <asp:ListItem Value="Bone Interrupted (अस्थि बाधित)">Bone Interrupted (अस्थि बाधित)</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>CURRENT ADDRESS</legend>
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>State<span style="color: red;">*</span></label>
                                                            <asp:DropDownList ID="ddlEmp_CurState" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEmp_CurState_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>City<span style="color: red;">*</span></label>
                                                            <asp:DropDownList ID="ddlEmp_CurCity" runat="server" class="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>Pin Code <span style="color: red;">*</span></label>

                                                            <asp:TextBox ID="txtEmp_CurPinCode" runat="server" placeholder="Enter PIN Code..." class="form-control" MaxLength="6" onkeypress="return validateNum(event)"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label>Address <span style="color: red;">*</span></label>
                                                            <asp:TextBox ID="txtEmp_CurAddress" runat="server" placeholder="Enter Address..." TextMode="MultiLine" Rows="3" class="form-control" MaxLength="500"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                        <div class="col-md-6">
                                            <fieldset>
                                                <legend>PERMANENT ADDRESS</legend>
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>State<span style="color: red;">*</span></label>
                                                            <asp:DropDownList ID="ddlEmp_PerState" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEmp_PerState_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>City<span style="color: red;">*</span></label>
                                                            <asp:DropDownList ID="ddlEmp_PerCity" runat="server" class="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>Pin Code <span style="color: red;">*</span></label>
                                                            <asp:TextBox ID="txtEmp_PerPinCode" runat="server" placeholder="Enter Pin Code..." class="form-control" MaxLength="6" onkeypress="return validateNum(event)"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label>Address <span style="color: red;">*</span></label>
                                                            <asp:TextBox ID="txtEmp_PerAddress" runat="server" placeholder="Enter Address..." TextMode="MultiLine" Rows="3" class="form-control" MaxLength="500"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <div id="divPersonalDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSavePersonalDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSavePersonalDetail_Click" OnClientClick="return validatePersonalDetail();" />
                                <asp:Button ID="btnClearPersonalDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearPersonalDetail_Click" />
                            </div>
                        </div>
                    </div>
                    <div id="boxOfficialDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Official Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Office Type (कार्यालय का प्रकार)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlOfficeType_Title" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlOfficeType_Title_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Office (कार्यालय)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlOffice_ID" runat="server" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>User ID<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtUserName" runat="server" placeholder="Enter ..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Password<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter ..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Department(विभाग)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlDepartment_ID" runat="server" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Level (स्तर)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlLevel" runat="server" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Class (श्रेणी)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlEmp_Class" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEmp_Class_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Designation (पद)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlDesignation_ID" runat="server" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Pay Scale ( वेतनमान)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlPayScale_ID" runat="server" class="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPayScale_ID_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Grade Pay (ग्रेड पे) <span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlGradPay_ID" runat="server" class="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Basic Salary (मूल वेतन)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtEmp_BasicSalery" runat="server" placeholder="Enter ..." class="form-control" MaxLength="10" onkeypress="return validateDec(this,event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Joining Date ( कार्यग्रहण तिथि)<span style="color: red;">*</span></label>
                                        <asp:Label ID="lblDob" runat="server" Text="" CssClass="hidden"></asp:Label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white" style="cursor: pointer;" onclick="openFlatpickr('txtEmp_JoiningDate');">
                                                <i class="fa fa-calendar text-primary"></i>
                                            </span>
                                            <asp:TextBox ID="txtEmp_JoiningDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                                data-date-format="dd/mm/yyyy" data-date-autoclose="true"
                                                CssClass="form-control datetime-local date-picker-joining" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Posting Date (पोस्टिंग तिथि)<span style="color: red;">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white" style="cursor: pointer;" onclick="openFlatpickr('txtEmp_PostingDate');">
                                                <i class="fa fa-calendar text-primary"></i>
                                            </span>
                                            <asp:TextBox ID="txtEmp_PostingDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                                data-date-format="dd/mm/yyyy" data-date-autoclose="true"
                                                CssClass="form-control datetime-local date-picker-posting" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Retirement Date (सेवानिवृत्ति की तारीख)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtEmp_RetirementDate" runat="server" placeholder="Select Date..." class="form-control" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Type of Recruitment ( भर्ती का प्रकार)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlEmp_TypeOfRecruitment" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Direct Recruitment">Direct Recruitment</asp:ListItem> 
                                            <asp:ListItem Value="Promotion">Promotion</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Type of Post (पद प्रकार) <span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlEmp_TypeOfPost" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Permanent">Regular/Permanent</asp:ListItem>
                                            <asp:ListItem Value="promotion">Trainee</asp:ListItem>
                                            <%--  <asp:ListItem Value="Fixed Employee">Fixed Employee(स्थाई कर्मी)</asp:ListItem>
                                            <asp:ListItem Value="Contigent Employee">Contigent Employee</asp:ListItem>
                                            <asp:ListItem Value="Samvida Employee">Samvida Employee</asp:ListItem>
                                            <asp:ListItem Value="Theka Shramik">Theka Shramik</asp:ListItem>
                                            <asp:ListItem Value="Outsource Employee">Outsource Employee</asp:ListItem>
                                            <asp:ListItem Value="Deputation Employee">Deputation Employee</asp:ListItem>
                                            <asp:ListItem Value="Contractual Employee">Contractual Employee</asp:ListItem>
                                            <asp:ListItem Value="Daily Wages Employee">Daily Wages Employee</asp:ListItem>
                                            <asp:ListItem Value="Daily Wages Federation">Daily Wages Federation</asp:ListItem>
                                            <asp:ListItem Value="Job Rate Employee">Job Rate Employee</asp:ListItem>--%>
                                            <%-- <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Permanent">Permanent (स्थायी)</asp:ListItem>
                                            <asp:ListItem Value="Temporary">Temporary (अस्थायी)</asp:ListItem>
                                            <asp:ListItem Value="Probation">Probation (परिवीक्षा)</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Select GPF/DPF/NPS  <span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlEmp_GpfType" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="GPF">GPF</asp:ListItem>
                                            <asp:ListItem Value="DPF">DPF</asp:ListItem>
                                            <asp:ListItem Value="NPS">NPS</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>GPF/DPF/NPS No.<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtEmp_GpfNo" runat="server" placeholder="Enter ..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div id="divOfficialDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSaveOfficialDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSaveOfficialDetail_Click" OnClientClick="return validateOfficialDetail();" />
                                <asp:Button ID="btnClearOfficialDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearOfficialDetail_Click" />
                            </div>
                        </div>
                    </div>
                    <div id="boxBankDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Bank Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Account No (खाता संख्या)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtBank_AccountNo" runat="server" placeholder="Enter Account No" class="form-control" MaxLength="17" onkeypress="return validateNum(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Account Type (खाते का प्रकार)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlBank_AccountType" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Salary Account">Salary Account</asp:ListItem>
                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Bank name(बैंक का नाम)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlBank_Name" runat="server" class="form-control select2"></asp:DropDownList>
                                        <%-- <asp:TextBox ID="txtBank_Name" runat="server" placeholder="Enter Bank Name" class="form-control" MaxLength="100"></asp:TextBox>--%>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Branch name(शाखा का नाम)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtBank_BranchName" runat="server" placeholder="Enter Branch Name" class="form-control" MaxLength="100" onkeypress="return alpha(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>IFSC code (आई एफ एस सी कोड)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtBank_IfscCode" runat="server" placeholder="Enter IFSC code" class="IFSC form-control" MaxLength="12" onkeypress="return alpha(event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="divBankDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSaveBankDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSaveBankDetail_Click" OnClientClick="return validateBankDetail();" />
                                <asp:Button ID="btnClearBankDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearBankDetail_Click" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewBankDetail" runat="server" class="table table-hover table-bordered pagination-ys" AutoGenerateColumns="False" DataKeyNames="Bank_ID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Bank_AccountNo" HeaderText="Account No (खाता संख्या)" />
                                            <asp:BoundField DataField="Bank_AccountType" HeaderText="Account Type (खाते का प्रकार)" />
                                            <asp:BoundField DataField="Bank_Name" HeaderText="Bank Name(बैंक का नाम)" />
                                            <asp:BoundField DataField="Bank_BranchName" HeaderText="Branch Name(शाखा का नाम)" />
                                            <asp:BoundField DataField="Bank_IfscCode" HeaderText="IFSC code (आई एफ एस सी कोड)" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="boxFixedAssetsDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Fixed Assets Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Type of Property (संपत्ति का प्रकार)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlProperty_Type" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Plot">Plot</asp:ListItem>
                                            <asp:ListItem Value="House">House</asp:ListItem>
                                            <asp:ListItem Value="Agriculture land">Agriculture land</asp:ListItem>
                                            <asp:ListItem Value="Shop">Shop</asp:ListItem>
                                            <asp:ListItem Value="Flat">Flat</asp:ListItem>
                                            <asp:ListItem Value="Other">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Location Of Property(संपत्ति का स्थान )<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtProperty_Location" runat="server" placeholder="Enter Location Of Property..." class="form-control" MaxLength="100" onkeypress="return alpha(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Property Purchase Year(संपत्ति खरीद वर्ष)<span style="color: red;">*</span></label>
                                        <%-- <asp:TextBox ID="txtProperty_PurchaseYear" runat="server" placeholder="Enter Property Purchase Yea..." class="form-control" MaxLength="4" type="" onkeypress="return validateNum(event);"></asp:TextBox>--%>
                                        <asp:DropDownList ID="ddlProperty_PurchaseYear" runat="server" CssClass="form-control select2">
                                        </asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Property Purchase Price Rs.( संपत्ति खरीद मूल्य)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtProperty_PurchasePrice" runat="server" placeholder="Enter Property Purchase Price Rs...." class="form-control" MaxLength="10" onkeypress="return validateDec(this,event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Current rate of property Rs.(संपत्ति की वर्तमान दर)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtProperty_CurrentRate" runat="server" placeholder="Enter Current rate of property Rs...." class="form-control" MaxLength="10" onkeypress="return validateDec(this,event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="divFixedAssetsDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSaveFixedAssetsDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSaveFixedAssetsDetail_Click" OnClientClick="return validateAssetsDetail();" />
                                <asp:Button ID="btnClearFixedAssetsDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearFixedAssetsDetail_Click" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewFixedAssetsDetail" runat="server" class="table table-hover table-bordered pagination-ys" AutoGenerateColumns="False" DataKeyNames="Property_ID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Property_Type" HeaderText="Type of Property (संपत्ति का प्रकार)" />
                                            <asp:BoundField DataField="Property_Location" HeaderText="Location Of Property(संपत्ति का स्थान )" />
                                            <asp:BoundField DataField="Property_PurchaseYear" HeaderText="Property Purchase Year(संपत्ति खरीद वर्ष)" />
                                            <asp:BoundField DataField="Property_PurchasePrice" HeaderText="Property Purchase Price( संपत्ति खरीद मूल्य)" />
                                            <asp:BoundField DataField="Property_CurrentRate" HeaderText="Current rate of property(संपत्ति की वर्तमान दर)" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="boxChildrenDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Children Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Son/Daughter (पुत्र / पुत्री)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlChild_Type" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Son">Son</asp:ListItem>
                                            <asp:ListItem Value="Daughter">Daughter</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Name (नाम)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtChild_Name" runat="server" placeholder="Enter Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Marital Status (वैवाहिक स्थिति)<span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlChild_MaritalStatus" runat="server" class="form-control">
                                            <asp:ListItem>Select</asp:ListItem>
                                            <asp:ListItem Value="Unmarried (अविवाहित)">Unmarried (अविवाहित)</asp:ListItem>
                                            <asp:ListItem Value="Married (विवाहित)">Married (विवाहित)</asp:ListItem>
                                            <asp:ListItem Value="Divorced (तलाकशुदा)">Divorced (तलाकशुदा)</asp:ListItem>
                                            <asp:ListItem Value="Widowed (विधवा)">Widowed (विधवा)</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Date of birth (जन्म की तारीख)<span style="color: red;">*</span></label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white" style="cursor: pointer;" onclick="openFlatpickr('txtChild_Dob');">
                                                <i class="fa fa-calendar text-primary"></i>
                                            </span>
                                            <asp:TextBox ID="txtChild_Dob" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                                data-date-format="dd/mm/yyyy" data-date-autoclose="true"
                                                CssClass="form-control datetime-local dob-picker" onpaste="return false" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Education(शिक्षा)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtChild_Education" runat="server" placeholder="Enter Education..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Business/Job(व्यापार / नौकरी)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtChild_Business" runat="server" placeholder="Enter Business/Job..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="divChildrenDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSaveChildrenDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSaveChildrenDetail_Click" OnClientClick="return validateChildrenDetail();" />
                                <asp:Button ID="btnClearChildrenDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearChildrenDetail_Click" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewChildrenDetail" runat="server" class="table table-hover table-bordered pagination-ys" AutoGenerateColumns="False" DataKeyNames="Child_ID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Child_Type" HeaderText="Son/Daughter (पुत्र / पुत्री)" />
                                            <asp:BoundField DataField="Child_Name" HeaderText="Name (नाम)" />
                                            <asp:BoundField DataField="Child_Dob" HeaderText="Date of birth (जन्म की तारीख)" />
                                            <asp:BoundField DataField="Child_MaritalStatus" HeaderText="Marital Status (वैवाहिक स्थिति)" />
                                            <asp:BoundField DataField="Child_Education" HeaderText="Education(शिक्षा)" />
                                            <asp:BoundField DataField="Child_Business" HeaderText="Business/Job(व्यापार / नौकरी)" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="boxNomineeDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Nominee Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Nominee Name(नामांकित का नाम )<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtNominee_Name" runat="server" placeholder="Enter Nominee Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Relation With Nominee (नामांकित से संबंध)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtNominee_Relation" runat="server" placeholder="Enter Relation With Nominee..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <div id="divNomineeDetail" runat="server" class="col-md-4">
                                    <div class="form-group">
                                        <label class="d-none d-md-block" style="visibility: hidden;">Action</label>
                                        <div class="d-flex gap-2">
                                            <asp:Button ID="btnSaveNomineeDetail" CssClass="btn btn-success font-weight-bold flex-fill shadow-sm" runat="server" Text="Save" OnClick="btnSaveNomineeDetail_Click" OnClientClick="return validateNomineeDetail();" />
                                            <asp:Button ID="btnClearNomineeDetail" CssClass="btn btn-secondary flex-fill shadow-sm" runat="server" Text="Clear" OnClick="btnClearNomineeDetail_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewNomineeDetail" runat="server" class="table table-hover table-bordered pagination-ys" AutoGenerateColumns="False" DataKeyNames="Nominee_ID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Nominee_Name" HeaderText="Nominee Name(नामांकित का नाम )" />
                                            <asp:BoundField DataField="Nominee_Relation" HeaderText="Relation With Nominee (नामांकित से संबंध)" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div id="boxOtherDetail" runat="server" class="box box-comment">
                        <div class="box-header">
                            <h3 class="box-title">Other Details</h3>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Training related Information(प्रशिक्षण से संबंधित जानकारी)<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtOther_Training" runat="server" placeholder="Enter Training related Information..." TextMode="MultiLine" Rows="4" class="form-control" MaxLength="100" onkeypress="javascript:tbx_fnAlphaOnly(event, this);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>विशेष उपलब्धि आदि की जानकारी (इस क़ालम में निगम में यदि आपको पुरस्कृत किया है अथवा प्रशारित पत्र आदि दिया गया है उसका विवरण दिया जाना है )<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtOther_Achievement" runat="server" placeholder="Enter Achievments..." TextMode="MultiLine" Rows="4" class="form-control" MaxLength="100" onkeypress="javascript:tbx_fnAlphaOnly(event, this);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div id="divOtherDetail" runat="server" class="form-actions">
                                <asp:Button ID="btnSaveOtherDetail" CssClass="btn btn-success" runat="server" Text="Save" OnClick="btnSaveOtherDetail_Click" OnClientClick="return validateOtherDetail();" />
                                <asp:Button ID="btnClearOtherDetail" CssClass="btn btn-secondary" runat="server" Text="Clear" OnClick="btnClearOtherDetail_Click" />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewOtherDetail" runat="server" class="table table-hover table-bordered pagination-ys" AutoGenerateColumns="False" DataKeyNames="Other_ID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Other_Training" HeaderText="प्रशिक्षण से संबंधित जानकारी (Training related Information )" />
                                            <asp:BoundField DataField="Other_Achievement" HeaderText="विशेष उपलब्धि आदि की जानकारी" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script src="../js/Script.js"></script>
    <script src="../js/ValidationJs.js"></script>
    <script src="../assets/js/flat-pickr/flatpickr.js"></script>

    <script type="text/javascript">
        function Validation() {
            var maritalDdl = document.getElementById('<%=ddlEmp_MaritalStatus.ClientID%>');
            if (maritalDdl && maritalDdl.selectedIndex == 1) {
                $(".ValidateMaritalStatus").hide();
            } else {
                $(".ValidateMaritalStatus").show();
            }
        }

        function RetirementDate() {
            var dobElem = document.getElementById('<%=lblDob.ClientID%>');
            var dobStr = dobElem ? (dobElem.innerText || dobElem.textContent || '').trim() : '';
            if (!dobStr) {
                var dobInput = document.getElementById('<%=txtEmp_Dob.ClientID%>');
                if (dobInput) dobStr = dobInput.value.trim();
            }
            if (!dobStr) return;

            dobStr = dobStr.replace(/-/g, '/');
            var parts = dobStr.split('/');
            if (parts.length < 3) return;

            var day = parseInt(parts[0], 10);
            var month = parseInt(parts[1], 10);
            var year = parseInt(parts[2], 10);
            if (isNaN(day) || isNaN(month) || isNaN(year) || year < 1900) return;

            var retYear = year + 62;
            var retDateObj;
            if (day === 1) {
                // If born on 1st of month, retirement on last day of preceding month
                retDateObj = new Date(retYear, month - 1, 0);
            } else {
                // Last day of birth month
                retDateObj = new Date(retYear, month, 0);
            }

            var retDay = ('0' + retDateObj.getDate()).slice(-2);
            var retMonth = ('0' + (retDateObj.getMonth() + 1)).slice(-2);
            var retYr = retDateObj.getFullYear();
            var finalRetDate = retDay + '/' + retMonth + '/' + retYr;

            var retInput = document.getElementById("txtEmp_RetirementDate");
            if (retInput) {
                retInput.value = finalRetDate;
            }
        }

        function previewProfileImage() {
            var preview = document.querySelector('#imgProfileImage');
            var fileInput = document.querySelector('#FU_Emp_ProfileImage');
            if (fileInput && fileInput.files && fileInput.files[0]) {
                var reader = new FileReader();
                reader.onloadend = function () {
                    if (preview) preview.src = reader.result;
                }
                reader.readAsDataURL(fileInput.files[0]);
            } else if (preview) {
                preview.src = "../image/boxed-bg.jpg";
            }
        }

        function validatePersonalDetail() {
            var msg = "";
            var name = document.getElementById('<%=txtEmp_Name.ClientID%>').value.trim();
            if (name == "") {
                msg += "Enter Employee Name.\n";
            }
            if (document.getElementById('<%=ddlEmp_Gender.ClientID%>').selectedIndex == 0) {
                msg += "Select Gender.\n";
            }
            if (document.getElementById('<%=txtEmp_Dob.ClientID%>').value.trim() == "") {
                msg += "Enter Date of Birth.\n";
            }
            if (document.getElementById('<%=ddlEmp_Relation.ClientID%>').selectedIndex == 0) {
                msg += "Select Relation.\n";
            }
            if (document.getElementById('<%=txtEmp_FatherHusbandName.ClientID%>').value.trim() == "") {
                msg += "Enter Father / Husband Name.\n";
            }
            if (document.getElementById('<%=ddlEmp_MaritalStatus.ClientID%>').selectedIndex == 0) {
                msg += "Select Marital Status.\n";
            }
            if (document.getElementById('<%=ddlEmp_BloodGroup.ClientID%>').selectedIndex == 0) {
                msg += "Select Blood Group.\n";
            }

            var mobile = document.getElementById('<%=txtEmp_MobileNo.ClientID%>').value.trim();
            if (mobile == "") {
                msg += "Enter Mobile No.\n";
            } else if (!/^[6-9][0-9]{9}$/.test(mobile)) {
                msg += "Enter Valid 10-digit Mobile No.\n";
            }

            var aadhar = document.getElementById('<%=txtEmp_AadharNo.ClientID%>').value.trim();
            if (aadhar == "") {
                msg += "Enter Aadhaar No.\n";
            } else if (!/^[2-9][0-9]{11}$/.test(aadhar)) {
                msg += "Enter Valid 12-digit Aadhaar No.\n";
            }

            var pan = document.getElementById('<%=txtEmp_PanCardNo.ClientID%>').value.trim().toUpperCase();
            if (pan == "") {
                msg += "Enter PAN Card No.\n";
            } else if (!/^[A-Z]{5}[0-9]{4}[A-Z]{1}$/.test(pan)) {
                msg += "Enter Valid 10-character PAN Card No.\n";
            }

            var email = document.getElementById('<%=txtEmp_Email.ClientID%>').value.trim();
            if (email == "") {
                msg += "Enter Email Address.\n";
            } else {
                var emailPat = /^([a-zA-Z0-9_\-\.])+@([a-zA-Z0-9_\-\.])+\.([a-zA-Z]{2,5})$/;
                if (!emailPat.test(email)) {
                    msg += "Enter Valid Email Address.\n";
                }
            }

            if (document.getElementById('<%=ddlEmp_Category.ClientID%>').selectedIndex == 0) {
                msg += "Select Category.\n";
            }
            if (document.getElementById('<%=ddlEmp_Religion.ClientID%>').selectedIndex == 0) {
                msg += "Select Religion.\n";
            }
            if (document.getElementById('<%=ddlEmp_DisabilityType.ClientID%>').selectedIndex == 0) {
                msg += "Select Disability Type.\n";
            }

            if (document.getElementById('<%=ddlEmp_CurState.ClientID%>').selectedIndex == 0) {
                msg += "Select Current State.\n";
            }
            if (document.getElementById('<%=ddlEmp_CurCity.ClientID%>').selectedIndex == 0) {
                msg += "Select Current City.\n";
            }
            var curPin = document.getElementById('<%=txtEmp_CurPinCode.ClientID%>').value.trim();
            if (curPin == "") {
                msg += "Enter Current PIN Code.\n";
            } else if (!/^[1-9][0-9]{5}$/.test(curPin)) {
                msg += "Enter Valid 6-digit Current PIN Code.\n";
            }
            if (document.getElementById('<%=txtEmp_CurAddress.ClientID%>').value.trim() == "") {
                msg += "Enter Current Address.\n";
            }

            if (document.getElementById('<%=ddlEmp_PerState.ClientID%>').selectedIndex == 0) {
                msg += "Select Permanent State.\n";
            }
            if (document.getElementById('<%=ddlEmp_PerCity.ClientID%>').selectedIndex == 0) {
                msg += "Select Permanent City.\n";
            }
            var perPin = document.getElementById('<%=txtEmp_PerPinCode.ClientID%>').value.trim();
            if (perPin == "") {
                msg += "Enter Permanent PIN Code.\n";
            } else if (!/^[1-9][0-9]{5}$/.test(perPin)) {
                msg += "Enter Valid 6-digit Permanent PIN Code.\n";
            }
            if (document.getElementById('<%=txtEmp_PerAddress.ClientID%>').value.trim() == "") {
                msg += "Enter Permanent Address.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Personal Details?");
        }

        function validateOfficialDetail() {
            var msg = "";
            if (document.getElementById('<%=ddlOfficeType_Title.ClientID%>').selectedIndex == 0) {
                msg += "Select Office Type.\n";
            }
            if (document.getElementById('<%=ddlOffice_ID.ClientID%>').selectedIndex == 0) {
                msg += "Select Office.\n";
            }
            if (document.getElementById('<%=ddlDepartment_ID.ClientID%>').selectedIndex == 0) {
                msg += "Select Department.\n";
            }
            if (document.getElementById('<%=ddlLevel.ClientID%>').selectedIndex == 0) {
                msg += "Select Employee Level.\n";
            }
            if (document.getElementById('<%=ddlEmp_Class.ClientID%>').selectedIndex == 0) {
                msg += "Select Employee Class.\n";
            }
            if (document.getElementById('<%=ddlDesignation_ID.ClientID%>').selectedIndex == 0) {
                msg += "Select Designation.\n";
            }
            if (document.getElementById('<%=ddlPayScale_ID.ClientID%>').selectedIndex == 0) {
                msg += "Select Pay Scale.\n";
            }
            if (document.getElementById('<%=ddlGradPay_ID.ClientID%>').selectedIndex == 0) {
                msg += "Select Grade Pay.\n";
            }
            if (document.getElementById('<%=txtEmp_BasicSalery.ClientID%>').value.trim() == "") {
                msg += "Enter Employee Basic Salary.\n";
            }
            if (document.getElementById('<%=txtEmp_JoiningDate.ClientID%>').value.trim() == "") {
                msg += "Select Joining Date.\n";
            }
            if (document.getElementById('<%=txtEmp_PostingDate.ClientID%>').value.trim() == "") {
                msg += "Select Posting Date.\n";
            }
            if (document.getElementById('<%=txtEmp_RetirementDate.ClientID%>').value.trim() == "") {
                msg += "Select Retirement Date.\n";
            }
            if (document.getElementById('<%=ddlEmp_TypeOfRecruitment.ClientID%>').selectedIndex == 0) {
                msg += "Select Type Of Recruitment.\n";
            }
            if (document.getElementById('<%=ddlEmp_TypeOfPost.ClientID%>').selectedIndex == 0) {
                msg += "Select Type Of Post.\n";
            }
            if (document.getElementById('<%=ddlEmp_GpfType.ClientID%>').selectedIndex == 0) {
                msg += "Select GPF / DPF / NPS.\n";
            }
            if (document.getElementById('<%=txtEmp_GpfNo.ClientID%>').value.trim() == "") {
                msg += "Enter GPF / DPF / NPS No.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Official Details?");
        }

        function validateBankDetail() {
            var msg = "";
            if (document.getElementById('<%=txtBank_AccountNo.ClientID%>').value.trim() == "") {
                msg += "Enter Account Number.\n";
            }
            if (document.getElementById('<%=ddlBank_AccountType.ClientID%>').selectedIndex == 0) {
                msg += "Select Type Of Bank Account.\n";
            }
            if (document.getElementById('<%=ddlBank_Name.ClientID%>').selectedIndex == 0) {
                msg += "Select Bank Name.\n";
            }
            if (document.getElementById('<%=txtBank_BranchName.ClientID%>').value.trim() == "") {
                msg += "Enter Branch Name.\n";
            }
            var ifsc = document.getElementById('<%=txtBank_IfscCode.ClientID%>').value.trim().toUpperCase();
            if (ifsc == "") {
                msg += "Enter IFSC Code.\n";
            } else if (!/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifsc)) {
                msg += "Enter Valid 11-character IFSC Code.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Bank Details?");
        }

        function validateAssetsDetail() {
            var msg = "";
            if (document.getElementById('<%=ddlProperty_Type.ClientID%>').selectedIndex == 0) {
                msg += "Select Type Of Property.\n";
            }
            if (document.getElementById('<%=txtProperty_Location.ClientID%>').value.trim() == "") {
                msg += "Enter Property Location.\n";
            }
            if (document.getElementById('<%=ddlProperty_PurchaseYear.ClientID%>').selectedIndex == 0) {
                msg += "Select Property Purchase Year.\n";
            }
            if (document.getElementById('<%=txtProperty_PurchasePrice.ClientID%>').value.trim() == "") {
                msg += "Enter Property Purchase Price.\n";
            }
            if (document.getElementById('<%=txtProperty_CurrentRate.ClientID%>').value.trim() == "") {
                msg += "Enter Property Current Rate.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Assets Details?");
        }

        function validateChildrenDetail() {
            var msg = "";
            if (document.getElementById('<%=ddlChild_Type.ClientID%>').selectedIndex == 0) {
                msg += "Select Type Of Child.\n";
            }
            if (document.getElementById('<%=txtChild_Name.ClientID%>').value.trim() == "") {
                msg += "Enter Child Name.\n";
            }
            if (document.getElementById('<%=txtChild_Dob.ClientID%>').value.trim() == "") {
                msg += "Select Child Date Of Birth.\n";
            }
            if (document.getElementById('<%=ddlChild_MaritalStatus.ClientID%>').selectedIndex == 0) {
                msg += "Select Child Marital Status.\n";
            }
            if (document.getElementById('<%=txtChild_Education.ClientID%>').value.trim() == "") {
                msg += "Enter Education Of Child.\n";
            }
            if (document.getElementById('<%=txtChild_Business.ClientID%>').value.trim() == "") {
                msg += "Enter Business Of Child.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Children Details?");
        }

        function validateNomineeDetail() {
            var msg = "";
            if (document.getElementById('<%=txtNominee_Name.ClientID%>').value.trim() == "") {
                msg += "Enter Nominee Name.\n";
            }
            if (document.getElementById('<%=txtNominee_Relation.ClientID%>').value.trim() == "") {
                msg += "Enter Relation With Nominee.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Nominee Details?");
        }

        function validateOtherDetail() {
            var msg = "";
            if (document.getElementById('<%=txtOther_Training.ClientID%>').value.trim() == "") {
                msg += "Enter Training related Information.\n";
            }
            if (document.getElementById('<%=txtOther_Achievement.ClientID%>').value.trim() == "") {
                msg += "Enter Particular achievement.\n";
            }

            if (msg != "") {
                alert(msg);
                return false;
            }
            return confirm("Do you really want to Save Other Details?");
        }

        // Event Listeners and Formatters
        $(document).on('change', '#txtEmp_JoiningDate', function () {
            var start = $(this).datepicker ? $(this).datepicker('getDate') : null;
            var end = $('#txtEmp_PostingDate').datepicker ? $('#txtEmp_PostingDate').datepicker('getDate') : null;

            if (start && end && $('#txtEmp_PostingDate').val() != "") {
                if (start > end) {
                    alert("Join date should not be greater than Posting Date.");
                    $(this).val("");
                }
            }
            if ($('#txtEmp_RetirementDate').val() == "") {
                RetirementDate();
            }
        });

        $(document).on('change', '#txtEmp_PostingDate', function () {
            var start = $('#txtEmp_JoiningDate').datepicker ? $('#txtEmp_JoiningDate').datepicker('getDate') : null;
            var end = $(this).datepicker ? $(this).datepicker('getDate') : null;

            if (start && end && $('#txtEmp_JoiningDate').val() != "") {
                if (start > end) {
                    alert("Posting Date cannot be less than Joining Date.");
                    $(this).val("");
                }
            }
        });

        $(document).on('blur', '.MobileNo', function () {
            var val = $(this).val().trim();
            if (val !== "") {
                var mobilePattern = /^[6-9][0-9]{9}$/;
                if (!mobilePattern.test(val)) {
                    alert("Invalid Mobile No. Please enter a valid 10-digit mobile number starting with 6, 7, 8, or 9.");
                    $(this).val('');
                }
            }
        });

        $(document).on('blur', '.AadharNo', function () {
            var val = $(this).val().trim();
            if (val !== "") {
                var aadharPattern = /^[2-9][0-9]{11}$/;
                if (!aadharPattern.test(val)) {
                    alert("Invalid Aadhaar No. Please enter a valid 12-digit Aadhaar number.");
                    $(this).val('');
                }
            }
        });

        $(document).on('blur', '.PanCard', function () {
            var val = $(this).val().trim().toUpperCase();
            $(this).val(val);
            if (val !== "") {
                var panPat = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
                if (!panPat.test(val)) {
                    alert("Invalid PAN Card No. Expected format: 5 letters, 4 numbers, 1 letter (e.g., ABCDE1234F).");
                    $(this).val('');
                }
            }
        });

        $(document).on('blur', '.IFSC', function () {
            var val = $(this).val().trim().toUpperCase();
            $(this).val(val);
            if (val !== "") {
                var ifscPat = /^[A-Z]{4}0[A-Z0-9]{6}$/;
                if (val.length !== 11 || !ifscPat.test(val)) {
                    alert("Invalid IFSC Code. Standard format is 4 letters, 0, followed by 6 alphanumeric characters (11 characters total).");
                    $(this).val('');
                }
            }
        });

        function openFlatpickr(id) {
            var el = document.getElementById(id);
            if (el) {
                if (el._flatpickr) {
                    el._flatpickr.open();
                } else {
                    el.focus();
                }
            }
        }

        function initFlatpickr() {
            if (typeof flatpickr !== 'undefined') {
                // DOB Picker (Employee Date of Birth)
                var dobEl = document.getElementById("txtEmp_Dob");
                if (dobEl) {
                    flatpickr(dobEl, {
                        dateFormat: "d/m/Y",
                        maxDate: "today",
                        allowInput: true,
                        onChange: function (selectedDates, dateStr, instance) {
                            RetirementDate();
                        }
                    });
                }

                // Child DOB Picker
                var childDobEl = document.getElementById("txtChild_Dob");
                if (childDobEl) {
                    flatpickr(childDobEl, {
                        dateFormat: "d/m/Y",
                        maxDate: "today",
                        allowInput: true
                    });
                }

                // Joining Date Picker
                var joinEl = document.getElementById("txtEmp_JoiningDate");
                if (joinEl) {
                    flatpickr(joinEl, {
                        dateFormat: "d/m/Y",
                        allowInput: true,
                        onChange: function (selectedDates, dateStr, instance) {
                            var postEl = document.getElementById("txtEmp_PostingDate");
                            if (selectedDates && selectedDates.length > 0 && postEl && postEl._flatpickr && postEl._flatpickr.selectedDates.length > 0) {
                                if (selectedDates[0] > postEl._flatpickr.selectedDates[0]) {
                                    alert("Join date should not be greater than Posting Date.");
                                    instance.clear();
                                }
                            }
                            if ($('#txtEmp_RetirementDate').val() == "") {
                                RetirementDate();
                            }
                        }
                    });
                }

                // Posting Date Picker
                var postEl = document.getElementById("txtEmp_PostingDate");
                if (postEl) {
                    flatpickr(postEl, {
                        dateFormat: "d/m/Y",
                        allowInput: true,
                        onChange: function (selectedDates, dateStr, instance) {
                            var joinEl = document.getElementById("txtEmp_JoiningDate");
                            if (selectedDates && selectedDates.length > 0 && joinEl && joinEl._flatpickr && joinEl._flatpickr.selectedDates.length > 0) {
                                if (joinEl._flatpickr.selectedDates[0] > selectedDates[0]) {
                                    alert("Posting Date cannot be less than Joining Date.");
                                    instance.clear();
                                }
                            }
                        }
                    });
                }

                // Any other datetime-local elements
                flatpickr(".datetime-local:not(.dob-picker):not(.date-picker-joining):not(.date-picker-posting)", {
                    dateFormat: "d/m/Y",
                    allowInput: true
                });
            }
        }

        function initPlugins() {
            if ($.fn.select2) {
                $('.select2').select2();
            }
            if ($.fn.datepicker) {
                $('.DateAdd').datepicker({
                    autoclose: true,
                    format: 'dd/mm/yyyy',
                    todayHighlight: true
                });
            }
            initFlatpickr();
        }

        $(document).ready(function () {
            initPlugins();
            Validation();
        });

        if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initPlugins();
            });
        }
    </script>
</asp:Content>





