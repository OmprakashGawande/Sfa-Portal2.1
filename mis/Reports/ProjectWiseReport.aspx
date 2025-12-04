<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="ProjectWiseReport.aspx.cs" Inherits="mis_Reports_ProjectWiseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Project Wise Report</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">

                                    <label runat="server">Project<%--<span style="color: red;">*</span>--%></label>

                                    <asp:DropDownList runat="server" ID="ddlProject" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
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
                                    <label>To Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtToDate" runat="server"
                                        placeholder="DD/MM/YYYY" autocomplete="off"
                                        CssClass="form-control datetime-local" />
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-xl-3">
                                <div class="form-group">
                                    <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" OnClick="btnSearch_Click" ValidationGroup="Save" ID="btnSearch" Text="Search" />
                                    <a href="ProjectWiseReport.aspx" style="margin-top: 22px;" class="btn btn-block btn-outline-danger">Clear</a>
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
                                        CssClass="datatable table table-bordered table-hover">
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
                                            <asp:TemplateField HeaderText="Employee" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee" runat="server" Text='<%# Eval("Emp_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Working Days" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalWorkingDays" runat="server" Text='<%# Eval("TotalWorkingDays") %>'></asp:Label>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var fromDate = document.getElementById("<%= txtFromDate.ClientID %>");
            var toDate = document.getElementById("<%= txtToDate.ClientID %>");

            function parseDate(str) {
                // dd/MM/yyyy ko JS Date me convert kare
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

            initCustomDataTable('.datatable', 'Project Wise Report', 'Project Wise Report');
        });
    </script>
</asp:Content>

