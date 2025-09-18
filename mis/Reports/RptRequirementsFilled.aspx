<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptRequirementsFilled.aspx.cs" Inherits="mis_Reports_RptRequirementsFilled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Requirements Filled Report</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
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
                                    <label>From Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtFromDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local"
                                       />
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
                                    <label>To Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local"
                                        />
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">

                                    <label runat="server">Employee</label>
                                    <asp:DropDownList runat="server" ID="ddlEmp" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <%--  <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Project."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Project.'></i>"
                                            ControlToValidate="ddlProject"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>--%>
                                    <label runat="server">Project<%--<span style="color: red;">*</span>--%></label>

                                    <asp:DropDownList runat="server" ID="ddlProject" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <label runat="server">Requirement Filled Status</label>
                                    <asp:DropDownList runat="server" ID="ddlFilledStatus" CssClass="form-select select2">
                                        <asp:ListItem Text="Filled" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Not Filled" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-xl-3">
                                <div class="form-group">
                                    <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" OnClick="btnSearch_Click" ValidationGroup="Save" ID="btnSearch" Text="Search" />
                                    <a href="RptRequirementsFilled.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--grid--%>
                <div class="card border-warning" runat="server" id="Div_Detail" visible="false">
                    <div class="card-header">
                        <h4>Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="dataGrid"
                                        CssClass="datatable table table-bordered table-hover" OnRowDataBound="dataGrid_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
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
                                            <asp:TemplateField HeaderText="Fill Status" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFillStatus" runat="server"
                                                        Text='<%# Eval("FillStatus") %>'
                                                        Font-Bold="True"
                                                        Font-Size="Medium"
                                                        ForeColor='<%# Eval("FillStatus").ToString() == "Filled" ? System.Drawing.Color.Green : System.Drawing.Color.Red %>'>
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

            // Aaj ki date ko min set karna for From Date
            var today = new Date().toISOString().split("T")[0];
            fromDate.setAttribute("min", today);

            // Jab From Date change ho
            fromDate.addEventListener("change", function () {
                toDate.value = ""; // Reset To Date jab From Date change ho
                toDate.setAttribute("min", fromDate.value);
            });

            // Jab To Date change ho
            toDate.addEventListener("change", function () {
                if (toDate.value < fromDate.value) {
                    alert("To Date cannot be earlier than From Date!");
                    toDate.value = "";
                }
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            var reportTitle = $('#<%= hfExcelHeader.ClientID %>').val();

            initCustomDataTable('.datatable', reportTitle, reportTitle);
        });
    </script>
</asp:Content>

