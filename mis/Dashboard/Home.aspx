<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="mis_Dashboard_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row mt-5">

            <div class="col-xl-12 col-sm-6 position-relative text-end">
                <div class="form-group">
                    <asp:Button ID="btnOldSFA" runat="server"
                        Text="Access Leave & Salary Management (Old SFA Portal)"
                        OnClientClick="window.open('https://portal2.sfatechnologies.com/','_blank'); return false;"
                        CssClass="btn btn-sm btn-primary" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
</asp:Content>

