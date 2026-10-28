<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptCustomLoginTimeReport.aspx.cs" Inherits="mis_HR_RptCustomLoginTimeReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Custom Login Time Report</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>DATE<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtStartDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>LOGIN BETWEEN (START TIME)<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                <asp:TextBox runat="server" CssClass="form-control" ClientIDMode="Static" autocomplete="off" ID="txtStartTime" placeholder="HH:MM AM/PM"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>(END TIME)<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                <asp:TextBox runat="server" CssClass="form-control" ClientIDMode="Static" autocomplete="off" ID="txtEndTime" placeholder="HH:MM AM/PM"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <asp:Button ID="btnSubmit" runat="server" class="btn btn-block btn-success" Style="margin-top: 24px;" Text="Search" OnClientClick="return validateform();" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box-body">
                            <asp:Label ID="lblMsg" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered"
                                    AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
                                        <asp:BoundField DataField="LoginTime" HeaderText="LoginTime" />
                                        <asp:TemplateField HeaderText="LogoutTime">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("LogoutTime") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="WorkingHours" HeaderText="Working Hours" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Custom Login Time Report', 'Custom Login Time Report');
            }
            if (window.flatpickr) {
                flatpickr("#txtStartTime", {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "h:i K"
                });
                flatpickr("#txtEndTime", {
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "h:i K"
                });
            }
        });

        function validateform() {
            var msg = "";
            if (document.getElementById('<%= txtStartDate.ClientID%>').value.trim() == "") {
                msg += "Select Date.\n";
            }
            if (document.getElementById('<%= txtStartTime.ClientID%>').value.trim() == "") {
                msg += "Select Start Time.\n";
            }
            if (document.getElementById('<%= txtEndTime.ClientID%>').value.trim() == "") {
                msg += "Select End Time.\n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

