<%@ Page Title="Earning Deduction Details | SFA Portal" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollAllEmpEarnDedDetailNew.aspx.cs" Inherits="mis_Payroll_PayrollAllEmpEarnDedDetailNew" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/bootstrap-multiselect.css" rel="stylesheet" />
    <style>
        @page {
            size: landscape;
            margin: 6mm 5mm;
        }

        .pay-sheet {
            overflow-x: auto;
            width: 100%;
            margin-top: 15px;
        }

        .pay-sheet table {
            width: 100%;
            border-collapse: collapse;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            line-height: 1.25;
            margin-top: 10px;
            background-color: #ffffff;
        }

        .pay-sheet table tr th, .pay-sheet table tr td {
            font-size: 11px;
            border: 1px solid #cbd5e1;
            padding: 4px 6px;
        }

        .pay-sheet table thead tr.tblheadingslip th {
            background-color: #f1f5f9 !important;
            color: #1e293b;
            font-weight: 600;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
            font-size: 10.5px;
            line-height: 1.15;
            padding: 4px 4px;
        }

        /* Employee groups & rows */
        tbody.emp-group {
            page-break-inside: avoid !important;
            break-inside: avoid !important;
        }

        .pay-sheet table tr.emp-info th {
            background-color: #fefce8 !important;
            border-top: 2px solid #64748b !important;
            color: #0f172a;
            font-weight: 600;
            white-space: nowrap;
        }

        .pay-sheet table tr.emp-earn td {
            background-color: #ffffff;
            white-space: nowrap;
        }

        .pay-sheet table tr.emp-ded td {
            background-color: #f8fafc;
            white-space: nowrap;
        }

        .pay-sheet table tr.emp-net td {
            background-color: #f1f5f9;
            border-bottom: 2px solid #94a3b8 !important;
            white-space: nowrap;
        }

        .pay-sheet table tbody tr.emp-earn:hover td,
        .pay-sheet table tbody tr.emp-ded:hover td,
        .pay-sheet table tbody tr.emp-net:hover td {
            background-color: #fef9c3 !important;
        }

        .pay-sheet table td[title]:hover,
        .pay-sheet table th[title]:hover {
            outline: 1px dashed #0284c7;
            cursor: pointer;
        }

        /* Summary styling (at end of report) */
        tbody.summary-group {
            page-break-inside: avoid !important;
            break-inside: avoid !important;
        }

        .pay-sheet table tr.summary-title th {
            background-color: #e0f2fe !important;
            color: #0369a1 !important;
            font-size: 11.5px;
            font-weight: 700;
            text-align: center;
            padding: 5px;
            border-top: 2px solid #0284c7 !important;
        }

        .pay-sheet table tr.summary-earn td {
            background-color: #f0fdf4;
            white-space: nowrap;
        }

        .pay-sheet table tr.summary-ded td {
            background-color: #fef2f2;
            white-space: nowrap;
        }

        .pay-sheet table tr.summary-net td {
            background-color: #e0f2fe;
            border-bottom: 2px solid #0284c7 !important;
            white-space: nowrap;
        }

        .alignright {
            text-align: right !important;
        }

        .text-left {
            text-align: left !important;
        }

        .header_div {
            display: none !important;
        }

        .pay-sheet table thead tr.tbl-title-row th {
            background-color: #ffffff !important;
            border: none !important;
            border-bottom: 1px solid #cbd5e1 !important;
            padding: 4px 2px 6px 2px !important;
        }

        /* =========================================================
           Multiselect Dropdown Styling (Matches PayrollEarDedSummarySection / Image 2)
           ========================================================= */
        .multiselect-native-select {
            position: relative;
            display: block;
            width: 100%;
        }

        .multiselect-native-select .btn-group {
            width: 100% !important;
            position: relative !important;
        }

        /* Native Bootstrap 3 Button style with grey gradient matching Image 2 */
        .multiselect-native-select .multiselect.btn,
        .btn-group .multiselect.btn {
            width: 100% !important;
            text-align: left !important;
            background-color: #f7f7f7 !important;
            background-image: linear-gradient(to bottom, #ffffff 0%, #e6e6e6 100%) !important;
            background-repeat: repeat-x !important;
            border: 1px solid #adadad !important;
            border-radius: 4px !important;
            color: #333333 !important;
            padding: 6px 12px !important;
            font-size: 14px !important;
            height: 36px !important;
            line-height: 1.42857143 !important;
            box-shadow: inset 0 1px 0 rgba(255, 255, 255, .15), 0 1px 1px rgba(0, 0, 0, .075) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            outline: none !important;
        }

        .multiselect-native-select .multiselect.btn:hover,
        .multiselect-native-select .multiselect.btn:focus,
        .btn-group.open .multiselect.btn {
            background-color: #e6e6e6 !important;
            background-image: none !important;
            border-color: #8c8c8c !important;
            color: #333333 !important;
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125) !important;
        }

        .multiselect-native-select .multiselect-selected-text {
            width: 100% !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            white-space: nowrap !important;
            font-weight: 500 !important;
            color: #333333 !important;
        }

        .multiselect-native-select .btn .caret {
            float: right !important;
            vertical-align: middle !important;
            margin-left: 8px !important;
            border-top: 5px solid #333 !important;
            border-right: 4px solid transparent !important;
            border-left: 4px solid transparent !important;
            display: inline-block !important;
        }

        /* Dropdown Menu Container */
        ul.multiselect-container.dropdown-menu {
            position: absolute !important;
            top: 100% !important;
            left: 0 !important;
            width: 100% !important;
            min-width: 160px !important;
            max-height: 200px !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
            background: #ffffff !important;
            border: 1px solid rgba(0, 0, 0, 0.15) !important;
            border-radius: 4px !important;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175) !important;
            padding: 4px 0 !important;
            margin: 2px 0 0 0 !important;
            z-index: 1050 !important;
            display: none;
        }

        .btn-group.open > ul.multiselect-container.dropdown-menu,
        ul.multiselect-container.dropdown-menu.show {
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
        }

        /* Menu items list */
        ul.multiselect-container > li {
            padding: 0 !important;
            margin: 0 !important;
            list-style: none !important;
        }

        ul.multiselect-container > li > a {
            display: block !important;
            padding: 0 !important;
            clear: both !important;
            text-decoration: none !important;
            color: #333333 !important;
            background-color: transparent !important;
        }

        ul.multiselect-container > li > a:hover,
        ul.multiselect-container > li > a:focus {
            background-color: #f1f4f8 !important;
            color: #212529 !important;
        }

        /* Select all row highlight (matching Image 2) */
        ul.multiselect-container > li.multiselect-all > a {
            background-color: #e2e6ea !important;
        }

        ul.multiselect-container > li.multiselect-all > a:hover {
            background-color: #dbe0e5 !important;
        }

        /* Neutralize theme's hijacked checkbox styles and force native visible checkboxes */
        ul.multiselect-container label.checkbox::before,
        ul.multiselect-container label.checkbox::after {
            display: none !important;
            content: none !important;
        }

        ul.multiselect-container label.checkbox {
            display: flex !important;
            align-items: center !important;
            gap: 8px !important;
            margin: 0 !important;
            padding: 5px 12px !important;
            cursor: pointer !important;
            font-weight: 500 !important;
            font-size: 13.5px !important;
            color: #212529 !important;
            width: 100% !important;
            user-select: none !important;
        }

        ul.multiselect-container > li.multiselect-all label.checkbox {
            font-weight: 600 !important;
        }

        ul.multiselect-container label.checkbox input[type="checkbox"] {
            opacity: 1 !important;
            visibility: visible !important;
            position: static !important;
            display: inline-block !important;
            margin: 0 !important;
            cursor: pointer !important;
            width: 15px !important;
            height: 15px !important;
            flex-shrink: 0 !important;
            vertical-align: middle !important;
            box-shadow: none !important;
            border: 1px solid #767676 !important;
            border-radius: 3px !important;
            background-color: #ffffff !important;
            accent-color: #0d6efd !important;
        }

        /* Suppress extraneous multiselect-dropdown widget from master */
        .multiselect-dropdown {
            display: none !important;
        }

        @media print {
            @page {
                size: landscape;
                margin: 5mm;
            }

            body {
                background: #fff;
            }

            .Hiderow, .main-footer, .header_div, .page-header, .sidebar-wrapper, .tap-top, .loader-wrapper {
                display: none !important;
            }

            .box, .content-wrapper, .content, .box-body {
                border: none !important;
                padding: 0 !important;
                margin: 0 !important;
                box-shadow: none !important;
            }

            .pay-sheet {
                overflow: visible !important;
                margin-top: 0 !important;
            }

            .pay-sheet table {
                margin-top: 0 !important;
                width: 100% !important;
            }

            .pay-sheet table tr th, .pay-sheet table tr td {
                font-size: 8px !important;
                padding: 1.5px 2.5px !important;
                line-height: 1.1 !important;
                border: 1px solid #475569 !important;
            }

            .pay-sheet table thead {
                display: table-header-group !important;
            }

            .pay-sheet table thead tr.tbl-title-row th {
                background-color: #ffffff !important;
                border: none !important;
                padding: 2px 0 4px 0 !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .pay-sheet table thead tr.tblheadingslip th {
                font-size: 7.5px !important;
                padding: 1.5px 2px !important;
                line-height: 1.05 !important;
                background-color: #f1f5f9 !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            tbody.emp-group {
                page-break-inside: avoid !important;
                break-inside: avoid !important;
            }

            tbody.summary-group {
                page-break-inside: avoid !important;
                break-inside: avoid !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div class="box box-success">
                <div class="box-header with-border Hiderow">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-sm-12">
                            <h3 class="box-title" style="font-weight: 600; color: #242934;">
                                <i class="fa fa-file-text-o text-success me-2"></i>Earning Deduction Details (Pay Sheet)
                            </h3>
                        </div>
                        <div class="col-md-6 col-sm-12 text-md-end mt-2 mt-md-0">
                            <asp:RadioButtonList ID="rbnlist" runat="server" RepeatDirection="Horizontal" CssClass="d-inline-block">
                                <asp:ListItem Text="&nbsp;Regular&nbsp;&nbsp;&nbsp;&nbsp;" Selected="True" Value="Generated"></asp:ListItem>
                                <asp:ListItem Text="&nbsp;Supplementry" Value="Supplementry Generated"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>

                <div class="box-body">
                    <div class="row Hiderow">
                        <div class="col-md-12">
                            <div class="form-group mb-2">
                                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Office Name <span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlOffice_SelectedIndexChanged" ID="ddlOffice" CssClass="form-control" ClientIDMode="Static">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Year <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlFinancialYear" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Month <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Select Month</asp:ListItem>
                                    <asp:ListItem Value="1">January</asp:ListItem>
                                    <asp:ListItem Value="2">February</asp:ListItem>
                                    <asp:ListItem Value="3">March</asp:ListItem>
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">June</asp:ListItem>
                                    <asp:ListItem Value="7">July</asp:ListItem>
                                    <asp:ListItem Value="8">August</asp:ListItem>
                                    <asp:ListItem Value="9">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Type of Post (पद प्रकार) <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlEmp_TypeOfPost" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                    <asp:ListItem Value="Permanent">Regular/Permanent</asp:ListItem>
                                    <asp:ListItem Value="Fixed Employee">Fixed Employee(स्थाई कर्मी)</asp:ListItem>
                                    <asp:ListItem Value="Contigent Employee">Contigent Employee</asp:ListItem>
                                    <asp:ListItem Value="Samvida Employee">Samvida Employee</asp:ListItem>
                                    <asp:ListItem Value="Theka Shramik">Theka Shramik</asp:ListItem>
                                    <asp:ListItem Value="Outsource Employee">Outsource Employee</asp:ListItem>
                                    <asp:ListItem Value="Other Employee">Other Employee</asp:ListItem>
                                    <asp:ListItem Value="Deputation Employee">Deputation Employee</asp:ListItem>
                                    <asp:ListItem Value="Contractual Employee">Contractual Employee</asp:ListItem>
                                    <asp:ListItem Value="Daily Wages Employee">Daily Wages Employee</asp:ListItem>
                                    <asp:ListItem Value="Daily Wages Federation">Daily Wages Federation</asp:ListItem>
                                    <asp:ListItem Value="Job Rate Employee">Job Rate Employee</asp:ListItem>
                                    <asp:ListItem Value="Permanent NPF">Regular/Permanent NPF</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Section No <span class="text-danger">*</span></label>
                                <asp:ListBox runat="server" ID="ddlSection" ClientIDMode="Static" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                            </div>
                        </div>
                    </div>

                    <div class="row Hiderow mt-2">
                        <div class="col-md-2 col-sm-6 mb-2">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block w-100" Text="Search" ID="btnShow" OnClick="btnShow_Click" OnClientClick="return validateform();" />
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6 mb-2">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-primary btn-block w-100" Text="Print" ID="btnPrint" OnClientClick="return PrintPage();" />
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6 mb-2">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-info btn-block w-100 text-white" Text="Export Excel" ID="btnExcel" OnClick="btnExcel_Click" />
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6 mb-2">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-default btn-block w-100" Text="Clear" ID="btnClear" OnClick="btnClear_Click" />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div runat="server" id="DivHead" class="header_div" style="text-align: center;">
                                <h4 style="font-weight: 700;">
                                    <asp:Label ID="lblOffice" runat="server" Text=""></asp:Label>
                                </h4>
                                <h5 style="text-decoration: underline dotted;">Pay Sheet For the Month of
                                    <asp:Label ID="lblSession" runat="server" Text=""></asp:Label>
                                    (
                                    <asp:Label ID="lblPosttype" runat="server" Text=""></asp:Label>
                                    )</h5>
                            </div>
                            <div id="DivDetail" class="pay-sheet" runat="server">
                            </div>

                            <div id="Div1" class="footer_div" runat="server">
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script src="../js/bootstrap-multiselect.js" type="text/javascript"></script>
    <script type="text/javascript">
        // Override conflicting multiselect-dropdown.js from MainMaster
        window.MultiselectDropdown = function () { };

        function initSectionMultiSelect() {
            var $sec = $('[id*=ddlSection]');
            if ($sec.length) {
                // Remove unwanted injected div from multiselect-dropdown.js if present
                $sec.siblings('.multiselect-dropdown').remove();

                try {
                    $sec.multiselect('destroy');
                } catch (e) { }

                $sec.multiselect({
                    includeSelectAllOption: true,
                    buttonWidth: '100%',
                    maxHeight: 200
                });

                // Tag parent container
                $sec.closest('.btn-group').addClass('show-multiselect');
            }
        }

        $(document).ready(function () {
            window.MultiselectDropdown = function () { };
            initSectionMultiSelect();

            // Explicit Bootstrap 5 click toggle handling
            $(document).off('click', '.btn-group:has(.multiselect) .dropdown-toggle').on('click', '.btn-group:has(.multiselect) .dropdown-toggle', function (e) {
                e.preventDefault();
                e.stopPropagation();
                var $group = $(this).closest('.btn-group');
                var $menu = $group.find('.multiselect-container');
                var wasOpen = $group.hasClass('open') || $menu.hasClass('show');

                $('.btn-group:has(.multiselect)').removeClass('open');
                $('.multiselect-container').removeClass('show').hide();

                if (!wasOpen) {
                    $group.addClass('open');
                    $menu.addClass('show').show();
                }
            });

            // Close when clicking anywhere outside
            $(document).on('click', function (e) {
                if (!$(e.target).closest('.btn-group:has(.multiselect)').length) {
                    $('.btn-group:has(.multiselect)').removeClass('open');
                    $('.multiselect-container').removeClass('show').hide();
                }
            });

            // Prevent closing when interacting inside the dropdown
            $(document).on('click', '.multiselect-container', function (e) {
                e.stopPropagation();
            });
        });

        // Ensure initialization after all window resources load
        $(window).on('load', function () {
            window.MultiselectDropdown = function () { };
            $('[id*=ddlSection]').siblings('.multiselect-dropdown').remove();
            initSectionMultiSelect();
        });

        // Form Validation
        function validateform() {
            var msg = "";
            var ddlOffice = document.getElementById('<%=ddlOffice.ClientID%>');
            if (ddlOffice && !ddlOffice.disabled && ddlOffice.selectedIndex === 0) {
                msg = msg + "Select Office. \n";
            }
            if (document.getElementById('<%=ddlFinancialYear.ClientID%>').selectedIndex === 0) {
                msg = msg + "Select Year. \n";
            }
            if (document.getElementById('<%=ddlMonth.ClientID%>').selectedIndex === 0) {
                msg = msg + "Select Month. \n";
            }
            if (document.getElementById('<%=ddlEmp_TypeOfPost.ClientID%>').selectedIndex === 0) {
                msg = msg + "Select Type of Post. \n";
            }
            if ($('[id*=ddlSection] option:selected').length === 0) {
                msg = msg + "Select Section No. \n";
            }
            if (msg !== "") {
                alert(msg);
                return false;
            }
            return true;
        }

        // Print handler
        function PrintPage() {
            var detailElem = document.getElementById('<%=DivDetail.ClientID%>');
            if (!detailElem || detailElem.innerHTML.trim() === "") {
                alert("No record to print. Please click Search first.");
                return false;
            }
            window.print();
            return false;
        }
    </script>
</asp:Content>
