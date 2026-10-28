<%@ Page Title="Employee Attendance" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true"
    CodeFile="PayrollEmpSetAttendance.aspx.cs" Inherits="mis_Payroll_PayrollEmpSetAttendance" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
        <link href="../css/StyleSheet.css" rel="stylesheet" />
        <style>

            .box {
                min-height: 135px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .legend-badge {
                display: inline-block;
                padding: 3px 8px;
                font-size: 11px;
                font-weight: 600;
                border-radius: 3px;
                margin-right: 5px;
                margin-bottom: 4px;
            }

            .badge-present {
                background-color: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #c8e6c9;
            }

            .badge-absent {
                background-color: #ffebee;
                color: #c62828;
                border: 1px solid #ffcdd2;
            }

            .badge-half {
                background-color: #fff8e1;
                color: #f57f17;
                border: 1px solid #ffecb3;
            }

            .badge-leave {
                background-color: #e3f2fd;
                color: #1565c0;
                border: 1px solid #bbdefb;
            }

            .search-box {
                background: url('images/searchicon.png') 10px 10px no-repeat;
                padding: 8px 15px 8px 36px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
                font-size: 13px;
                margin-bottom: 10px;
            }

            .att-table-container {
                max-height: 480px;
                overflow: auto;
                border: 1px solid #ddd;
                position: relative;
            }

            #GridView1 {
                border-collapse: separate;
                border-spacing: 0;
                width: 100%;
                font-size: 11px;
            }

            #GridView1 thead th {
                position: sticky;
                top: 0;
                z-index: 20;
                background: #f4f6f9;
                border: 1px solid #ddd;
                text-align: center;
                padding: 4px !important;
                font-size: 11px;
                white-space: nowrap;
            }

            #GridView1 td {
                vertical-align: middle;
                padding: 2px !important;
                border: 1px solid #e9ecef;
            }

            .att-select {
                width: 58px;
                height: 26px;
                padding: 1px 3px;
                font-size: 11px;
                font-weight: 700;
                text-align: center;
                border-radius: 3px;
                border: 1px solid #ccc;
            }

            .emp-name-col {
                min-width: 170px;
                max-width: 220px;
                font-weight: 600;
                color: #2c3e50;
                padding-left: 6px !important;
            }

            .sno-col {
                width: 40px;
                text-align: center;
                font-weight: 600;
            }

            .payable-col {
                width: 75px;
                text-align: center;
            }

            .payable-col input {
                text-align: center;
                font-weight: bold;
                height: 26px;
            }

            .day-col {
                min-width: 62px;
                text-align: center;
            }

            /* Row Hover Effects */
            #GridView1 tbody tr {
                transition: background-color 0.15s ease-in-out;
            }

            #GridView1 tbody tr:hover:not(.row-emp-highlight) > td {
                background-color: #eef6ff !important;
            }

            #GridView1 tbody tr:hover .emp-name-col {
                color: #1d4ed8 !important;
                font-weight: 700 !important;
            }

            #GridView1 tbody tr.row-selected:hover:not(.row-emp-highlight) > td {
                background-color: #fee2e2 !important;
            }

            #tblEmpSummary tbody tr {
                transition: background-color 0.15s ease-in-out;
            }

            #tblEmpSummary tbody tr:hover:not(.active-summary-row) > td {
                background-color: #eef6ff !important;
            }

            .row-selected {
                background-color: #fff2f2 !important;
            }

            .attendance-locked {
                background-color: #f7f9fa !important;
            }

            .attendance-locked select,
            .attendance-locked input {
                background-color: #eee !important;
                color: #888 !important;
                border-color: #ddd !important;
                cursor: not-allowed !important;
                pointer-events: none !important;
            }

            .summary-panel {
                background: #ffffff;
                border: 1px solid #dcdfe6;
                border-radius: 6px;
                padding: 12px 16px;
                margin-top: 15px;
                margin-bottom: 5px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            }

            .summary-header {
                font-size: 13px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 10px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .summary-card {
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                padding: 14px 16px;
                text-align: center;
                transition: all 0.2s ease;
                margin-bottom: 12px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            }

            .summary-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            }

            .summary-card .card-title {
                display: block;
                font-size: 13px;
                font-weight: 600;
                color: #64748b;
                margin-bottom: 6px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .summary-card .card-val {
                display: block;
                font-size: 26px;
                font-weight: 700;
                line-height: 1.2;
            }

            .card-total {
                border-top: 4px solid #3b82f6;
                background: #f8fafc;
            }
            .card-total .card-val { color: #1d4ed8; }

            .card-generated {
                border-top: 4px solid #ef4444;
                background: #fef2f2;
            }
            .card-generated .card-val { color: #dc2626; }

            .card-notgenerated {
                border-top: 4px solid #10b981;
                background: #f0fdf4;
            }
            .card-notgenerated .card-val { color: #15803d; }

            .card-selected {
                border-top: 4px solid #0284c7;
                background: #f0f9ff;
            }
            .card-selected .card-val { color: #0369a1; }

            #tblEmpSummary th {
                font-weight: 700;
                color: #475569;
                border-bottom: 2px solid #cbd5e1;
                white-space: nowrap;
                text-align: center;
                background-color: #f8fafc;
            }

            #tblEmpSummary td {
                vertical-align: middle;
                padding: 5px 8px !important;
            }

            .summary-status-badge {
                display: inline-block;
                padding: 2px 7px;
                font-size: 10px;
                font-weight: 600;
                border-radius: 3px;
                white-space: nowrap;
            }

            .status-ready { background-color: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
            .status-unselected { background-color: #f1f5f9; color: #64748b; border: 1px solid #e2e8f0; }
            .status-locked { background-color: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }
            .status-set { background-color: #e0f2fe; color: #0369a1; border: 1px solid #bae6fd; }

            .active-summary-row {
                background-color: #dbeafe !important;
                border-left: 4px solid #2563eb !important;
            }

            .row-emp-highlight {
                outline: 3px solid #eab308 !important;
                box-shadow: 0 0 16px rgba(234, 179, 8, 0.8) !important;
                z-index: 15;
                position: relative;
            }

            .row-emp-highlight td {
                background-color: #fef08a !important;
                color: #0f172a !important;
                font-weight: 700 !important;
            }

            .row-emp-highlight select {
                border-color: #ca8a04 !important;
                box-shadow: 0 0 6px rgba(202, 138, 4, 0.9) !important;
                background-color: #fef9c3 !important;
            }

            @media print {

                .print_hidden,
                .loader,
                #myInput,
                .main-footer {
                    display: none !important;
                }

                .att-table-container {
                    max-height: none !important;
                    overflow: visible !important;
                }

                select {
                    border: none !important;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                }

                .headingOfDept {
                    display: block !important;
                }
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
        <div class="content-wrapper">
            <section class="content">
                <div class="box box-success" style="min-height: 500px;">
                    <div class="box-header with-border">
                        <h3 class="box-title print_hidden">Employee Attendance Entry</h3>
                    </div>
                    <asp:Label ID="lblMsg" runat="server" CssClass="print_hidden" Text=""></asp:Label>

                    <div class="box-body">
                        <!-- Filters Section -->
                        <div class="row print_hidden">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Office Name <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlOfficeName" runat="server" CssClass="form-control select2"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlOfficeName_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Year <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Month <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Type of Post<span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlEmp_TypeOfPost" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                        <asp:ListItem Value="Permanent">Regular/Permanent</asp:ListItem>
                                        <asp:ListItem Value="trainee">Trainee</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="btnSearch" CssClass="btn btn-block btn-success"
                                        Style="margin-top: 24px;" runat="server" Text="Search" OnClick="btnSearch_Click"
                                        OnClientClick="return validateform();" />
                                </div>
                            </div>
                        </div>

                        <!-- Attendance Detail Section -->
                        <div id="DivDetail" runat="server">
                            <!-- Legend & Print Header -->
                            <div class="row print_hidden" style="margin-top: 10px; margin-bottom: 8px;">
                                <div class="col-md-7">
                                    <span class="legend-badge badge-present">P: Present</span>
                                    <span class="legend-badge badge-absent">A: Absent</span>
                                    <span class="legend-badge badge-half">FH: First Half</span>
                                    <span class="legend-badge badge-half">SH: Second Half</span>
                                    <span class="legend-badge badge-leave">CL: Casual Leave</span>
                                    <span class="legend-badge badge-leave">CoF: Comp-off</span>
                                </div>
                                <div class="col-md-5 text-right">
                                    <button type="button" class="btn btn-sm btn-success" onclick="exportAttendanceGridToExcel()" style="margin-right: 10px; font-weight: 600;">
                                        <i class="fa fa-file-excel-o"></i> Export to Excel
                                    </button>
                                    <small style="color: #666;"><i class="fa fa-print"></i> Press <b>Ctrl + P</b> to
                                        print this sheet</small>
                                </div>
                            </div>

                            <!-- Print Letterhead -->
                            <div class="col-md-12 headingOfDept" style="display: none;">
                                <div class="text-center">
                                    <img src="../image/mpagro-logo.png" style="width: 40px;" /><br />
                                    <b>THE MADHYA PRADESH STATE AGRO INDUSTRIES DEVELOPMENT CORPORATION
                                        LIMITED</b><br />
                                    <small>"PANCHANAN" 3rd FLOOR, MALAVIYA NAGAR BHOPAL</small>
                                </div>
                                <div class="row" style="margin-top: 10px;">
                                    <div class="col-md-6 text-left">
                                        <asp:Label ID="lblSelectedItems" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        Date: <asp:Label ID="lblAttDate" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </div>

                            <!-- Instant Filter Input -->
                            <asp:TextBox ID="myInput" runat="server" ClientIDMode="Static"
                                CssClass="search-box print_hidden" onkeyup="filterEmployeeNames()"
                                placeholder="Search by employee name..." title="Type in employee name"></asp:TextBox>

                            <!-- Scrollable Table Container -->
                            <div class="att-table-container">
                                <asp:GridView ID="GridView1" runat="server"
                                    CssClass="table table-bordered table-striped" ClientIDMode="Static"
                                    AutoGenerateColumns="False" AllowPaging="false"
                                    OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="checkAll" runat="server" ClientIDMode="static" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" runat="server"
                                                    Enabled='<%# Eval("GenerateStatus").ToString() == "Not Generated" && Eval("Checked").ToString().ToLower() != "true" %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="S.No." ItemStyle-CssClass="sno-col">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>'
                                                    ToolTip='<%# Eval("Emp_ID").ToString() %>' runat="server" />
                                                <asp:Label ID="lblGenerateStatus"
                                                    Text='<%# Eval("GenerateStatus").ToString() %>' runat="server"
                                                    Visible="false" />
                                                <asp:Label ID="lblChecked"
                                                    Text='<%# Eval("Checked").ToString() %>' runat="server"
                                                    Visible="false" />
                                                <asp:Label ID="lblEmp_ID" Text='<%# Eval("Emp_ID").ToString() %>'
                                                    runat="server" Visible="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name"
                                            ItemStyle-CssClass="emp-name-col" />

                                        <%-- Day 1 to 31 Columns (Populated via GridView1_RowDataBound) --%>
                                            <asp:TemplateField HeaderText="1" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay1"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="2" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay2"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="3" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay3"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="4" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay4"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="5" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay5"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="6" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay6"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="7" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay7"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="8" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay8"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="9" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay9"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="10" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay10"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="11" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay11"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="12" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay12"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="13" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay13"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="14" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay14"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="15" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay15"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="16" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay16"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="17" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay17"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="18" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay18"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="19" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay19"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="20" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay20"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="21" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay21"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="22" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay22"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="23" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay23"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="24" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay24"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="25" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay25"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="26" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay26"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="27" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay27"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="28" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay28"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="29" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay29"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="30" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay30"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="31" HeaderStyle-CssClass="day-col">
                                                <ItemTemplate>
                                                    <asp:DropDownList onchange="change(this);" ID="ddlDay31"
                                                        runat="server" CssClass="att-select" ClientIDMode="Static" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Payable Days"
                                                HeaderStyle-CssClass="payable-col" ItemStyle-CssClass="payable-col">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPayableDays" runat="server"
                                                        CssClass="form-control" Text='<%#Bind("PayableDays") %>'
                                                        Enabled="false"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <!-- Real-time Verification Summary Box -->
                            <div class="row print_hidden">
                                <div class="col-md-12">
                                    <div class="summary-panel">
                                        <div class="summary-header">
                                            <i class="fa fa-dashboard"></i> Attendance Verification Summary
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 col-sm-6 col-xs-12">
                                                <div class="summary-card card-total">
                                                    <span class="card-title"><i class="fa fa-users"></i> Total Employee</span>
                                                    <span class="card-val" id="sumTotalStaff">0</span>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-xs-12">
                                                <div class="summary-card card-generated">
                                                    <span class="card-title"><i class="fa fa-lock"></i> Total Generated</span>
                                                    <span class="card-val" id="sumTotalGenerated">0</span>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-xs-12">
                                                <div class="summary-card card-notgenerated">
                                                    <span class="card-title"><i class="fa fa-clock-o"></i> Total Not Generated</span>
                                                    <span class="card-val" id="sumTotalNotGenerated">0</span>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-xs-12">
                                                <div class="summary-card card-selected">
                                                    <span class="card-title"><i class="fa fa-check-square-o"></i> Selected Record</span>
                                                    <span class="card-val" id="sumSelectedStaff">0</span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Employee-Wise Attendance Breakdown Table -->
                                        <div style="margin-top: 14px; border-top: 1px solid #ebeef5; padding-top: 10px;">
                                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                                <span style="font-size: 12px; font-weight: 700; color: #34495e; text-transform: uppercase;">
                                                    <i class="fa fa-users"></i> Employee-Wise Attendance Verification
                                                </span>
                                                <div style="display: flex; align-items: center; gap: 8px;">
                                                    <button type="button" class="btn btn-xs btn-success" onclick="exportSummaryGridToExcel()" style="padding: 4px 12px; font-weight: 600; height: 28px;">
                                                        <i class="fa fa-file-excel-o"></i> Export to Excel
                                                    </button>
                                                    <input type="text" id="summaryEmpFilter" class="form-control" style="width: 240px; height: 28px; font-size: 11px; padding: 3px 8px; display: inline-block;" placeholder="Filter employee in summary..." onkeyup="filterSummaryTable()" />
                                                </div>
                                            </div>
                                            <div style="max-height: 260px; overflow-y: auto; border: 1px solid #e2e8f0; border-radius: 4px;">
                                                <table class="table table-bordered table-striped table-hover" id="tblEmpSummary" style="margin-bottom: 0; font-size: 11px;">
                                                    <thead style="position: sticky; top: 0; background: #f8fafc; z-index: 5;">
                                                        <tr>
                                                            <th style="width: 45px; text-align: center;">S.No.</th>
                                                            <th>Employee Name</th>
                                                            <th style="width: 90px; text-align: center;">Present (P)</th>
                                                            <th style="width: 90px; text-align: center;">Absent (A)</th>
                                                            <th style="width: 110px; text-align: center;">Half Day (FH/SH)</th>
                                                            <th style="width: 105px; text-align: center;">Leaves (CL/CoF)</th>
                                                            <th style="width: 105px; text-align: center;">Payable Days</th>
                                                            <th style="width: 115px; text-align: center;">Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- Dynamic Rows Populated in JavaScript -->
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Save Button Section -->
                            <div class="row print_hidden" style="margin-top: 15px;">
                                <div class="col-md-10"></div>
                                <div class="col-md-2">
                                    <asp:Button ID="btnSave" CssClass="btn btn-block btn-success" runat="server"
                                        Text="Save Attendance" OnClick="btnSave_Click" OnClientClick="return confirmSaveAttendance();" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </asp:Content>

    <asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
        <script>
            $(document).ready(function () {
                if (window.hideLoader) { window.hideLoader(); }

                // Initial color-coding of attendance dropdowns
                $('#GridView1 select').each(function () {
                    applyStyle(this);
                });

                // Initial row selection highlighting
                $('#GridView1 tbody tr:has(td)').each(function () {
                    var $row = $(this);
                    if ($row.find('td:first-child input[type="checkbox"]').is(':checked')) {
                        $row.addClass('row-selected');
                    } else {
                        $row.removeClass('row-selected');
                    }
                });

                // Compute initial summary stats
                updateSummaryStats();
            });

            // Select All checkboxes toggle
            $(document).on('click', '#checkAll', function () {
                var isChecked = this.checked;
                $('#GridView1 tbody tr:has(td)').each(function () {
                    var $row = $(this);
                    var $chk = $row.find('td:first-child input[type="checkbox"]');
                    var isLocked = $row.hasClass('attendance-locked') || 
                                   ($row.attr('data-attendance-set') || '').trim().toLowerCase() === 'true' || 
                                   ($row.attr('data-generate-status') || '').trim().toLowerCase() === 'generated';
                    if (!isLocked && !$chk.is(':disabled')) {
                        $chk.prop('checked', isChecked);
                        if (isChecked) {
                            $row.addClass('row-selected');
                        } else {
                            $row.removeClass('row-selected');
                        }
                    }
                });
                updateSummaryStats();
            });

            // Individual row checkbox change
            $(document).on('change', '#GridView1 tbody td:first-child input[type="checkbox"]', function () {
                var $row = $(this).closest('tr');
                if (this.checked) {
                    $row.addClass('row-selected');
                } else {
                    $row.removeClass('row-selected');
                    $('#checkAll').prop('checked', false);
                }
                updateSummaryStats();
            });

            // Dropdown change: update color & recalculate Payable Days immediately
            function change(ddl) {
                applyStyle(ddl);
                calculateRowPayableDays(ddl);
            }

            // Apply color-coding to dropdown
            function applyStyle(ddl) {
                var val = $(ddl).val();
                if (val === 'A') {
                    $(ddl).css({ 'color': '#d9534f', 'border-color': '#d9534f', 'background-color': '#fff5f5' });
                } else if (val === 'H' || val === 'FH' || val === 'SH') {
                    $(ddl).css({ 'color': '#e67e22', 'border-color': '#f39c12', 'background-color': '#fef9e7' });
                } else if (val === 'P') {
                    $(ddl).css({ 'color': '#27ae60', 'border-color': '#2ecc71', 'background-color': '#eafaf1' });
                } else {
                    $(ddl).css({ 'color': '#2980b9', 'border-color': '#3498db', 'background-color': '#ebf5fb' });
                }
            }

            // Client-side instant recalculation of Payable Days
            function calculateRowPayableDays(element) {
                var $row = $(element).closest('tr');
                if ($row.length === 0) return;

                var year = parseInt($('#<%=ddlYear.ClientID%>').val());
                var month = parseInt($('#<%=ddlMonth.ClientID%>').val());
                var totalDays = (year && month) ? new Date(year, month, 0).getDate() : $row.find('select').length;

                var countAbsent = 0;
                var dayIndex = 1;

                $row.find('select').each(function () {
                    if (dayIndex <= totalDays) {
                        var v = $(this).val();
                        if (v === 'A') {
                            countAbsent += 1;
                        } else if (v === 'H' || v === 'FH' || v === 'SH') {
                            countAbsent += 0.5;
                        }
                    }
                    dayIndex++;
                });

                if (countAbsent > totalDays) {
                    countAbsent = totalDays;
                }

                var payableDays = totalDays - countAbsent;

                var $txtPayable = $row.find('input[id*="txtPayableDays"]');
                if ($txtPayable.length > 0) {
                    $txtPayable.val(payableDays.toFixed(2));
                }

                // Automatically check row checkbox and highlight row on edit
                var $chk = $row.find('td:first-child input[type="checkbox"]');
                if ($chk.length > 0 && !$chk.is(':checked') && !$chk.is(':disabled')) {
                    $chk.prop('checked', true);
                    $row.addClass('row-selected');
                }

                // Update verification summary
                updateSummaryStats();
            }

            // Calculate and display verification totals and employee-wise rows
            function updateSummaryStats() {
                var $rows = $('#GridView1 tbody tr:has(td)');
                var totalStaff = $rows.length;
                var totalGenerated = 0;
                var totalNotGenerated = 0;
                var selectedStaff = 0;
                var totalPresent = 0;
                var totalAbsent = 0;
                var totalHalf = 0;
                var totalLeaves = 0;
                var totalPayable = 0;

                var empTableHtml = '';

                $rows.each(function (idx) {
                    var $row = $(this);
                    var sno = $row.find('td').eq(1).text().trim() || (idx + 1);
                    var empName = $row.find('td').eq(2).text().trim();
                    var $chk = $row.find('td:first-child input[type="checkbox"]');
                    var isChecked = $chk.is(':checked');
                    var isDisabled = $chk.is(':disabled');
                    var genAttr = ($row.attr('data-generate-status') || '').trim();
                    var attSetAttr = ($row.attr('data-attendance-set') || '').trim();
                    var isAttendanceSet = (attSetAttr.toLowerCase() === 'true');
                    var isGenerated = (genAttr.toLowerCase() === 'generated');
                    var isLocked = $row.hasClass('attendance-locked') || isGenerated || isAttendanceSet;

                    if (isLocked) {
                        totalGenerated++;
                    } else {
                        totalNotGenerated++;
                    }

                    if (isChecked && !isLocked && !isDisabled) {
                        selectedStaff++;
                    }

                    var rowP = 0;
                    var rowA = 0;
                    var rowH = 0;
                    var rowL = 0;

                    $row.find('select').each(function () {
                        var v = $(this).val();
                        if (v === 'P') {
                            rowP++;
                            totalPresent++;
                        } else if (v === 'A') {
                            rowA++;
                            totalAbsent++;
                        } else if (v === 'H' || v === 'FH' || v === 'SH') {
                            rowH++;
                            totalHalf++;
                        } else if (v === 'CL' || v === 'CoF' || v === 'EL' || v === 'ML' || v === 'OL' || v === 'RH') {
                            rowL++;
                            totalLeaves++;
                        }
                    });

                    var payVal = parseFloat($row.find('input[id*="txtPayableDays"]').val()) || 0;
                    totalPayable += payVal;

                    // Status badge
                    var statusBadge = '';
                    if (isLocked) {
                        if (isGenerated) {
                            statusBadge = '<span class="summary-status-badge status-locked"><i class="fa fa-lock"></i> Salary Generated</span>';
                        } else {
                            statusBadge = '<span class="summary-status-badge status-set"><i class="fa fa-check-circle"></i> Attendance Set (Locked)</span>';
                        }
                    } else if (isChecked) {
                        statusBadge = '<span class="summary-status-badge status-ready"><i class="fa fa-check"></i> Selected to Save</span>';
                    } else {
                        statusBadge = '<span class="summary-status-badge status-unselected">Pending</span>';
                    }

                    empTableHtml += '<tr data-row-idx="' + idx + '" data-emp-name="' + empName.replace(/"/g, '&quot;') + '" style="cursor: pointer;" title="Click to view & highlight ' + empName.replace(/"/g, '&quot;') + ' in attendance table above">';
                    empTableHtml += '<td style="text-align: center; font-weight: 600;">' + sno + '</td>';
                    empTableHtml += '<td style="font-weight: 600; color: #1e293b;">' + empName + '</td>';
                    empTableHtml += '<td style="text-align: center;"><span class="legend-badge badge-present" style="margin: 0; padding: 2px 7px;">' + rowP + '</span></td>';
                    empTableHtml += '<td style="text-align: center;">' + (rowA > 0 ? '<span class="legend-badge badge-absent" style="margin: 0; padding: 2px 7px;">' + rowA + '</span>' : '<span style="color: #94a3b8;">0</span>') + '</td>';
                    empTableHtml += '<td style="text-align: center;">' + (rowH > 0 ? '<span class="legend-badge badge-half" style="margin: 0; padding: 2px 7px;">' + rowH + '</span>' : '<span style="color: #94a3b8;">0</span>') + '</td>';
                    empTableHtml += '<td style="text-align: center;">' + (rowL > 0 ? '<span class="legend-badge badge-leave" style="margin: 0; padding: 2px 7px;">' + rowL + '</span>' : '<span style="color: #94a3b8;">0</span>') + '</td>';
                    empTableHtml += '<td style="text-align: center; font-weight: 700; color: #0f172a; font-size: 12px;">' + payVal.toFixed(2) + '</td>';
                    empTableHtml += '<td style="text-align: center;">' + statusBadge + '</td>';
                    empTableHtml += '</tr>';
                });

                $('#sumTotalStaff').text(totalStaff);
                $('#sumTotalGenerated').text(totalGenerated);
                $('#sumTotalNotGenerated').text(totalNotGenerated);
                $('#sumSelectedStaff').text(selectedStaff);

                $('#tblEmpSummary tbody').html(empTableHtml);
                filterSummaryTable();
            }

            // Filter rows inside employee-wise summary table
            function filterSummaryTable() {
                var query = $('#summaryEmpFilter').val();
                if (!query) {
                    $('#tblEmpSummary tbody tr').show();
                    return;
                }
                query = query.toUpperCase();
                $('#tblEmpSummary tbody tr').each(function () {
                    var name = $(this).find('td').eq(1).text().toUpperCase();
                    if (name.indexOf(query) > -1) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }

            // Click on summary row to jump and highlight employee in top grid
            $(document).on('click', '#tblEmpSummary tbody tr', function () {
                var $clickedRow = $(this);
                var idx = parseInt($clickedRow.attr('data-row-idx'), 10);
                var empName = ($clickedRow.attr('data-emp-name') || $clickedRow.find('td').eq(1).text()).trim();

                // 1. Mark clicked summary row as active
                $('#tblEmpSummary tbody tr').removeClass('active-summary-row');
                $clickedRow.addClass('active-summary-row');

                // 2. Locate target row in GridView1 (first by index, verified by name)
                var $targetRow = null;
                if (!isNaN(idx)) {
                    var $candidate = $('#GridView1 tbody tr:has(td)').eq(idx);
                    if ($candidate.length > 0 && $candidate.find('td').eq(2).text().trim().toUpperCase() === empName.toUpperCase()) {
                        $targetRow = $candidate;
                    }
                }
                // Fallback: search across all data rows in GridView1
                if (!$targetRow || $targetRow.length === 0) {
                    $('#GridView1 tbody tr:has(td)').each(function () {
                        if ($(this).find('td').eq(2).text().trim().toUpperCase() === empName.toUpperCase()) {
                            $targetRow = $(this);
                            return false;
                        }
                    });
                }

                if ($targetRow && $targetRow.length > 0) {
                    // A. If target row was hidden by top filter (#myInput), clear top filter so it is visible
                    if ($targetRow.is(':hidden')) {
                        $('#myInput').val('');
                        $('#GridView1 tbody tr').show();
                    }

                    var $container = $('.att-table-container');

                    // B. Smoothly scroll browser window to attendance table
                    $('html, body').stop().animate({
                        scrollTop: $container.offset().top - 70
                    }, 400);

                    // C. Smoothly scroll inside .att-table-container to the exact employee row
                    var containerScroll = $container.scrollTop();
                    var rowOffsetTop = $targetRow.offset().top;
                    var containerOffsetTop = $container.offset().top;
                    var targetScroll = containerScroll + (rowOffsetTop - containerOffsetTop) - 60;

                    $container.stop().animate({
                        scrollTop: targetScroll
                    }, 400);

                    // D. Apply pulsing glowing highlight to target row and cells
                    $('#GridView1 tbody tr').removeClass('row-emp-highlight');
                    $targetRow.addClass('row-emp-highlight');

                    setTimeout(function () {
                        $targetRow.removeClass('row-emp-highlight');
                    }, 4000);
                }
            });

            // Live employee name filter
            function filterEmployeeNames() {
                var filter = $('#myInput').val().toUpperCase();
                $('#GridView1 tbody tr').each(function () {
                    var empNameTd = $(this).find('td').eq(2);
                    if (empNameTd.length > 0) {
                        var nameText = empNameTd.text().toUpperCase();
                        if (nameText.indexOf(filter) > -1) {
                            $(this).show();
                        } else {
                            $(this).hide();
                        }
                    }
                });
            }

            // Search validation
            function validateform() {
                var msg = "";
                if (document.getElementById('<%=ddlYear.ClientID%>').selectedIndex <= 0) {
                    msg += "Select Financial Year. \n";
                }
                if (document.getElementById('<%=ddlMonth.ClientID%>').selectedIndex <= 0) {
                    msg += "Select Month. \n";
                }
                if (document.getElementById('<%=ddlOfficeName.ClientID%>').selectedIndex <= 0) {
                    msg += "Select Office Name. \n";
                }
                if (msg !== "") {
                    alert(msg);
                    return false;
                }
                showLoader('Searching attendance records...');
                return true;
            }

            // Save Attendance Confirmation & Loader
            function confirmSaveAttendance() {
                var selected = parseInt($('#sumSelectedStaff').text(), 10) || 0;
                if (selected <= 0) {
                    alert('Please select at least one employee before saving attendance.');
                    return false;
                }
                if (confirm('Are you sure you want to save attendance for ' + selected + ' selected employee(s)?')) {
                    showLoader('Saving attendance for ' + selected + ' employee(s)...');
                    return true;
                }
                return false;
            }

            // Generic Excel Blob File Downloader
            function downloadExcelFile(htmlContent, filename) {
                var fullHtml = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">' +
                    '<head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"/>' +
                    '<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>Sheet1</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
                    '<style>table { border-collapse: collapse; } td, th { vertical-align: middle; border: 1px solid #b0b0b0; padding: 4px; }</style>' +
                    '</head><body>' + htmlContent + '</body></html>';

                var blob = new Blob([fullHtml], { type: 'application/vnd.ms-excel;charset=utf-8;' });
                if (window.navigator && window.navigator.msSaveBlob) {
                    window.navigator.msSaveBlob(blob, filename);
                } else {
                    var link = document.createElement("a");
                    var url = URL.createObjectURL(blob);
                    link.href = url;
                    link.download = filename;
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                    setTimeout(function () { URL.revokeObjectURL(url); }, 2000);
                }
            }

            // Export 1: Main Attendance Grid
            function exportAttendanceGridToExcel() {
                var $grid = $('#GridView1');
                if ($grid.length === 0 || $grid.find('tbody tr:has(td)').length === 0) {
                    alert('No attendance records found to export.');
                    return;
                }

                var monthText = $('#<%=ddlMonth.ClientID%> option:selected').text().trim();
                if (monthText.toLowerCase().indexOf('select') === 0) monthText = '';

                var yearText = $('#<%=ddlYear.ClientID%> option:selected').text().trim();
                if (yearText.toLowerCase().indexOf('select') === 0) yearText = '';

                var officeText = $('#<%=ddlOfficeName.ClientID%> option:selected').text().trim();
                if (officeText.toLowerCase().indexOf('select') === 0) officeText = '';

                var postText = $('#<%=ddlEmp_TypeOfPost.ClientID%> option:selected').text().trim();
                if (postText.toLowerCase().indexOf('select') === 0) postText = '';

                var html = '<table border="1" style="border-collapse:collapse; font-family:Calibri, Arial, sans-serif; font-size:10pt;">';
                html += '<tr><th colspan="34" style="background:#1e3a8a; color:#ffffff; font-size:14pt; text-align:center; height:36px; font-weight:bold;">' + (officeText || 'Office Attendance') + '</th></tr>';
                
                var subHeader = 'Attendance Sheet - ' + (monthText ? monthText + ' ' : '') + yearText + (postText ? ' | Type of Post: ' + postText : '');
                html += '<tr><th colspan="34" style="background:#3b82f6; color:#ffffff; font-size:11pt; text-align:center; height:26px; font-weight:bold;">' + subHeader + '</th></tr>';

                // Column Headers
                html += '<tr style="background:#e2e8f0; font-weight:bold; height:26px; text-align:center;">';
                html += '<th style="width:45px;">S.No.</th>';
                html += '<th style="width:200px; text-align:left;">Employee Name</th>';
                for (var d = 1; d <= 31; d++) {
                    html += '<th style="width:32px;">' + d + '</th>';
                }
                html += '<th style="width:90px;">Payable Days</th>';
                html += '</tr>';

                // Data Rows
                $grid.find('tbody tr:has(td)').each(function () {
                    var $row = $(this);
                    if ($row.css('display') === 'none') return;

                    var sno = $row.find('td').eq(1).text().trim();
                    var empName = $row.find('td').eq(2).text().trim();

                    html += '<tr style="height:22px;">';
                    html += '<td style="text-align:center;">' + sno + '</td>';
                    html += '<td style="text-align:left; font-weight:600;">' + empName + '</td>';

                    for (var d = 1; d <= 31; d++) {
                        var $select = $row.find('select[id*="ddlDay' + d + '"]');
                        var val = ($select.length > 0) ? $select.val() : ($row.find('td').eq(d + 2).text().trim() || '');
                        var bg = '#ffffff';
                        if (val === 'A') bg = '#fee2e2';
                        else if (val === 'FH' || val === 'SH' || val === 'H') bg = '#fef3c7';
                        else if (val === 'CL' || val === 'CoF') bg = '#e0f2fe';

                        html += '<td style="text-align:center; background:' + bg + ';">' + val + '</td>';
                    }

                    var payVal = $row.find('input[id*="txtPayableDays"]').val() || $row.find('td').eq(34).text().trim() || '0.00';
                    html += '<td style="text-align:center; font-weight:bold; mso-number-format:\'0.00\';">' + payVal + '</td>';
                    html += '</tr>';
                });

                html += '</table>';

                var cleanOffice = officeText.replace(/[^a-zA-Z0-9]/g, '_');
                var cleanMonth = monthText.replace(/[^a-zA-Z0-9]/g, '_');
                var cleanYear = yearText.replace(/[^a-zA-Z0-9]/g, '_');
                var filename = 'Attendance_Sheet_' + (cleanOffice ? cleanOffice + '_' : '') + (cleanMonth ? cleanMonth + '_' : '') + (cleanYear ? cleanYear : 'Export') + '.xls';
                downloadExcelFile(html, filename);
            }

            // Export 2: Employee-Wise Verification Summary
            function exportSummaryGridToExcel() {
                var $table = $('#tblEmpSummary');
                if ($table.length === 0 || $table.find('tbody tr').length === 0) {
                    alert('No summary records found to export.');
                    return;
                }

                var monthText = $('#<%=ddlMonth.ClientID%> option:selected').text().trim();
                if (monthText.toLowerCase().indexOf('select') === 0) monthText = '';

                var yearText = $('#<%=ddlYear.ClientID%> option:selected').text().trim();
                if (yearText.toLowerCase().indexOf('select') === 0) yearText = '';

                var officeText = $('#<%=ddlOfficeName.ClientID%> option:selected').text().trim();
                if (officeText.toLowerCase().indexOf('select') === 0) officeText = '';

                var postText = $('#<%=ddlEmp_TypeOfPost.ClientID%> option:selected').text().trim();
                if (postText.toLowerCase().indexOf('select') === 0) postText = '';

                var totalStaff = $('#sumTotalStaff').text() || '0';
                var totalGenerated = $('#sumTotalGenerated').text() || '0';
                var totalNotGenerated = $('#sumTotalNotGenerated').text() || '0';

                var html = '<table border="1" style="border-collapse:collapse; font-family:Calibri, Arial, sans-serif; font-size:10pt;">';
                html += '<tr><th colspan="8" style="background:#0f766e; color:#ffffff; font-size:14pt; text-align:center; height:36px; font-weight:bold;">' + (officeText || 'Office Attendance Summary') + '</th></tr>';
                
                var summarySubHeader = 'Attendance Verification Summary - ' + (monthText ? monthText + ' ' : '') + yearText + (postText ? ' | Type of Post: ' + postText : '');
                html += '<tr><th colspan="8" style="background:#14b8a6; color:#ffffff; font-size:11pt; text-align:center; height:26px; font-weight:bold;">' + summarySubHeader + '</th></tr>';
                html += '<tr><th colspan="8" style="background:#f1f5f9; font-size:10pt; text-align:left; height:24px;">' +
                    '<b>Total Employees:</b> ' + totalStaff + ' &nbsp;&nbsp;|&nbsp;&nbsp; ' +
                    '<b>Generated (Locked):</b> ' + totalGenerated + ' &nbsp;&nbsp;|&nbsp;&nbsp; ' +
                    '<b>Not Generated (Pending):</b> ' + totalNotGenerated + ' &nbsp;&nbsp;|&nbsp;&nbsp; ' +
                    '<b>Selected Record:</b> ' + ($('#sumSelectedStaff').text() || '0') +
                    '</th></tr>';

                // Column Headers
                html += '<tr style="background:#e2e8f0; font-weight:bold; height:26px; text-align:center;">';
                html += '<th style="width:45px;">S.No.</th>';
                html += '<th style="width:220px; text-align:left;">Employee Name</th>';
                html += '<th style="width:90px;">Present (P)</th>';
                html += '<th style="width:90px;">Absent (A)</th>';
                html += '<th style="width:110px;">Half Day (FH/SH)</th>';
                html += '<th style="width:110px;">Leaves (CL/CoF)</th>';
                html += '<th style="width:100px;">Payable Days</th>';
                html += '<th style="width:140px;">Status</th>';
                html += '</tr>';

                // Rows
                $table.find('tbody tr').each(function () {
                    var $tr = $(this);
                    if ($tr.css('display') === 'none') return;

                    var sno = $tr.find('td').eq(0).text().trim();
                    var empName = $tr.find('td').eq(1).text().trim();
                    var pVal = $tr.find('td').eq(2).text().trim();
                    var aVal = $tr.find('td').eq(3).text().trim();
                    var hVal = $tr.find('td').eq(4).text().trim();
                    var lVal = $tr.find('td').eq(5).text().trim();
                    var payVal = $tr.find('td').eq(6).text().trim();
                    var status = $tr.find('td').eq(7).text().trim();

                    html += '<tr style="height:22px;">';
                    html += '<td style="text-align:center;">' + sno + '</td>';
                    html += '<td style="text-align:left; font-weight:600;">' + empName + '</td>';
                    html += '<td style="text-align:center;">' + pVal + '</td>';
                    html += '<td style="text-align:center;">' + aVal + '</td>';
                    html += '<td style="text-align:center;">' + hVal + '</td>';
                    html += '<td style="text-align:center;">' + lVal + '</td>';
                    html += '<td style="text-align:center; font-weight:bold; mso-number-format:\'0.00\';">' + payVal + '</td>';
                    html += '<td style="text-align:center;">' + status + '</td>';
                    html += '</tr>';
                });

                html += '</table>';

                var cleanMonth = monthText.replace(/[^a-zA-Z0-9]/g, '_');
                var cleanYear = yearText.replace(/[^a-zA-Z0-9]/g, '_');
                var filename = 'Attendance_Verification_Summary_' + (cleanMonth ? cleanMonth + '_' : '') + (cleanYear ? cleanYear : 'Export') + '.xls';
                downloadExcelFile(html, filename);
            }
        </script>
    </asp:Content>