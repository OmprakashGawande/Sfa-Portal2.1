<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollEarnDeductionDetailFullNew.aspx.cs" Inherits="mis_Payroll_PayrollEarnDeductionDetailFullNew" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <style>
        /* =========================================================
           Payroll Earn Deduction Detail Full - Enterprise Matrix Styling
           Matches Old Portal Dashboard (Attractive & Pixel-Aligned)
           ========================================================= */

        /* Outer Box / Card */
        .box.box-success {
            border: 1px solid #e2e8f0 !important;
            border-top: 3px solid #00a65a !important;
            border-radius: 4px !important;
            background: #ffffff !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06) !important;
            margin-bottom: 25px !important;
        }

        .box.box-success > .box-header {
            padding: 12px 18px !important;
            border-bottom: 1px solid #f1f5f9 !important;
            background-color: #ffffff !important;
        }

        .box.box-success > .box-header .box-title {
            font-size: 16px !important;
            font-weight: 700 !important;
            color: #1e293b !important;
            margin: 0 !important;
            letter-spacing: -0.2px !important;
        }

        /* Filter Controls */
        .filter-section label {
            font-size: 12.5px !important;
            font-weight: 600 !important;
            color: #334155 !important;
            margin-bottom: 4px !important;
            display: block !important;
        }

        .filter-section .form-control,
        .filter-section select {
            height: 36px !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 4px !important;
            font-size: 13px !important;
            color: #1e293b !important;
            box-shadow: none !important;
        }

        .filter-section .select2-container .select2-selection--single {
            height: 36px !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 4px !important;
        }

        .filter-section .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 24px !important;
            font-size: 13px !important;
            color: #1e293b !important;
            padding-left: 5px !important;
        }

        .filter-section .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 34px !important;
            right: 8px !important;
        }

        /* Search Button */
        #btnSearch {
            background-color: #00a65a !important;
            background-image: linear-gradient(to bottom, #00a65a 0%, #008d4c 100%) !important;
            border: 1px solid #008d4c !important;
            color: #ffffff !important;
            font-weight: 700 !important;
            font-size: 13.5px !important;
            height: 36px !important;
            line-height: 20px !important;
            border-radius: 4px !important;
            margin-top: 23px !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12) !important;
            cursor: pointer !important;
            transition: all 0.15s ease-in-out !important;
        }

        #btnSearch:hover {
            background-color: #008d4c !important;
            background-image: none !important;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2) !important;
        }

        /* Employee Info Summary Grid (Bank, EPF, etc.) */
        table.basic_detail {
            width: 100% !important;
            border-collapse: separate !important;
            border-spacing: 0 !important;
            border: 1px solid #e2e8f0 !important;
            border-radius: 4px !important;
            background: #ffffff !important;
            margin-bottom: 12px !important;
        }

        table.basic_detail tr th {
            font-size: 11px !important;
            font-weight: 700 !important;
            color: #1e293b !important;
            text-transform: uppercase !important;
            padding: 6px 10px !important;
            background: #f8fafc !important;
            border: none !important;
            border-bottom: 1px solid #f1f5f9 !important;
            white-space: nowrap !important;
            vertical-align: middle !important;
            width: 13% !important;
        }

        table.basic_detail tr td {
            padding: 5px 10px !important;
            background: #ffffff !important;
            border: none !important;
            border-bottom: 1px solid #f1f5f9 !important;
            vertical-align: middle !important;
            width: 20% !important;
        }

        table.basic_detail td span,
        table.basic_detail td .form-control {
            display: block !important;
            background: #ffffff !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 3px !important;
            padding: 3px 8px !important;
            font-size: 12px !important;
            font-weight: 600 !important;
            color: #0f172a !important;
            min-height: 26px !important;
            line-height: 20px !important;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.04) !important;
        }

        /* Hindi Instructions Card */
        .payroll-notice-card {
            background-color: #ffffff !important;
            border: 1px solid #e2e8f0 !important;
            border-left: 3px solid #00a65a !important;
            border-radius: 4px !important;
            padding: 10px 16px !important;
            margin-bottom: 16px !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04) !important;
        }

        .payroll-notice-card .notice-item {
            font-size: 12px !important;
            color: #334155 !important;
            line-height: 1.7 !important;
            font-weight: 500 !important;
        }

        .payroll-notice-card .notice-arrow {
            color: #475569 !important;
            font-weight: 700 !important;
            margin-right: 4px !important;
        }

        .payroll-notice-card .datafocus {
            color: #1d4ed8 !important;
            font-size: 12.5px !important;
            font-weight: 700 !important;
        }

        /* Earning & Deduction Sub-Headers */
        .section-sub-header {
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
            padding: 8px 12px !important;
            background-color: #f8fafc !important;
            border: 1px solid #cbd5e1 !important;
            border-bottom: none !important;
            border-top-left-radius: 4px !important;
            border-top-right-radius: 4px !important;
            margin-top: 14px !important;
        }

        .section-sub-header h3.box-title {
            font-size: 14.5px !important;
            font-weight: 700 !important;
            color: #1e293b !important;
            margin: 0 !important;
        }

        .section-sub-header .btn-box-tool {
            background-color: transparent !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 3px !important;
            color: #64748b !important;
            padding: 2px 8px !important;
            cursor: pointer !important;
            font-size: 12px !important;
            transition: all 0.15s ease-in-out !important;
        }

        .section-sub-header .btn-box-tool:hover {
            background-color: #e2e8f0 !important;
            color: #1e293b !important;
        }

        /* Responsive Matrix Wrapper */
        .matrix-wrapper {
            overflow-x: auto !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 0 0 4px 4px !important;
            margin-bottom: 14px !important;
            background: #ffffff !important;
        }

        /* Core Table / Grid Styling */
        table.Grid {
            width: 100% !important;
            min-width: 1180px !important;
            table-layout: fixed !important;
            border-collapse: collapse !important;
            border-spacing: 0 !important;
            margin: 0 !important;
        }

        /* Table Header */
        table.Grid thead th,
        table.Grid tr th {
            background-color: #eaecf0 !important;
            background-image: linear-gradient(to bottom, #f8f9fa 0%, #eaecf0 100%) !important;
            color: #1e293b !important;
            font-weight: 700 !important;
            font-size: 12px !important;
            padding: 6px 4px !important;
            border: 1px solid #cbd5e1 !important;
            text-align: center !important;
            vertical-align: middle !important;
            white-space: nowrap !important;
        }

        /* Data Rows */
        table.Grid tbody tr td {
            padding: 2px !important;
            border: 1px solid #cbd5e1 !important;
            vertical-align: middle !important;
            height: 28px !important;
            background-color: #ffffff;
        }

        table.Grid tbody tr:hover td {
            background-color: #f8fafc;
        }

        /* Column 1: SNo */
        table.main-matrix-grid th:first-child,
        table.main-matrix-grid td:first-child {
            width: 40px !important;
            max-width: 40px !important;
            min-width: 40px !important;
            text-align: center !important;
            font-weight: 600 !important;
            font-size: 12px !important;
            color: #475569 !important;
        }

        /* Column 2: Name (Fully visible without ellipsis or truncation) */
        table.main-matrix-grid th.ss,
        table.main-matrix-grid td.ss,
        table.main-matrix-grid td:nth-child(2) {
            width: 360px !important;
            min-width: 360px !important;
            max-width: 380px !important;
            text-align: left !important;
            font-weight: 600 !important;
            font-size: 11px !important;
            color: #1e293b !important;
            text-transform: uppercase !important;
            padding-left: 8px !important;
            padding-right: 6px !important;
            white-space: nowrap !important;
            overflow: visible !important;
            text-overflow: clip !important;
        }

        /* Subtotal Tables (Basic, Gross, Deduction Total) First Column (Aligns with SNo + Name = 40px + 360px = 400px) */
        table.subtotal-grid th:first-child,
        table.subtotal-grid td:first-child {
            width: 400px !important;
            min-width: 400px !important;
            max-width: 400px !important;
            text-align: right !important;
            font-weight: 700 !important;
            font-size: 12px !important;
            color: #1e293b !important;
            padding-right: 12px !important;
            background-color: #f8fafc !important;
            border: 1px solid #cbd5e1 !important;
            white-space: nowrap !important;
        }

        /* Month Columns in Both Main Grid and Subtotal Grid (Equal Width) */
        table.main-matrix-grid th:not(:first-child):not(.ss),
        table.main-matrix-grid td:not(:first-child):not(.ss):not(:nth-child(2)),
        table.subtotal-grid th:not(:first-child),
        table.subtotal-grid td:not(:first-child) {
            width: calc((100% - 400px) / 12) !important;
            min-width: 60px !important;
            text-align: center !important;
        }

        /* Input Textboxes inside cells */
        table.Grid td input.form-control,
        table.Grid input.form-control {
            display: block !important;
            width: 100% !important;
            height: 25px !important;
            min-height: 25px !important;
            max-height: 25px !important;
            padding: 2px 4px !important;
            margin: 0 !important;
            text-align: right !important;
            font-size: 12px !important;
            font-weight: 700 !important;
            line-height: 20px !important;
            border: 1px solid #d1d5db !important;
            border-radius: 2px !important;
            box-shadow: none !important;
            box-sizing: border-box !important;
        }

        /* Active / Editable inputs */
        table.Grid td input.form-control:not(:disabled):not([disabled]) {
            background-color: #ffffff !important;
            color: #334155 !important;
        }

        table.Grid td input.form-control:not(:disabled):not([disabled]):focus {
            border-color: #2563eb !important;
            box-shadow: inset 0 0 0 1px #2563eb !important;
            outline: none !important;
            background-color: #f8faff !important;
        }

        /* Disabled inputs - Exact DarkSeaGreen tint (#8fbc8f94) matching user screenshot */
        table.Grid td input.form-control:disabled,
        table.Grid td input.form-control[disabled],
        .form-control[disabled],
        .form-control:disabled {
            background-color: #8fbc8f94 !important;
            border-color: #9cb89c !important;
            cursor: default !important;
            opacity: 1 !important;
        }

        /* View Button in Policy row */
        table.Grid td a.label-info,
        a.label-info,
        .label.label-info {
            display: inline-block !important;
            background-color: #00c0ef !important;
            background-image: linear-gradient(to bottom, #00c0ef 0%, #00acd6 100%) !important;
            border: 1px solid #0097bc !important;
            color: #ffffff !important;
            font-size: 11px !important;
            font-weight: 700 !important;
            padding: 2px 9px !important;
            border-radius: 3px !important;
            text-decoration: none !important;
            margin-top: 3px !important;
            margin-bottom: 2px !important;
            line-height: 14px !important;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.15) !important;
            cursor: pointer !important;
            text-align: center !important;
        }

        table.Grid td a.label-info:hover,
        a.label-info:hover,
        .label.label-info:hover {
            background-color: #00acd6 !important;
            background-image: none !important;
            color: #ffffff !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.25) !important;
        }

        /* Save Button */
        #btnSave {
            background-color: #00a65a !important;
            background-image: linear-gradient(to bottom, #00a65a 0%, #008d4c 100%) !important;
            border: 1px solid #008d4c !important;
            color: #ffffff !important;
            font-weight: 700 !important;
            font-size: 14px !important;
            height: 36px !important;
            line-height: 20px !important;
            border-radius: 4px !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12) !important;
            cursor: pointer !important;
            transition: all 0.15s ease-in-out !important;
            width: 100% !important;
            margin-top: 10px !important;
        }

        #btnSave:hover {
            background-color: #008d4c !important;
            background-image: none !important;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.18) !important;
        }

        /* Policy Detail Modal Styling */
        #ModalPolicyDetail .modal-content {
            border-radius: 6px !important;
            border: 1px solid #cbd5e1 !important;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2) !important;
        }

        #ModalPolicyDetail .modal-header {
            background-color: #f8fafc !important;
            border-bottom: 1px solid #e2e8f0 !important;
            padding: 12px 16px !important;
            border-top-left-radius: 6px !important;
            border-top-right-radius: 6px !important;
        }

        #ModalPolicyDetail .modal-title {
            font-weight: 700 !important;
            color: #1e293b !important;
            font-size: 15px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="content-wrapper">

        <!-- Main content -->
        <section class="content">
            <!-- Default box -->
            <div class="box box-success">
                <div class="box-header">
                    <h3 class="box-title">Earning & Deduction Detail</h3>
                </div>
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="box-body">
                    <div class="row filter-section">

                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Office Name<span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlOfficeName" runat="server" class="form-control select2" AutoPostBack="True" OnSelectedIndexChanged="ddlOfficeName_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Employee<span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlEmployee" runat="server" class="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Year<span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <asp:Button ID="btnSearch" CssClass="btn btn-block btn-success" Style="margin-top: 23px;" runat="server" Text="Search" OnClick="btnSearch_Click" OnClientClick="return validateform1();" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group"></div>
                    <div class="row" runat="server" id="divDetail">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="box-body">
                                    <div class="table-responsive">
                                        <table class="table basic_detail">
                                            <tbody>
                                                <tr>
                                                    <th>BANK ACCOUNT NUMBER :</th>
                                                    <td>
                                                        <asp:Label ID="lblBank_AccountNo" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <th>EPF NUMBER :</th>
                                                    <td>
                                                        <asp:Label ID="lblEPF_No" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <th>G.Ins NUMBER :</th>
                                                    <td>
                                                        <asp:Label ID="lblGroupInsurance_No" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>BANK NAME :</th>
                                                    <td>
                                                        <asp:Label ID="lblBank_Name" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <th>IFSC CODE :</th>
                                                    <td>
                                                        <asp:Label ID="lblIFSCCode" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <th>BASIC SALARY :</th>
                                                    <td>
                                                        <asp:Label ID="lblSalary_NetSalary" runat="server" Text="" CssClass="basic_salary"></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <div class="payroll-notice-card">
                                            <div class="notice-item"><span class="notice-arrow">&rarr;</span> कृपया पहले यह सुनिश्चित करें की अटेंडेंस सेट की जा चुकी है |</div>
                                            <div class="notice-item"><span class="notice-arrow">&rarr;</span> अप्रैल के अनुसार बेसिक वेतन बनेगा और उसके अनुसार Permanent कर्मचारी का DA <asp:Label ID="lblPermanent_DARate" CssClass="datafocus" runat="server" Text=""></asp:Label>% एवं स्थाई कर्मी का DA <asp:Label ID="lblFixed_DARate" CssClass="datafocus" runat="server" Text=""></asp:Label>% स्वतः ही आयेगा |</div>
                                            <div class="notice-item"><span class="notice-arrow">&rarr;</span> इसी प्रकार से EPF = BASIC+DA का 12% स्वतः ही आ जाएगा |</div>
                                            <div class="notice-item"><span class="notice-arrow">&rarr;</span> प्रोफेशनल TAX 250 250 10 महीने तक स्वतः ही आयेगा |</div>
                                            <div class="notice-item"><span class="notice-arrow">&rarr;</span> कुछ भी परिवर्तन करने के पश्चात या अटेंडेंस सेट करने के पश्चात , कृपया Save बटन में क्लिक करके इसे सुरक्षित करें |</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header section-sub-header" runat="server" id="HeaderEarning">
                                    <h3 class="box-title">Earning Detail</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool togglebody"><i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="matrix-wrapper">
                                        <asp:GridView ID="GridView1" runat="server" ClientIDMode="Static" class="table table-bordered table-striped Grid main-matrix-grid" AutoGenerateColumns="False" AllowPaging="false" DataKeyNames="ID_1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="10">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("ID_1").ToString()%>' runat="server" />
                                                    <asp:Label ID="lblRowNumber_2" Visible="false" ToolTip='<%# Eval("ID_2").ToString()%>' runat="server" />
                                                    <asp:Label ID="lblEarnDeduction_ID" Text='<%# Eval("EarnDeduction_ID").ToString()%>' runat="server" Visible="false" />
                                                    <asp:Label ID="lblCalculation_Type" Text='<%# Eval("Calculation_Type").ToString()%>' runat="server" Visible="false" />

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="EarnDeduction_Name" HeaderText="Name" HeaderStyle-CssClass="ss" />

                                            <asp:TemplateField HeaderText="Apr" ItemStyle-Width="73" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtApr_Amount" runat="server" Text='<%# Eval("Apr_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="May" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMay_Amount" runat="server" Text='<%# Eval("May_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jun" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJun_Amount" runat="server" Text='<%# Eval("Jun_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jul" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJul_Amount" runat="server" Text='<%# Eval("Jul_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Aug" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAug_Amount" runat="server" Text='<%# Eval("Aug_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sep" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSep_Amount" runat="server" Text='<%# Eval("Sep_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Oct" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOct_Amount" runat="server" Text='<%# Eval("Oct_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nov" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtNov_Amount" runat="server" Text='<%# Eval("Nov_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dec" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDec_Amount" runat="server" Text='<%# Eval("Dec_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jan" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJan_Amount" runat="server" Text='<%# Eval("Jan_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Feb" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFeb_Amount" runat="server" Text='<%# Eval("Feb_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mar" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMar_Amount" runat="server" Text='<%# Eval("Mar_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                        <table class="table table-bordered table-striped Grid subtotal-grid">
                                        <tbody>
                                            <tr>
                                                <th style="width: 20%;"></th>
                                                <th>Apr</th>
                                                <th>May</th>
                                                <th>Jun</th>
                                                <th>Jul</th>
                                                <th>Aug</th>
                                                <th>Sep</th>
                                                <th>Oct</th>
                                                <th>Nov</th>
                                                <th>Dec</th>
                                                <th>Jan</th>
                                                <th>Feb</th>
                                                <th>Mar</th>

                                            </tr>
                                            <tr>
                                                <th>Basic</th>

                                                <td>
                                                    <asp:TextBox ID="txtEarTotApr" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotMay" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotJun" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotJul" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotAug" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotSep" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotOct" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotNov" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotDec" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotJan" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotFeb" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtEarTotMar" ClientIDMode="Static" class="form-control" runat="server" MaxLength="9" onblur="return checkvalue(this);" onfocusout="EarningTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <th>Gross Amount</th>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToApr" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToMay" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToJun" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToJul" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToAug" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToSep" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToOct" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToNov" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToDec" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToJan" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToFeb" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtGrossToMar" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    </div>
                                </div>
                                <div class="box-header section-sub-header" runat="server" id="HeaderDeduction">
                                    <h3 class="box-title">Deduction Detail</h3>
                                    <div class="box-tools pull-right">
                                        <button type="button" class="btn btn-box-tool togglebody"><i class="fa fa-minus"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="matrix-wrapper">
                                        <asp:GridView ID="GridView2" runat="server" ClientIDMode="Static" class="table table-bordered table-striped Grid main-matrix-grid" AutoGenerateColumns="False" AllowPaging="false" DataKeyNames="ID_1" ShowFooter="true">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="10">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("ID_1").ToString()%>' runat="server" />
                                                    <asp:Label ID="lblRowNumber_2" Visible="false" ToolTip='<%# Eval("ID_2").ToString()%>' runat="server" />
                                                    <asp:Label ID="lblEarnDeduction_ID" Text='<%# Eval("EarnDeduction_ID").ToString()%>' runat="server" Visible="false" />
                                                    <asp:Label ID="lblCalculation_Type" Text='<%# Eval("Calculation_Type").ToString()%>' runat="server" Visible="false" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblRowNumber" runat="server" />
                                                </FooterTemplate>
                                            </asp:TemplateField>

                                            <%--  <asp:BoundField DataField="EarnDeduction_Name" HeaderText="Name" HeaderStyle-CssClass="ss" />--%>
                                            <asp:TemplateField HeaderText="Name" HeaderStyle-CssClass="ss">
                                                <ItemTemplate>
                                                    <asp:Label ID="EarnDeduction_Name" Text='<%# Eval("EarnDeduction_Name").ToString() %>' runat="server" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lblEarnDeduction_Name" Text='Policy' runat="server" />
                                                </FooterTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Apr" ItemStyle-Width="73" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtApr_Amount" runat="server" Text='<%# Eval("Apr_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtApr_Amount" runat="server" class="form-control" MaxLength="9" Enabled="false" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center> <asp:LinkButton ID="btnApr_Amount" runat="server" CssClass="label label-info" CommandArgument="4" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="May" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMay_Amount" runat="server" Text='<%# Eval("May_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtMay_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center> <asp:LinkButton ID="btnMay_Amount" runat="server" CssClass="label label-info" CommandArgument="5" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jun" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJun_Amount" runat="server" Text='<%# Eval("Jun_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtJun_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center>  <asp:LinkButton ID="btnJun_Amount" runat="server" CssClass="label label-info" CommandArgument="6" OnClick="btnMonth_Click">View</asp:LinkButton>
                                              </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jul" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJul_Amount" runat="server" Text='<%# Eval("Jul_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtJul_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center>  <asp:LinkButton ID="btnJul_Amount" runat="server" CssClass="label label-info" CommandArgument="7" OnClick="btnMonth_Click">View</asp:LinkButton>
                                               </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Aug" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAug_Amount" runat="server" Text='<%# Eval("Aug_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtAug_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center><asp:LinkButton ID="btnAug_Amount" runat="server" CssClass="label label-info" CommandArgument="8" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sep" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSep_Amount" runat="server" Text='<%# Eval("Sep_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtSep_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center> <asp:LinkButton ID="btnSep_Amount" runat="server" CssClass="label label-info" CommandArgument="9" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Oct" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOct_Amount" runat="server" Text='<%# Eval("Oct_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtOct_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center>  <asp:LinkButton ID="btnOct_Amount" runat="server" CssClass="label label-info" CommandArgument="10" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nov" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtNov_Amount" runat="server" Text='<%# Eval("Nov_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtNov_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center>  <asp:LinkButton ID="btnNov_Amount" runat="server" CssClass="label label-info" CommandArgument="11" OnClick="btnMonth_Click">View</asp:LinkButton>
                                               </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dec" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDec_Amount" runat="server" Text='<%# Eval("Dec_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtDec_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center>  <asp:LinkButton ID="btnDec_Amount" runat="server" CssClass="label label-info" CommandArgument="12" OnClick="btnMonth_Click">View</asp:LinkButton>
                                               </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Jan" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtJan_Amount" runat="server" Text='<%# Eval("Jan_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtJan_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center> <asp:LinkButton ID="btnJan_Amount" runat="server" CssClass="label label-info" CommandArgument="1" OnClick="btnMonth_Click">View</asp:LinkButton>
                                               </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Feb" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFeb_Amount" runat="server" Text='<%# Eval("Feb_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtFeb_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center><asp:LinkButton ID="btnFeb_Amount" runat="server" CssClass="label label-info" CommandArgument="2" OnClick="btnMonth_Click">View</asp:LinkButton>
                                                </center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mar" ItemStyle-Width="73">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtMar_Amount" runat="server" Text='<%# Eval("Mar_Amount").ToString()%>' class="form-control" MaxLength="9" onblur="return checkvalue(this);" onfocusout="DeductionTotal();" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtMar_Amount" runat="server" class="form-control" Enabled="false" MaxLength="9" onblur="return checkvalue(this);" onkeypress="return validateDec(this,event)"></asp:TextBox>
                                                    <center> <asp:LinkButton ID="btnMar_Amount" runat="server" CssClass="label label-info" CommandArgument="3" OnClick="btnMonth_Click">View</asp:LinkButton></center>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                        <table class="table table-bordered table-striped Grid subtotal-grid">
                                        <tbody>
                                            <tr>
                                                <th style="width: 21%;"></th>
                                                <th>Apr</th>
                                                <th>May</th>
                                                <th>Jun</th>
                                                <th>Jul</th>
                                                <th>Aug</th>
                                                <th>Sep</th>
                                                <th>Oct</th>
                                                <th>Nov</th>
                                                <th>Dec</th>
                                                <th>Jan</th>
                                                <th>Feb</th>
                                                <th>Mar</th>

                                            </tr>
                                            <tr>
                                                <th>Deduction Total</th>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotApr" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotMay" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotJun" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotJul" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotAug" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotSep" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotOct" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotNov" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotDec" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotJan" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotFeb" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>
                                                <td>
                                                    <asp:TextBox ID="txtDedTotMar" ClientIDMode="Static" class="form-control" runat="server" Enabled="false"></asp:TextBox></td>

                                            </tr>
                                        </tbody>
                                    </table>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 15px; margin-bottom: 15px;">
                                    <div class="col-md-10"></div>
                                    <div class="col-md-2">
                                        <asp:Button ID="btnSave" CssClass="btn btn-block btn-success" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateform();" />
                                    </div>
                                </div>
                                <div class="form-group"></div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>


            <div id="ModalPolicyDetail" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Policy Detail</h4>
                        </div>
                        <div class="modal-body">
                            <asp:GridView ID="GridView3" runat="server" class="table table-bordered table-striped" AutoGenerateColumns="true" AllowPaging="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="10">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="modal-footer">
                            <a type="button" class="btn btn-default" href="PayrollPolicyDetail.aspx" target="_blank">Edit Policy Detail</a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">

        // alert($(".basic_salary").text());

        $('.togglebody').click(function () {
            $(this).closest('.box').find('.box-body').first().slideToggle(250);
            var $icon = $(this).find('i');
            if ($icon.hasClass('fa-minus')) {
                $icon.removeClass('fa-minus').addClass('fa-plus');
            } else {
                $icon.removeClass('fa-plus').addClass('fa-minus');
            }
        });


        function MonthDetail() {
            $('#ModalPolicyDetail').modal('show');
        }
        function validateform1() {
            var msg = "";
            if (document.getElementById('<%=ddlEmployee.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Employee Name. \n";
            }
            if (document.getElementById('<%=ddlYear.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Year. \n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                return true;

            }
        }
        function validateform() {
            var msg = "";
            if (document.getElementById('<%=ddlYear.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Financial Year. \n";
            }
            if (document.getElementById('<%=ddlEmployee.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Employee Name. \n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                if (confirm("Do you really want to Save Details ?")) {
                    return true;
                }
                else {
                    return false;
                }

            }
        }

        function ColorText() {
            var $inputs = $(".table tr td input[type='text'], .Grid input[type='text']");
            $inputs.each(function () {
                var val = parseFloat($(this).val());
                if (!isNaN(val) && val > 0) {
                    $(this).css({ 'color': 'darkblue', 'font-weight': '700' });
                } else {
                    $(this).css({ 'color': '#475569', 'font-weight': '600' });
                }
            });
        }

        $(document).ready(function () {
            ColorText();
        });

        /// Earning Total
        function EarningTotal() {

            var TotApr_Amount = 0.00;
            var TotMay_Amount = 0.00;
            var TotJun_Amount = 0.00;
            var TotJul_Amount = 0.00;
            var TotAug_Amount = 0.00;
            var TotSep_Amount = 0.00;
            var TotOct_Amount = 0.00;
            var TotNov_Amount = 0.00;
            var TotDec_Amount = 0.00;
            var TotJan_Amount = 0.00;
            var TotFeb_Amount = 0.00;
            var TotMar_Amount = 0.00;


            var i = 0;
            var Tval = 0;

            $('#GridView1 tr').each(function (index) {

                if (i > 0) {

                    var Apr_Amount = $(this).children("td").eq(2).find('input[type="text"]').val();
                    var May_Amount = $(this).children("td").eq(3).find('input[type="text"]').val();
                    var Jun_Amount = $(this).children("td").eq(4).find('input[type="text"]').val();
                    var Jul_Amount = $(this).children("td").eq(5).find('input[type="text"]').val();
                    var Aug_Amount = $(this).children("td").eq(6).find('input[type="text"]').val();
                    var Sep_Amount = $(this).children("td").eq(7).find('input[type="text"]').val();
                    var Oct_Amount = $(this).children("td").eq(8).find('input[type="text"]').val();
                    var Nov_Amount = $(this).children("td").eq(9).find('input[type="text"]').val();
                    var Dec_Amount = $(this).children("td").eq(10).find('input[type="text"]').val();
                    var Jan_Amount = $(this).children("td").eq(11).find('input[type="text"]').val();
                    var Feb_Amount = $(this).children("td").eq(12).find('input[type="text"]').val();
                    var Mar_Amount = $(this).children("td").eq(13).find('input[type="text"]').val();

                    if (Apr_Amount == "")
                        Apr_Amount = 0;
                    if (May_Amount == "")
                        May_Amount = 0;
                    if (Jun_Amount == "")
                        Jun_Amount = 0;
                    if (Jul_Amount == "")
                        Jul_Amount = 0;
                    if (Aug_Amount == "")
                        Aug_Amount = 0;
                    if (Sep_Amount == "")
                        Sep_Amount = 0;
                    if (Oct_Amount == "")
                        Oct_Amount = 0;
                    if (Nov_Amount == "")
                        Nov_Amount = 0;
                    if (Dec_Amount == "")
                        Dec_Amount = 0;
                    if (Jan_Amount == "")
                        Jan_Amount = 0;
                    if (Feb_Amount == "")
                        Feb_Amount = 0;
                    if (Mar_Amount == "")
                        Mar_Amount = 0;

                    TotApr_Amount = parseFloat(parseFloat(TotApr_Amount) + parseFloat(Apr_Amount)).toFixed(2);
                    TotMay_Amount = parseFloat(parseFloat(TotMay_Amount) + parseFloat(May_Amount)).toFixed(2);
                    TotJun_Amount = parseFloat(parseFloat(TotJun_Amount) + parseFloat(Jun_Amount)).toFixed(2);
                    TotJul_Amount = parseFloat(parseFloat(TotJul_Amount) + parseFloat(Jul_Amount)).toFixed(2);
                    TotAug_Amount = parseFloat(parseFloat(TotAug_Amount) + parseFloat(Aug_Amount)).toFixed(2);
                    TotSep_Amount = parseFloat(parseFloat(TotSep_Amount) + parseFloat(Sep_Amount)).toFixed(2);
                    TotOct_Amount = parseFloat(parseFloat(TotOct_Amount) + parseFloat(Oct_Amount)).toFixed(2);
                    TotNov_Amount = parseFloat(parseFloat(TotNov_Amount) + parseFloat(Nov_Amount)).toFixed(2);
                    TotDec_Amount = parseFloat(parseFloat(TotDec_Amount) + parseFloat(Dec_Amount)).toFixed(2);
                    TotJan_Amount = parseFloat(parseFloat(TotJan_Amount) + parseFloat(Jan_Amount)).toFixed(2);
                    TotFeb_Amount = parseFloat(parseFloat(TotFeb_Amount) + parseFloat(Feb_Amount)).toFixed(2);
                    TotMar_Amount = parseFloat(parseFloat(TotMar_Amount) + parseFloat(Mar_Amount)).toFixed(2);
                }
                i++;
            });



            var basicApr = parseFloat(document.getElementById('<%=txtEarTotApr.ClientID%>').value) || 0;
            var basicMay = parseFloat(document.getElementById('<%=txtEarTotMay.ClientID%>').value) || 0;
            var basicJun = parseFloat(document.getElementById('<%=txtEarTotJun.ClientID%>').value) || 0;
            var basicJul = parseFloat(document.getElementById('<%=txtEarTotJul.ClientID%>').value) || 0;
            var basicAug = parseFloat(document.getElementById('<%=txtEarTotAug.ClientID%>').value) || 0;
            var basicSep = parseFloat(document.getElementById('<%=txtEarTotSep.ClientID%>').value) || 0;
            var basicOct = parseFloat(document.getElementById('<%=txtEarTotOct.ClientID%>').value) || 0;
            var basicNov = parseFloat(document.getElementById('<%=txtEarTotNov.ClientID%>').value) || 0;
            var basicDec = parseFloat(document.getElementById('<%=txtEarTotDec.ClientID%>').value) || 0;
            var basicJan = parseFloat(document.getElementById('<%=txtEarTotJan.ClientID%>').value) || 0;
            var basicFeb = parseFloat(document.getElementById('<%=txtEarTotFeb.ClientID%>').value) || 0;
            var basicMar = parseFloat(document.getElementById('<%=txtEarTotMar.ClientID%>').value) || 0;

            var grossApr = (parseFloat(TotApr_Amount) + basicApr);
            var grossMay = (parseFloat(TotMay_Amount) + basicMay);
            var grossJun = (parseFloat(TotJun_Amount) + basicJun);
            var grossJul = (parseFloat(TotJul_Amount) + basicJul);
            var grossAug = (parseFloat(TotAug_Amount) + basicAug);
            var grossSep = (parseFloat(TotSep_Amount) + basicSep);
            var grossOct = (parseFloat(TotOct_Amount) + basicOct);
            var grossNov = (parseFloat(TotNov_Amount) + basicNov);
            var grossDec = (parseFloat(TotDec_Amount) + basicDec);
            var grossJan = (parseFloat(TotJan_Amount) + basicJan);
            var grossFeb = (parseFloat(TotFeb_Amount) + basicFeb);
            var grossMar = (parseFloat(TotMar_Amount) + basicMar);

            document.getElementById('<%=txtGrossToApr.ClientID%>').value = grossApr.toFixed(2);
            document.getElementById('<%=txtGrossToMay.ClientID%>').value = grossMay.toFixed(2);
            document.getElementById('<%=txtGrossToJun.ClientID%>').value = grossJun.toFixed(2);
            document.getElementById('<%=txtGrossToJul.ClientID%>').value = grossJul.toFixed(2);
            document.getElementById('<%=txtGrossToAug.ClientID%>').value = grossAug.toFixed(2);
            document.getElementById('<%=txtGrossToSep.ClientID%>').value = grossSep.toFixed(2);
            document.getElementById('<%=txtGrossToOct.ClientID%>').value = grossOct.toFixed(2);
            document.getElementById('<%=txtGrossToNov.ClientID%>').value = grossNov.toFixed(2);
            document.getElementById('<%=txtGrossToDec.ClientID%>').value = grossDec.toFixed(2);
            document.getElementById('<%=txtGrossToJan.ClientID%>').value = grossJan.toFixed(2);
            document.getElementById('<%=txtGrossToFeb.ClientID%>').value = grossFeb.toFixed(2);
            document.getElementById('<%=txtGrossToMar.ClientID%>').value = grossMar.toFixed(2);

            // Recalculate EPF & ESI in GridView2 based on monthly Basic & Gross Amount
            var maxEpf = 3000;
            var basicArr = [basicApr, basicMay, basicJun, basicJul, basicAug, basicSep, basicOct, basicNov, basicDec, basicJan, basicFeb, basicMar];
            var maxEsiGross = 21000;
            var esiPercentage = 0.75;
            var grossArr = [grossApr, grossMay, grossJun, grossJul, grossAug, grossSep, grossOct, grossNov, grossDec, grossJan, grossFeb, grossMar];
            var actualBasic = parseFloat($(".basic_salary").text().trim()) || 0;

            $('#GridView2 tr').each(function () {
                var name = $(this).children('td').eq(1).text().trim().toUpperCase();
                if ((name.indexOf('EMPLOYEES PROVIDENT FUND') === 0 || name.indexOf('EPF') === 0) && name.indexOf('EMPLOYER') === -1) {
                    for (var m = 0; m < 12; m++) {
                        var $txt = $(this).children('td').eq(m + 2).find('input[type="text"]');
                        if ($txt.length && !$txt.prop('disabled')) {
                            var b = basicArr[m];
                            var epfVal = 0;
                            if (actualBasic >= 25000) {
                                if (b >= 25000) {
                                    epfVal = 3000;
                                } else {
                                    epfVal = Math.round((b * 12) / 100);
                                }
                            } else {
                                epfVal = Math.round((b * 12) / 100);
                                if (epfVal > maxEpf) {
                                    epfVal = maxEpf;
                                }
                            }
                            $txt.val(epfVal);
                        }
                    }
                } else if (name.indexOf('ESI') === 0 || name.indexOf('ESI(') !== -1) {
                    for (var m = 0; m < 12; m++) {
                        var $txt = $(this).children('td').eq(m + 2).find('input[type="text"]');
                        if ($txt.length && !$txt.prop('disabled')) {
                            var g = grossArr[m];
                            var esiVal = 0;
                            if (g <= maxEsiGross) {
                                esiVal = Math.round((g * esiPercentage) / 100);
                            }
                            $txt.val(esiVal);
                        }
                    }
                }
            });

            DeductionTotal();
            ColorText();
        }

        // Deduction Detail Total

        function DeductionTotal() {

            var TotApr_Amount = 0.00;
            var TotMay_Amount = 0.00;
            var TotJun_Amount = 0.00;
            var TotJul_Amount = 0.00;
            var TotAug_Amount = 0.00;
            var TotSep_Amount = 0.00;
            var TotOct_Amount = 0.00;
            var TotNov_Amount = 0.00;
            var TotDec_Amount = 0.00;
            var TotJan_Amount = 0.00;
            var TotFeb_Amount = 0.00;
            var TotMar_Amount = 0.00;


            var i = 0;
            var Tval = 0;

            $('#GridView2 tr').each(function (index) {

                if (i > 0) {

                    var Apr_Amount = $(this).children("td").eq(2).find('input[type="text"]').val();
                    var May_Amount = $(this).children("td").eq(3).find('input[type="text"]').val();
                    var Jun_Amount = $(this).children("td").eq(4).find('input[type="text"]').val();
                    var Jul_Amount = $(this).children("td").eq(5).find('input[type="text"]').val();
                    var Aug_Amount = $(this).children("td").eq(6).find('input[type="text"]').val();
                    var Sep_Amount = $(this).children("td").eq(7).find('input[type="text"]').val();
                    var Oct_Amount = $(this).children("td").eq(8).find('input[type="text"]').val();
                    var Nov_Amount = $(this).children("td").eq(9).find('input[type="text"]').val();
                    var Dec_Amount = $(this).children("td").eq(10).find('input[type="text"]').val();
                    var Jan_Amount = $(this).children("td").eq(11).find('input[type="text"]').val();
                    var Feb_Amount = $(this).children("td").eq(12).find('input[type="text"]').val();
                    var Mar_Amount = $(this).children("td").eq(13).find('input[type="text"]').val();

                    if (Apr_Amount == "")
                        Apr_Amount = 0;
                    if (May_Amount == "")
                        May_Amount = 0;
                    if (Jun_Amount == "")
                        Jun_Amount = 0;
                    if (Jul_Amount == "")
                        Jul_Amount = 0;
                    if (Aug_Amount == "")
                        Aug_Amount = 0;
                    if (Sep_Amount == "")
                        Sep_Amount = 0;
                    if (Oct_Amount == "")
                        Oct_Amount = 0;
                    if (Nov_Amount == "")
                        Nov_Amount = 0;
                    if (Dec_Amount == "")
                        Dec_Amount = 0;
                    if (Jan_Amount == "")
                        Jan_Amount = 0;
                    if (Feb_Amount == "")
                        Feb_Amount = 0;
                    if (Mar_Amount == "")
                        Mar_Amount = 0;

                    TotApr_Amount = parseFloat(parseFloat(TotApr_Amount) + parseFloat(Apr_Amount)).toFixed(2);
                    TotMay_Amount = parseFloat(parseFloat(TotMay_Amount) + parseFloat(May_Amount)).toFixed(2);
                    TotJun_Amount = parseFloat(parseFloat(TotJun_Amount) + parseFloat(Jun_Amount)).toFixed(2);
                    TotJul_Amount = parseFloat(parseFloat(TotJul_Amount) + parseFloat(Jul_Amount)).toFixed(2);
                    TotAug_Amount = parseFloat(parseFloat(TotAug_Amount) + parseFloat(Aug_Amount)).toFixed(2);
                    TotSep_Amount = parseFloat(parseFloat(TotSep_Amount) + parseFloat(Sep_Amount)).toFixed(2);
                    TotOct_Amount = parseFloat(parseFloat(TotOct_Amount) + parseFloat(Oct_Amount)).toFixed(2);
                    TotNov_Amount = parseFloat(parseFloat(TotNov_Amount) + parseFloat(Nov_Amount)).toFixed(2);
                    TotDec_Amount = parseFloat(parseFloat(TotDec_Amount) + parseFloat(Dec_Amount)).toFixed(2);
                    TotJan_Amount = parseFloat(parseFloat(TotJan_Amount) + parseFloat(Jan_Amount)).toFixed(2);
                    TotFeb_Amount = parseFloat(parseFloat(TotFeb_Amount) + parseFloat(Feb_Amount)).toFixed(2);
                    TotMar_Amount = parseFloat(parseFloat(TotMar_Amount) + parseFloat(Mar_Amount)).toFixed(2);
                }
                i++;
            });


            document.getElementById('<%=txtDedTotApr.ClientID%>').value = TotApr_Amount;
            document.getElementById('<%=txtDedTotMay.ClientID%>').value = TotMay_Amount;
            document.getElementById('<%=txtDedTotJun.ClientID%>').value = TotJun_Amount;
            document.getElementById('<%=txtDedTotJul.ClientID%>').value = TotJul_Amount;
            document.getElementById('<%=txtDedTotAug.ClientID%>').value = TotAug_Amount;
            document.getElementById('<%=txtDedTotSep.ClientID%>').value = TotSep_Amount;
            document.getElementById('<%=txtDedTotOct.ClientID%>').value = TotOct_Amount;
            document.getElementById('<%=txtDedTotNov.ClientID%>').value = TotNov_Amount;
            document.getElementById('<%=txtDedTotDec.ClientID%>').value = TotDec_Amount;
            document.getElementById('<%=txtDedTotJan.ClientID%>').value = TotJan_Amount;
            document.getElementById('<%=txtDedTotFeb.ClientID%>').value = TotFeb_Amount;
            document.getElementById('<%=txtDedTotMar.ClientID%>').value = TotMar_Amount;

            ColorText();
        }





    </script>
</asp:Content>


