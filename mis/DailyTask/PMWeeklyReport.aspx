<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PMWeeklyReport.aspx.cs" Inherits="mis_DailyTask_PMWeeklyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <%--Confirmation Modal Start --%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div style="display: table; height: 100%; width: 100%;">
                <div class="modal-dialog" style="width: 340px; display: table-cell; vertical-align: middle;">
                    <div class="modal-content" style="width: inherit; height: inherit; margin: 0 auto;">
                        <div class="modal-header" style="background-color: #d7c9988c;">

                            <span class="modal-title f-15" style="float: left;" id="myModalLabel">Confirmation</span>
                            <button type="button" class="btn-close py-0 white" data-bs-dismiss="modal" aria-label="Close" data-dismiss="modal">
                            </button>
                        </div>
                        <div class="clearfix"></div>
                        <div class="modal-body">
                            <p>
                                <%--<img src="../assets/images/question-circle.png" width="30" />--%>&nbsp;&nbsp; 
                           <i class="fa fa-question-circle"></i>
                                <asp:Label ID="lblPopupAlert" runat="server"></asp:Label>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="btnYes" OnClick="btnSave_Click" />
                            <button
                                type="button"
                                class="btn btn-secondary"
                                onclick="closePopup('#myModal')">
                                No
                            </button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <%--ConfirmationModal End --%>
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Weekly Report</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvAllocationDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Date.'></i>"
                                            ControlToValidate="txtDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                        data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control datetime-local" />
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Project."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Project.'></i>"
                                            ControlToValidate="txtTotalProject"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Project<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalProject" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Task."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Task.'></i>"
                                            ControlToValidate="txtTotalTask"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Task<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalTask" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV19"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Task Allocated to All Team Members"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Task Allotted to All Team Members.'></i>"
                                            ControlToValidate="ddlTaskATATM"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Task Allocated to All Team Members<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlTaskATATM" CssClass="form-select select2" OnSelectedIndexChanged="ddlTaskATATM_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_TaskATATMReason" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV20" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Reason."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Reason.'></i>"
                                            ControlToValidate="txtTaskATATMReason"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtTaskATATMReason" runat="server" TextMode="MultiLine" placeholder="Enter Reason" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV21"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Reporting Submitted by All Team"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Reporting Submitted by All Team.'></i>"
                                            ControlToValidate="ddlReportingSubmittedbyAllTeam"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Task Reporting Submitted by All Team<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlReportingSubmittedbyAllTeam" CssClass="form-select select2" OnSelectedIndexChanged="ddlReportingSubmittedbyAllTeam_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_ReportingSubmittedbyAllTeamReason" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV22" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Reason."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Reason.'></i>"
                                            ControlToValidate="txtReportingSubmittedbyAllTeamReason"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtReportingSubmittedbyAllTeamReason" runat="server" TextMode="MultiLine" placeholder="Enter Reason" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Time Overrun."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Time Overrun.'></i>"
                                            ControlToValidate="ddlTimeOverrun"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Time Overrun<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlTimeOverrun" CssClass="form-select select2" OnSelectedIndexChanged="ddlTimeOverrun_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_TOReason" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV4" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Reason."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Reason.'></i>"
                                            ControlToValidate="txtTotalTask"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtTOReason" runat="server" TextMode="MultiLine" placeholder="Enter Reason" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV5"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Client Meeting."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Client Meeting.'></i>"
                                            ControlToValidate="ddlClientMeeting"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Client Meeting<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlClientMeeting" CssClass="form-select select2" OnSelectedIndexChanged="ddlClientMeeting_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_NoofMeeting" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV6" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No. of Meeting."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No. of Meeting.'></i>"
                                            ControlToValidate="txtNoofMeeting"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No. of Meeting's<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofMeeting" runat="server" placeholder="Enter No. of Meeting" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV10"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Audited from Audit Team."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Audited from Audit Team.'></i>"
                                            ControlToValidate="ddlAuditedfromAuditTeam"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Audited from Audit Team<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAuditedfromAuditTeam" CssClass="form-select select2">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV7"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Test Cases Passed"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Test Cases Passed.'></i>"
                                            ControlToValidate="txtTestCasesPassed"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Test Cases Passed<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput2(this)" ID="txtTestCasesPassed" runat="server" placeholder="Enter Test Cases Passed" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV8"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Test Cases Fail"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Test Cases Fail.'></i>"
                                            ControlToValidate="txtTestCasesFail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Test Cases Fail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput2(this)" ID="txtTestCasesFail" runat="server" placeholder="Enter Test Cases Fail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV9"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Code Upload."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Code Upload.'></i>"
                                            ControlToValidate="ddlCodeUpload"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Code Upload<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlCodeUpload" CssClass="form-select select2">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV11"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Project Delay."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Project Delay.'></i>"
                                            ControlToValidate="ddlProjectDelay"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Project Delay<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlProjectDelay" CssClass="form-select select2" OnSelectedIndexChanged="ddlProjectDelay_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_PDReason" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV12" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Reason."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Reason.'></i>"
                                            ControlToValidate="txtPDReason"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtPDReason" runat="server" TextMode="MultiLine" placeholder="Enter Reason" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV13"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Major Challenges."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Major Challenges.'></i>"
                                            ControlToValidate="ddlMajorChallenges"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Major Challenges<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlMajorChallenges" CssClass="form-select select2" OnSelectedIndexChanged="ddlMajorChallenges_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_MCDetail" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV14" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtMCDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Detail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtMCDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV15"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any Internal Support Required."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any Internal Support Required.'></i>"
                                            ControlToValidate="ddlAnyInternalSupportRequired"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Internal Support Required<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyInternalSupportRequired" CssClass="form-select select2" OnSelectedIndexChanged="ddlAnyInternalSupportRequired_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_AISRDetail" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV16" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtAISRDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Detail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAISRDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV17"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any External Support Required."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any External Support Required.'></i>"
                                            ControlToValidate="ddlAnyExternalSupportRequired"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any External Support Required<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyExternalSupportRequired" CssClass="form-select select2" OnSelectedIndexChanged="ddlAnyExternalSupportRequired_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_AESRDetail" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV18" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtAESRDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Detail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAESRDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV23"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Team Utilization %."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Team Utilization %.'></i>"
                                            ControlToValidate="txtTeamUtilization"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Team Utilization %<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtTeamUtilization" runat="server"
                                        placeholder="Enter Team Utilization %"
                                        CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <label runat="server">Team Utilization Detail</label>
                                    <asp:TextBox autocomplete="off" ID="txtTeamUtilizationDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV24"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Daily Standup Meeting."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Daily Standup Meeting.'></i>"
                                            ControlToValidate="ddlDailyStandupMeeting"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Daily Standup Meeting<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlDailyStandupMeeting" CssClass="form-select select2" OnSelectedIndexChanged="ddlDailyStandupMeeting_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_DailyStandupMeeting" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV25" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtDailyStandupMeetingDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Detail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtDailyStandupMeetingDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV26"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select All MOM / Email Shered."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select All MOM / Email Shered.'></i>"
                                            ControlToValidate="ddlAllMOMEmailShered"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">All MOM / Email Shered<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAllMOMEmailShered" CssClass="form-select select2" OnSelectedIndexChanged="ddlAllMOMEmailShered_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_AllMOMEmailShered" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV27" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtAllMOMEmailSheredDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Detail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAllMOMEmailSheredDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV28"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any Team Memberes (Underutilized)."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any Team Memberes (Underutilized).'></i>"
                                            ControlToValidate="ddlAnyTeamMemberesU"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Team Memberes (Underutilized)<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyTeamMemberesU" CssClass="form-select select2" OnSelectedIndexChanged="ddlAnyTeamMemberesU_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_AnyTeamMemberesU" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV29" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Detail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Detail.'></i>"
                                            ControlToValidate="txtAnyTeamMemberesUDetail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason With Name<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAnyTeamMemberesUDetail" runat="server" TextMode="MultiLine" placeholder="Enter Detail" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="PMWeeklyReport.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />
                <div class="card border-warning">
                    <div class="card-header">
                        <h4>Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvPMWeeklyReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="PMWeeklyReportId">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Manager Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("PMName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblWeeklyReportDate" runat="server" Text='<%# Eval("WeeklyReportDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Project" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalProject" runat="server" Text='<%# Eval("TotalProject") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Task" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalTask" runat="server" Text='<%# Eval("TotalTask") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Task Allocated to All Team Members" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskATATM" runat="server" Text='<%# Eval("TaskATATM") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskATATMReaso" runat="server" Text='<%# Eval("TaskATATMReaso") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reporting Submitted by All Team" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportingSubmittedbyAllTeam" runat="server" Text='<%# Eval("ReportingSubmittedbyAllTeam") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reporting Submitted by All Team Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportingSubmittedbyAllTeamReason" runat="server" Text='<%# Eval("ReportingSubmittedbyAllTeamReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Overrun" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsTimeOverrun" runat="server" Text='<%# Eval("IsTimeOverrun") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Overrun Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTimeOverrunReason" runat="server" Text='<%# Eval("TimeOverrunReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client Meeting" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsClientMeeting" runat="server" Text='<%# Eval("IsClientMeeting") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Meeting's" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNumberOfMeetings" runat="server" Text='<%# Eval("NumberOfMeetings") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Cases Passed" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTestCasesPassed" runat="server" Text='<%# Eval("TestCasesPassed") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Cases Fail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTestCasesFail" runat="server" Text='<%# Eval("TestCasesFail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code Upload" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsCodeUpload" runat="server" Text='<%# Eval("IsCodeUpload") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Audited from Audit Team" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsAuditedFromAuditTeam" runat="server" Text='<%# Eval("IsAuditedFromAuditTeam") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Delay" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsProjectDelay" runat="server" Text='<%# Eval("IsProjectDelay") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Delay Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectDelayReason" runat="server" Text='<%# Eval("ProjectDelayReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Major Challenges" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsMajorChallenges" runat="server" Text='<%# Eval("IsMajorChallenges") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Major Challenges Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMajorChallengesDetail" runat="server" Text='<%# Eval("MajorChallengesDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Internal Support Required" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsInternalSupportRequired" runat="server" Text='<%# Eval("IsInternalSupportRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Internal Support Required Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInternalSupportDetail" runat="server" Text='<%# Eval("InternalSupportDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any External Support Required" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsExternalSupportRequired" runat="server" Text='<%# Eval("IsExternalSupportRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any External Support Required Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExternalSupportDetail" runat="server" Text='<%# Eval("ExternalSupportDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Team Utilization" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTeamUtilization" runat="server" Text='<%# Eval("TeamUtilization") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Team Utilization Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTeamUtilizationDetail" runat="server" Text='<%# Eval("TeamUtilizationDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daily Standup Meeting" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDailyStandupMeeting" runat="server" Text='<%# Eval("DailyStandupMeeting") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daily Standup Meeting Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDailyStandupMeetingDetail" runat="server" Text='<%# Eval("DailyStandupMeetingDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="All MOM Email Shared" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllMOMEmailShered" runat="server" Text='<%# Eval("AllMOMEmailShered") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="All MOM Email Shared Detail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllMOMEmailSheredDetail" runat="server" Text='<%# Eval("AllMOMEmailSheredDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Team Memberes (Underutilized)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyTeamMemberesU" runat="server" Text='<%# Eval("AnyTeamMemberesU") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason With Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyTeamMemberesUDetail" runat="server" Text='<%# Eval("AnyTeamMemberesUDetail") %>'></asp:Label>
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        function ValidatePage() {

            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate('Save');
            }

            if (Page_IsValid) {

                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Update") {
                    document.getElementById('<%=lblPopupAlert.ClientID%>').textContent = "Are you sure you want to Update this record?";
                    $('#myModal').modal('show');
                    return false;
                }
                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Save") {
                    document.getElementById('<%=lblPopupAlert.ClientID%>').textContent = "Are you sure you want to Save this record?";
                    $('#myModal').modal('show');
                    return false;
                }
            }
        }
        function sanitizeInput(el) {
            // sirf digit lo
            let v = (el.value || '').replace(/\D+/g, '');
            // max 2 digit
            if (v.length > 2) v = v.slice(0, 2);
            // agar 0 ya 00 hai to empty kar do
            if (v === "0" || v === "00") v = "";
            el.value = v;
        }
        function sanitizeInput2(el) {
            // sirf digit lo
            let v = (el.value || '').replace(/\D+/g, '');
            //if (v === "0" || v === "00") v = "";
            el.value = v;
        }

        document.addEventListener("DOMContentLoaded", function () {
            var txt = document.getElementById("<%= txtTeamUtilization.ClientID %>");

            txt.addEventListener("input", function () {
                // सिर्फ digits और वैकल्पिक % चिन्ह की अनुमति
                this.value = this.value.replace(/[^0-9%]/g, '');

                // अगर यूजर ने % लगाया है तो सिर्फ एक बार आने दे और आख़िर में ही हो
                this.value = this.value.replace(/(%.+)/g, '%');

                // सिर्फ 0-100 तक की वैल्यू allow करे
                let val = this.value.replace('%', '');
                if (val !== "" && Number(val) > 100) {
                    this.value = "100%";
                }
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            // Main page DataTable
            initCustomDataTable('.datatable', 'Project Manager Weekly Report', 'Project Manager Weekly Report');
        });
    </script>
</asp:Content>

