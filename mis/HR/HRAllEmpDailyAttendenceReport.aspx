<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRAllEmpDailyAttendenceReport.aspx.cs" Inherits="HRAllEmpDailyAttendenceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Employee Wise Attendance Report</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>From Date<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtStartDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>To Date<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtEndDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Employee<span style="color: red;"> *</span></label>
                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control select2"></asp:DropDownList>
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
                                            <asp:GridView ID="GridView1" DataKeyNames="Per_ID" runat="server" class="datatable table table-hover table-bordered"
                                                AutoGenerateColumns="false"  ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
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
                                                    <%-- <asp:BoundField DataField="Login_LogoutTime" HeaderText="O'Clock" />
                                                 <asp:BoundField DataField="DiffTime" HeaderText="Difference(In min)" />--%>
                                                    <asp:BoundField DataField="WorkingHours" HeaderText="Working Hours" />
                                                    <asp:BoundField DataField="PermissionType" HeaderText ="Late Login/Early Logout" />
                                                    <asp:TemplateField HeaderText="Action" ItemStyle-Width="5%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkview" CssClass="label label-info" runat="server" CommandName="Select" Text="View" Visible='<%# Eval("PermissionType").ToString()==""?false:true %>'></asp:LinkButton>
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

                <div id="myModal" class="modal fade" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Late Login/Early Logout Permission - Detail</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="table-responsive">
                                            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-bordered table-striped table-hover" AutoGenerateRows="false">
                                                <Fields>
                                                    <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
                                                    <asp:BoundField DataField="PermissionType" HeaderText="Permission Type" />
                                                    <asp:BoundField DataField="InsertedOn" HeaderText="Applied Date" />
                                                    <asp:BoundField DataField="Login_LogoutTime" HeaderText="Intimation For - O'Clock" />
                                                    <asp:BoundField DataField="Emp_Remark" HeaderText="Reason" />                                                   
                                                </Fields>
                                            </asp:DetailsView> 
                                        </div>
                                    </div>
                                </div>
                                <fieldset>
                                    <legend>HR Reply Section</legend>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Status<span style="color: red;">*</span></label>
                                                <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server">
                                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                                    <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                                    <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Remark</label>
                                                <asp:TextBox ID="txtHRRemark" runat="server" TextMode="MultiLine" Rows="3" placeholder="Enter Remark..." class="form-control" ClientIDMode="Static"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>                                    
                                </fieldset>
                            </div> 
                            <div class="modal-footer">                            
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Close</button>
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
                initCustomDataTable('.datatable', 'Employee Wise Attendance Report', 'Employee Wise Attendance Report', [8]);
            }
            $(document).on('click', '[data-bs-dismiss="modal"]', function () {
                var modalEl = $(this).closest('.modal');
                if (window.bootstrap && bootstrap.Modal) {
                    var modalObj = bootstrap.Modal.getInstance(modalEl[0]);
                    if (modalObj) modalObj.hide();
                }
                modalEl.modal('hide');
            });
        });

        function callalert() {
            var myModalEl = document.getElementById('myModal');
            if (myModalEl) {
                if (window.bootstrap && bootstrap.Modal) {
                    bootstrap.Modal.getOrCreateInstance(myModalEl).show();
                } else {
                    $("#myModal").modal('show');
                }
            }
        }

        function parseDateDMY(dateStr) {
            if (!dateStr) return null;
            var parts = dateStr.split('/');
            if (parts.length === 3) {
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }
            return new Date(dateStr);
        }

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
                var Fdate = parseDateDMY(fromdate);
                var Tdate = parseDateDMY(Todate);

                if (Fdate && Tdate && Fdate > Tdate) {
                    alert("Invalid Date Range!\nStart Date cannot be after End Date!");
                    return false;
                }
            }
            if (document.getElementById('<%=ddlEmployee.ClientID%>').selectedIndex == 0) {
                msg += "Select Employee Name \n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

