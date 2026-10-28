<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HROverAllEmpList.aspx.cs" Inherits="mis_HR_HREmpDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <style>
        table {
            white-space: nowrap;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Overall Department's Employee List (कर्मचारी सूची)</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Office Name</label><span style="color: red">*</span>
                            <asp:DropDownList runat="server" ID="ddlOffice" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlOffice_SelectedIndexChanged" ClientIDMode="Static">
                                <asp:ListItem>Select</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" DataKeyNames="Emp_ID">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
                                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
                                    <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                    <asp:BoundField DataField="Emp_MobileNo" HeaderText="Mobile No." />
                                    <asp:BoundField DataField="Office_Name" HeaderText="Office Name" />
                                    <asp:BoundField DataField="Emp_AadharNo" HeaderText="Aadhar No" />
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
                initCustomDataTable('.datatable', 'Overall Department Employee List', 'Overall Department Employee List');
            }
        });
    </script>
</asp:Content>
