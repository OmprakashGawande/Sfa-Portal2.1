<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollEarn_DedMaster.aspx.cs" Inherits="mis_Payroll_PayrollEarn_DedMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="row mt-3">
            <div class="col-md-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Earning & Deduction Master</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Type<span style="color: red;"> *</span></label>
                                    <asp:DropDownList ID="ddlEarnDeduction_Type" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEarnDeduction_Type_SelectedIndexChanged">
                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                        <asp:ListItem Value="Earning">Earning</asp:ListItem>
                                        <asp:ListItem Value="Deduction">Deduction</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Name<span style="color: red;"> *</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control text-uppercase" ID="txtEarnDeduction_Name" onkeypress="javascript:tbx_fnAlphaOnly(event, this);" placeholder="Enter Name" autocomplete="off" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Calculation<span style="color: red;"> *</span></label>
                                    <asp:DropDownList ID="ddlEarnDeduction_Calculation" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                        <asp:ListItem Value="Amount(Rs)">Amount(Rs)</asp:ListItem>
                                        <asp:ListItem Value="Percentage(%)">Percentage(%)</asp:ListItem>
                                        <asp:ListItem Value="Loan">Loan</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Show In Pay Sheet<span style="color: red;"> *</span></label>
                                    <asp:DropDownList ID="ddlIsShowInPaySheet" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                        <asp:ListItem Value="0">No</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <asp:Button runat="server" CssClass="btn btn-success w-100" ID="btnSave" Text="Save" OnClientClick="return validateform()" OnClick="btnSave_Click" />
                            </div>
                            <div class="col-md-4">
                                <a href="PayrollEarn_DedMaster.aspx" class="btn btn-outline-secondary w-100">Clear</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Earning & Deduction Detail</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label ID="lblRecord" runat="server" Text="" ForeColor="Red"></asp:Label>
                                <div class="table-responsive">
                                    <asp:GridView ID="GridView1" PageSize="50" runat="server" class="datatable table table-hover table-bordered" ShowHeaderWhenEmpty="true"
                                        AutoGenerateColumns="False" DataKeyNames="EarnDeduction_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("EarnDeduction_ID").ToString()%>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="EarnDeduction_Type" HeaderText="Type" />
                                            <asp:BoundField DataField="EarnDeduction_Name" HeaderText="Name" />
                                            <asp:BoundField DataField="EarnDeduction_Calculation" HeaderText="Calculation" />
                                            <asp:BoundField DataField="IsShowInPaySheet" HeaderText="Show In Pay Sheet" />

                                            <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="Select" runat="server" CssClass="label label-default" CausesValidation="False" CommandName="Select" Text="Edit"></asp:LinkButton>
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


        function tbx_fnAlphaOnly(e, cntrl) {
            if (!e) e = window.event; if (e.charCode) {
                if (e.charCode < 65 || (e.charCode > 90 && e.charCode < 97) || e.charCode > 122)
                { if (e.charCode != 95 && e.charCode != 32) { if (e.preventDefault) { e.preventDefault(); } } }
            } else if (e.keyCode) {
                if (e.keyCode < 65 || (e.keyCode > 90 && e.keyCode < 97) || e.keyCode > 122)
                { if (e.keyCode != 95 && e.keyCode != 32) { try { e.keyCode = 0; } catch (e) { } } }
            }
        }
    </script>
    <script type="text/javascript">
        function validateform() {
            debugger
            var msg = "";
           
            if (document.getElementById("ddlEarnDeduction_Type").selectedIndex == 0) {
                msg += "Select Type\n";
            }
            if (document.getElementById('<%=txtEarnDeduction_Name.ClientID%>').value.trim() == "") {

                msg = msg + "Enter Name. \n";
            }
            if (document.getElementById("ddlEarnDeduction_Calculation").selectedIndex == 0) {
                msg += "Select Calculation\n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Save") {
                    if (confirm("Do you really want to Save Details ?")) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Edit") {
                    if (confirm("Do you really want to Edit Details ?")) {
                        return true;
                    }
                    else {
                        return false;
                    }

                }
            }
        }

        $(document).ready(function () {
            if ($('.datatable').length > 0 && $('.datatable tbody tr').length > 0) {
                initCustomDataTable('.datatable', 'Earning & Deduction Master', 'Earning & Deduction Master');
            }
        });
    </script>
</asp:Content>
