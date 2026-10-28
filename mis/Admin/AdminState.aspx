<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="AdminState.aspx.cs" Inherits="mis_Admin_AdminState" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="row mt-3">
            <div class="col-md-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">State Master</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">State Name<span style="color: red;"> *</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtState_Name" onkeypress="javascript:tbx_fnAlphaOnly(event, this);"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Button runat="server" CssClass="btn btn-success w-100" ID="btnSave" Text="Save" OnClick="btnSave_Click" onclientclick="return validateform();" />
                            </div>
                            <div class="col-md-4">
                                <a href="AdminState.aspx" class="btn btn-outline-secondary w-100">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">State List</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" PageSize="50" runat="server" class="datatable table table-hover table-bordered" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="State_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("State_ID").ToString()%>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="State_Name" HeaderText="State Name" />
                                    <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Select" runat="server" CssClass="btn btn-sm btn-outline-primary" CausesValidation="False" CommandName="Select" Text="<i class='fa fa-edit'></i> Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="30" HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" OnCheckedChanged="chkSelect_CheckedChanged" runat="server" ToolTip='<%# Eval("State_ID").ToString()%>' Checked='<%# Eval("State_IsActive").ToString()=="1" ? true : false %>' AutoPostBack="true" />
                                        </ItemTemplate>
                                        <ItemStyle Width="30px"></ItemStyle>
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


        function validateform() {
            var msg = "";
            if (document.getElementById('<%=txtState_Name.ClientID%>').value.trim() == "") {
                msg = msg + "Enter State Name. \n";
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
                initCustomDataTable('.datatable', 'State Master', 'State Master');
            }
        });
    </script>
</asp:Content>
