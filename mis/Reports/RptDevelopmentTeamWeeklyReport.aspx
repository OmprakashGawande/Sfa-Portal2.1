<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptDevelopmentTeamWeeklyReport.aspx.cs" Inherits="mis_Reports_RptDevelopmentTeamWeeklyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
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
                                            ID="rfvFromDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select From Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select From Date.'></i>"
                                            ControlToValidate="txtFromDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>From Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtFromDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local" />
                                </div>
                            </div>

                            <!-- To Date -->
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvToDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select To Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select To Date.'></i>"
                                            ControlToValidate="txtToDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>To Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local" />
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClick="btnSave_Click" ValidationGroup="Save" />
                                <a href="RptPMWeeklyReport.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvDevWeeklyReport" OnRowCommand="gvDevWeeklyReport_RowCommand"
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
                                                    <asp:Label ID="lblWeekStartDate" runat="server" Text='<%# Eval("WeekStartDate") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblWeekEndDate" runat="server" Text='<%# Eval("WeekEndDate") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportDate" runat="server" Text='<%# Eval("ReportDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Task Received From Project Manager" ItemStyle-CssClass="center-grid" Visible="false">
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
                                            <asp:TemplateField HeaderText="Code Audited by Ritesh Sir" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodeAudited" runat="server" Text='<%# Eval("CodeAudited") %>'></asp:Label>
                                                    <asp:Label ID="lblCodeAuditedBy" runat="server" Text='<%# Eval("CodeAuditedBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReason" runat="server" Text='<%# Eval("Reason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Coding Standards Followed" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCodingStandardsFollowed" runat="server" Text='<%# Eval("CodingStandardsFollowed") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of SQL Queries (Total Queries)" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfSQLQueriesTotal" runat="server" Text='<%# Eval("NoOfSQLQueriesTotal") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of SQL Queries (Optimize)" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfSQLQueriesOptimize" runat="server" Text='<%# Eval("NoOfSQLQueriesOptimize") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Procedures (Total Procedures)" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfProceduresTotal" runat="server" Text='<%# Eval("NoOfProceduresTotal") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Procedures (Optimize)" ItemStyle-CssClass="center-grid" Visible="false">
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
                                            <asp:TemplateField HeaderText="View Weekly Report" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkView"
                                                        runat="server"
                                                        Text="View"
                                                        CommandName="ViewReport"
                                                        CommandArgument='<%# Eval("DevReportId") %>'
                                                        CssClass="btn btn-info btn-sm">
                                                    </asp:LinkButton>
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
        <!--  Add Module -->
        <div id="AddModuleModal" class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myLargeAddModuleModel">Weekly Report (Development Team)</h4>
                        <div>
                            <button type="button" class="btn btn-sm btn-primary me-2" onclick="printCurrentWeeklyReport()">
                                <i class="bi bi-printer"></i>Print
                            </button>
                            <button class="btn-close py-0" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                    </div>
                    <div class="modal-body dark-modal">
                        <div class="row" style="padding: 7px;">
                            <div class="col-md-12">
                                <asp:Label runat="server" ID="lblMsgModule" Text=""></asp:Label>
                            </div>
                        </div>
                        <div>
                            <div>
                                <!-- Modal Body -->
                                <div class="modal-body">
                                    <div runat="server" id="weeklyReportContainer">
                                        <asp:Literal ID="litWeeklyReport" runat="server"></asp:Literal>
                                    </div>
                                    <!-- Modal Footer -->
                                    <div class="modal-footer">
                                        <button
                                            type="button"
                                            class="btn btn-secondary"
                                            onclick="closePopup('#AddModuleModal')">
                                            Close
                                        </button>
                                    </div>
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
        document.addEventListener("DOMContentLoaded", function () {
            var fromDate = document.getElementById("<%= txtFromDate.ClientID %>");
            var toDate = document.getElementById("<%= txtToDate.ClientID %>");

            function parseDate(str) {
                // dd/MM/yyyy ko JS Date me convert kare
                var parts = str.split("/");
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }

            fromDate.addEventListener("change", function () {
                toDate.value = "";
            });

            toDate.addEventListener("change", function () {
                if (fromDate.value && toDate.value) {
                    var fDate = parseDate(fromDate.value);
                    var tDate = parseDate(toDate.value);

                    if (tDate < fDate) {
                        alert("To Date cannot be earlier than From Date!");
                        toDate.value = "";
                    }
                }
            });
        });
    </script>
    <script>
        function printCurrentWeeklyReport() {
            var container = document.getElementById('<%= weeklyReportContainer.ClientID %>');

            if (container) {
                var printWindow = window.open('', '', 'width=1000,height=800');
                printWindow.document.write('<html><head><title>Print</title></head><body>');
                printWindow.document.write(container.innerHTML);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.focus();
                printWindow.print();
                printWindow.close();
            }
        }

    </script>
    <script>
        $(document).ready(function () {
            initCustomDataTable('.datatable', 'Development Team Weekly Report', 'Development Team Weekly Report', [20]);
        });
    </script>
</asp:Content>

