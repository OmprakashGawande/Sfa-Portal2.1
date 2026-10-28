<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRDailyAttendenceReport.aspx.cs" Inherits="HRDailyAttendenceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card shadow-sm mt-3">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0" id="Label1">Attendance Report</h5>
                <asp:Label ID="lblMsg" runat="server" ClientIDMode="Static" Text=""></asp:Label>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group mb-3">
                            <label class="form-label font-weight-bold">FROM DATE<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <div class="input-group-prepend input-group-addon">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtStartDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group mb-3">
                            <label class="form-label font-weight-bold">TO DATE<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <div class="input-group-prepend input-group-addon">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtEndDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group mb-3">
                            <label class="form-label d-block">&nbsp;</label>
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary w-100" Text="Search" OnClientClick="return validateform();" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered"
                                AutoGenerateColumns="false" ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" Text='<%# Eval("Status").ToString()%>' runat="server"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DATE" HeaderText="Date" />
                                    <asp:BoundField DataField="Day" HeaderText="Day" />
                                    <asp:BoundField DataField="LoginTime" HeaderText="LoginTime" />
                                    <asp:BoundField DataField="LogoutTime" HeaderText="LogoutTime" />
                                    <asp:BoundField DataField="WorkingHours" HeaderText="Working Hours" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        function validateform() {
            var msg = "";
            var fromdate = document.getElementById('<%=txtStartDate.ClientID%>').value.trim();
            var Todate = document.getElementById('<%=txtEndDate.ClientID%>').value.trim();
            if (fromdate == "") {
                msg += "Select From Date. \n";
            }
            if (Todate == "") {
                msg += "Select To Date. \n";
            }
            if (fromdate != "" && Todate != "") {
                var fromParts = fromdate.split('/');
                var toParts = Todate.split('/');
                if (fromParts.length === 3 && toParts.length === 3) {
                    var Fdate = new Date(fromParts[2], fromParts[1] - 1, fromParts[0]);
                    var Tdate = new Date(toParts[2], toParts[1] - 1, toParts[0]);
                    if (Fdate > Tdate) {
                        alert("Invalid Date Range!\nFrom Date cannot be after To Date!");
                        return false;
                    }
                }
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            return true;
        }

        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Attendance Report', 'Attendance Report');
            } else if ($.fn.DataTable) {
                $('.datatable').DataTable({
                    paging: true,
                    pageLength: 50,
                    responsive: true
                });
            }
        });
    </script>
</asp:Content>

