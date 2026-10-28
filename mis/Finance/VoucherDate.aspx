<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="VoucherDate.aspx.cs" Inherits="mis_Finance_VoucherDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .datepicker{
            z-index:9999 !important; 
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3 border-warning">
                    <div class="card-header">
                        <h4>Voucher Date</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3 hidden" >
                                <div class="form-group">
                                    <label>Financial Year</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtFY" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Voucher Date<span style="color:red;">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        <asp:TextBox ID="txtVoucherdate" autocomplete="off" placeholder="DD/MM/YYYY" ClientIDMode="Static" runat="server" data-date-end-date="0d" CssClass="form-control datetime-local"></asp:TextBox>
                                    </div>
                                    <small><span id="valtxtVoucherdate" style="color: red;"></span></small>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success btn-block" ClientIDMode="Static" Style="margin-top: 25px;" OnClientClick="return validateform();" OnClick="btnSave_Click"/>

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
        function validateform()
        {
            var msg = "";
            $("valtxtVoucherdate").html("");
            if (document.getElementById('<%=txtVoucherdate.ClientID%>').value.trim() == "")
            {
                msg = "Select Voucher Date."
                $("#valtxtVoucherdate").html("Select Voucher Date");
            }
            if(msg != "")
            {
                alert(msg);
                return false;
            }
            else
            {
                    document.querySelector('.popup-wrapper').style.display = 'block';
                    return true;
            }
        }
        
       
    </script>
</asp:Content>

