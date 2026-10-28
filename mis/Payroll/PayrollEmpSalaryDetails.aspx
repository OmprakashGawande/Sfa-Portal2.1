<%@ Page Title="Employee Wise Salary Detail" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollEmpSalaryDetails.aspx.cs" Inherits="mis_Payroll_PayrollEmpSalaryDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <style>
        .salary-header-title {
            font-size: 17px;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
            display: inline-block;
        }

        .filter-panel {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 15px 18px 8px 18px;
            margin-bottom: 15px;
        }

        .search-box-wrap {
            position: relative;
            margin-bottom: 12px;
        }

        .search-box-wrap i {
            position: absolute;
            left: 12px;
            top: 10px;
            color: #94a3b8;
            font-size: 14px;
        }

        .search-box-wrap input {
            padding-left: 36px;
            height: 36px;
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            width: 100%;
            font-size: 12px;
            transition: all 0.2s ease;
        }

        .search-box-wrap input:focus {
            border-color: #3b82f6;
            outline: none;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }

        /* Summary Cards */
        .summary-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 12px 14px;
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
            font-size: 11px;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .summary-card .card-val {
            display: block;
            font-size: 22px;
            font-weight: 700;
            line-height: 1.2;
        }

        .card-total { border-top: 4px solid #3b82f6; background: #f8fafc; }
        .card-total .card-val { color: #1d4ed8; }

        .card-generated { border-top: 4px solid #ef4444; background: #fef2f2; }
        .card-generated .card-val { color: #dc2626; }

        .card-notgenerated { border-top: 4px solid #10b981; background: #f0fdf4; }
        .card-notgenerated .card-val { color: #15803d; }

        .card-selected { border-top: 4px solid #6366f1; background: #eef2ff; }
        .card-selected .card-val { color: #4f46e5; }

        .card-earning { border-top: 4px solid #0284c7; background: #f0f9ff; }
        .card-earning .card-val { color: #0284c7; }

        .card-deduction { border-top: 4px solid #dc2626; background: #fef2f2; }
        .card-deduction .card-val { color: #dc2626; }

        .card-netpay { border-top: 4px solid #059669; background: #ecfdf5; }
        .card-netpay .card-val { color: #047857; }

        /* Grid Table Styles */
        .salary-table-container {
            max-height: 480px;
            overflow: auto;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            position: relative;
            background: #ffffff;
        }

        #GridView1 {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-size: 11px;
            margin-bottom: 0;
        }

        #GridView1 thead th {
            position: sticky;
            top: 0;
            z-index: 20;
            background: #f1f5f9;
            color: #334155;
            font-weight: 700;
            border: 1px solid #cbd5e1;
            text-align: center;
            padding: 7px 6px !important;
            font-size: 11px;
            white-space: nowrap;
        }

        #GridView1 td {
            vertical-align: middle;
            padding: 5px 6px !important;
            border: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        /* Row Hover & Selection */
        #GridView1 tbody tr {
            transition: background-color 0.15s ease-in-out;
        }

        #GridView1 tbody tr:hover > td {
            background-color: #eef6ff !important;
        }

        #GridView1 tbody tr.row-selected > td {
            background-color: #fef2f2 !important;
        }

        #GridView1 tbody tr.salary-locked {
            background-color: #f8fafc !important;
        }

        #GridView1 tbody tr.salary-locked td {
            color: #64748b;
        }

        #GridView1 tbody tr.salary-hold {
            background-color: #fffbeb !important;
        }

        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 3px 8px;
            font-size: 10px;
            font-weight: 700;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .badge-generated {
            background-color: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .badge-hold {
            background-color: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
        }

        .badge-pending {
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
        }

        .btn-detail {
            padding: 2px 8px;
            font-size: 11px;
            font-weight: 600;
            border-radius: 3px;
        }

        .amount-col {
            text-align: right !important;
            font-family: 'Consolas', 'Courier New', monospace;
            font-weight: 600;
        }

        .center-col {
            text-align: center !important;
        }


        @media print {
            .print_hidden,
            .loader,
            .main-footer {
                display: none !important;
            }

            .salary-table-container {
                max-height: none !important;
                overflow: visible !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="content-wrapper">
        <section class="content">
            <div class="box box-success" style="min-height: 520px; border-top: 3px solid #10b981; border-radius: 6px;">
                <div class="box-header with-border" style="padding: 12px 16px;">
                    <h3 class="salary-header-title">
                        <i class="fa fa-money" style="color: #10b981; margin-right: 6px;"></i> Employee Wise Salary Details & Processing
                    </h3>
                </div>

                <div class="box-body" style="padding: 16px;">
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

                    <!-- Filter Section -->
                    <div class="filter-panel print_hidden">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label style="font-weight: 600; font-size: 12px;">Office Name <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlOfficeName" runat="server" CssClass="form-control select2" AutoPostBack="True" OnSelectedIndexChanged="ddlOfficeName_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label style="font-weight: 600; font-size: 12px;">Financial Year <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label style="font-weight: 600; font-size: 12px;">Month <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label style="font-weight: 600; font-size: 12px;">Type of Post <span style="color: red;">*</span></label>
                                    <asp:DropDownList ID="ddlEmp_TypeOfPost" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="0">Select Post Type</asp:ListItem>
                                        <asp:ListItem Value="Permanent">Regular/Permanent</asp:ListItem>
                                        <asp:ListItem Value="promotion">Trainee</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group" style="margin-top: 24px;">
                                    <asp:Button ID="btnSearch" CssClass="btn btn-block btn-success" Style="font-weight: 600;" runat="server" Text="Search" OnClick="btnSearch_Click" OnClientClick="return validateform();" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Salary Detail Content Section -->
                    <div id="DivDetail" runat="server">
                        <!-- Headcount Summary Cards -->
                        <div class="row print_hidden" style="margin-bottom: 4px;">
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="summary-card card-total">
                                    <span class="card-title"><i class="fa fa-users"></i> Total Employee</span>
                                    <span class="card-val" id="sumTotalStaff">0</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="summary-card card-generated">
                                    <span class="card-title"><i class="fa fa-lock"></i> Total Generated</span>
                                    <span class="card-val" id="sumTotalGenerated">0</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="summary-card card-notgenerated">
                                    <span class="card-title"><i class="fa fa-clock-o"></i> Not Generated</span>
                                    <span class="card-val" id="sumTotalNotGenerated">0</span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="summary-card card-selected">
                                    <span class="card-title"><i class="fa fa-check-square-o"></i> Selected Record</span>
                                    <span class="card-val" id="sumSelectedStaff">0</span>
                                </div>
                            </div>
                        </div>

                        <!-- Financial Summary Cards (Earning, Deduction, Net) -->
                        <div class="row print_hidden" style="margin-bottom: 10px;">
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="summary-card card-earning">
                                    <span class="card-title"><i class="fa fa-money"></i> Total Earning</span>
                                    <span class="card-val" id="sumTotalEarning"><i class="fa fa-inr"></i> 0.00</span>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="summary-card card-deduction">
                                    <span class="card-title"><i class="fa fa-minus-circle"></i> Total Deduction</span>
                                    <span class="card-val" id="sumTotalDeduction"><i class="fa fa-inr"></i> 0.00</span>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <div class="summary-card card-netpay">
                                    <span class="card-title"><i class="fa fa-calculator"></i> Total Net Salary</span>
                                    <span class="card-val" id="sumTotalNetSalary"><i class="fa fa-inr"></i> 0.00</span>
                                </div>
                            </div>
                        </div>

                        <!-- Top Table Bar: Search & Export -->
                        <div class="row print_hidden" style="margin-bottom: 8px;">
                            <div class="col-md-5">
                                <div class="search-box-wrap" style="margin-bottom: 0;">
                                    <i class="fa fa-search"></i>
                                    <asp:TextBox ID="myInput" runat="server" ClientIDMode="Static" onkeyup="filterEmployeeNames()" placeholder="Search by Employee Name or ID..." title="Type employee name or ID"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-7 text-right">
                                <button type="button" class="btn btn-sm btn-success" onclick="exportSalaryGridToExcel()" style="font-weight: 600; margin-right: 8px;">
                                    <i class="fa fa-file-excel-o"></i> Export to Excel
                                </button>
                                <small style="color: #64748b; font-size: 11px;"><i class="fa fa-print"></i> Press <b>Ctrl + P</b> to print sheet</small>
                            </div>
                        </div>

                        <!-- Scrollable Table Container -->
                        <div class="salary-table-container">
                            <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-striped Grid" ClientIDMode="Static" AutoGenerateColumns="False" AllowPaging="false" DataKeyNames="Emp_ID" OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="30px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="center-col">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="checkAll" runat="server" ClientIDMode="static" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server" Checked="false" Enabled='<%# Eval("GenStatus").ToString() == "Not Generated" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="40px" ItemStyle-CssClass="center-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("Emp_ID").ToString()%>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="UserName" HeaderText="Employee ID" ItemStyle-Font-Bold="true" ItemStyle-CssClass="center-col" />

                                    <asp:TemplateField HeaderText="Employee Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmployeeName" runat="server" Font-Bold="true" ForeColor="#1e293b" Text='<%# Eval("Emp_Name").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Basic Salary" ItemStyle-CssClass="amount-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_Basic" runat="server" Text='<%# Eval("Salary_Basic").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Basic Pay Scale" ControlStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_BasicPayScale" runat="server" Text='<%# Eval("Salary_BasicPayScale").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Payable Days" ItemStyle-CssClass="center-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_PayableDays" runat="server" Font-Bold="true" Text='<%# Eval("Salary_PayableDays").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Earning Total" ItemStyle-CssClass="amount-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_EarningTotal" runat="server" ForeColor="#16a34a" Text='<%# Eval("Salary_EarningTotal").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Deduction Total" ItemStyle-CssClass="amount-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_DeductionTotal" runat="server" ForeColor="#dc2626" Text='<%# Eval("Salary_DeductionTotal").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Net Salary" ItemStyle-CssClass="amount-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSalary_NetSalary" runat="server" Font-Bold="true" ForeColor="#0f172a" Text='<%# Eval("Salary_NetSalary").ToString()%>'></asp:Label>
                                            <asp:Label ID="lblSalary_NoDayEarnAmt" runat="server" CssClass="hidden" Text='<%# Eval("Salary_NoDayEarnAmt").ToString()%>'></asp:Label>
                                            <asp:Label ID="lblSalary_NoDayDeduAmt" runat="server" CssClass="hidden" Text='<%# Eval("Salary_NoDayDeduAmt").ToString()%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Salary Status" ItemStyle-CssClass="center-col">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Visible="false" Text='<%# Eval("Status").ToString()%>' />
                                            <asp:Label ID="lblGenStatus" runat="server" CssClass="hidden" Text='<%# Eval("GenStatus").ToString()%>' />
                                            <%# Eval("GenStatus").ToString() == "Generated" 
                                                ? "<span class='status-badge badge-generated'><i class='fa fa-lock'></i> Generated</span>" 
                                                : (Eval("Status").ToString().ToLower() == "hold" 
                                                    ? "<span class='status-badge badge-hold'><i class='fa fa-pause'></i> Hold</span>" 
                                                    : "<span class='status-badge badge-pending'><i class='fa fa-clock-o'></i> Pending</span>") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Salary Slip" ItemStyle-CssClass="center-col">
                                        <ItemTemplate>
                                            <a id="a1" runat="server" class="btn btn-xs btn-primary btn-detail" target="_blank" href='<%# "PayrollEmpSalarySlip.aspx?Emp_ID=" + APIProcedure.Client_Encrypt(Eval("Emp_ID").ToString()) + "&&Office_ID=" + APIProcedure.Client_Encrypt(Eval("Office_ID").ToString()) + "&&Year=" + APIProcedure.Client_Encrypt(Eval("Year").ToString()) + "&&MonthNo=" + APIProcedure.Client_Encrypt(Eval("MonthNo").ToString()) + "&&GenStatus=" + APIProcedure.Client_Encrypt(Eval("GenStatus").ToString()) %>'>
                                                <i class="fa fa-file-text-o"></i> View Slip
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Action Buttons Section -->
                        <div class="row print_hidden" style="margin-top: 15px;">
                            <div class="col-md-7">
                                <span style="font-size: 11px; color: #64748b;">
                                    <i class="fa fa-info-circle"></i> Note: Check the employees whose salary you want to process, then click <b>Generate Salary</b> or <b>Hold Salary</b>.
                                </span>
                            </div>
                            <div class="col-md-5 text-right">
                                <asp:Button ID="btnGenerated" CssClass="btn btn-success" Style="font-weight: 700; min-width: 140px; margin-right: 8px;" runat="server" Text="Generate Salary" OnClick="btnGenerated_Click" OnClientClick="return confirmAction('Generate');" />
                                <asp:Button ID="btnHold" CssClass="btn btn-warning" Style="font-weight: 700; min-width: 110px;" OnClick="btnHold_Click" runat="server" Text="Hold Salary" OnClientClick="return confirmAction('Hold');" />
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
            hideLoader();

            // Initial calculation of KPI values
            updateSalaryStats();
        });

        function showLoader(msg) {
            if (window.showLoader) {
                window.showLoader(msg);
            }
        }

        function hideLoader() {
            if (window.hideLoader) {
                window.hideLoader();
            }
        }

        // Toggle Select All checkboxes
        $(document).on('click', '#checkAll', function () {
            var isChecked = this.checked;
            $('#GridView1 tbody tr:has(td)').each(function () {
                var $row = $(this);
                var $chk = $row.find('td:first-child input[type="checkbox"]');
                var isLocked = $row.hasClass('salary-locked') || ($row.attr('data-gen-status') || '').trim().toLowerCase() === 'generated';

                if (!isLocked && !$chk.is(':disabled')) {
                    $chk.prop('checked', isChecked);
                    if (isChecked) {
                        $row.addClass('row-selected');
                    } else {
                        $row.removeClass('row-selected');
                    }
                }
            });
            updateSalaryStats();
        });

        // Individual checkbox change
        $(document).on('change', '#GridView1 tbody td:first-child input[type="checkbox"]', function () {
            var $row = $(this).closest('tr');
            if (this.checked) {
                $row.addClass('row-selected');
            } else {
                $row.removeClass('row-selected');
                $('#checkAll').prop('checked', false);
            }
            updateSalaryStats();
        });

        // Recalculate summary KPIs in real-time
        function updateSalaryStats() {
            var $rows = $('#GridView1 tbody tr:has(td)');
            var totalStaff = $rows.length;
            var totalGenerated = 0;
            var totalNotGenerated = 0;
            var selectedStaff = 0;
            var totalEarnSalary = 0;
            var selectedEarnSalary = 0;
            var totalDeduSalary = 0;
            var selectedDeduSalary = 0;
            var totalNetSalary = 0;
            var selectedNetSalary = 0;

            $rows.each(function () {
                var $row = $(this);
                var $chk = $row.find('td:first-child input[type="checkbox"]');
                var isChecked = $chk.is(':checked');
                var isLocked = $row.hasClass('salary-locked') || ($row.attr('data-gen-status') || '').trim().toLowerCase() === 'generated';

                // Earning total parsing
                var earnText = $row.find('span[id*="lblSalary_EarningTotal"]').text().replace(/[^0-9.-]/g, '');
                var earnVal = parseFloat(earnText) || 0;
                totalEarnSalary += earnVal;

                // Deduction total parsing
                var deduText = $row.find('span[id*="lblSalary_DeductionTotal"]').text().replace(/[^0-9.-]/g, '');
                var deduVal = parseFloat(deduText) || 0;
                totalDeduSalary += deduVal;

                // Net salary parsing
                var netText = $row.find('span[id*="lblSalary_NetSalary"]').text().replace(/[^0-9.-]/g, '');
                var netVal = parseFloat(netText) || 0;
                totalNetSalary += netVal;

                if (isLocked) {
                    totalGenerated++;
                } else {
                    totalNotGenerated++;
                }

                if (isChecked && !isLocked) {
                    selectedStaff++;
                    selectedEarnSalary += earnVal;
                    selectedDeduSalary += deduVal;
                    selectedNetSalary += netVal;
                }
            });

            $('#sumTotalStaff').text(totalStaff);
            $('#sumTotalGenerated').text(totalGenerated);
            $('#sumTotalNotGenerated').text(totalNotGenerated);
            $('#sumSelectedStaff').text(selectedStaff);

            var displayEarn = (selectedStaff > 0) ? selectedEarnSalary : totalEarnSalary;
            var displayDedu = (selectedStaff > 0) ? selectedDeduSalary : totalDeduSalary;
            var displayNet = (selectedStaff > 0) ? selectedNetSalary : totalNetSalary;

            var fmtEarn = displayEarn.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            var fmtDedu = displayDedu.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            var fmtNet = displayNet.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

            $('#sumTotalEarning').html('<i class="fa fa-inr"></i> ' + fmtEarn);
            $('#sumTotalDeduction').html('<i class="fa fa-inr"></i> ' + fmtDedu);
            $('#sumTotalNetSalary').html('<i class="fa fa-inr"></i> ' + fmtNet);

            if (selectedStaff > 0) {
                $('.card-earning .card-title').html('<i class="fa fa-money"></i> Selected Earning');
                $('.card-deduction .card-title').html('<i class="fa fa-minus-circle"></i> Selected Deduction');
                $('.card-netpay .card-title').html('<i class="fa fa-calculator"></i> Selected Net Salary');
            } else {
                $('.card-earning .card-title').html('<i class="fa fa-money"></i> Total Earning');
                $('.card-deduction .card-title').html('<i class="fa fa-minus-circle"></i> Total Deduction');
                $('.card-netpay .card-title').html('<i class="fa fa-calculator"></i> Total Net Salary');
            }
        }

        // Live employee search filter by name and ID
        function filterEmployeeNames() {
            var query = ($('#myInput').val() || '').trim().toUpperCase();
            $('#GridView1 tbody tr:has(td)').each(function () {
                var $row = $(this);
                var empId = $row.find('td').eq(2).text().toUpperCase();
                var empName = $row.find('td').eq(3).text().toUpperCase();

                if (!query || empId.indexOf(query) > -1 || empName.indexOf(query) > -1) {
                    $row.show();
                } else {
                    $row.hide();
                }
            });
        }

        // Search Form Validation
        function validateform() {
            var msg = "";
            if (document.getElementById('<%=ddlOfficeName.ClientID%>').selectedIndex <= 0) {
                msg += "Select Office Name. \n";
            }
            if (document.getElementById('<%=ddlYear.ClientID%>').selectedIndex <= 0) {
                msg += "Select Financial Year. \n";
            }
            if (document.getElementById('<%=ddlMonth.ClientID%>').selectedIndex <= 0) {
                msg += "Select Month. \n";
            }
            if (document.getElementById('<%=ddlEmp_TypeOfPost.ClientID%>').selectedIndex <= 0) {
                msg += "Select Type of Post. \n";
            }

            if (msg !== "") {
                alert(msg);
                return false;
            }
            showLoader('Searching salary details...');
            return true;
        }

        // Action confirmation for Generate & Hold
        function confirmAction(actionType) {
            var selected = parseInt($('#sumSelectedStaff').text(), 10) || 0;
            if (selected <= 0) {
                alert('Please select at least one employee before proceeding.');
                return false;
            }
            var verb = (actionType === 'Generate') ? 'generate salary' : 'put salary on hold';
            if (confirm('Are you sure you want to ' + verb + ' for ' + selected + ' selected employee(s)?')) {
                if (actionType === 'Generate') {
                    showLoader('Generating salary for ' + selected + ' employee(s)...');
                } else {
                    showLoader('Putting salary on hold for ' + selected + ' employee(s)...');
                }
                return true;
            }
            return false;
        }

        // Generic Excel Download Helper
        function downloadExcelFile(htmlContent, filename) {
            var fullHtml = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">' +
                '<head><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"/>' +
                '<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>SalaryDetails</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->' +
                '<style>table { border-collapse: collapse; } td, th { vertical-align: middle; border: 1px solid #b0b0b0; padding: 5px; font-family: Calibri, Arial, sans-serif; font-size: 10pt; }</style>' +
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

        // Export Salary Details Grid to Excel
        function exportSalaryGridToExcel() {
            var $grid = $('#GridView1');
            if ($grid.length === 0 || $grid.find('tbody tr:has(td)').length === 0) {
                alert('No salary records found to export.');
                return;
            }

            var officeText = $('#<%=ddlOfficeName.ClientID%> option:selected').text().trim();
            if (officeText.toLowerCase().indexOf('select') === 0) officeText = '';

            var yearText = $('#<%=ddlYear.ClientID%> option:selected').text().trim();
            if (yearText.toLowerCase().indexOf('select') === 0) yearText = '';

            var monthText = $('#<%=ddlMonth.ClientID%> option:selected').text().trim();
            if (monthText.toLowerCase().indexOf('select') === 0) monthText = '';

            var postText = $('#<%=ddlEmp_TypeOfPost.ClientID%> option:selected').text().trim();
            if (postText.toLowerCase().indexOf('select') === 0) postText = '';

            var totalStaff = $('#sumTotalStaff').text() || '0';
            var totalGenerated = $('#sumTotalGenerated').text() || '0';
            var totalNotGenerated = $('#sumTotalNotGenerated').text() || '0';
            var totalEarnSalary = ($('#sumTotalEarning').text() || '0').trim();
            var totalDeduSalary = ($('#sumTotalDeduction').text() || '0').trim();
            var totalNetSalary = ($('#sumTotalNetSalary').text() || '0').trim();

            var html = '<table border="1" style="border-collapse:collapse; font-family:Calibri, Arial, sans-serif;">';
            html += '<tr><th colspan="9" style="background:#1e3a8a; color:#ffffff; font-size:14pt; text-align:center; height:36px; font-weight:bold;">' + (officeText || 'Office Salary Details') + '</th></tr>';

            var subHeader = 'Employee Wise Salary Statement - ' + (monthText ? monthText + ' ' : '') + yearText + (postText ? ' | Type of Post: ' + postText : '');
            html += '<tr><th colspan="9" style="background:#3b82f6; color:#ffffff; font-size:11pt; text-align:center; height:26px; font-weight:bold;">' + subHeader + '</th></tr>';

            html += '<tr><th colspan="9" style="background:#f1f5f9; font-size:10pt; text-align:left; height:24px;">' +
                '<b>Total Staff:</b> ' + totalStaff + ' &nbsp;|&nbsp; ' +
                '<b>Generated:</b> ' + totalGenerated + ' &nbsp;|&nbsp; ' +
                '<b>Pending:</b> ' + totalNotGenerated + ' &nbsp;|&nbsp; ' +
                '<b>Earning:</b> Rs. ' + totalEarnSalary + ' &nbsp;|&nbsp; ' +
                '<b>Deduction:</b> Rs. ' + totalDeduSalary + ' &nbsp;|&nbsp; ' +
                '<b>Net Salary:</b> Rs. ' + totalNetSalary +
                '</th></tr>';

            // Table Column Headers
            html += '<tr style="background:#e2e8f0; font-weight:bold; height:28px; text-align:center;">';
            html += '<th style="width:45px;">S.No.</th>';
            html += '<th style="width:110px;">Employee ID</th>';
            html += '<th style="width:220px; text-align:left;">Employee Name</th>';
            html += '<th style="width:100px;">Basic Salary</th>';
            html += '<th style="width:90px;">Payable Days</th>';
            html += '<th style="width:110px;">Earning Total</th>';
            html += '<th style="width:110px;">Deduction Total</th>';
            html += '<th style="width:110px;">Net Salary</th>';
            html += '<th style="width:120px;">Salary Status</th>';
            html += '</tr>';

            // Data Rows
            $grid.find('tbody tr:has(td)').each(function () {
                var $row = $(this);
                if ($row.css('display') === 'none') return; // respect search filter

                var sno = $row.find('td').eq(1).text().trim();
                var empId = $row.find('td').eq(2).text().trim();
                var empName = $row.find('td').eq(3).text().trim();
                var basic = $row.find('span[id*="lblSalary_Basic"]').text().trim();
                var payableDays = $row.find('span[id*="lblSalary_PayableDays"]').text().trim();
                var earn = $row.find('span[id*="lblSalary_EarningTotal"]').text().trim();
                var dedu = $row.find('span[id*="lblSalary_DeductionTotal"]').text().trim();
                var net = $row.find('span[id*="lblSalary_NetSalary"]').text().trim();
                var status = ($row.attr('data-gen-status') || $row.find('td').eq(10).text()).trim();

                html += '<tr style="height:24px;">';
                html += '<td style="text-align:center;">' + sno + '</td>';
                html += '<td style="text-align:center; font-weight:bold;">' + empId + '</td>';
                html += '<td style="text-align:left; font-weight:bold;">' + empName + '</td>';
                html += '<td style="text-align:right; mso-number-format:\'#,##0.00\';">' + basic + '</td>';
                html += '<td style="text-align:center;">' + payableDays + '</td>';
                html += '<td style="text-align:right; mso-number-format:\'#,##0.00\';">' + earn + '</td>';
                html += '<td style="text-align:right; mso-number-format:\'#,##0.00\';">' + dedu + '</td>';
                html += '<td style="text-align:right; font-weight:bold; mso-number-format:\'#,##0.00\';">' + net + '</td>';
                html += '<td style="text-align:center;">' + status + '</td>';
                html += '</tr>';
            });

            html += '</table>';

            var cleanOffice = officeText.replace(/[^a-zA-Z0-9]/g, '_');
            var cleanMonth = monthText.replace(/[^a-zA-Z0-9]/g, '_');
            var cleanYear = yearText.replace(/[^a-zA-Z0-9]/g, '_');
            var filename = 'Salary_Details_' + (cleanOffice ? cleanOffice + '_' : '') + (cleanMonth ? cleanMonth + '_' : '') + (cleanYear ? cleanYear : 'Export') + '.xls';
            downloadExcelFile(html, filename);
        }
    </script>
</asp:Content>
