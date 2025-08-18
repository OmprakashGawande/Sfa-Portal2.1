﻿<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="UMEmpRoleMap.aspx.cs" Inherits="mis_UserMgmt_UMEmpRoleMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" Runat="Server">
    <%--Confirmation Modal Start --%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div style="display: table; height: 100%; width: 100%;">
            <div class="modal-dialog" style="width: 340px; display: table-cell; vertical-align: middle;">
                <div class="modal-content" style="width: inherit; height: inherit; margin: 0 auto;">
                    <div class="modal-header" style="background-color: #d9d9d9;">

                        <span class="modal-title" style="float: left" id="myModalLabel">Confirmation</span>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                    </div>
                    <div class="clearfix"></div>
                    <div class="modal-body">
                        <p>
                            <%--<img src="../assets/images/question-circle.png" width="30" />--%>&nbsp;&nbsp; 
                           <i class="fa fa-question-circle"></i>
                            <asp:Label ID="lblPopupAlert" runat="server"></asp:Label>
                        </p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="btnYes" OnClick="btnSave_Click" Style="margin-top: 20px; width: 50px;" />
                        <asp:Button ID="btnNo" ValidationGroup="no" runat="server" CssClass="btn btn-danger" Text="No" data-dismiss="modal" Style="margin-top: 20px; width: 50px;" />
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <%--ConfirmationModal End --%>
    <div class="content-wrapper">
        <asp:ValidationSummary ID="vs" runat="server" ValidationGroup="a" ShowMessageBox="true" ShowSummary="false" />
        <section class="content">
            <div class="container-fluid">
                <div class="box">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="box-body">
                          <div class="card">
                                <div class="card-header">User Role Mapping
                            </div>
                            <div class="card-body">
                                 <div class="row">
                                    <div class="col-md-4">
                            <div class="form-group">
                                <label>User Type</label>
                                <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged" ></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="form-group">
                                <label><asp:Label ID="lblUserName" runat="server" Text="Employee"></asp:Label> Employee Name<span style="color: red;"> *</span></label>
                                    <span class="pull-right">
                                                <asp:RequiredFieldValidator ID="rfv1" ValidationGroup="a"
                                                    ControlToValidate="ddlEmployye_Name" InitialValue="0" ForeColor="Red" Display="Dynamic" runat="server">
                                                </asp:RequiredFieldValidator>
                                            </span>
                                <asp:DropDownList ID="ddlEmployye_Name" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlEmployye_Name_SelectedIndexChanged" >
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                                    </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                     <div id="divGrid" runat="server">
                        <asp:GridView ID="GridView1" PageSize="50" runat="server" class="table table-hover table-bordered pagination-ys" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("Role_ID").ToString()%>' runat="server" />
                                        <asp:Label ID="lblRole_ID" Visible="false" Text='<%# Eval("Role_ID") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Role_Name_E" HeaderText="Roles" />
                                <asp:BoundField DataField="Role_Name_H" HeaderText="Roles(Hindi)" />
                                <asp:TemplateField ItemStyle-Width="30" HeaderText="Exist Roles">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" ToolTip='<%# Eval("Role_ID").ToString()%>' Checked='<%# Eval("ExistID").ToString() != "" ? true : false %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="30px"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-outline-success btn-block" ValidationGroup="a" OnClientClick="return ValidatePage();" />
                                </div>
                            </div>
                        </div>
                    </div>
                                        </div>
                                    
                              </div>
                                </div>
                              </div>
                        </div>
                    </div>
                </div>
            </section>
         </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" Runat="Server">
     <script>
         function ValidatePage() {

             if (typeof (Page_ClientValidate) == 'function') {
                 Page_ClientValidate('a');
             }

             if (Page_IsValid) {

                 if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Edit") {
                    document.getElementById('<%=lblPopupAlert.ClientID%>').textContent = "Are you sure you want to Update this record?";
                    $('#myModal').modal('show');
                    return false;
                }
                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Save") {
                    document.getElementById('<%=lblPopupAlert.ClientID%>').textContent = "Are you sure you want to Save this record?";
                    $('#myModal').modal('show');
                    return false;
                }
            }
        }
    </script>
</asp:Content>

