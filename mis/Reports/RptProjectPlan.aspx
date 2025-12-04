<%@ Page Title="Project Plan Report" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptProjectPlan.aspx.cs" Inherits="mis_Reports_RptProjectPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="server">
    <style>
        body {
            font-family: 'Calibri', Arial, sans-serif;
            font-size: 14px;
        }

        .main-container {
            width: 98%;
            margin: auto;
            border: 1px solid #000;
            padding: 10px;
        }

        .section-title {
            text-align: center;
            font-weight: bold;
            text-decoration: underline;
            font-size: 16px;
            margin-top: 10px;
            margin-bottom: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 6px;
        }

        th, td {
            border: 1px solid #000;
            padding: 5px 6px;
            text-align: center;
            vertical-align: middle;
        }

        th {
            background-color: #d9d9d9;
            font-weight: bold;
        }

        .project-detail-table th {
            width: 20%;
        }

        .project-detail-table td {
            width: 30%;
        }

        .dropdown-section {
            text-align: left;
            margin-bottom: 10px;
        }

            .dropdown-section label {
                font-weight: bold;
                margin-right: 10px;
            }

        /* Print Styling */
        @media print {
            .dropdown-section {
                display: none;
            }
        }

        .fs-badge {
            border: 1px dashed #cbd5e1;
            padding: 1rem;
            border-radius: 8px;
            margin: 1rem 0;
        }

            .fs-badge .legend-badge {
                display: inline-block;
                padding: 0.25rem 0.6rem;
                font-size: 0.85rem;
                border-radius: 999px;
                background: #eef2ff;
                color: #3730a3;
                font-weight: 600;
                border: 1px solid rgba(55,48,163,0.08);
            }

        /* make legend text scale a little on small screens */
        @media (max-width: 480px) {
            .fs-simple legend,
            .fs-overlap legend,
            .fs-badge .legend-badge {
                font-size: 0.82rem;
                padding-left: 0.4rem;
                padding-right: 0.4rem;
            }
        }
        /* prefer reduced motion for users who requested it */
        @media (prefers-reduced-motion: reduce) {
            .fs-overlap legend {
                transition: none;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">

                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Project Plan</h4>

                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvPriorityType"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Project."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Priority.'></i>"
                                            ControlToValidate="ddlProject"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Project<span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlProject" CssClass="form-select select2" runat="server"></asp:DropDownList>

                                </div>

                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSearch" OnClick="btnSearch_Click" Text="Save" ValidationGroup="Save" />
                                <a href="RptProjectPlan.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
                        </div>



                    </div>
                </div>
            </div>
        </div>

        <fieldset class="fs-badge">
            <div class="text-center mb-3" id="DivButton" runat="server" visible="false">
                <button type="button" class="btn btn-success" onclick="exportProjectReportToExcel()">📊 Export to Excel</button>
            </div>
            <legend><span class="legend-badge">Project Detail</span></legend>
            <div class="row g-3">
                <div class="col-md-6">
                    <table class="project-detail-table">
                        <tr>

                            <td rowspan="5">
                                <img src="../assets/images/logo/logo_darkNew-1.png" style="height: 100px; width: 180px" /></td>
                            <th>Project Name</th>
                            <td>
                                <asp:Label ID="lblProjectName" runat="server" /></td>

                        </tr>
                        <tr>
                            <th>Project ID</th>
                            <td>
                                <asp:Label ID="lblProjectID" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Client Name</th>
                            <td>
                                <asp:Label ID="lblClientName" runat="server" /></td>

                        </tr>
                        <tr>
                            <th>Project Start Date</th>
                            <td>
                                <asp:Label ID="lblStartDate" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Project End Date</th>
                            <td>
                                <asp:Label ID="lblEndDate" runat="server" /></td>
                        </tr>
                    </table>

                </div>

            </div>
        </fieldset>
        <fieldset class="fs-badge">
            <legend><span class="legend-badge">Project Plan</span></legend>
            <div class="row g-3">
                <asp:GridView ID="grdProjectPlan" runat="server" AutoGenerateColumns="False" CssClass="project-plan-table" ShowHeaderWhenEmpty="True">
                    <Columns>
                        <asp:BoundField DataField="SrNo" HeaderText="Sr. No" />
                        <asp:BoundField DataField="Phase" HeaderText="Phase" />
                        <asp:BoundField DataField="DetailedTask" HeaderText="Detailed Task Description" />
                        <asp:BoundField DataField="DeliverableTo" HeaderText="Deliverable To" />
                        <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To / Team" />
                        <asp:BoundField DataField="Role" HeaderText="Role" />
                        <asp:BoundField DataField="ManpowerCount" HeaderText="Manpower Count" />
                        <%--<asp:BoundField DataField="AssignDate" HeaderText="Assign Date" />--%>
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" />
                        <asp:BoundField DataField="Duration" HeaderText="Duration (Days)" />
                        <asp:BoundField DataField="Dependency" HeaderText="Dependency" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="Priority" HeaderText="Priority" />
                        <asp:BoundField DataField="CompletedPercent" HeaderText="% Completed" />
                        <asp:BoundField DataField="PlannedMilestone" HeaderText="Planned Milestone" />
                        <asp:BoundField DataField="RiskIssue" HeaderText="Risk / Issue" />
                        <asp:BoundField DataField="ActionRequired" HeaderText="Action Required" />
                    </Columns>
                    <HeaderStyle BackColor="#d9d9d9" Font-Bold="True" />
                    <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:GridView>
            </div>
        </fieldset>



    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="server">

    <script type="text/javascript">
        // 🔹 PRINT FUNCTION
        function printProjectReport() {
            var printContents = '';
            var projectDetails = document.querySelector('.project-detail-table').outerHTML;
            var projectPlan = document.querySelector('.project-plan-table').outerHTML;

            printContents += '<h2 style="text-align:center;margin-bottom:10px;">Project Plan Report</h2>';
            printContents += '<h3 style="margin-top:10px;">Project Detail</h3>';
            printContents += projectDetails;
            printContents += '<br><h3>Project Plan</h3>';
            printContents += projectPlan;

            var win = window.open('', '', 'height=900,width=1200');
            win.document.write('<html><head><title>Project Plan Report</title>');
            win.document.write('<style>');
            win.document.write('body{font-family:Calibri,Arial,sans-serif;font-size:14px;}');
            win.document.write('table{border-collapse:collapse;width:100%;}');
            win.document.write('th,td{border:1px solid #000;padding:6px;text-align:center;vertical-align:middle;}');
            win.document.write('th{background-color:#d9d9d9;font-weight:bold;}');
            win.document.write('img{height:100px;width:180px;}');
            win.document.write('h2,h3{text-align:center;}');
            win.document.write('</style></head><body>');
            win.document.write(printContents);
            win.document.write('</body></html>');
            win.document.close();
            win.print();
        }

        // 🔹 EXCEL EXPORT FUNCTION
        function exportProjectReportToExcel() {
            var table1 = document.querySelector('.project-detail-table').outerHTML;
            var table2 = document.querySelector('.project-plan-table').outerHTML;

            var html = `
                <html>
                    <head>
                        <meta charset="UTF-8">
                        <style>
                            table {border-collapse: collapse; width: 100%;}
                            th, td {border: 1px solid #000; padding: 6px; text-align: center;}
                            th {background-color: #d9d9d9;}
                        </style>
                    </head>
                    <body>
                        <h2 style="text-align:center;">Project Plan Report</h2>
                        <h3>Project Detail</h3>
                        ${table1}
                        <br><h3>Project Plan</h3>
                        ${table2}
                    </body>
                </html>`;

            var blob = new Blob([html], { type: 'application/vnd.ms-excel' });
            var url = URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = 'ProjectPlanReport.xls';
            a.click();
            URL.revokeObjectURL(url);
        }
    </script>
</asp:Content>
