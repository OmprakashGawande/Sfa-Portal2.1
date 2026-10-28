<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="Rpt_Late_Login.aspx.cs" Inherits="mis_Daily_Task_Rpt_Late_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" Runat="Server">
    <asp:ValidationSummary ID="vs" runat="server" ValidationGroup="a" ShowMessageBox="true" ShowSummary="false" />
    <%--Confirmation Modal Start --%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div style="display: table; height: 100%; width: 100%;">
            <div class="modal-dialog" style="width: 340px; display: table-cell; vertical-align: middle;">
                <div class="modal-content" style="width: inherit; height: inherit; margin: 0 auto;">
                    <div class="modal-header" style="background-color: #D9D9D9;">
                        <span class="modal-title" style="float: left" id="myModalLabel">Confirmation</span>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <p>
                            <i class="fa fa-question-circle"></i>
                            <asp:Label ID="lblPopupAlert" runat="server"></asp:Label>
                        </p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="btnYes" Style="margin-top: 20px; width: 50px;" />
                        <asp:Button ID="btnNo" ValidationGroup="no" runat="server" CssClass="btn btn-danger" Text="No" data-bs-dismiss="modal" data-dismiss="modal" Style="margin-top: 20px; width: 50px;" />
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <%--ConfirmationModal End --%>
    <div class="container-fluid">
        <asp:Label runat="server" ID="lblMsg"></asp:Label>
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0" id="Label1"><i class="fa fa-clock-o me-2"></i> Late Login</h5>
            </div>
            <div class="card-body">
                <div class="row align-items-end g-3 mb-4">
                    <div class="col-md-3">
                        <div class="form-group mb-0">
                            <label class="form-label font-weight-bold">Date <span class="text-danger">*</span></label>
                            <asp:RequiredFieldValidator ID="rfv_date" runat="server" ForeColor="Red" Text="<i class='fa fa-exclamation-circle' title='Required'></i>" ControlToValidate="txt_date" ErrorMessage="Required Date" SetFocusOnError="true" Display="Dynamic" ValidationGroup="a">
                            </asp:RequiredFieldValidator>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" ID="txt_date" CssClass="form-control datetime-local" autocomplete="off" placeholder="DD/MM/YYYY"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" ValidationGroup="a" CssClass="btn btn-success w-100" OnClick="btnSearch_Click" runat="server" Text="Search" />
                    </div>
                    <div class="col-md-2">
                        <a href="Rpt_Late_Login.aspx" class="btn btn-outline-secondary w-100">Clear</a>
                    </div>
                </div>

                <div class="card shadow-none border">
                    <div class="card-header bg-light">
                        <h6 class="card-title mb-0 font-weight-bold">Details</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" CssClass="datatable table table-hover table-bordered table-striped" ShowHeaderWhenEmpty="true"
                                AutoGenerateColumns="False" DataKeyNames="Emp_Late_ID" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Late_Date") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Employee Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("Emp_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Time">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLate_Time" runat="server" Text='<%# Eval("Late_Time") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ShowHeader="False" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbDelete" runat="server" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Do you really want to delete?');"
                                                CausesValidation="False" CommandName="Select" CommandArgument='<%#Eval("Emp_Late_ID")%>' Text="<i class='fa fa-trash'></i> Delete"
                                                ></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    No record found !
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        $(document).ready(function () {
            if ($('.datatable').length > 0 && $('.datatable tbody tr').length > 0) {
                initCustomDataTable('.datatable', 'Late Login Report', 'Late Login Report');
            }
        });
    </script>
</asp:Content>

