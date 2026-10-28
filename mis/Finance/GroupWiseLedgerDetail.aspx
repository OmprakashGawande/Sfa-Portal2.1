<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="GroupWiseLedgerDetail.aspx.cs" Inherits="mis_Finance_GroupWiseLedgerDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" Runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0"><i class="fa fa-list me-2"></i> GroupWise Ledger Detail</h5>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label font-weight-bold">Group Name <span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" ID="ddlGroup" CssClass="form-control select2" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GVLedgerDetail" ShowHeaderWhenEmpty="true" EmptyDataText="Record Not Found!" EmptyDataRowStyle-ForeColor="Red" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" DataKeyNames="Ledger_ID" runat="server" OnSelectedIndexChanged="GVLedgerDetail_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" ToolTip='<%# Eval("Ledger_ID") %>' Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Ledger_Name" HeaderText="Ledger Name" />
                                    <asp:BoundField DataField="Head_Name" HeaderText="Head Name" />
                                    <asp:BoundField DataField="Office_Name" HeaderText="Office Name" />
                                    <asp:TemplateField HeaderText="Action" ShowHeader="False" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Edit" runat="server" CssClass="btn btn-sm btn-outline-primary" CausesValidation="False" CommandName="Select" Text="<i class='fa fa-eye'></i> View"></asp:LinkButton>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" Runat="Server">
    <script>
        $(document).ready(function () {
            if ($('.datatable').length > 0 && $('.datatable tbody tr').length > 0) {
                initCustomDataTable('.datatable', 'GroupWise Ledger Detail', 'GroupWise Ledger Detail');
            }
        });
    </script>
</asp:Content>

