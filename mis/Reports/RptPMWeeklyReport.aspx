<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptPMWeeklyReport.aspx.cs" Inherits="mis_Reports_RptPMWeeklyReport" %>

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
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvPMWeeklyReport" OnRowCommand="gvPMWeeklyReport_RowCommand"
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
                                                    <asp:Label ID="lblWeekStartDate" runat="server" Text='<%# Eval("WeekStartDate") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblWeekEndDate" runat="server" Text='<%# Eval("WeekEndDate") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid" Visible="false">
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
                                            <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskATATMReaso" runat="server" Text='<%# Eval("TaskATATMReaso") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reporting Submitted by All Team" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportingSubmittedbyAllTeam" runat="server" Text='<%# Eval("ReportingSubmittedbyAllTeam") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reporting Submitted by All Team Reason" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReportingSubmittedbyAllTeamReason" runat="server" Text='<%# Eval("ReportingSubmittedbyAllTeamReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Overrun" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsTimeOverrun" runat="server" Text='<%# Eval("IsTimeOverrun") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Overrun Reason" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTimeOverrunReason" runat="server" Text='<%# Eval("TimeOverrunReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client Meeting" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsClientMeeting" runat="server" Text='<%# Eval("IsClientMeeting") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Meeting's" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNumberOfMeetings" runat="server" Text='<%# Eval("NumberOfMeetings") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Cases Passed" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTestCasesPassed" runat="server" Text='<%# Eval("TestCasesPassed") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Cases Fail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTestCasesFail" runat="server" Text='<%# Eval("TestCasesFail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code Upload" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsCodeUpload" runat="server" Text='<%# Eval("IsCodeUpload") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Audited from Audit Team" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsAuditedFromAuditTeam" runat="server" Text='<%# Eval("IsAuditedFromAuditTeam") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Delay" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsProjectDelay" runat="server" Text='<%# Eval("IsProjectDelay") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Delay Reason" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectDelayReason" runat="server" Text='<%# Eval("ProjectDelayReason") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Major Challenges" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsMajorChallenges" runat="server" Text='<%# Eval("IsMajorChallenges") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Major Challenges Detail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMajorChallengesDetail" runat="server" Text='<%# Eval("MajorChallengesDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Internal Support Required" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsInternalSupportRequired" runat="server" Text='<%# Eval("IsInternalSupportRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Internal Support Required Detail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInternalSupportDetail" runat="server" Text='<%# Eval("InternalSupportDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any External Support Required" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsExternalSupportRequired" runat="server" Text='<%# Eval("IsExternalSupportRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any External Support Required Detail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExternalSupportDetail" runat="server" Text='<%# Eval("ExternalSupportDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Team Utilization" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTeamUtilization" runat="server" Text='<%# Eval("TeamUtilization") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Team Utilization Detail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTeamUtilizationDetail" runat="server" Text='<%# Eval("TeamUtilizationDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daily Standup Meeting" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDailyStandupMeeting" runat="server" Text='<%# Eval("DailyStandupMeeting") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Daily Standup Meeting Detail" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDailyStandupMeetingDetail" runat="server" Text='<%# Eval("DailyStandupMeetingDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="All MOM Email Shared" ItemStyle-CssClass="center-grid" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllMOMEmailShered" runat="server" Text='<%# Eval("AllMOMEmailShered") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="All MOM Email Shared Detail" ItemStyle-CssClass="center-grid" Visible="false">
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
                                            <asp:TemplateField HeaderText="View Weekly Report" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkView"
                                                        runat="server"
                                                        Text="View"
                                                        CommandName="ViewReport"
                                                        CommandArgument='<%# Eval("PMWeeklyReportId") %>'
                                                        CssClass="btn btn-info btn-sm">
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="View Detail Report" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:LinkButton
                                                        ID="lnkViewFull"
                                                        runat="server"
                                                        Text="View"
                                                        CommandName="ViewFullReport"
                                                        CommandArgument='<%# Eval("PMWeeklyReportId") %>'
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
                        <h4 class="modal-title" id="myLargeAddModuleModel">Weekly Report (Project Manager)</h4>
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
                                    <div runat="server" visible="false" id="weeklyReportContainer">
                                        <asp:Literal ID="litWeeklyReport" runat="server"></asp:Literal>
                                    </div>
                                    <div runat="server" visible="false" id="weeklyReportContainer2">
                                        <asp:Literal ID="litWeeklyReportFull" runat="server"></asp:Literal>
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
        document.addEventListener('DOMContentLoaded', function () {
            var modal = document.getElementById('ModalPMData');

            modal.addEventListener('shown.bs.modal', function () {
                // Agar datatable already initialized hai
                if ($.fn.DataTable.isDataTable('#<%= gvPMWeeklyReport.ClientID %>')) {
                    $('#<%= gvPMWeeklyReport.ClientID %>').DataTable().columns.adjust().draw();
                }
            });
        });
    </script>
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
            var container1 = document.getElementById('<%= weeklyReportContainer.ClientID %>');
            var container2 = document.getElementById('<%= weeklyReportContainer2.ClientID %>');
            var printContents = '';

            if (container1 && container1.style.display !== 'none') {
                printContents = container1.innerHTML;
            }
            else if (container2 && container2.style.display !== 'none') {
                printContents = container2.innerHTML;
            }

            if (printContents) {
                var printWindow = window.open('', '', 'width=1000,height=800');
                printWindow.document.write('<html><head><title>Print</title></head><body>');
                printWindow.document.write(printContents);
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
            // Main page DataTable
            initCustomDataTable('.datatable', 'Project Manager Weekly Report', 'Project Manager Weekly Report', [12, 13]);
        });
    </script>
</asp:Content>

