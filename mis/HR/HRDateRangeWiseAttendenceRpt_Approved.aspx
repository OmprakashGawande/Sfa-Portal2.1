<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRDateRangeWiseAttendenceRpt_Approved.aspx.cs" Inherits="mis_HR_HRDateRangeWiseAttendenceRpt_Approved" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        input[type="radio"] {
            margin-right: 2px;
            margin-left: 6px;
        }

        .cssPedding {
            padding: 3px !important;
        }

        .dataTables_wrapper, div#ModalAttendence {
            font-size: 12px;
        }

            div#ModalAttendence .form-control {
                height: 26px;
                padding: 1px 4px;
                font-size: 12px;
            }

            .dataTables_wrapper th, .dataTables_wrapper td {
                padding: 5px !important;
            }

        th.sorting, th.sorting_asc, th.sorting_desc {
            background: teal !important;
            color: white !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 8px 5px;
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

        .dt-buttons {
            margin-bottom: 11px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Administrative Approved Attendance Report</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>From Date<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtStartDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>To Date<span style="color: red;"> *</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox runat="server" autocomplete="off" placeholder="DD/MM/YYYY" CssClass="form-control datetime-local" ID="txtEndDate" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Office<span style="color: red;"> *</span></label>
                                        <asp:DropDownList ID="ddlOffice" runat="server" CssClass="form-control Select2"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Employee Type</label><span style="color: red">*</span>
                                        <asp:DropDownList ID="ddlEmployeeType" runat="server" class="form-control select2" OnSelectedIndexChanged="ddlEmployeeType_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="Permanent">Permanent Employee</asp:ListItem>
                                              <asp:ListItem Value="Trainee Employee">Trainee Employee</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Employee</label>
                                        <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control select2"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <asp:Button ID="btnSubmit" runat="server" class="btn btn-block btn-success" Style="margin-top: 24px;" Text="Search" OnClientClick="return validateform();" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="box-body">
                                        <asp:Label ID="lbltotalworkingdays" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                                        <br />
                                        <br />
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView1" DataKeyNames="Emp_ID" runat="server" class="datatable table table-hover table-bordered"
                                                AutoGenerateColumns="false" ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found" OnRowCommand="GridView1_RowCommand">
                                                <Columns>

                                                    <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmp_Name" Text='<%# Eval("Emp_Name").ToString() %>' runat="server" />
                                                            <asp:HiddenField ID="HF_Emp_ID" Value='<%# Eval("Emp_ID").ToString() %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--                                                <asp:BoundField DataField="OfficialWorkingDays" HeaderText="Official Working Days" />
                                                    <asp:BoundField DataField="TotalHoliDays" HeaderText="Holidays" /> --%>
                                                    <asp:BoundField DataField="PresentDays" HeaderText="Full Present E-Attendance" />
                                                    <asp:BoundField DataField="AdministrativeApproved" HeaderText="Administrative Approved (Days)" />

                                                    <asp:BoundField DataField="TourDays" HeaderText="Tour (Days)" />
                                                    <asp:BoundField DataField="OnLeaveDays" HeaderText="On Leave (Days)" />
                                                    <asp:BoundField DataField="LwpDays" HeaderText="LWP (Days)" />
                                                    <asp:BoundField DataField="DifferenceDays" HeaderText="Difference In Days" />

                                                    <%--          <asp:BoundField DataField="AbsentDays" HeaderText="Not Login (Days)" />--%>
                                                    <asp:BoundField DataField="TotalWorkingHours" HeaderText="Total Working Hours" />
                                                    <asp:BoundField DataField="AverageWorkingHours" HeaderText="Average Working Hours" />
                                                    <asp:ButtonField ButtonType="Link" CommandName="View" ControlStyle-CssClass="label label-info" HeaderText="Action" Text="View Detail" />

                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ModalAttendence" class="modal fade" role="dialog" tabindex="-1">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Date Wise Attendence Of 
                                <asp:Label ID="lblEmployee" runat="server" Text=""></asp:Label></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblMsgEmp" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                            <asp:Label ID="lblAvailableLeave" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                            <div class="row mt-2">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView2" DataKeyNames="Emp_ID" runat="server" class="datatable1 table table-hover table-bordered" AutoGenerateColumns="false" ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" Text='<%# Eval("Status").ToString()%>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDate" Text='<%# Eval("DATE").ToString()%>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Day" HeaderText="Day" />
                                                <asp:BoundField DataField="LoginTime" HeaderText="LoginTime" />
                                                <asp:BoundField DataField="LogoutTime" HeaderText="LogoutTime" />
                                                <asp:BoundField DataField="WorkingHours" HeaderText="Working Hours" />
                                                <asp:BoundField DataField="PermissionType" HeaderText="Late Login/Early Logout" />
                                                <asp:TemplateField HeaderText="Allow Full Day">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllowStatus" CssClass="label label-Default" Style="background-color: gray;" Text='<%# Eval("AllowStatus").ToString()%>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Reason" HeaderText="Reason" />
                                                <asp:TemplateField HeaderText="View Letter">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" Text='<%# Eval("AllowButton").ToString()%>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Administrative Approved Attendance Report', 'Administrative Approved Attendance Report', [9]);
            }
            $(document).on('click', '[data-bs-dismiss="modal"]', function () {
                var modalEl = $(this).closest('.modal');
                if (window.bootstrap && bootstrap.Modal) {
                    var modalObj = bootstrap.Modal.getInstance(modalEl[0]);
                    if (modalObj) modalObj.hide();
                }
                modalEl.modal('hide');
            });
        });

        function ModalAttendenceFun() {
            var modalEl = document.getElementById('ModalAttendence');
            if (modalEl) {
                if (window.bootstrap && bootstrap.Modal) {
                    bootstrap.Modal.getOrCreateInstance(modalEl).show();
                } else {
                    $("#ModalAttendence").modal('show');
                }
            }
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable1', 'Date Wise Attendance', 'Date Wise Attendance', [9]);
            }
        }

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
                msg += "Select Start Date. \n";
            }
            if (todate == "") {
                msg += "Select End Date. \n";
            }
            if (fromdate != "" && todate != "") {
                var Fdate = parseDateDMY(fromdate);
                var Tdate = parseDateDMY(todate);
                if (Fdate && Tdate && Fdate > Tdate) {
                    msg += "Start Date cannot be after End Date!\n";
                }
            }
            if (document.getElementById('<%=ddlOffice.ClientID%>').selectedIndex == 0) {
                msg += "Select Office.\n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            return true;
        }

        $('#txtStartDate').on('change', function () {
            var start = parseDateDMY($('#txtStartDate').val());
            var end = parseDateDMY($('#txtEndDate').val());

            if ($('#txtEndDate').val() != "" && start && end) {
                if (start > end) {
                    if ($('#txtStartDate').val() != "") {
                        alert("From date should not be greater than To Date.");
                        $('#txtStartDate').val("");
                    }
                }
            }
        });
        $('#txtEndDate').on('change', function () {
            var start = parseDateDMY($('#txtStartDate').val());
            var end = parseDateDMY($('#txtEndDate').val());

            if (start && end && start > end) {
                if ($('#txtEndDate').val() != "") {
                    alert("To Date can not be less than From Date.");
                    $('#txtEndDate').val("");
                }
            }
        });
    </script>
</asp:Content>


