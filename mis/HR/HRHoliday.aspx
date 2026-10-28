<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRHoliday.aspx.cs" Inherits="mis_HR_HRHoliday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Holiday Calendar</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Holiday Date<span style="color: red;">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox ID="txtHoliday_Date" runat="server" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" autocomplete="off" onpaste="return false" ClientIDMode="Static" AutoPostBack="true" OnTextChanged="txtHoliday_Date_TextChanged"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>Holiday Type<span style="color: red;"> *</span></label>
                                        <asp:DropDownList runat="server" ID="ddlHoliday_Type" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem Value="Select">Select</asp:ListItem>
                                            <asp:ListItem Value="Regular">Regular</asp:ListItem>
                                            <asp:ListItem Value="Optional">Optional</asp:ListItem>
                                            <asp:ListItem Value="Optional">Other</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label>Holiday Name<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtHoliday_Name" runat="server" placeholder="Enter Holiday Name..." class="form-control" MaxLength="100"></asp:TextBox>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Button ID="btnSave" CssClass="btn btn-block btn-success" runat="server" Text="Save" OnClientClick="return validateform();" OnClick="btnSave_Click" />
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <a class="btn btn-block btn-default" href="HRHoliday.aspx">Clear</a>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" DataKeyNames="Holiday_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDeleting="GridView1_RowDeleting">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Holiday_Date" HeaderText="Holiday Date" HeaderStyle-Width="120" />
                                            <asp:BoundField DataField="Holiday_Name" HeaderText="Holiday Name" />
                                            <asp:BoundField DataField="Holiday_Type" HeaderText="Holiday Type" HeaderStyle-Width="100" />
                                            <asp:TemplateField HeaderText="Action" ShowHeader="False" ItemStyle-Width="9%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="Select" runat="server" CssClass="label label-default" CausesValidation="False" CommandName="Select" Text="Edit"></asp:LinkButton>
                                                    <asp:LinkButton ID="Delete" runat="server" CssClass="label label-danger" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('The Holiday will be deleted. Are you sure want to continue?');"></asp:LinkButton>
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
    <script>
        $(document).ready(function () {
            if ($('.datatable').length > 0 && $('.datatable tbody tr').length > 0) {
                initCustomDataTable('.datatable', 'Holiday Calendar', 'Holiday Calendar');
            }
        });
        function validateform() {
            var msg = "";
            if (document.getElementById('<%=txtHoliday_Date.ClientID%>').value.trim() == "") {
                msg = msg + "Select Holiday Date. \n";
            }
            if (document.getElementById('<%=ddlHoliday_Type.ClientID%>').selectedIndex == 0) {
                msg = msg + "Select Holiday Type. \n";
            }
            if (document.getElementById('<%=txtHoliday_Name.ClientID%>').value.trim() == "") {
                msg = msg + "Enter Holiday Name. \n";
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
    </script>
</asp:Content>

