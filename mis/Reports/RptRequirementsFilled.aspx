<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptRequirementsFilled.aspx.cs" Inherits="mis_Reports_RptRequirementsFilled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .card-header {
            background-color: var(--theme-deafult, #005d68) !important;
            color: #ffffff !important;
        }

        .card-header h4 {
            color: #ffffff !important;
            margin-bottom: 0;
        }

        .table th {
            background-color: var(--theme-deafult, #005d68) !important;
            color: #ffffff !important;
            white-space: nowrap !important;
            text-align: center !important;
            vertical-align: middle !important;
        }

        .table td {
            vertical-align: middle !important;
        }

        .text-nowrap {
            white-space: nowrap !important;
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
        }

        .buttons-print,
        a.buttons-print,
        button.buttons-print {
            background-color: #009688 !important;
            border-color: #009688 !important;
            color: #fff !important;
            font-weight: 600 !important;
            border-radius: 4px !important;
            padding: 6px 14px !important;
            margin-right: 6px !important;
            border: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>

                <!-- Filter Card -->
                <div class="card mt-3">
                    <div class="card-header">
                        <h4 class="mb-0 text-white">Requirements Filled Report</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <!-- From Date -->
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
                                    <label class="form-label font-weight-bold">From Date<span style="color: red;">*</span></label>
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
                                    <label class="form-label font-weight-bold">To Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local" />
                                </div>
                            </div>

                            <!-- Employee DropDown -->
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">Employee</label>
                                    <asp:DropDownList runat="server" ID="ddlEmp" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Project DropDown -->
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">Project</label>
                                    <asp:DropDownList runat="server" ID="ddlProject" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Requirement Filled Status DropDown -->
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <label class="form-label font-weight-bold">Requirement Filled Status</label>
                                    <asp:DropDownList runat="server" ID="ddlFilledStatus" CssClass="form-select select2">
                                        <asp:ListItem Text="Filled" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Not Filled" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <!-- Buttons Row -->
                        <div class="row mt-3">
                            <div class="col-12">
                                <asp:Button runat="server" CssClass="btn btn-outline-success px-4 me-2" OnClick="btnSearch_Click" ValidationGroup="Save" ID="btnSearch" Text="Search" />
                                <a href="RptRequirementsFilled.aspx" class="btn btn-outline-danger px-4">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Details Card -->
                <div class="card mt-4" runat="server" id="Div_Detail" visible="false">
                    <div class="card-header">
                        <h4 class="mb-0 text-white">Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive dt-ext">
                            <asp:GridView runat="server" AutoGenerateColumns="false" ID="dataGrid"
                                CssClass="datatable table table-bordered table-hover w-100" OnRowDataBound="dataGrid_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="45px">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Project" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjectName" runat="server" Text='<%# Eval("ProjectName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Requirement Point" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("TaskDescription") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Priority" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPriorityType" runat="server" Text='<%# Eval("PriorityType") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Employee" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Assigned By" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAssignedBy" runat="server" Text='<%# Eval("AssignedBy") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Allocation Date" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAllocationDate" runat="server" Text='<%# Eval("AllocationDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Requirement Duration" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAllocationTime" runat="server" Text='<%# Eval("AllocationTime") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Requirement Fill Date" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFillDate" runat="server" Text='<%# Eval("FillDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskStatus" runat="server" Text='<%# Eval("TaskStatus") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Remark" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskRemark" runat="server" Text='<%# Eval("TaskRemark") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Other Project" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOtherProject" runat="server" Text='<%# Eval("OtherProjectName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Other Hours" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOtherTaskHour" runat="server" Text='<%# Eval("OtherTaskHour") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Other Task" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOtherTask" runat="server" Text='<%# Eval("OtherTask") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Forward To QA" ItemStyle-CssClass="center-grid">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFwdtoQA" runat="server"
                                                Text='<%# Eval("FwdtoQA") %>'
                                                ForeColor='<%# (Eval("FwdtoQA").ToString() == "Yes" ? System.Drawing.Color.Green : 
                                                (Eval("FwdtoQA").ToString() == "No" ? System.Drawing.Color.Orange : 
                                                System.Drawing.Color.Black)) %>'
                                                Font-Bold='<%# (Eval("FwdtoQA").ToString() == "Yes" || Eval("FwdtoQA").ToString() == "No") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hfExcelHeader" />
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var fromDate = document.getElementById("<%= txtFromDate.ClientID %>");
            var toDate = document.getElementById("<%= txtToDate.ClientID %>");

            function parseDate(str) {
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
        $(document).ready(function () {
            var reportTitle = $('#<%= hfExcelHeader.ClientID %>').val();
            if (!reportTitle) {
                reportTitle = 'Requirements Filled Report';
            }
            initCustomDataTable('.datatable', reportTitle, reportTitle);
        });
    </script>
</asp:Content>
