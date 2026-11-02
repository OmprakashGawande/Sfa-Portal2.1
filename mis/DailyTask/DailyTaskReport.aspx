<%@ Page Title="Daily Task Report" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="DailyTaskReport.aspx.cs" Inherits="mis_DailyTask_DailyTaskReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        /* Complete Vertical Alignment fix for GridView */
        .datatable th,
        .datatable td,
        #gvReport th,
        #gvReport td {
            vertical-align: middle !important;
        }

        .datatable th,
        #gvReport th {
            text-align: center !important;
            vertical-align: middle !important;
            white-space: nowrap !important;
            padding: 10px 8px !important;
        }

        .datatable td,
        #gvReport td {
            vertical-align: middle !important;
            padding: 8px 10px !important;
        }

        .text-nowrap {
            white-space: nowrap !important;
        }

        .badge-priority-high {
            background-color: #dc3545;
            color: #fff;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-priority-medium {
            background-color: #fd7e14;
            color: #fff;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-priority-low {
            background-color: #28a745;
            color: #fff;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-priority-spot {
            background-color: #6f42c1;
            color: #fff;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-priority-default {
            background-color: #6c757d;
            color: #fff;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        /* High Priority Complete Row Red */
        .row-high-priority,
        .row-high-priority > td {
            background-color: #f8d7da !important;
            color: #721c24 !important;
        }

            .row-high-priority:hover,
            .row-high-priority:hover > td {
                background-color: #f1b0b7 !important;
            }

            .row-high-priority .text-muted {
                color: #842029 !important;
            }

        .badge-ticket-a {
            background-color: #17a2b8;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-ticket-b {
            background-color: #007bff;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-ticket-c {
            background-color: #6f42c1;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-ticket-d {
            background-color: #e83e8c;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-ticket-e {
            background-color: #fd7e14;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-ticket-f {
            background-color: #20c997;
            color: #fff;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
            padding: 5px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .badge-status-complete {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-status-partial {
            background-color: #fff3cd;
            color: #664d03;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .badge-status-pending {
            background-color: #f8d7da;
            color: #842029;
            padding: 5px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
            white-space: nowrap !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }

        .table-responsive {
            overflow-x: auto !important;
        }

        .dt-buttons {
            margin-bottom: 12px;
        }

        .buttons-excel,
        a.buttons-excel,
        button.buttons-excel {
            background-color: #ff5722 !important;
            border-color: #ff5722 !important;
            color: #fff !important;
            font-weight: 600 !important;
            border-radius: 4px !important;
            padding: 6px 14px !important;
            margin-right: 6px !important;
            border: none !important;
            box-shadow: 1px 2px 4px rgba(0,0,0,0.15) !important;
        }

        .buttons-pdf,
        a.buttons-pdf,
        button.buttons-pdf {
            background-color: #e91e63 !important;
            border-color: #e91e63 !important;
            color: #fff !important;
            font-weight: 600 !important;
            border-radius: 4px !important;
            padding: 6px 14px !important;
            margin-right: 6px !important;
            border: none !important;
            box-shadow: 1px 2px 4px rgba(0,0,0,0.15) !important;
        }

        .buttons-print,
        a.buttons-print,
        button.buttons-print,
        .dt-buttons .buttons-print {
            display: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

                <!-- Filter Card -->
                <div class="card mt-3 border-primary">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h4 class="mb-0"><i class="fa fa-calendar-check-o me-2 text-primary"></i>Daily Task Report</h4>
                            <small class="text-white">Track task allocations and daily activities across date ranges</small>
                        </div>
                        <div class="mt-2 mt-md-0">
                            <asp:Label ID="lblRoleBadge" runat="server" CssClass="badge bg-light text-dark px-3 py-2 fs-6 border" Text="Role: User View"></asp:Label>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="row g-3">
                            <!-- From Date -->
                            <div class="col-xl-3 col-md-6">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        From Date <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control date-picker" placeholder="DD/MM/YYYY" autocomplete="off"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- To Date -->
                            <div class="col-xl-3 col-md-6">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        To Date <span class="text-danger">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control date-picker" placeholder="DD/MM/YYYY" autocomplete="off"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Priority Filter -->
                            <div class="col-xl-3 col-md-6">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">Priority</label>
                                    <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select select2">
                                        <asp:ListItem Text="All Priorities" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Employee Filter (Visible to Admin/Manager) -->
                            <div class="col-xl-3 col-md-6" id="divEmployeeFilter" runat="server">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">Employee</label>
                                    <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select select2">
                                        <asp:ListItem Text="All Employees" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="row mt-3">
                            <div class="col-12 d-flex justify-content-end">
                                <asp:Button ID="btnSearch" runat="server" Text="Search Report" CssClass="btn btn-primary px-4 me-2" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset Filters" CssClass="btn btn-outline-secondary px-4" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Report Results Card -->
                <div class="card mt-4">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                        <h5 class="mb-0 text-white">
                            <i class="fa fa-table text-primary me-2"></i>Task Entries Data 
                            (<asp:Label ID="lblRecordCount" runat="server" Text="0"></asp:Label>
                            records)
                        </h5>
                        <div class="mt-2 mt-md-0" style="display:none">
                            <span class="badge bg-light text-dark border p-2">Total Hours: <strong class="text-primary">
                                <asp:Label ID="lblTotalHours" runat="server" Text="0.00"></asp:Label>
                                Hrs</strong>
                            </span>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="table-responsive dt-ext">
                            <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="false"
                                CssClass="datatable table table-bordered table-hover w-100"
                                EmptyDataText="No task entries found for the selected date range and criteria."
                                OnRowDataBound="gvReport_RowDataBound" OnPreRender="gvReport_PreRender" ShowHeaderWhenEmpty="true">
                                <HeaderStyle CssClass="table-primary" />
                                <Columns>
                                    <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="45px">
                                        <ItemTemplate>
                                            <span class="fw-bold"><%# Container.DataItemIndex + 1 %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Employee" ItemStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="fw-bold text-nowrap"><%# Eval("EmployeeName") %></div>
                                            <small class="text-muted text-nowrap"><%# Eval("EmployeeCode") != null && !string.IsNullOrEmpty(Eval("EmployeeCode").ToString()) ? Eval("EmployeeCode") : "" %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Allocation Date &amp; Time" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div class="fw-bold text-nowrap">
                                                <i class="fa fa-calendar text-primary me-1"></i>
                                                <%# Eval("AllocationDate") != null && !string.IsNullOrEmpty(Eval("AllocationDate").ToString()) ? Eval("AllocationDate") : "-" %>
                                            </div>
                                            <small class="text-muted text-nowrap">
                                                <i class="fa fa-clock-o me-1"></i><%# Eval("AllocationTime") != null && !string.IsNullOrEmpty(Eval("AllocationTime").ToString()) && Eval("AllocationTime").ToString() != "-" ? Eval("AllocationTime") : "-" %>
                                            </small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Requirement Duration" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <span class="badge bg-light text-primary font-weight-bold fs-6 border text-nowrap">
                                                <i class="fa fa-hourglass-half me-1"></i><%# Eval("RequirementDuration") != null && !string.IsNullOrEmpty(Eval("RequirementDuration").ToString()) ? Eval("RequirementDuration") : "-" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Project Name" ItemStyle-Width="130px">
                                        <ItemTemplate>
                                            <span class="fw-bold text-dark text-nowrap"><%# Eval("ProjectName") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Requirement Point" ItemStyle-Width="160px">
                                        <ItemTemplate>
                                            <span class="fw-bold text-dark text-nowrap"><%# Eval("RequirementPoint") != null && !string.IsNullOrEmpty(Eval("RequirementPoint").ToString()) ? Eval("RequirementPoint") : "-" %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Description" ItemStyle-Width="180px">
                                        <ItemTemplate>
                                            <span class="text-secondary text-break"><%# Eval("TaskDescription") != null && !string.IsNullOrEmpty(Eval("TaskDescription").ToString()) ? Eval("TaskDescription") : "-" %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="QA Name" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <%# GetQABadge(Eval("QAName")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Start Date" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="105px">
                                        <ItemTemplate>
                                            <span class="text-nowrap"><i class="fa fa-calendar text-muted me-1"></i><%# Eval("StartDate") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Start Time" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="95px">
                                        <ItemTemplate>
                                            <span class="text-nowrap"><i class="fa fa-clock-o text-muted me-1"></i><%# Eval("StartTime") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="End Date" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="105px">
                                        <ItemTemplate>
                                            <span class="text-nowrap"><i class="fa fa-calendar text-muted me-1"></i><%# Eval("EndDate") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="End Time" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="95px">
                                        <ItemTemplate>
                                            <span class="text-nowrap"><i class="fa fa-clock-o text-muted me-1"></i><%# Eval("EndTime") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Hours" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="85px">
                                        <ItemTemplate>
                                            <span class="badge bg-light-success text-success font-weight-bold fs-6 text-nowrap">
                                                <%# Eval("WorkingHours") %> Hrs
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Priority" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <%# GetPriorityBadge(Eval("Priority"), Eval("PriorityId")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Allocated / Assignee" ItemStyle-Width="140px">
                                        <ItemTemplate>
                                            <span class="text-nowrap">
                                                <i class="fa fa-user-secret text-secondary me-1"></i><%# Eval("Allocated") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Ticket Type" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="120px">
                                        <ItemTemplate>
                                            <span class='badge text-nowrap <%# GetTicketTypeClass(Eval("TicketType")) %>'>
                                                <%# Eval("TicketType") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <%# GetStatusBadge(Eval("TaskStatus")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Activity Performed" ItemStyle-Width="260px">
                                        <ItemTemplate>
                                            <small class='<%# Eval("Priority") != null && (Eval("Priority").ToString().ToLower().Contains("high") || Eval("Priority").ToString().ToLower().Contains("critical")) ? "text-danger fw-bold text-break" : "text-muted text-break" %>'><%# Eval("Remark") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function initReportDataTable() {
                if (typeof initCustomDataTable === 'function') {
                    if ($('.datatable').length > 0 && $('.datatable tr').length > 1) {
                        initCustomDataTable('.datatable', 'Daily_Task_Report', 'Daily Task Report', [], { showPrint: false });
                    }
                }
                if (window.jQuery && $.fn.select2 && $('.select2').length > 0) {
                    $('.select2').select2();
                }
            }

            $(document).ready(function () {
                initReportDataTable();
            });

            window.addEventListener('load', function () {
                initReportDataTable();
            });
        </script>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                if ($('.datatable').length > 0 && $('.datatable tr').length > 1) {
                    initCustomDataTable('.datatable', 'Daily_Task_Report', 'Daily Task Report', [], { showPrint: false });
                }
            }
        });
    </script>
</asp:Content>
