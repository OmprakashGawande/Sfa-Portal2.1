<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="DevelopmentTeamWeeklyReport.aspx.cs" Inherits="mis_DailyTask_DevelopmentTeamWeeklyReport" %>

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
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" OnClick="btnSave_Click" ID="btnYes" />
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
                        <h4>Development Team Weekly Report</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Date.'></i>"
                                            ControlToValidate="txtDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Date<span style="color: red;">*</span></label>
                                    <asp:TextBox runat="server" ID="txtDate"
                                        data-provide="timepicker" placeholder="DD/MM/YYYY"
                                        autocomplete="off" data-date-format="dd/mm/yyyy"
                                        data-date-autoclose="true" CssClass="form-control disableFuturedate"
                                        AutoPostBack="true"></asp:TextBox>
                                    <%-- <asp:TextBox ID="txtDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off" 
                                        data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control disableFuturedate" />--%>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No of Task Received From Project Manager."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No of Task Received From Project Manager.'></i>"
                                            ControlToValidate="txtNoofTRFPM"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No of Task Received From Project Manager<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofTRFPM" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Daily Report Submitted"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Daily Report Submitted.'></i>"
                                            ControlToValidate="ddlDailyReportSubmitted"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Daily Report Submitted<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlDailyReportSubmitted" CssClass="form-select select2">
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
                                            ID="RFV3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select QA Feedback Received"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select QA Feedback Received.'></i>"
                                            ControlToValidate="ddlQAFeedbackReceived"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">QA Feedback Received<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlQAFeedbackReceived" CssClass="form-select select2">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <%--       <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Code Audited by Ritesh Sir"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Code Audited by Ritesh Sir.'></i>"
                                            ControlToValidate="ddlCodeAudited"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Code Audited by Ritesh Sir<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlCodeAudited" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlCodeAudited_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>--%>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Code Audit"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Code Audit.'></i>"
                                            ControlToValidate="ddlCodeAudited"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Code Audit<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlCodeAudited" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlCodeAudited_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_CodeAuditedby" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFVCodeAuditedby" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Code Audited By."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Code Audited By.'></i>"
                                            ControlToValidate="txtCodeAuditedby"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Code Audited By<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtCodeAuditedby" runat="server" placeholder="Enter Code Audited By" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_CodeAuditedReason" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV5" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Reason."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Reason.'></i>"
                                            ControlToValidate="txtCodeAuditedReason"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Reason<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtCodeAuditedReason" runat="server" TextMode="MultiLine" placeholder="Enter Reason" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV6"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Coding Standards Followed"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Coding Standards Followed.'></i>"
                                            ControlToValidate="ddlCodingStandardsFollowed"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Coding Standards Followed<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlCodingStandardsFollowed" CssClass="form-select select2">
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
                                            ErrorMessage="Please Enter No of SQL Queries."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No of SQL Queries.'></i>"
                                            ControlToValidate="txtNoofSQLQueries"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No of SQL Queries (Total Queries)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofSQLQueries" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV8"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No of SQL Queries (Optimize)."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No of SQL Queries (Optimize).'></i>"
                                            ControlToValidate="txtNoofSQLQueriesOptimize"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No of SQL Queries (Optimize)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofSQLQueriesOptimize" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV9"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No of Procedures."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No of Procedures.'></i>"
                                            ControlToValidate="txtNoofProcedures"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No of Procedures (Total Procedures)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofProcedures" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV10"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No Procedures (Optimize)."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No of Procedures (Optimize).'></i>"
                                            ControlToValidate="txtNoofProceduresOptimize"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No of Procedures (Optimize)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtNoofProceduresOptimize" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV11"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any Major Challenges"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any Major Challenges.'></i>"
                                            ControlToValidate="ddlAnyMajorChallenges"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Major Challenges<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyMajorChallenges" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlAnyMajorChallenges_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_Internal" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV12" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Internal."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Internal.'></i>"
                                            ControlToValidate="txtInternal"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Internal<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtInternal" runat="server" TextMode="MultiLine" placeholder="Enter Internal" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_External" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV13" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter External."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter External.'></i>"
                                            ControlToValidate="txtExternal"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">External<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtExternal" runat="server" TextMode="MultiLine" placeholder="Enter External" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV14"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any Major Requirements"
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any Major Requirements.'></i>"
                                            ControlToValidate="ddlAnyMajorRequirements"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Major Requirements<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyMajorRequirements" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlAnyMajorRequirements_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_RequirementsInternal" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV15" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Internal."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Internal.'></i>"
                                            ControlToValidate="txtRequirementsInternal"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Internal<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtRequirementsInternal" runat="server" TextMode="MultiLine" placeholder="Enter Internal" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_RequirementsExternal" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV16" Enabled="false"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter External."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter External.'></i>"
                                            ControlToValidate="txtRequirementsExternal"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">External<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtRequirementsExternal" runat="server" TextMode="MultiLine" placeholder="Enter External" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="DevelopmentTeamWeeklyReport.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
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
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvDevReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="DevReportId">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportDate" runat="server" Text='<%# Eval("ReportDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Task Received From Project Manager" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfTaskReceivedFromPM" runat="server" Text='<%# Eval("NoOfTaskReceivedFromPM") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daily Report Submitted" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDailyReportSubmitted" runat="server" Text='<%# Eval("DailyReportSubmitted") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="QA Feedback Received" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQAFeedbackReceived" runat="server" Text='<%# Eval("QAFeedbackReceived") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code Audit" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodeAudited" runat="server" Text='<%# Eval("CodeAudited") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code Audit By" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodeAuditedBy" runat="server" Text='<%# Eval("CodeAuditedBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReason" runat="server" Text='<%# Eval("Reason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Coding Standards Followed" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodingStandardsFollowed" runat="server" Text='<%# Eval("CodingStandardsFollowed") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of SQL Queries (Total Queries)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfSQLQueriesTotal" runat="server" Text='<%# Eval("NoOfSQLQueriesTotal") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of SQL Queries (Optimize)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfSQLQueriesOptimize" runat="server" Text='<%# Eval("NoOfSQLQueriesOptimize") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Procedures (Total Procedures)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfProceduresTotal" runat="server" Text='<%# Eval("NoOfProceduresTotal") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Procedures (Optimize)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfProceduresOptimize" runat="server" Text='<%# Eval("NoOfProceduresOptimize") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Major Challenges" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyMajorChallenges" runat="server" Text='<%# Eval("AnyMajorChallenges") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Internal" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInternalNote" runat="server" Text='<%# Eval("InternalNote") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="External" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExternalNote" runat="server" Text='<%# Eval("ExternalNote") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Major Requirements" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyMajorRequirements" runat="server" Text='<%# Eval("AnyMajorRequirements") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Internal" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRequirementsInternalNote" runat="server" Text='<%# Eval("RequirementsInternalNote") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="External" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRequirementsExternalNote" runat="server" Text='<%# Eval("RequirementsExternalNote") %>'></asp:Label>
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
            //if (v === "0" || v === "00") v = "";
            el.value = v;
        }
        function sanitizeInput2(el) {
            // sirf digit lo
            let v = (el.value || '').replace(/\D+/g, '');
            //if (v === "0" || v === "00") v = "";
            el.value = v;
        }

        $(document).ready(function () {
            // Main page DataTable
            initCustomDataTable('.datatable', 'Development Team Weekly Report', 'Development Team Weekly Report');
        });
    </script>
</asp:Content>

