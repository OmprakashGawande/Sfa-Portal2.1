<%@ Page Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskAllocationEntry.aspx.cs" Inherits="mis_DailyTask_TaskAllocationEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .badge-ticket-a {
            background-color: #0d6efd;
            color: #fff;
        }

        .badge-ticket-b {
            background-color: #6f42c1;
            color: #fff;
        }

        .badge-ticket-c {
            background-color: #0dcaf0;
            color: #000;
        }

        .badge-ticket-d {
            background-color: #fd7e14;
            color: #fff;
        }

        .badge-ticket-e {
            background-color: #20c997;
            color: #fff;
        }

        .badge-ticket-f {
            background-color: #d63384;
            color: #fff;
        }

        .badge-status-complete {
            background-color: #198754;
            color: #fff;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .badge-status-partial {
            background-color: #0dcaf0;
            color: #000;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .badge-status-pending {
            background-color: #ffc107;
            color: #000;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
        }

        .progress-meter {
            height: 12px;
            border-radius: 6px;
            overflow: hidden;
            background-color: #e9ecef;
        }

        .calc-box {
            background-color: #eef2ff;
            border-left: 4px solid #7366ff;
            padding: 10px 15px;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .required-star {
            color: #dc3545;
            font-weight: bold;
        }

        .text-high-priority,
        textarea.text-high-priority,
        textarea.form-control.text-high-priority {
            color: #dc3545 !important;
            font-weight: 600 !important;
            border-color: #dc3545 !important;
        }

        /* High Priority Complete Row Red */
        .row-high-priority,
        .row-high-priority > td,
        .row-high-priority > th {
            background-color: #f8d7da !important;
            color: #491217 !important;
        }

            .row-high-priority:hover,
            .row-high-priority:hover > td {
                background-color: #f1b0b7 !important;
                color: #2c0b0e !important;
            }

            .row-high-priority a,
            .row-high-priority .btn {
                opacity: 1 !important;
            }

        /* Compact Timepicker Popup (Leaves Date Calendar intact) */
        .flatpickr-calendar.noCalendar,
        .flatpickr-calendar.hasTime.noCalendar {
            width: 175px !important;
            min-width: 175px !important;
            max-width: 175px !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.18) !important;
            border-radius: 8px !important;
            border: 1px solid #ced4da !important;
            background: #ffffff !important;
            padding: 4px 6px !important;
        }

            .flatpickr-calendar.noCalendar .flatpickr-time {
                height: 40px !important;
                max-height: 40px !important;
                line-height: 40px !important;
                display: flex !important;
                align-items: center !important;
                justify-content: space-between !important;
                padding: 0 2px !important;
            }

        /* Make Hours & Minutes Arrows Always Visible */
        .flatpickr-time .numInputWrapper {
            height: 34px !important;
            border: 1px solid rgba(0, 0, 0, 0.15) !important;
            border-radius: 4px !important;
            background: #fff !important;
            margin: 0 2px !important;
        }

            .flatpickr-time .numInputWrapper span {
                opacity: 1 !important;
                visibility: visible !important;
                border: 1px solid rgba(0, 0, 0, 0.1) !important;
                background: #f8f9fa !important;
            }

                .flatpickr-time .numInputWrapper span:hover {
                    background: #e2e6ea !important;
                }

                .flatpickr-time .numInputWrapper span.arrowUp:after {
                    border-bottom-color: #333 !important;
                }

                .flatpickr-time .numInputWrapper span.arrowDown:after {
                    border-top-color: #333 !important;
                }

        /* AM/PM Box with Clear Up/Down Arrows */
        .flatpickr-time .flatpickr-am-pm {
            position: relative !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            font-weight: 700 !important;
            font-size: 13px !important;
            cursor: pointer !important;
            width: 48px !important;
            height: 34px !important;
            line-height: 34px !important;
            padding-right: 14px !important;
            border-radius: 4px !important;
            border: 1px solid rgba(0, 0, 0, 0.15) !important;
            background: #f8f9fa !important;
            color: #212529 !important;
            margin-left: 3px !important;
            user-select: none !important;
        }

            .flatpickr-time .flatpickr-am-pm:hover {
                background: #e2e6ea !important;
                border-color: #adb5bd !important;
            }

            /* Up/Down Arrow Triangles on AM/PM */
            .flatpickr-time .flatpickr-am-pm::before {
                content: "" !important;
                position: absolute !important;
                right: 4px !important;
                top: 9px !important;
                width: 0 !important;
                height: 0 !important;
                border-left: 3.5px solid transparent !important;
                border-right: 3.5px solid transparent !important;
                border-bottom: 4px solid #495057 !important;
            }

            .flatpickr-time .flatpickr-am-pm::after {
                content: "" !important;
                position: absolute !important;
                right: 4px !important;
                bottom: 9px !important;
                width: 0 !important;
                height: 0 !important;
                border-left: 3.5px solid transparent !important;
                border-right: 3.5px solid transparent !important;
                border-top: 4px solid #495057 !important;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <!-- Save Confirmation Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div style="display: table; height: 100%; width: 100%;">
                <div class="modal-dialog" style="width: 360px; display: table-cell; vertical-align: middle;">
                    <div class="modal-content" style="width: inherit; height: inherit; margin: 0 auto;">
                        <div class="modal-header" style="background-color: #d7c9988c;">
                            <span class="modal-title f-15" style="float: left;" id="myModalLabel">Confirmation</span>
                            <button type="button" class="btn-close py-0 white" data-bs-dismiss="modal" aria-label="Close" data-dismiss="modal">
                            </button>
                        </div>
                        <div class="clearfix"></div>
                        <div class="modal-body">
                            <p>
                                <i class="fa fa-question-circle fa-2x text-warning me-2" style="vertical-align: middle;"></i>
                                <asp:Label ID="lblPopupAlert" runat="server" Text="Are you sure you want to save all added task(s)?"></asp:Label>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes, Save Now" ID="btnYes" OnClick="btnConfirmSave_Click" />
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closePopup('#myModal')">
                                No
                           
                            </button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

                <!-- Main Form Card -->
                <div id="cardMain" class="card mt-3 border-warning">
                    <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <h4 class="mb-0"><i class="fa fa-pencil-square-o me-2 text-warning"></i>Fill Daily Task</h4>
                            <small class="text-white">Allocate tasks with multi-add and 8-hour daily limit check</small>
                        </div>
                        <div class="mt-2 mt-md-0">
                            <span class="badge bg-warning text-dark px-3 py-2 fs-6">
                                <i class="fa fa-clock-o me-1"></i>Max 8 Hours / Day Limit
                            </span>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- Input Fields Row 1: Project & Timing -->
                        <div class="row g-3">
                            <!-- 1. Project Name -->
                            <div class="col-xl-3 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Project Name <span class="required-star">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- 2. Start Date -->
                            <div class="col-xl-2 col-md-3 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Start Date <span class="required-star">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control date-picker" placeholder="DD/MM/YYYY" autocomplete="off" onchange="calculateHoursClient();"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- 3. Start Time (12hr PM format) -->
                            <div class="col-xl-2 col-md-3 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Start Time <span class="required-star">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtStartTime" runat="server" CssClass="form-control time-picker" placeholder="hh:mm PM" autocomplete="off" onchange="calculateHoursClient();"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- 4. End Date -->
                            <div class="col-xl-2 col-md-3 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        End Date <span class="required-star">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control date-picker" placeholder="DD/MM/YYYY" autocomplete="off" onchange="calculateHoursClient();"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- 5. End Time (12hr PM format) -->
                            <div class="col-xl-2 col-md-3 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        End Time <span class="required-star">*</span>
                                    </label>
                                    <div class="input-group">
                                        <asp:TextBox ID="txtEndTime" runat="server" CssClass="form-control time-picker" placeholder="hh:mm PM" autocomplete="off" onchange="calculateHoursClient();"></asp:TextBox>
                                        <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                    </div>
                                </div>
                            </div>

                            <!-- 6. Working Hours (Auto Calculated) -->
                            <div class="col-xl-1 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Hours
                                   
                                    </label>
                                    <asp:TextBox ID="txtWorkingHours" runat="server" CssClass="form-control bg-light text-primary font-weight-bold text-center px-1" ReadOnly="true" placeholder="0.00 Hrs"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Input Fields Row 2: Details, Priority, Ticket Type, Status -->
                        <div class="row g-3 mt-1">


                            <!-- 7. Priority -->
                            <div class="col-xl-3 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Priority <span class="required-star">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlPriority_SelectedIndexChanged" onchange="updateActivityColor();">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <!-- 8. Allocated / Assignee -->
                            <div class="col-xl-3 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Allocated / Assignee <span class="required-star">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlAllocated" runat="server" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- 9. Ticket Type -->
                            <div class="col-xl-3 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Ticket Type <span class="required-star">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlTicketType" runat="server" CssClass="form-select select2">
                                        <asp:ListItem Text="Select Ticket Type" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Support" Value="Support"></asp:ListItem>
                                        <asp:ListItem Text="On going Development" Value="Ongoing Development"></asp:ListItem>
                                        <asp:ListItem Text="Enhancement" Value="Enhancement"></asp:ListItem>
                                        <asp:ListItem Text="Production Support" Value="Production Support"></asp:ListItem>
                                        <asp:ListItem Text="Production Development" Value="Production Development"></asp:ListItem>
                                        <asp:ListItem Text="CR Activity" Value="CR Activity"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- 10. Status (Complete, Partially Complete, Pending) -->
                            <div class="col-xl-3 col-md-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Status <span class="required-star">*</span>
                                    </label>
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select select2">
                                        <asp:ListItem Text="Select Status" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Complete" Value="Complete"></asp:ListItem>
                                        <asp:ListItem Text="Partially Complete" Value="Partially Complete"></asp:ListItem>
                                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <!-- Input Fields Row 3: Remark (Large Textarea) -->
                        <div class="row g-3 mt-1">
                            <div class="col-12 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">
                                        Activity Performed <span class="required-star">*</span>
                                    </label>
                                    <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Rows="3" MaxLength="1500" CssClass="form-control" placeholder="Enter detailed remarks, task requirements, implementation details or notes..."></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Add Button & Calculation Hint -->
                        <div class="row mt-3">
                            <div class="col-12 d-flex justify-content-between align-items-center flex-wrap">
                                <div class="text-muted small">
                                    
                                </div>
                                <div class="mt-2 mt-md-0">
                                    <asp:Button ID="btnAddRow" runat="server" Text="+ Add Task to List" CssClass="btn btn-success px-4" OnClick="btnAddRow_Click" />
                                    <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel Edit" CssClass="btn btn-outline-danger px-3 ms-2" Visible="false" OnClick="btnCancelEdit_Click" />
                                    <asp:Button ID="btnClearInput" runat="server" Text="Clear Fields" CssClass="btn btn-outline-secondary ms-2" OnClick="btnClearInput_Click" />
                                </div>
                            </div>
                        </div>

                        <hr class="my-4" />

                        <!-- Multi-Add Staged Grid Section -->
                        <div class="row mb-3 align-items-center">
                            <div class="col-md-6">
                                <h5 class="mb-0 text-dark">
                                    <i class="fa fa-list-ol text-primary me-2"></i>Added Tasks List (<asp:Label ID="lblAddedCount" runat="server" Text="0"></asp:Label>)
                                </h5>
                            </div>
                            <div class="col-md-6 text-md-end mt-2 mt-md-0">
                                <span class="badge bg-light text-dark border p-2 fs-6">Total Working Hours: <strong class="text-primary">
                                    <asp:Label ID="lblTotalStagedHours" runat="server" Text="0.00"></asp:Label>
                                    Hrs</strong> / 8.00 Hrs
                                </span>
                            </div>
                        </div>

                        <!-- Staged Tasks GridView -->
                        <div class="table-responsive">
                            <asp:GridView ID="gvAddedTasks" runat="server" AutoGenerateColumns="false"
                                CssClass="table table-bordered table-hover w-100"
                                EmptyDataText="No tasks added yet. Fill the fields above and click '+ Add Task to List'."
                                OnRowCommand="gvAddedTasks_RowCommand" OnRowDataBound="gvAddedTasks_RowDataBound" ShowHeaderWhenEmpty="true">
                                <HeaderStyle CssClass="table-primary" />
                                <Columns>
                                    <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="ProjectName" HeaderText="Project Name" ItemStyle-Font-Bold="true" />

                                    <asp:TemplateField HeaderText="Ticket Type">
                                        <ItemTemplate>
                                            <span class='badge <%# GetTicketTypeClass(Eval("TicketType")) %>'>
                                                <%# Eval("TicketType") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Priority" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span class='badge <%# GetPriorityClass(Eval("Priority")) %>'>
                                                <%# Eval("Priority") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Start Date & Time">
                                        <ItemTemplate>
                                            <i class="fa fa-calendar me-1 text-muted"></i><%# Eval("StartDate") %>
                                            <span class="text-muted"><i class="fa fa-clock-o ms-1"></i><%# Eval("StartTime") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="End Date & Time">
                                        <ItemTemplate>
                                            <i class="fa fa-calendar me-1 text-muted"></i><%# Eval("EndDate") %>
                                            <span class="text-muted"><i class="fa fa-clock-o ms-1"></i><%# Eval("EndTime") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Working Hours" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span class="badge bg-light-success text-success font-weight-bold fs-6">
                                                <i class="fa fa-clock-o me-1"></i><%# Eval("WorkingHours") %> Hrs
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Allocated" HeaderText="Allocated / Assignee" />

                                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# GetStatusBadge(Eval("TaskStatus")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Activity Performed / Remark">
                                        <ItemTemplate>
                                            <small class='<%# Eval("Priority") != null && (Eval("Priority").ToString().ToLower().Contains("high") || Eval("Priority").ToString().ToLower().Contains("critical")) ? "text-danger fw-bold" : "text-muted" %>'><%# Eval("Remark") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDeleteRow" runat="server" CommandName="RemoveTask"
                                                CommandArgument='<%# Container.DataItemIndex %>'
                                                CssClass="btn btn-sm btn-outline-danger"
                                                OnClientClick="return confirm('Are you sure you want to remove this task from the list?');">
                                                <i class="fa fa-trash"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Final Action Buttons -->
                        <div class="row mt-4">
                            <div class="col-12 d-flex justify-content-end">
                                <asp:Button ID="btnFinalSave" runat="server" Text="Final Save" CssClass="btn btn-primary btn-lg px-5 me-2" OnClick="btnFinalSave_Click" OnClientClick="return confirm('Are you sure you want to save all added task(s)?');" />
                                <asp:Button ID="btnResetAll" runat="server" Text="Reset All" CssClass="btn btn-outline-danger btn-lg px-4" OnClick="btnResetAll_Click" OnClientClick="return confirm('Are you sure you want to reset all added tasks?');" />
                            </div>
                        </div>

                        <!-- Saved Database Records History Section -->
                        <hr class="my-5" />
                        <div class="row mb-3 align-items-center">
                            <div class="col-md-6">
                                <h5 class="mb-0 text-dark">
                                    <i class="fa fa-database text-success me-2"></i>Saved Task Allocations History
                                </h5>
                            </div>
                        </div>

                        <div class="table-responsive dt-ext">
                            <asp:GridView ID="gvSavedHistory" runat="server" AutoGenerateColumns="false"
                                CssClass="datatable table table-bordered table-hover w-100"
                                EmptyDataText="No saved task records found in the database yet."
                                OnRowCommand="gvSavedHistory_RowCommand" OnRowDataBound="gvSavedHistory_RowDataBound" ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="ProjectName" HeaderText="Project" ItemStyle-Font-Bold="true" />

                                    <asp:TemplateField HeaderText="Ticket Type">
                                        <ItemTemplate>
                                            <span class='badge <%# GetTicketTypeClass(Eval("TicketType")) %>'>
                                                <%# Eval("TicketType") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Priority" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span class='badge <%# GetPriorityClass(Eval("Priority")) %>'>
                                                <%# Eval("Priority") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Start & End Time">
                                        <ItemTemplate>
                                            <div><i class="fa fa-calendar text-muted me-1"></i><%# Eval("StartDate") %> <small class="text-muted"><%# Eval("StartTime") %></small></div>
                                            <div><i class="fa fa-calendar-check-o text-muted me-1"></i><%# Eval("EndDate") %> <small class="text-muted"><%# Eval("EndTime") %></small></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Hours" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span class="badge bg-light-info text-info font-weight-bold">
                                                <%# Eval("WorkingHours") %> Hrs
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Allocated" HeaderText="Assignee" />

                                    <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# GetStatusBadge(Eval("TaskStatus")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Activity Performed / Remark">
                                        <ItemTemplate>
                                            <small class='<%# Eval("Priority") != null && (Eval("Priority").ToString().ToLower().Contains("high") || Eval("Priority").ToString().ToLower().Contains("critical")) ? "text-danger fw-bold" : "text-muted" %>'><%# Eval("Remark") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Active / Inactive" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="110px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnToggleActive" runat="server" CommandName="ToggleActive"
                                                CommandArgument='<%# Eval("TaskEntryId") %>'
                                                CssClass='<%# Convert.ToString(Eval("IsActive")) == "False" || Convert.ToString(Eval("IsActive")) == "0" ? "btn btn-sm btn-outline-danger" : "btn btn-sm btn-outline-success" %>'
                                                OnClientClick='<%# (Convert.ToString(Eval("IsActive")) == "False" || Convert.ToString(Eval("IsActive")) == "0") ? "return confirm(\"Are you sure you want to activate this task?\");" : "return confirm(\"Are you sure you want to deactivate this task?\");" %>'
                                                ToolTip='<%# (Convert.ToString(Eval("IsActive")) == "False" || Convert.ToString(Eval("IsActive")) == "0") ? "Click to set Active" : "Click to set Inactive" %>'>
                                                <i class='<%# (Convert.ToString(Eval("IsActive")) == "False" || Convert.ToString(Eval("IsActive")) == "0") ? "fa fa-ban me-1" : "fa fa-check-circle me-1" %>'></i>
                                                <%# (Convert.ToString(Eval("IsActive")) == "False" || Convert.ToString(Eval("IsActive")) == "0") ? "Inactive" : "Active" %>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditSaved" runat="server" CommandName="EditTask"
                                                CommandArgument='<%# Eval("TaskEntryId") %>'
                                                CssClass="btn btn-sm btn-outline-primary"
                                                ToolTip="Edit Task">
                                                <i class="fa fa-pencil me-1"></i>Edit
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        $(document).ready(function () {
            // Restore saved times from sessionStorage if this was a priority postback
            try {
                var savedStartTime = sessionStorage.getItem('sfa_task_start_time');
                var savedEndTime = sessionStorage.getItem('sfa_task_end_time');
                var $txtStart = $('#<%= txtStartTime.ClientID %>');
                var $txtEnd = $('#<%= txtEndTime.ClientID %>');

                if (savedStartTime && $txtStart.length) {
                    $txtStart.val(savedStartTime);
                }
                if (savedEndTime && $txtEnd.length) {
                    $txtEnd.val(savedEndTime);
                }
            } catch (e) { }

            initFlatpickrs();
            if ($('.select2').length > 0) {
                $('.select2').select2();
            }
            if ($('.datatable tbody tr').length > 0 && $('.datatable td').length > 1) {
                initCustomDataTable('.datatable', 'Saved_Task_Allocations', 'Saved Task Allocations', []);
            }

            // Bind change on Priority dropdown (for Select2 & native select)
            $(document).on('change select2:select', '#<%= ddlPriority.ClientID %>', function () {
                updateActivityColor();
                // Store times before postback so PM/AM are never lost
                try {
                    var sVal = $('#<%= txtStartTime.ClientID %>').val();
                    var eVal = $('#<%= txtEndTime.ClientID %>').val();
                    if (sVal) sessionStorage.setItem('sfa_task_start_time', sVal);
                    if (eVal) sessionStorage.setItem('sfa_task_end_time', eVal);
                } catch (e) { }

                var val = $(this).val();
                var text = ($(this).find('option:selected').text() || '').toLowerCase();
                if (val === '4' || text.indexOf('on-spot') > -1) {
                    if (typeof __doPostBack === 'function') {
                        __doPostBack('<%= ddlPriority.UniqueID %>', '');
                    }
                }
            });

            // Keep red color active while user is typing in txtRemark
            $(document).on('input keyup paste change focus', '#<%= txtRemark.ClientID %>', function () {
                updateActivityColor();
            });

            // Save times in sessionStorage on user change
            $(document).on('change input', '#<%= txtStartTime.ClientID %>, #<%= txtEndTime.ClientID %>', function () {
                try {
                    var sVal = $('#<%= txtStartTime.ClientID %>').val();
                    var eVal = $('#<%= txtEndTime.ClientID %>').val();
                    if (sVal) sessionStorage.setItem('sfa_task_start_time', sVal);
                    if (eVal) sessionStorage.setItem('sfa_task_end_time', eVal);
                } catch (e) { }
            });

            // Clear sessionStorage on add or reset
            $(document).on('click', '#<%= btnAddRow.ClientID %>, #<%= btnResetAll.ClientID %>', function () {
                try {
                    sessionStorage.removeItem('sfa_task_start_time');
                    sessionStorage.removeItem('sfa_task_end_time');
                } catch (e) { }
            });

            // Initial trigger
            updateActivityColor();
            calculateHoursClient();
        });

        function updateActivityColor() {
            try {
                var $ddl = $('#<%= ddlPriority.ClientID %>');
                var $txt = $('#<%= txtRemark.ClientID %>');
                if ($ddl.length === 0 || $txt.length === 0) return;

                var selectedText = ($ddl.find('option:selected').text() || '').trim().toLowerCase();
                var selectedVal = ($ddl.val() || '').trim().toLowerCase();

                var isHigh = (selectedText.indexOf('high') > -1 || selectedText.indexOf('critical') > -1 || selectedVal === '1');

                if (isHigh) {
                    $txt.addClass('text-high-priority');
                    $txt.css({
                        'color': '#dc3545',
                        'font-weight': '600',
                        'border-color': '#dc3545'
                    });
                } else {
                    $txt.removeClass('text-high-priority');
                    $txt.css({
                        'color': '',
                        'font-weight': '',
                        'border-color': ''
                    });
                }
            } catch (err) {
                console.error(err);
            }
        }

        function initFlatpickrs() {
            flatpickr(".date-picker", {
                dateFormat: "d/m/Y",
                allowInput: true,
                onChange: function () {
                    calculateHoursClient();
                }
            });

            $('.time-picker').each(function () {
                var input = this;
                var currentVal = (input.value || '').trim();
                var isPM = currentVal.toUpperCase().indexOf('PM') > -1;
                var isAM = currentVal.toUpperCase().indexOf('AM') > -1;

                flatpickr(input, {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "h:i K",
                    time_24hr: false,
                    minuteIncrement: 5,
                    allowInput: true,
                    defaultDate: currentVal ? currentVal : undefined,
                    onReady: function (selectedDates, dateStr, instance) {
                        if (currentVal) {
                            instance.input.value = currentVal;
                            if (isPM && instance.amPM) {
                                instance.amPM.textContent = "PM";
                                if (instance.latestSelectedDateObj && instance.latestSelectedDateObj.getHours() < 12) {
                                    instance.latestSelectedDateObj.setHours(instance.latestSelectedDateObj.getHours() + 12);
                                }
                            } else if (isAM && instance.amPM) {
                                instance.amPM.textContent = "AM";
                                if (instance.latestSelectedDateObj && instance.latestSelectedDateObj.getHours() >= 12) {
                                    instance.latestSelectedDateObj.setHours(instance.latestSelectedDateObj.getHours() - 12);
                                }
                            }
                        }
                    },
                    onChange: function (selectedDates, dateStr, instance) {
                        try {
                            if (instance.input && instance.input.id) {
                                if (instance.input.id.indexOf('txtStartTime') > -1) {
                                    sessionStorage.setItem('sfa_task_start_time', instance.input.value);
                                } else if (instance.input.id.indexOf('txtEndTime') > -1) {
                                    sessionStorage.setItem('sfa_task_end_time', instance.input.value);
                                }
                            }
                        } catch (e) { }
                        calculateHoursClient();
                    },
                    onClose: function () {
                        calculateHoursClient();
                    }
                });
            });
        }

        function parseTimeToHoursAndMinutes(timeStr) {
            if (!timeStr) return null;
            timeStr = timeStr.trim();
            var isPM = timeStr.toUpperCase().indexOf('PM') > -1;
            var isAM = timeStr.toUpperCase().indexOf('AM') > -1;
            var cleanTime = timeStr.replace(/AM|PM/gi, '').trim();
            var parts = cleanTime.split(':');
            if (parts.length < 2) return null;
            var h = parseInt(parts[0], 10);
            var m = parseInt(parts[1], 10);
            if (isNaN(h) || isNaN(m)) return null;

            if (isPM && h < 12) h += 12;
            if (isAM && h === 12) h = 0;

            return { hours: h, minutes: m };
        }

        function calculateHoursClient() {
            try {
                var sDateStr = document.getElementById('<%= txtStartDate.ClientID %>').value;
                var sTimeStr = document.getElementById('<%= txtStartTime.ClientID %>').value;
                var eDateStr = document.getElementById('<%= txtEndDate.ClientID %>').value;
                var eTimeStr = document.getElementById('<%= txtEndTime.ClientID %>').value;
                var txtHours = document.getElementById('<%= txtWorkingHours.ClientID %>');

                if (!sDateStr || !sTimeStr || !eDateStr || !eTimeStr) {
                    return;
                }

                var sParts = sDateStr.split('/');
                var eParts = eDateStr.split('/');
                if (sParts.length !== 3 || eParts.length !== 3) return;

                var sTime = parseTimeToHoursAndMinutes(sTimeStr);
                var eTime = parseTimeToHoursAndMinutes(eTimeStr);
                if (!sTime || !eTime) return;

                var startDt = new Date(parseInt(sParts[2], 10), parseInt(sParts[1], 10) - 1, parseInt(sParts[0], 10), sTime.hours, sTime.minutes, 0);
                var endDt = new Date(parseInt(eParts[2], 10), parseInt(eParts[1], 10) - 1, parseInt(eParts[0], 10), eTime.hours, eTime.minutes, 0);

                var diffMs = endDt - startDt;
                if (diffMs > 0) {
                    var diffHrs = (diffMs / (1000 * 60 * 60)).toFixed(2);
                    txtHours.value = diffHrs + " Hrs";
                } else {
                    txtHours.value = "0.00 Hrs";
                }
            } catch (err) {
                console.error(err);
            }
        }

        function showConfirmationModal() {
            $('#myModal').modal('show');
        }

        function closePopup(modalId) {
            $(modalId).modal('hide');
        }
    </script>
</asp:Content>
