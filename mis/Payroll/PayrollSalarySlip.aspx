<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollSalarySlip.aspx.cs" Inherits="mis_Payroll_PayrollSalarySlip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="../css/salarySleep.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="content-wrapper">
        <!-- Filter Section -->
        <section class="content printhide" style="min-height: 80px; padding-bottom: 0px;">
            <div class="filter-card">
                <div class="filter-card-header">
                    <i class="fa fa-sliders"></i> Employee Salary Slip Search
                </div>
                <div class="filter-card-body">
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <div class="row">
                        <div class="col-md-3 col-sm-4">
                            <div class="form-group">
                                <label>Year <span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-4">
                            <div class="form-group">
                                <label>Month <span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Select Month</asp:ListItem>
                                    <asp:ListItem Value="01">January</asp:ListItem>
                                    <asp:ListItem Value="02">February</asp:ListItem>
                                    <asp:ListItem Value="03">March</asp:ListItem>
                                    <asp:ListItem Value="04">April</asp:ListItem>
                                    <asp:ListItem Value="05">May</asp:ListItem>
                                    <asp:ListItem Value="06">June</asp:ListItem>
                                    <asp:ListItem Value="07">July</asp:ListItem>
                                    <asp:ListItem Value="08">August</asp:ListItem>
                                    <asp:ListItem Value="09">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-4">
                            <div class="form-group">
                                <asp:Button ID="btnSearch" CssClass="btn btn-block btn-modern-search" runat="server" Text="Search" OnClick="btnSearch_Click" OnClientClick="return validateform();" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="lblNotGenerated" Style="font-size: 15px; font-weight: 600; color: #dc2626; display: block; margin-top: 10px;" runat="server" Text="Salary Not Generated"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Salary Slip Section -->
        <section class="content" id="DivSlip" runat="server" style="padding-top: 0px;">
            <div class="section-to-print">
                <div class="slip-outer-container">
                    <div class="salary-slip-card">
                        <!-- Header Row -->
                        <div class="slip-header-row">
                            <!-- Company Logo & Name -->
                            <div class="company-brand">
                                <img src="../image/Sfa_logo.png" class="company-logo" alt="SFA Technologies" />
                                <div class="company-brand-text">
                                    <h1 runat="server" id="HOfficeName"></h1>
                                    <%--<p>Innovating for a Better Tomorrow</p>--%>
                                </div>
                            </div>

                            <!-- Title Center -->
                            <div class="slip-header-center">
                                <h2>Salary Slip</h2>
                                <%--<p>Confidential | For Employee Use Only</p>--%>
                            </div>

                            <!-- Pay Month Right Badge -->
                            <div class="pay-month-badge">
                                <svg class="calendar-icon" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 22px; height: 22px; min-width: 22px; stroke: #ffffff !important; color: #ffffff !important;">
                                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                    <line x1="16" y1="2" x2="16" y2="6"></line>
                                    <line x1="8" y1="2" x2="8" y2="6"></line>
                                    <line x1="3" y1="10" x2="21" y2="10"></line>
                                    <path d="M9 16l2 2 4-4"></path>
                                </svg>
                                <div class="month-details">
                                    <span class="month-lbl">Pay Month</span>
                                    <span class="month-val">
                                        <span id="lblMonth" runat="server"></span>&nbsp;<span id="lblFinancialYear" runat="server"></span>
                                        <span id="lblGenStatus" runat="server" style="color: #fca5a5; font-size: 11px;"></span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Employee Details Box -->
                        <div class="employee-details-box">
                            <!-- Left Column -->
                            <div class="emp-col">
                                <div class="emp-col-icon">
                                    <i class="fa fa-user"></i>
                                </div>
                                <table class="emp-info-table">
                                    <tr>
                                        <td class="info-label">Employee Name</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblEmp_Name" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Employee ID</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Designation</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblDesignation_Name" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Department</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">Information Technology</td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Date of Joining</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val"><asp:Label ID="lblJoiningDate" runat="server" Text=""></asp:Label></td>
                                    </tr>
                                </table>
                            </div>

                            <div class="emp-col-divider"></div>

                            <!-- Right Column -->
                            <div class="emp-col">
                                <div class="emp-col-icon">
                                    <i class="fa fa-university"></i>
                                </div>
                                <table class="emp-info-table">
                                    <tr>
                                        <td class="info-label">Bank Name</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblBank_Name" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Account Number</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblBank_AccountNo" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">IFSC Code</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblIFSCCode" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">UAN / EPF Number</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblEPF_No" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                   <%-- <tr>
                                        <td class="info-label">Group Ins. Number</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">
                                            <asp:Label ID="lblGroupInsurance_No" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td class="info-label">Work Location</td>
                                        <td class="info-colon">:</td>
                                        <td class="info-val">Bhopal, Madhya Pradesh</td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <!-- Earnings & Deductions Tables -->
                        <div class="tables-split-row">
                            <!-- Earnings Table Card -->
                            <div class="table-card">
                                <div class="table-card-header header-earnings">
                                    EARNINGS
                                </div>
                                <table class="slip-table earning-table">
                                    <thead class="thead-earnings">
                                        <tr>
                                            <th>Description</th>
                                            <th style="text-align: right; width: 110px;">Amount (&#8377;)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Basic Salary</td>
                                            <td class="amount-cell">
                                                <asp:Label ID="lblSalary_Basic" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="RepeaterEarning" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("EarnDeduction_Name").ToString()%>'></asp:Label>
                                                    </td>
                                                    <td class="amount-cell">
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Earning").ToString()%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                    <tfoot class="tfoot-earnings">
                                        <tr>
                                            <td>Total Earnings (A)</td>
                                            <td class="amount-cell">
                                                <asp:Label ID="lblSalary_EarningTotal" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <!-- Deductions Table Card -->
                            <div class="table-card">
                                <div class="table-card-header header-deductions">
                                    DEDUCTIONS
                                </div>
                                <table class="slip-table deduction-table">
                                    <thead class="thead-deductions">
                                        <tr>
                                            <th>Description</th>
                                            <th style="text-align: right; width: 110px;">Amount (&#8377;)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="hidden">
                                            <td>Salary Deduction (Absent Days)</td>
                                            <td class="amount-cell">
                                                <asp:Label ID="lblSalary_NoDayDeduAmt" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="RepeaterDeduction" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("EarnDeduction_Name").ToString()%>'></asp:Label>
                                                    </td>
                                                    <td class="amount-cell">
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Earning").ToString()%>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <%--<tr>
                                            <td>LIC Premium</td>
                                            <td class="amount-cell">
                                                <asp:Label ID="lblPolicyDeduction" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>--%>
                                    </tbody>
                                    <tfoot class="tfoot-deductions">
                                        <tr>
                                            <td>Total Deductions (B)</td>
                                            <td class="amount-cell">
                                                <asp:Label ID="lblSalary_DeductionTotal" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>

                        <!-- Net Payable Banner -->
                        <div class="net-payable-row">
                            <div class="net-payable-left">
                                <div class="net-icon-circle">
                                    <i class="fa fa-database"></i>
                                </div>
                                <div class="net-title-text">
                                    <h3>Net Payable (A - B)</h3>
                                    <p>(Amount in Words: <span id="lblAmountInWords" style="font-weight: 600; color: #0b3b60;">Calculating...</span>)</p>
                                </div>
                            </div>
                            <div class="net-payable-badge">
                                &#8377;&nbsp;<asp:Label ID="lblSalary_NetSalary" runat="server" Text="0.00"></asp:Label>
                            </div>
                        </div>

                        <!-- 4 Stat Metrics Strip -->
                        <div class="stats-metrics-strip">
                            <div class="stat-card-item">
                                <i class="fa fa-calendar-check-o stat-icon"></i>
                                <div class="stat-info">
                                    <div class="stat-lbl">Paid Days</div>
                                    <div class="stat-val"><span id="TotalDayOfMonth" runat="server">0</span></div>

                                </div>
                            </div>
                            <div class="stat-card-item">
                                <i class="fa fa-calendar-times-o stat-icon"></i>
                                <div class="stat-info">
                                    <div class="stat-lbl">Absent Days</div>
                                    <div class="stat-val"><span id="NotPayableDays" runat="server">0</span></div>
                                </div>
                            </div>
                            <div class="stat-card-item">
                                <i class="fa fa-calendar stat-icon"></i>
                                <div class="stat-info">
                                    <div class="stat-lbl">Working Days</div>
                                    <div class="stat-val"><span id="PayableDays" runat="server">0</span></div>

                                </div>
                            </div>
                            <div class="stat-card-item">
                                <i class="fa fa-inr stat-icon" style="border: 2px solid #203969; border-radius: 50%; width: 28px; height: 28px; font-size: 16px; display: inline-flex; align-items: center; justify-content: center;"></i>
                                <div class="stat-info">
                                    <div class="stat-lbl">Payment Mode</div>
                                    <div class="stat-val" style="font-size: 14px;">Bank Transfer</div>
                                </div>
                            </div>
                        </div>

                        <!-- Footer Notes -->
                        <div class="slip-footer-row">
                            <div class="footer-notes">
                                <strong>Note:</strong> This is a computer generated salary slip and does not require a signature.
                            </div>
                        </div>
                    </div>

                    <!-- Print Button (Hidden on Print) -->
                    <div class="print-btn-bar printhide">
                        <button type="button" class="btn-print-slip" onclick="updateAmountWords(); window.print();">
                            <i class="fa fa-print"></i> Print Salary Slip
                        </button>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        function validateform() {
            var msg = "";

            if (document.getElementById('<%=ddlYear.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Financial Year. \n";
            }
            if (document.getElementById('<%=ddlMonth.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Month. \n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                return true;
            }
        }

        // Amount in Words Converter
        function numberToWords(amount) {
            var words = new Array();
            words[0] = '';
            words[1] = 'One';
            words[2] = 'Two';
            words[3] = 'Three';
            words[4] = 'Four';
            words[5] = 'Five';
            words[6] = 'Six';
            words[7] = 'Seven';
            words[8] = 'Eight';
            words[9] = 'Nine';
            words[10] = 'Ten';
            words[11] = 'Eleven';
            words[12] = 'Twelve';
            words[13] = 'Thirteen';
            words[14] = 'Fourteen';
            words[15] = 'Fifteen';
            words[16] = 'Sixteen';
            words[17] = 'Seventeen';
            words[18] = 'Eighteen';
            words[19] = 'Nineteen';
            words[20] = 'Twenty';
            words[30] = 'Thirty';
            words[40] = 'Forty';
            words[50] = 'Fifty';
            words[60] = 'Sixty';
            words[70] = 'Seventy';
            words[80] = 'Eighty';
            words[90] = 'Ninety';

            amount = amount.toString().replace(/,/g, '').trim();
            var atemp = amount.split(".");
            var number = parseInt(atemp[0]);
            if (isNaN(number) || number === 0) return "Zero Rupees Only";

            var n_length = number.toString().length;
            var words_string = "";
            if (n_length <= 9) {
                var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
                var received_n_array = new Array();
                for (var i = 0; i < n_length; i++) {
                    received_n_array[i] = number.toString().substr(i, 1);
                }
                for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
                    n_array[i] = received_n_array[j];
                }
                for (var i = 0, j = 1; i < 9; i++, j++) {
                    if (i == 0 || i == 2 || i == 4 || i == 7) {
                        if (n_array[i] == 1) {
                            n_array[j] = 10 + parseInt(n_array[j]);
                            n_array[i] = 0;
                        }
                    }
                }
                var val = 0;
                for (var i = 0; i < 9; i++) {
                    if (i == 0 || i == 2 || i == 4 || i == 7) {
                        val = n_array[i] * 10;
                    } else {
                        val = n_array[i];
                    }
                    if (val != 0) {
                        words_string += words[val] + " ";
                    }
                    if ((i == 1 && val != 0) || (i == 0 && val != 0 && n_array[i + 1] == 0)) {
                        words_string += "Crores ";
                    }
                    if ((i == 3 && val != 0) || (i == 2 && val != 0 && n_array[i + 1] == 0)) {
                        words_string += "Lakhs ";
                    }
                    if ((i == 5 && val != 0) || (i == 4 && val != 0 && n_array[i + 1] == 0)) {
                        words_string += "Thousand ";
                    }
                    if (i == 6 && val != 0 && (n_array[i + 1] != 0 || n_array[i + 2] != 0)) {
                        words_string += "Hundred and ";
                    } else if (i == 6 && val != 0) {
                        words_string += "Hundred ";
                    }
                }
                words_string = words_string.split("  ").join(" ");
            }
            return words_string.trim() + " Rupees Only";
        }

        // On Load Trigger
        function updateAmountWords() {
            var netElem = document.getElementById('<%=lblSalary_NetSalary.ClientID%>');
            var wordsElem = document.getElementById('lblAmountInWords');
            if (netElem && wordsElem) {
                var txt = netElem.innerText || netElem.textContent || "0";
                wordsElem.innerText = numberToWords(txt);
            }
        }

        if (document.readyState === 'complete' || document.readyState === 'interactive') {
            updateAmountWords();
        } else {
            document.addEventListener('DOMContentLoaded', updateAmountWords);
        }
        window.addEventListener('beforeprint', updateAmountWords);
    </script>
</asp:Content>
