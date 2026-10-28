<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRDateRangeWiseAttendenceRpt_New.aspx.cs" Inherits="mis_HR_HRDateRangeWiseAttendenceRpt_New" %>

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
                <h5 class="card-title mb-0">Date Range Wise Attendance Report</h5>
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
                                <div class="col-md-2">
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
                                            <asp:ListItem Value="Fixed Employee">Fixed Employee</asp:ListItem>
                                            <asp:ListItem Value="Samvida Employee">Samvida Employee</asp:ListItem>
                                            <asp:ListItem Value="Outsource Employee">Outsource Employee</asp:ListItem>
					    <asp:ListItem Value="Contigent Employee">Contigent Employee</asp:ListItem>
					    <asp:ListItem Value="Theka Shramik">Theka Shramik</asp:ListItem>
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
                                                            <%--  <asp:Label ID="lblEmp_ID" CssClass="hidden" Text='<%# Eval("Emp_ID").ToString() %>' runat="server" />--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PresentDays" HeaderText="Full Present E-Attendance" />
                                                    <asp:BoundField DataField="AdministrativeApproved" HeaderText="Administrative Approved (Days)" />
                                                    <asp:BoundField DataField="TourDays" HeaderText="Tour (Days)" />
                                                    <asp:BoundField DataField="OnLeaveDays" HeaderText="On Leave (Days)" />
                                                    <asp:BoundField DataField="LwpDays" HeaderText="LWP (Days)" />
                                                    <asp:BoundField DataField="DifferenceDays" HeaderText="Difference In Days" />
                                                    <%--

                                                    <asp:BoundField DataField="OfficialWorkingDays" HeaderText="Official Working Days" />
                                                    <asp:BoundField DataField="TotalHoliDays" HeaderText="Holidays" />--%>
                                                    <%--<asp:BoundField DataField="AbsentDays" HeaderText="Absent Days" />--%>
                                                    <asp:BoundField DataField="TotalWorkingHours" HeaderText="Total Working Hours" />
                                                    <asp:BoundField DataField="AverageWorkingHours" HeaderText="Average Working Hours" />
                                                    <asp:ButtonField ButtonType="Link" CommandName="View" ControlStyle-CssClass="label label-info" HeaderText="Action" Text="Admin Approval" />
                                                    <%-- <asp:TemplateField HeaderText="Action" ItemStyle-Width="5%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkview" CssClass="label label-info" runat="server" CommandName="Select" Text="Admin Approval"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
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
                            <h5 class="modal-title">Date Wise Attendance Of 
                                <asp:Label ID="lblEmployee" runat="server" Text=""></asp:Label></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" data-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblMsgEmp" runat="server" ClientIDMode="Static" Text=""></asp:Label><br />
                            <asp:Label ID="lblAvailableLeave" runat="server" ClientIDMode="Static" Text=""></asp:Label>
                            <div class="row mt-2">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <asp:GridView ID="GridView2" DataKeyNames="Per_ID" runat="server" class="table table-hover table-bordered"
                                            AutoGenerateColumns="false" ShowHeaderWhenEmpty="True" EmptyDataText="No Record Found" OnRowDataBound="GridView2_RowDataBound">
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
                                                <asp:TemplateField HeaderText="Allow Full Day" ItemStyle-Width="5%">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllow" Text='<%# Eval("Allow_Status").ToString()%>' runat="server" Visible="false" />
                                                        <asp:Label ID="lblEmpStatus" Text='<%# Eval("EmpStatus").ToString()%>' runat="server" Visible="false" />

                                                        <asp:CheckBox ID="chkAllow" runat="server" Checked='<%# Eval("Allow_Status").ToString() == "Yes" ? true : false %>' Visible='<%# Eval("PresentSattus").ToString() == "Less" ? true : false %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Reason Allow Full Day" ItemStyle-Width="15%" ItemStyle-CssClass="cssPedding">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMyQuantity" CssClass="lblMyQuantity" ForeColor="#0033cc" Text='<%# Eval("Reason").ToString()%>' runat="server" />
                                                        <br />
                                                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlMyQuantity" Enabled='<%# Eval("PresentSattus").ToString() == "Less"? true : false %>' SelectedValue='<%# Eval("Reason") %>'>
                                                            <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                                            <asp:ListItem Value="Full Day" Text="Full Day(Casual Leave)"></asp:ListItem>
                                                            <asp:ListItem Value="First Half" Text="Half Day First Half(Casual Leave)"></asp:ListItem>
                                                            <asp:ListItem Value="Second Half" Text="Half Day Second Half(Casual Leave)"></asp:ListItem>
                                                            <asp:ListItem Value="Late 1/3" Text="Late 1/3 (Casual Leave)"></asp:ListItem>
                                                            <asp:ListItem Value="LWP(Leave Without Pay)" Text="LWP(Leave Without Pay)"></asp:ListItem>
                                                            <asp:ListItem Value="Medical Leave" Text="Medical Leave"></asp:ListItem>
                                                            <asp:ListItem Value="Meeting" Text="Meeting"></asp:ListItem>
                                                            <asp:ListItem Value="Not Logout" Text="Not Logout"></asp:ListItem>
                                                            <asp:ListItem Value="Not Login/Logout" Text="Not Login/ Logout"></asp:ListItem>
                                                            <asp:ListItem Value="Official Work" Text="Official Work"></asp:ListItem>
                                                            <asp:ListItem Value="Others" Text="Others"></asp:ListItem>
                                                            <asp:ListItem Value="Special Holiday" Text="Special Holiday"></asp:ListItem>
                                                            <asp:ListItem Value="Technical Problem" Text="Technical Problem"></asp:ListItem>
                                                            <asp:ListItem Value="Tour" Text="Tour"></asp:ListItem>
                                                            <asp:ListItem Value="Training" Text="Training"></asp:ListItem>
                                                            <asp:ListItem Value="Working Out Of Office" Text="Working Out Of Office"></asp:ListItem>
                                                            <asp:ListItem Value="Manual Attendence" Text="Manual Attendence"></asp:ListItem>
                                                            <asp:ListItem Value="Covid-19/WFH" Text="Covid-19/WFH"></asp:ListItem>
						                                    <asp:ListItem Value="Optional Leave" Text="Optional Leave"></asp:ListItem>
                                                        </asp:DropDownList>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnAllow" runat="server" class="btn btn-success" Text="Submit" OnClientClick="return validateform();" OnClick="btnAllow_Click" />
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
                initCustomDataTable('.datatable', 'Date Range Wise Attendance Report', 'Date Range Wise Attendance Report', [9]);
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


