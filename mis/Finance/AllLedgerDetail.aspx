<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="AllLedgerDetail.aspx.cs" Inherits="mis_Finance_AllLedgerDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card shadow-sm mt-3">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">Office Ledgers (All)</h5>
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="GVLedgerDetail" ShowHeaderWhenEmpty="true" EmptyDataText="Record Not Found!" EmptyDataRowStyle-ForeColor="Red" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" DataKeyNames="Ledger_ID" runat="server" OnSelectedIndexChanged="GVLedgerDetail_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:Label ID="lblRowNumber" ToolTip='<%# Eval("Ledger_ID") %>' Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Ledger_Name" HeaderText="Ledger Name" />
                            <asp:BoundField DataField="GST_No" HeaderText="GST No." />
                            <asp:BoundField DataField="Head_Name" HeaderText="Head Name" />
                            <asp:BoundField DataField="Office_Name" HeaderText="Office Name" />
                            <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="Edit" runat="server" CssClass="btn btn-outline-info btn-xs" CausesValidation="False" CommandName="Select" Text="View"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Office Ledgers (All)', 'Office Ledgers List');
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

