<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptRequirementsTraceabilityMatrix.aspx.cs" Inherits="mis_Reports_RptRequirementsTraceabilityMatrix" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div>
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <div class="card mt-3  border-warning">
                        <div class="card-header">
                            <h4>Requirements Allocation Report</h4>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvAllocationDate"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Allocation Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Allocation Date.'></i>"
                                                ControlToValidate="txtAllocationDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtAllocationDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                            data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control datetime-local" AutoPostBack="true" OnTextChanged="txtAllocationDate_TextChanged" />
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

                                        <label runat="server">Project</label>
                                        <asp:DropDownList runat="server" ID="ddlProject" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="DivAllocationStatus">
                                    <div class="form-group">
                                        <label runat="server">Allocation Status</label>
                                        <asp:DropDownList runat="server" ID="ddlAllocationStatus" CssClass="form-select select2">
                                            <asp:ListItem Text="Allocated" Value="Allocated" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Not Allocated" Value="Not Allocated"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" OnClick="btnSearch_Click" ValidationGroup="Save" ID="btnSearch" Text="Search" />
                                        <a href="RptRequirementsTraceabilityMatrix.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField runat="server" ID="hfExcelHeader" />
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
                                                <asp:TemplateField HeaderText="Allocation Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" runat="server"
                                                            Text='<%# Eval("AllocationStatus") %>'
                                                            Font-Bold="True"
                                                            Font-Size="Medium"
                                                            ForeColor='<%# Eval("AllocationStatus").ToString() == "Allocated" ? System.Drawing.Color.Green : System.Drawing.Color.Red %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="On Leave" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOnLeave" runat="server" Text='<%# Eval("FillStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="Task Status" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskStatus" runat="server" Text='<%# Eval("TaskStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
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
            var reportTitle = $('#<%= hfExcelHeader.ClientID %>').val();

            initCustomDataTable('.datatable', reportTitle, reportTitle);
        });
    </script>
</asp:Content>

