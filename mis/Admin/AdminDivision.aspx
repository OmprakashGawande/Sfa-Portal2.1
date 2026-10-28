<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="AdminDivision.aspx.cs" Inherits="mis_Admin_AdminDivision" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="row mt-3">
            <div class="col-md-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Division Master</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">State Name<span style="color: red;"> *</span></label>
                                    <asp:dropdownlist runat="server" id="ddlState_Name" cssclass="form-control select2" clientidmode="Static">
                                        <asp:ListItem>Select</asp:ListItem>
                                    </asp:dropdownlist>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Division Name<span style="color: red;"> *</span></label>
                                    <asp:textbox id="txtDivision_Name" runat="server" placeholder="Enter Division Name..." class="form-control" maxlength="100" onkeypress="javascript:tbx_fnAlphaOnly(event, this);"></asp:textbox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:button runat="server" cssclass="btn btn-success w-100" id="btnSave" text="Save" onclick="btnSave_Click" onclientclick="return validateform();" />
                            </div>
                            <div class="col-md-4">
                                <a href="AdminDivision.aspx" class="btn btn-outline-secondary w-100">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Division List</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <asp:GridView ID="GridView1" PageSize="50" runat="server" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="Division_ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("Division_ID").ToString()%>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="State_Name" HeaderText="State Name" />
                                            <asp:BoundField DataField="Division_Name" HeaderText="Division Name " />
                                            <asp:TemplateField HeaderText="Edit" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="Select" runat="server" CssClass="label label-default" CausesValidation="False" CommandName="Select" Text="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="30" HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" OnCheckedChanged="chkSelect_CheckedChanged" runat="server" ToolTip='<%# Eval("Division_ID").ToString()%>' Checked='<%# Eval("Division_IsActive").ToString()=="True" ? true : false %>' AutoPostBack="true" />
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">

    <script type="text/javascript">

        function validateform() {
            var msg = "";
            if (document.getElementById('<%=ddlState_Name.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select State Name. \n";
            }
            if (document.getElementById('<%=txtDivision_Name.ClientID%>').value.trim() == "") {
                msg = msg + "Enter Division Name. \n";
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
                initCustomDataTable('.datatable', 'Division Master', 'Division Master');
            }
        });
    </script>
</asp:Content>

