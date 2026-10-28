<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="LedgerDetailBOther.aspx.cs" Inherits="mis_Finance_LedgerDetailBOther" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        div.dataTables_wrapper div.dataTables_length select {
            margin-top: 3px !important;
        }

        input[type="text"]:focus {
            background-color: #3c8dbc7a;
            outline: 2px solid #00a1ff;
        }

        ul.ui-autocomplete.ui-menu.ui-widget.ui-widget-content.ui-corner-all {
            height: 197px !important;
            overflow-y: scroll !important;
            width: 520px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0"><i class="fa fa-book me-2"></i> Other Office Ledgers (Only Sundry Creditors)</h5>
                <asp:HyperLink ID="lnkYourOffice" runat="server" NavigateUrl="LedgerDetailB.aspx" CssClass="btn btn-sm btn-light text-primary"><i class="fa fa-arrow-left me-1"></i> Your Office Ledgers</asp:HyperLink>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label font-weight-bold">Ledger Name</label>
                            <asp:TextBox runat="server" CssClass="form-control capitalize ui-autocomplete-12" placeholder="Enter Ledger Name" ID="txtLedgerName" MaxLength="255" ClientIDMode="Static"></asp:TextBox>
                            <asp:HiddenField ID="hfLedgerName" runat="server" ClientIDMode="Static" />
                            <small><span id="valtxtLedgerName" style="color: red;"></span></small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-block btn-success" Style="margin-top: 23px;" Text="Search" OnClick="btnSearch_Click" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-block btn-default" Style="margin-top: 23px;" Text="Clear" OnClick="btnClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GVLedgerOther" ShowHeaderWhenEmpty="true" EmptyDataText="Record Not Found!" EmptyDataRowStyle-ForeColor="Red" class="datatable table table-hover table-bordered" AutoGenerateColumns="False" DataKeyNames="Ledger_ID" runat="server" OnSelectedIndexChanged="GVLedgerOther_SelectedIndexChanged" AllowPaging="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" ToolTip='<%# Eval("Ledger_ID") %>' Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ledger Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLedger_Name" Text='<%# Eval("Ledger_Name") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GST NO">
                                        <ItemTemplate>
                                            <asp:Label ID="lblGstNO" Text='<%# Eval("GST_No") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Office_Name" HeaderText="Office Name" />
                                    <asp:TemplateField HeaderText="Action" ShowHeader="False" ItemStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Edit" runat="server" CssClass="btn btn-sm btn-outline-primary" CausesValidation="False" CommandName="Select" Text="<i class='fa fa-arrow-left me-1'></i> Select"></asp:LinkButton>
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
                initCustomDataTable('.datatable', 'Other Office Ledgers', 'Other Office Ledgers (Only Sundry Creditors)', [4]);
            }
        });
        function getConfirmation() {
            var retVal = confirm("Record will be deleted. Are you sure want to continue?");
            if (retVal == true) {
                document.querySelector('.popup-wrapper').style.display = 'block';
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script>
        $(document).ready(function () {
            $("#<%=txtLedgerName.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("LedgerDetailBOther.aspx/SearchLedger") %>',
                        data: "{ 'Ledger_Name': '" + $('#txtLedgerName').val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hfLedgerName.ClientID %>").val(i.item.val);
                },
                minLength: 1
            });
        });
    </script>
</asp:Content>



