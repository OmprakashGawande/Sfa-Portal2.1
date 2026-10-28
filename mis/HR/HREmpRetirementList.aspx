<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HREmpRetirementList.aspx.cs" Inherits="mis_HR_HREmpRetirementList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0 text-white">कर्मचारी निवृत्ति विवरण / Employee Retirement Detail</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:Label ID="lblMsg2" runat="server" Text="" Style="color: red; font-size: 15px;"></asp:Label>
                            <asp:GridView ID="GridView1" runat="server" CssClass="datatable table table-hover table-bordered" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.NO" ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
                                    <asp:BoundField DataField="Separation_Type" HeaderText="Separation Type" />
                                    <asp:BoundField DataField="Emp_RetirementDate" HeaderText="Retirement Date" />
                                    <asp:BoundField DataField="Office_Name" HeaderText="Office Name" />
                                    <asp:BoundField DataField="Order_Date" HeaderText="Order Date" />
                                    <asp:BoundField DataField="Order_No" HeaderText="Order No" />
                                    <asp:BoundField DataField="Remark" HeaderText="Remark" />
                                    <asp:TemplateField HeaderText="Documents">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="Documents" runat="server" CssClass="btn btn-sm btn-info text-white" Text="View Document" Target="_blank" NavigateUrl='<%# "~/mis/HR/" + Eval("Documents") %>'> 
                                            </asp:HyperLink>
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Employee Retirement Detail', 'Employee Retirement Detail', [8]);
            }
        });
    </script>
</asp:Content>
