<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRDepartmentalEnquiry.aspx.cs" Inherits="mis_HR_HRDepartmentalEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0 text-white">Departmental Enquiry (विभागीय जांच)</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Office Name <span style="color: red;"> *</span></label>
                            <asp:DropDownList ID="ddlOffice" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlOffice_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Employee Name <span style="color: red;"> *</span></label>
                            <asp:DropDownList ID="ddlEmployeeName" runat="server" CssClass="form-control select2">
                                <asp:ListItem>Select</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Order No <span style="color: red;"> *</span></label>
                            <asp:TextBox ID="txtOrderNo" runat="server" CssClass="form-control" placeholder="Enter Order No"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Order Date <span style="color: red;"> *</span></label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <asp:TextBox ID="txtOrderDate" runat="server" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" autocomplete="off" onpaste="return false" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Enquiry Officer <span style="color: red;"> *</span></label>
                            <asp:DropDownList ID="ddlEnquiryOfficer" runat="server" CssClass="form-control select2"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Presenting Officer <span style="color: red;"> *</span></label>
                            <asp:DropDownList ID="ddlPresentingOfficer" runat="server" CssClass="form-control select2"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Remark <span style="color: red;"> *</span></label>
                            <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Enter Remark"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-2">
                        <div class="form-group">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success btn-block" Text="Save" OnClick="btnSave_Click" OnClientClick="return Validateform();"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        function Validateform() {
            var msg = "";
            if (document.getElementById('<%=ddlOffice.ClientID %>').selectedIndex == 0) {
                msg = msg + "Select Office Name.\n";
            }
            if (document.getElementById('<%=ddlEmployeeName.ClientID %>').selectedIndex == 0) {
                msg = msg + "Select Employee Name.\n";
            }
            if (document.getElementById('<%=txtOrderNo.ClientID %>').value.trim() == "") {
                msg = msg + "Enter Order No.\n";
            }
            if (document.getElementById('<%=txtOrderDate.ClientID %>').value.trim() == "") {
                msg = msg + "Enter Order Date.\n";
            }
            if (document.getElementById('<%=ddlEnquiryOfficer.ClientID %>').selectedIndex == 0) {
                msg = msg + "Select Enquiry Officer.\n";
            }
            if (document.getElementById('<%=ddlPresentingOfficer.ClientID %>').selectedIndex == 0) {
                msg = msg + "Select Presenting Officer.\n";
            }
            if (document.getElementById('<%=txtRemark.ClientID %>').value.trim() == "") {
                msg = msg + "Enter Remark.\n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</asp:Content>
