<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="PayrollAccountInfo.aspx.cs" Inherits="mis_Payroll_PayrollAccountInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm border-0">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0 text-white">Account Section Information (खाता अनुभाग जानकारी)</h5>
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
            </div>
            <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Office Name<span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlOfficeName" runat="server" class="form-control select2" AutoPostBack="True" OnSelectedIndexChanged="ddlOfficeName_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered table-striped" ShowHeaderWhenEmpty="true"
                                    AutoGenerateColumns="False" DataKeyNames="Emp_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbAction" CssClass="btn btn-outline-primary btn-xs" runat="server" CommandName="select">Add Detail</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%-- <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:BoundField DataField="UserName" HeaderText="MFP ID" />
                                        <asp:BoundField DataField="Emp_Name" HeaderText="Employee Name" />
                                        <asp:BoundField DataField="Designation_Name" HeaderText="Designation Name" />
                                        <asp:BoundField DataField="IsEPFDeduct" HeaderText="EPF Deduction" />
                                        <asp:BoundField DataField="EPF_No" HeaderText="EPF No" />
                                        <asp:BoundField DataField="UAN_No" HeaderText="UAN No" />
                                        <asp:BoundField DataField="GroupInsurance_No" HeaderText="Group Insurance" />
                                        <asp:BoundField DataField="Gratuity_ID" HeaderText="Gratuity ID" />
                                        <asp:BoundField DataField="EGLS_ID" HeaderText="EGLS ID" />
                                        <asp:BoundField DataField="EDLI_ID" HeaderText="EDLI ID" />
                                        <asp:BoundField DataField="LeaveEncashment_ID" HeaderText="Leave Encashment ID" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="myModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white d-flex justify-content-between align-items-center">
                                <h5 class="modal-title mb-0 text-white">Add Account Detail</h5>
                                <button type="button" class="btn-close" data-dismiss="modal" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>EPF Deduction<span style="color: red;">* </span></label>
                                            <asp:DropDownList runat="server" ID="ddlEPFDeduction" CssClass="form-control">
                                                <asp:ListItem Value="False">No</asp:ListItem>
                                                <asp:ListItem Value="True">Yes</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>EPF No. (ईपीएफ संख्या)<span style="color: red;">* </span></label>
                                            <asp:TextBox ID="txtEPFNo" CssClass="form-control" runat="server" onkeypress="return validateNum(event);" placeholder="ईपीएफ संख्या"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>UAN No (यूएएन संख्या)<span style="color: red;">* </span></label>
                                            <asp:TextBox ID="txtUANNo" CssClass="form-control" runat="server" placeholder="यूएएन संख्या" MaxLength="12" onkeypress="return validateNum(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Group Insurance No (समूह बीमा संख्या)</label>
                                            <asp:TextBox ID="txtGroupInsurance" CssClass="form-control" runat="server" placeholder="समूह बीमा संख्या"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Gratuity ID (ग्रैच्युइटी आईडी)</label>
                                            <asp:TextBox ID="txtGratuityID" CssClass="form-control" runat="server" placeholder="ग्रैच्युइटी आईडी"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>EGLS ID (ईजीएलएस आईडी)</label>
                                            <asp:TextBox ID="txtEGLSId" CssClass="form-control" runat="server" placeholder="ईजीएलएस आईडी"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>EDLI ID (ईडीएलआई आईडी)</label>
                                            <asp:TextBox ID="txtEDLIId" CssClass="form-control" runat="server" placeholder="ईडीएलआई आईडी"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Leave Encashment ID (एनकैशमेंट आईडी छोड़ दें)</label>
                                            <asp:TextBox ID="txtLeaveEncashmentID" CssClass="form-control" runat="server" placeholder="एनकैशमेंट आईडी छोड़ दें"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validateform();" />
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" data-bs-dismiss="modal">Close</button>
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
        function callalert() {
            var el = document.getElementById("myModal");
            if (el) {
                try {
                    if (window.bootstrap && bootstrap.Modal) {
                        bootstrap.Modal.getOrCreateInstance(el).show();
                        return;
                    }
                } catch (e) {}
                try { $(el).modal('show'); } catch (e) {}
            }
        }

        $(document).on('click', '[data-dismiss="modal"], [data-bs-dismiss="modal"]', function (e) {
            var m = $(this).closest('.modal')[0];
            if (m) {
                try {
                    if (window.bootstrap && bootstrap.Modal) {
                        var inst = bootstrap.Modal.getInstance(m) || bootstrap.Modal.getOrCreateInstance(m);
                        if (inst) inst.hide();
                    }
                } catch (ex) {}
                try { $(m).modal('hide'); } catch (ex) {}
            }
        });

        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Account Section Information', 'Account Section Information', [0]);
            }
        });

        function validateform() {
            var msg = "";

            if (document.getElementById('<%=txtEPFNo.ClientID%>').value.trim() == "") {
                msg = msg + "Enter EPF No. \n";
            }
            if (document.getElementById('<%=txtUANNo.ClientID%>').value.trim() == "") {
                msg = msg + "Enter UAN No. \n";
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
            }
        }
    </script>
</asp:Content>

