<%@ Page Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TodayAllocatedTask.aspx.cs" Inherits="mis_DailyTask_TodayAllocatedTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .badge-priority-high {
            background-color: #dc3545;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
        }
        .badge-priority-medium {
            background-color: #fd7e14;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
        }
        .badge-priority-low {
            background-color: #28a745;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
        }
        .badge-priority-default {
            background-color: #6c757d;
            color: #fff;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 11px;
        }
        .kpi-card {
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease;
        }
        .kpi-card:hover {
            transform: translateY(-2px);
        }
        .center-grid {
            text-align: center;
            vertical-align: middle !important;
        }
        .today-badge {
            background: linear-gradient(135deg, #7366ff 0%, #a26cf8 100%);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            display: inline-block;
        }
        .high-priority-row,
        .high-priority-row td,
        .high-priority-row td *,
        .high-priority-row td span,
        .high-priority-row td div,
        .high-priority-row td small,
        .high-priority-row td i,
        .high-priority-row .text-primary,
        .high-priority-row .text-muted,
        .high-priority-row .text-info,
        .high-priority-row .badge:not(.badge-priority-high) {
            color: #dc3545 !important;
            border-color: #f5c2c7 !important;
        }
        .high-priority-row {
            background-color: #fff5f5 !important;
        }
        .high-priority-row:hover {
            background-color: #ffebeb !important;
        }
        .high-priority-row .badge-priority-high {
            color: #ffffff !important;
            background-color: #dc3545 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

                <!-- Page Header Card -->
                <div class="card mt-3 border-warning">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h4 class="mb-0"><i class="fa fa-calendar-check-o me-2 text-warning"></i>Today Allocated Tasks</h4>
                            <small class="text-white">View all tasks allocated to employees for today</small>
                        </div>
                        <div class="mt-2 mt-md-0 d-flex align-items-center gap-2">
                            <a href="TaskAllocationEntry.aspx" class="btn btn-warning text-dark font-weight-bold">
                                <i class="fa fa-pencil-square-o me-1"></i>Fill Daily Task Entry
                            </a>
                            <span class="today-badge">
                                <i class="fa fa-clock-o me-1"></i> Date: <asp:Label ID="lblCurrentDate" runat="server"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- KPI Metric Cards -->
                        <div class="row mb-4 g-3">
                            <div class="col-xl-4 col-md-4 col-sm-6">
                                <div class="card kpi-card bg-light-primary border-primary mb-0">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 bg-primary text-white p-3 rounded-circle me-3">
                                                <i class="fa fa-tasks fa-2x"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="text-muted mb-1">Total Tasks Today</h6>
                                                <h3 class="mb-0 text-primary font-weight-bold">
                                                    <asp:Label ID="lblTotalTasks" runat="server" Text="0"></asp:Label>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-4 col-md-4 col-sm-6">
                                <div class="card kpi-card bg-light-warning border-warning mb-0">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 bg-warning text-white p-3 rounded-circle me-3">
                                                <i class="fa fa-hourglass-half fa-2x"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="text-muted mb-1">Total Allocated Hours</h6>
                                                <h3 class="mb-0 text-warning font-weight-bold">
                                                    <asp:Label ID="lblTotalHours" runat="server" Text="0.00 Hrs"></asp:Label>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-4 col-md-4 col-sm-6">
                                <div class="card kpi-card bg-light-danger border-danger mb-0">
                                    <div class="card-body p-3">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 bg-danger text-white p-3 rounded-circle me-3">
                                                <i class="fa fa-exclamation-triangle fa-2x"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="text-muted mb-1">High Priority Tasks</h6>
                                                <h3 class="mb-0 text-danger font-weight-bold">
                                                    <asp:Label ID="lblHighPriorityCount" runat="server" Text="0"></asp:Label>
                                                </h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Filter Controls -->
                        <div class="card bg-light border-0 mb-4">
                            <div class="card-body p-3">
                                <div class="row g-3 align-items-end">
                                    <div class="col-xl-4 col-md-6">
                                        <div class="form-group mb-0">
                                            <label class="form-label font-weight-bold font-dark">Employee</label>

                                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-select select2">
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="col-xl-4 col-md-6">
                                        <div class="form-group mb-0">
                                            <label class="form-label font-weight-bold font-dark">Project</label>
                                            <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-select select2">
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="col-xl-4 col-md-12 text-md-start">
                                        <asp:Button ID="btnSearch" runat="server" Text="Filter Tasks" CssClass="btn btn-primary me-2" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset / Show All Today" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Grid Table for Today's Tasks -->
                        <div class="table-responsive dt-ext">
                            <asp:GridView ID="gvTodayTasks" runat="server" AutoGenerateColumns="false"
                                CssClass="datatable table table-bordered table-hover w-100"
                                EmptyDataText="No tasks allocated for today with the selected filters."
                                OnRowDataBound="gvTodayTasks_RowDataBound"
                                ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="60px">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Employee" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <div class="font-weight-bold text-primary">
                                                <i class="fa fa-user me-1"></i>
                                                <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("Employee_Name") %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Project" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <span class="badge bg-light text-dark border">
                                                <i class="fa fa-folder-open-o me-1"></i>
                                                <asp:Label ID="lblProject_Name" runat="server" Text='<%# Eval("Project_Name") %>'></asp:Label>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Allocation Date & Time" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <div><i class="fa fa-calendar text-muted me-1"></i><%# Eval("AllocationDate") %></div>
                                            <small class="text-muted"><i class="fa fa-clock-o me-1"></i><%# Eval("TaskDuration") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Duration" ItemStyle-CssClass="center-grid" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <span class="badge bg-light-info text-info font-weight-bold">
                                                <i class="fa fa-hourglass-start me-1"></i>
                                                <asp:Label ID="lblTaskDuration" runat="server" Text='<%# Eval("TaskDuration") %>'></asp:Label>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requirement Point">
                                        <ItemTemplate>
                                            <div class="font-weight-bold">
                                                <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Priority" ItemStyle-CssClass="center-grid" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <%# GetPriorityBadge(Eval("PriorityType"), Eval("PriorityTypeId")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <small class="text-muted"><%# Eval("TaskDescription") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="QA Name" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblQA" runat="server" Text='<%# Eval("Employee_Name_QA") != null && !string.IsNullOrEmpty(Eval("Employee_Name_QA").ToString()) ? Eval("Employee_Name_QA") : "-" %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Assigned By" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAssignedBy" runat="server" Text='<%# Eval("AssignedBy") != null && !string.IsNullOrEmpty(Eval("AssignedBy").ToString()) ? Eval("AssignedBy") : "-" %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="center-grid" ItemStyle-Width="120px">
                                        <ItemTemplate>
                                            <a href="TaskAllocationEntry.aspx" class="btn btn-sm btn-success text-white">
                                                <i class="fa fa-pencil-square-o me-1"></i>Fill Task
                                            </a>
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
    <script>
        $(document).ready(function () {
            if ($('.datatable tbody tr').length > 0 && $('.datatable td').length > 1) {
                initCustomDataTable('.datatable', 'Today_Allocated_Tasks', 'Today Allocated Tasks', []);
            }
            if ($('.select2').length > 0) {
                $('.select2').select2();
            }
        });
    </script>
</asp:Content>
