<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRClass.aspx.cs" Inherits="mis_HR_HRClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="row mt-3">
            <div class="col-md-5">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Class Master</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-3">
                                    <label class="form-label font-weight-bold">Class Name<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtClass_Name" runat="server" placeholder="Enter Class Name..." class="form-control" MaxLength="100" onkeypress="return alpha(event);"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Button ID="btnSave" CssClass="btn btn-success w-100" runat="server" Text="Save" OnClientClick="return validateform();" OnClick="btnSave_Click" />
                            </div>
                            <div class="col-md-4">
                                <a class="btn btn-outline-secondary w-100" href="HRClass.aspx">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Class List</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" PageSize="50" runat="server" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="Class_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDeleting="GridView1_RowDeleting">
                                <Columns>
                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Class_Name" HeaderText="Class Name" />
                                    <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Select" runat="server" CssClass="btn btn-sm btn-outline-primary me-1" CausesValidation="False" CommandName="Select" Text="<i class='fa fa-edit'></i> Edit"></asp:LinkButton>
                                            <asp:LinkButton ID="Delete" runat="server" CssClass="btn btn-sm btn-outline-danger" CausesValidation="False" CommandName="Delete" Text="<i class='fa fa-trash'></i> Delete" OnClientClick="return confirm('The Class will be deleted. Are you sure want to continue?');"></asp:LinkButton>
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
            if (document.getElementById('<%=txtClass_Name.ClientID%>').value.trim() == "") {
                msg = msg + "Enter Class Name. \n";
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
                initCustomDataTable('.datatable', 'Class Master', 'Class Master');
            }
        });
    </script>
</asp:Content>

