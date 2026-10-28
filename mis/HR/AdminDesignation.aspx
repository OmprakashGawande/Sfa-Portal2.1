<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="AdminDesignation.aspx.cs" Inherits="mis_HR_AdminDesignation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Designation Master</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Designation  Name<span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtDesignation_Name" runat="server" placeholder="Enter Designation Name..." class="form-control" MaxLength="100" onkeypress="return validatename(event);"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Designation Order<span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtOrderNo" runat="server" placeholder="Enter Designation Order..." class="form-control" MaxLength="5" onkeypress="return validateNum(event);"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Class (श्रेणी)<span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlClass" runat="server" class="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        
                        <div class="col-md-2">
                            <div class="form-group">
                                <asp:Button ID="btnSave" CssClass="btn btn-block btn-success" Style="margin-top: 23px;" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateform();" />
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <a class="btn btn-block btn-default" style="margin-top: 23px;" href="AdminDesignation.aspx">Clear</a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" PageSize="50" runat="server" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="Designation_ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation Name" />
                                    <asp:BoundField DataField="Class" HeaderText="Class" />
                                    <asp:BoundField DataField="OrderNo" HeaderText="Designation Order" />

                                    <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Select" runat="server" CssClass="label label-default" CausesValidation="False" CommandName="Select" Text="Edit"></asp:LinkButton>
                                            <asp:LinkButton ID="Delete" runat="server" CssClass="label label-danger" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Both the Designation and mapped class will be deleted. Are you sure want to continue?');"></asp:LinkButton>
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
        function validateform() {
            var msg = "";
            if (document.getElementById('<%=txtDesignation_Name.ClientID%>').value.trim() == "") {
                msg = msg + "Enter Designation Name. \n";
            }
            if (document.getElementById('<%=ddlClass.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Class. \n";
            }
            if (document.getElementById('<%=txtOrderNo.ClientID%>').value.trim() == "") {
                msg = msg + "Enter Designation Order. \n";
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
                initCustomDataTable('.datatable', 'Designation Master', 'Designation Master');
            }
        });
    </script>
</asp:Content>
