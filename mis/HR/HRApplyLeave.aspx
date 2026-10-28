<%@ Page Title="Apply for Leave" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRApplyLeave.aspx.cs" Inherits="mis_HR_HRApplyLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <!-- Flatpickr CSS & FontAwesome -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
    <link rel="stylesheet" type="text/css" href="../assets/css/vendors/flatpickr/flatpickr.min.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <style>
        .leave-card {
            border-radius: 16px;
            border: 1px solid #edf0f5;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
            background: #ffffff;
            margin-bottom: 25px;
            overflow: hidden;
        }

        .leave-card-header {
            padding: 18px 24px;
            background: #ffffff;
            border-bottom: 1px solid #f1f4f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .form-label-custom {
            font-size: 0.88rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
            display: block;
        }

        .lblBalanceLeave {
            font-size: 15px;
            color: #1e40af;
            font-weight: 600;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            padding: 10px 16px;
            border-radius: 10px;
            display: inline-block;
            margin-top: 5px;
        }

        .btn-apply-leave {
            background: linear-gradient(135deg, #7366ff 0%, #5142f5 100%);
            border: none;
            color: #ffffff !important;
            padding: 10px 28px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.92rem;
            box-shadow: 0 4px 14px rgba(115, 102, 255, 0.35);
            transition: all 0.25s ease;
        }

        .btn-apply-leave:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(115, 102, 255, 0.45);
            background: linear-gradient(135deg, #5b4bf0 0%, #3f2fe0 100%);
        }

        .btn-clear-leave {
            background: #f8fafc;
            border: 1px solid #cbd5e1;
            color: #475569 !important;
            padding: 10px 24px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.92rem;
            transition: all 0.25s ease;
        }

        .btn-clear-leave:hover {
            background: #e2e8f0;
            color: #1e293b !important;
        }

        .input-group-text {
            border-color: #dee2e6;
        }

        .form-control:focus, .form-select:focus {
            border-color: #7366ff;
            box-shadow: 0 0 0 0.2rem rgba(115, 102, 255, 0.15);
        }

        .flatpickr-calendar {
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
            border-radius: 12px !important;
            border: 1px solid #e2e8f0 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid pt-3">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

        <!-- 2. LEAVE APPLICATION CARD -->
        <div class="leave-card">
            <div class="leave-card-header">
                <h5 class="mb-0 fw-bold text-dark">
                    <i class="fa fa-calendar-check-o text-primary me-2"></i> विवरण प्रविष्ट करें (Enter Leave Details)
                </h5>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill">
                    <i class="fa fa-pencil-square-o me-1"></i> Leave Request Form
                </span>
            </div>

            <div class="card-body p-4">
                <div class="row g-3">
                    <!-- Types of Leave -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="form-label-custom">
                                अवकाश का प्रकार (Types of Leave) <span class="text-danger">*</span>
                            </label>
                            <asp:DropDownList ID="ddlLeaveTpye" runat="server" CssClass="form-select select2" ClientIDMode="Static" onchange="Showhide()" OnSelectedIndexChanged="ddlLeaveTpye_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="0">Select Leave Type</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Financial Year -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="form-label-custom">
                                वित्तीय वर्ष (Select Year) <span class="text-danger">*</span>
                            </label>
                            <asp:DropDownList ID="ddlFinancial_Year" runat="server" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlLeaveTpye_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select Year</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- From Date (दिनांक से) with Flatpickr Calendar -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="form-label-custom">
                                दिनांक से (From Date) <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-primary" style="cursor: pointer;" onclick="var el=document.getElementById('<%=txtFromDate.ClientID%>'); if(el && el._flatpickr) el._flatpickr.open(); else if(el) el.focus();">
                                    <i class="fa fa-calendar"></i>
                                </span>
                                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- To Date (दिनांक तक) with Flatpickr Calendar -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="form-label-custom">
                                दिनांक तक (To Date) <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-white text-primary" style="cursor: pointer;" onclick="var el=document.getElementById('<%=txtToDate.ClientID%>'); if(el && el._flatpickr) el._flatpickr.open(); else if(el) el.focus();">
                                    <i class="fa fa-calendar"></i>
                                </span>
                                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Balance Leave Display -->
                    <div class="col-12" id="pnlBalance" runat="server">
                        <asp:Label ID="lblBalanceLeave" runat="server" Text="" CssClass="lblBalanceLeave"></asp:Label>
                        <asp:HiddenField ID="hfBalanceLeave" runat="server" />
                    </div>

                    <!-- Leave Day Option (Half Day / Full Day) -->
                    <div class="col-md-3" id="divLeaveDay" style="display: none;">
                        <div class="form-group">
                            <label class="form-label-custom">
                                अवकाश का दिन (Leave Day)
                            </label>
                            <asp:DropDownList ID="ddlLeaveDays" runat="server" CssClass="form-select">
                                <asp:ListItem>First Half</asp:ListItem>
                                <asp:ListItem>Second Half</asp:ListItem>
                                <asp:ListItem Selected="True">Full Day</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Leave Approval Authority -->
                    <div class="col-md-5">
                        <div class="form-group">
                            <label class="form-label-custom">
                                अवकाश स्वीकृतकर्ता अधिकारी (Leave Approval Authority) <span class="text-danger">*</span>
                            </label>
                            <asp:DropDownList ID="ddlEmployeeName" runat="server" CssClass="form-select select2">
                                <asp:ListItem Value="0">Select Approval Authority</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Attach Document -->
                    <div class="col-md-4">
                        <div class="form-group">
                            <label id="lblDoc" class="form-label-custom">
                                दस्तावेज संलग्न करें (Attach Document) <span id="spnAsterisk" class="text-danger" style="display: none;">*</span>
                            </label>
                            <asp:FileUpload ID="EmpLeaveDoc" CssClass="form-control" runat="server" ClientIDMode="Static" onchange="UploadControlValidationForLenthAndFileFormat(100, 'JPEG*PNG*JPG*GIF*PDF*DOC*DOCX', this),ValidateFileSize(this)" />
                            <small class="text-muted d-block mt-1" style="font-size: 11px;">
                                Allowed: JPEG, PNG, JPG, PDF, DOC, DOCX (Max: 2MB)
                            </small>
                        </div>
                    </div>

                    <!-- Reason Of Leave -->
                    <div class="col-12">
                        <div class="form-group">
                            <label id="lblReason" class="form-label-custom">
                                छुट्टी का कारण (Reason Of Leave) <span class="text-danger">*</span>
                            </label>
                            <asp:TextBox ID="txtLeaveRemark" TextMode="MultiLine" Rows="3" CssClass="form-control" runat="server" placeholder="कृपया छुट्टी का कारण यहाँ लिखें... (Enter Reason Of Leave)"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- 3. ACTION BUTTONS -->
                <div class="d-flex flex-wrap align-items-center gap-3 mt-4 pt-3 border-top">
                    <asp:Button ID="applyleave" CssClass="btn btn-apply-leave" runat="server" Text="Apply For Leave" OnClick="applyleave_Click" OnClientClick="return validateLeaveForm();" />
                    <a class="btn btn-clear-leave" href="HRApplyLeave.aspx">
                        <i class="fa fa-refresh me-1"></i> Clear Form
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <!-- Flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="../assets/js/flat-pickr/flatpickr.js"></script>

    <script type="text/javascript">
        function initCalendar() {
            if (typeof flatpickr !== "undefined") {
                flatpickr(".datetime-local", {
                    dateFormat: "d/m/Y",
                    enableTime: false,
                    allowInput: true,
                    onChange: function (selectedDates, dateStr, instance) {
                        checkDateRange();
                        Showhide();
                    }
                });
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            initCalendar();
            Showhide();
        });

        // Re-initialize flatpickr on postback
        if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initCalendar();
                Showhide();
            });
        }

        function checkDateRange() {
            var txtFrom = document.getElementById('<%=txtFromDate.ClientID%>');
            var txtTo = document.getElementById('<%=txtToDate.ClientID%>');
            if (txtFrom && txtTo && txtFrom.value.trim() !== "" && txtTo.value.trim() !== "") {
                var fromParts = txtFrom.value.trim().split('/');
                var toParts = txtTo.value.trim().split('/');
                if (fromParts.length === 3 && toParts.length === 3) {
                    var dFrom = new Date(parseInt(fromParts[2], 10), parseInt(fromParts[1], 10) - 1, parseInt(fromParts[0], 10));
                    var dTo = new Date(parseInt(toParts[2], 10), parseInt(toParts[1], 10) - 1, parseInt(toParts[0], 10));
                    if (dFrom > dTo) {
                        alert("दिनांक से, दिनांक तक से अधिक नहीं हो सकती है। (From Date cannot be greater than To Date.)");
                        txtTo.value = "";
                    }
                }
            }
        }

        function Showhide() {
            var txtFrom = document.getElementById('<%=txtFromDate.ClientID%>');
            var txtTo = document.getElementById('<%=txtToDate.ClientID%>');
            var e = document.getElementById("ddlLeaveTpye");
            var divLeaveDay = document.getElementById("divLeaveDay");
            var spnAsterisk = document.getElementById("spnAsterisk");

            if (!e || e.selectedIndex < 0) return;
            var strUser = e.options[e.selectedIndex].value;
            var FromDate = txtFrom ? txtFrom.value.trim() : "";
            var ToDate = txtTo ? txtTo.value.trim() : "";

            if (divLeaveDay) {
                if ((strUser == "1" || strUser == "3") && FromDate !== "" && FromDate === ToDate) {
                    divLeaveDay.style.display = 'block';
                } else {
                    divLeaveDay.style.display = 'none';
                }
            }

            if (spnAsterisk) {
                if (strUser == "3") {
                    spnAsterisk.style.display = 'inline';
                } else {
                    spnAsterisk.style.display = 'none';
                }
            }
        }

        function validateLeaveForm() {
            var msg = "";
            var ddlType = document.getElementById('<%=ddlLeaveTpye.ClientID%>');
            var txtFrom = document.getElementById('<%=txtFromDate.ClientID%>');
            var txtTo = document.getElementById('<%=txtToDate.ClientID%>');
            var ddlAuth = document.getElementById('<%=ddlEmployeeName.ClientID%>');
            var txtRemark = document.getElementById('<%=txtLeaveRemark.ClientID%>');

            if (ddlType && ddlType.selectedIndex <= 0) {
                msg += "कृपया अवकाश का प्रकार चुनें | (Please Select Leave Type)\n";
            }
            if (txtFrom && txtFrom.value.trim() === "") {
                msg += "कृपया दिनांक से चुनें | (Please Select From Date)\n";
            }
            if (txtTo && txtTo.value.trim() === "") {
                msg += "कृपया दिनांक तक चुनें | (Please Select To Date)\n";
            }
            if (ddlAuth && ddlAuth.selectedIndex <= 0) {
                msg += "कृपया अवकाश स्वीकृतकर्ता अधिकारी चुनें | (Please Select Approval Authority)\n";
            }
            if (txtRemark && txtRemark.value.trim() === "") {
                msg += "कृपया छुट्टी का कारण भरें | (Please Enter Reason of Leave)\n";
            }

            if (msg !== "") {
                alert(msg);
                return false;
            } else {
                return confirm("क्या आप अवकाश के लिए आवेदन करना चाहते हैं? (Do you really want to apply for leave?)");
            }
        }

        function UploadControlValidationForLenthAndFileFormat(maxLengthFileName, validFileFormaString, that) {
            var msg = '';
            if (document.getElementById(that.id).value != '') {
                var fileName = document.getElementById(that.id).value;
                var lengthFileName = parseInt(document.getElementById(that.id).value.length);
                var fileExtacntionArray = fileName.split('.');

                if (fileExtacntionArray.length >= 2) {
                    var fileExtacntion = fileExtacntionArray[fileExtacntionArray.length - 1];

                    if (lengthFileName >= parseInt(maxLengthFileName) + 1) {
                        msg += '- File name should be less than ' + maxLengthFileName + ' characters. \n';
                    }
                    for (var i = 0; i < fileName.length; i++) {
                        var charFileName = fileName.substring(i, i + 1);
                        if (['~', '!', '@', '#', '$', '%', '&', '*', '{', '}', '|', '<', '>', '?'].indexOf(charFileName) !== -1) {
                            msg += '- Special character not allowed in file name. \n';
                            break;
                        }
                    }
                    var isFileFormatCorrect = false;
                    var strValidFormates = '';

                    if (validFileFormaString != "") {
                        var fileFormatArray = validFileFormaString.split('*');
                        for (var j = 0; j < fileFormatArray.length; j++) {
                            if (fileFormatArray[j].toUpperCase() === fileExtacntion.toUpperCase()) {
                                isFileFormatCorrect = true;
                            }
                            strValidFormates += '.' + fileFormatArray[j].toLowerCase() + (j < fileFormatArray.length - 1 ? '/' : '');
                        }
                        if (!isFileFormatCorrect) {
                            msg += '- File format is not correct (only ' + strValidFormates + ').\n';
                        }
                    }
                } else {
                    msg += '- File name is incorrect';
                }
                if (msg != '') {
                    document.getElementById(that.id).value = "";
                    alert(msg);
                    return false;
                }
                return true;
            }
        }

        function ValidateFileSize(a) {
            var uploadcontrol = document.getElementById(a.id);
            if (uploadcontrol && uploadcontrol.files && uploadcontrol.files.length > 0) {
                if (uploadcontrol.files[0].size > 2097152) {
                    alert('File size should not be greater than 2 MB.');
                    uploadcontrol.value = '';
                    return false;
                }
            }
            return true;
        }
    </script>
</asp:Content>
