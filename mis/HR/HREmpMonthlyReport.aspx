<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HREmpMonthlyReport.aspx.cs" Inherits="mis_HR_HREmpMonthlyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <link href="../css/StyleSheet.css" rel="stylesheet" />
    <link href="css/hrcustom.css" rel="stylesheet" />
    <link href="css/dataTables.bootstrap.min.css" rel="stylesheet" />
    <style>
        th.sorting, th.sorting_asc, th.sorting_desc {
            background: teal !important;
            color: white !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 5px 3px !important;
        }

        a.btn.btn-default.buttons-excel.buttons-html5 {
            background: #ff5722c2;
            color: white;
            border-radius: unset;
            box-shadow: 2px 2px 2px #808080;
            margin-left: 6px;
            border: none;
        }

        a.btn.btn-default.buttons-pdf.buttons-html5 {
            background: #009688c9;
            color: white;
            border-radius: unset;
            box-shadow: 2px 2px 2px #808080;
            margin-left: 6px;
            border: none;
        }

        a.btn.btn-default.buttons-print {
            background: #e91e639e;
            color: white;
            border-radius: unset;
            box-shadow: 2px 2px 2px #808080;
            border: none;
        }

            a.btn.btn-default.buttons-print:hover, a.btn.btn-default.buttons-pdf.buttons-html5:hover, a.btn.btn-default.buttons-excel.buttons-html5:hover {
                box-shadow: 1px 1px 1px #808080;
            }

            a.btn.btn-default.buttons-print:active, a.btn.btn-default.buttons-pdf.buttons-html5:active, a.btn.btn-default.buttons-excel.buttons-html5:active {
                box-shadow: 1px 1px 1px #808080;
            }

        .box.box-pramod {
            border-top-color: #1ca79a;
        }

        .box {
            min-height: auto;
        }

        table {
            white-space: nowrap;
            font-size: 12px;
        }

        .table th {
            background-color: cadetblue;
        }

        table.dataTable td, table.dataTable th {
            border-color: rgba(158, 158, 158, 0.32);
            word-wrap: break-word !important;
            width: 50px !important;
        }

        table.dataTable {
            border-collapse: collapse !important;
        }

        tr th {
            background: #1ca79a !important;
            border: 1px solid #e0e0e0 !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 3px 2px !important;
            font-size: 11px;
            font-family: verdana;
            line-height: 10px;
            font-weight: 400;
            border: 1px solid #00000061;
        }

        .table > thead > tr > th {
            padding: 5px 2px !important;
            font-weight: 600;
        }

        @media print {
            .print-disable {
                display: none;
            }
        }

        .lblGridHeading {
            text-align: center;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Monthly E-Attendance Report</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row print-disable">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Office Name</label><span style="color: red">*</span>
                            <asp:DropDownList runat="server" ID="ddlOffice" CssClass="form-control select2" AutoPostBack="false" ClientIDMode="Static" Enabled="false">
                                <asp:ListItem>Select</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>FROM DATE<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtStartDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>TO DATE<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtEndDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label>&nbsp;</label>
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Search" ID="btnSearch" OnClick="btnSearch_Click" OnClientClick="return validateform();" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <asp:Label ID="lblGridHeading" CssClass="lblGridHeading" runat="server" Text=""></asp:Label>
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" class="datatable table table-hover table-bordered" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found" OnRowDataBound="GridView1_RowDataBound" ClientIDMode="Static">
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
        function hideColumn() {
            var gridrows = $("#GridView1 tr");
            for (var i = 0; i < gridrows.length; i++) {
                if (gridrows[i].cells.length > 1) {
                    gridrows[i].cells[1].style.display = "none";
                    gridrows[i].cells[0].style.display = "none";
                }
            }
            return false;
        }

        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Monthly E-Attendance Report', 'Monthly E-Attendance Report');
            }
            hideColumn();
        });

        function parseDateDMY(dateStr) {
            if (!dateStr) return null;
            var parts = dateStr.split('/');
            if (parts.length === 3) {
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }
            return new Date(dateStr);
        }

        function validateform() {
            var msg = "";
            var fromdate = document.getElementById('<%=txtStartDate.ClientID%>').value.trim();
            var todate = document.getElementById('<%=txtEndDate.ClientID%>').value.trim();
            if (fromdate == "") {
                msg += "Select From Date. \n";
            }
            if (todate == "") {
                msg += "Select To Date. \n";
            }
            if (fromdate != "" && todate != "") {
                var Fdate = parseDateDMY(fromdate);
                var Tdate = parseDateDMY(todate);
                if (Fdate && Tdate && Fdate > Tdate) {
                    msg += "From Date cannot be greater than To Date!\n";
                }
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            return true;
        }
    </script>
</asp:Content>


