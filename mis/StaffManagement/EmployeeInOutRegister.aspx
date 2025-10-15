<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="EmployeeInOutRegister.aspx.cs" Inherits="mis_StaffManagement_EmployeeInOutRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <%--Confirmation Modal Start --%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div style="display: table; height: 100%; width: 100%;">
                <div class="modal-dialog" style="width: 340px; display: table-cell; vertical-align: middle;">
                    <div class="modal-content" style="width: inherit; height: inherit; margin: 0 auto;">
                        <div class="modal-header" style="background-color: #d7c9988c;">

                            <span class="modal-title f-15" style="float: left;" id="myModalLabel">Confirmation</span>
                            <button type="button" class="btn-close py-0 white" data-bs-dismiss="modal" aria-label="Close" data-dismiss="modal">
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
                            <asp:Button runat="server" CssClass="btn btn-success" OnClick="btnSave_Click" Text="Yes" ID="btnYes" />
                            <button
                                type="button"
                                class="btn btn-secondary"
                                onclick="closePopup('#myModal')">
                                No
                            </button>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <%--ConfirmationModal End --%>
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Employee In-Out Register</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Date.'></i>"
                                            ControlToValidate="txtDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                        data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control datetime-local" />
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvEmployeeName"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Employee Name."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Employee Name.'></i>"
                                            ControlToValidate="ddlEmployee"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Employee Name<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlEmployee" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Place."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Place.'></i>"
                                            ControlToValidate="txtPlace"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Place<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtPlace" runat="server" placeholder="Enter Place" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                  <%--  <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Order By."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Order By.'></i>"
                                            ControlToValidate="txtOrderBy"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>--%>
                                    <label runat="server">Order By<%--<span style="color: red;">*</span>--%></label>
                                    <asp:TextBox autocomplete="off" ID="txtOrderBy" runat="server" placeholder="Enter Order By" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfv3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Time Out."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Time Out.'></i>"
                                            ControlToValidate="txtTimeOut"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Time Out<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtTimeOut" placeholder="HH:MM" runat="server" CssClass="form-control" autocomplete="off" />
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfv4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Time In."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Time In.'></i>"
                                            ControlToValidate="txtTimeIn"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Time In<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtTimeIn" placeholder="HH:MM" runat="server" CssClass="form-control" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="EmployeeInOutRegister.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />
                <div class="card border-warning">
                    <div class="card-header">
                        <h4>Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvInOutRegisterReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="InOutRegisterId">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Eval("EntryDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Place" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPlace" runat="server" Text='<%# Eval("Place") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Order By" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOrderBy" runat="server" Text='<%# Eval("OrderBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Out" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTimeOut" runat="server" Text='<%# Eval("TimeOut") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time In" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTimeIn" runat="server" Text='<%# Eval("TimeIn") %>'></asp:Label>
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var txtTimeOut = "#<%= txtTimeOut.ClientID %>";
         var txtTimeIn = "#<%= txtTimeIn.ClientID %>";

         // Utility: Convert HH:MM → minutes (24-hour)
         function convertToMinutes(timeStr) {
             if (!timeStr) return null;
             var parts = timeStr.match(/(\d+):(\d+) ?(AM|PM)?/i);
             if (!parts) return null;

             var hh = parseInt(parts[1], 10);
             var mm = parseInt(parts[2], 10);
             var meridian = parts[3];

             if (meridian) {
                 if (meridian.toUpperCase() === "PM" && hh < 12) hh += 12;
                 if (meridian.toUpperCase() === "AM" && hh === 12) hh = 0;
             }

             return hh * 60 + mm;
         }

         // Time Out Picker
         flatpickr(txtTimeOut, {
             enableTime: true,
             noCalendar: true,
             dateFormat: "h:i K",  // 12-hour format
             time_24hr: false,
             defaultDate: new Date()
         });

         // Time In Picker
         flatpickr(txtTimeIn, {
             enableTime: true,
             noCalendar: true,
             dateFormat: "h:i K",  // 12-hour format
             time_24hr: false,
             defaultDate: "",
             onClose: function (selectedDates, dateStr) {
                 var outVal = document.querySelector(txtTimeOut).value;
                 if (outVal && dateStr) {
                     var outTime = convertToMinutes(outVal);
                     var inTime = convertToMinutes(dateStr);

                     if (inTime <= outTime) {
                         alert("Time In must be greater than Time Out!");
                         document.querySelector(txtTimeIn).value = "";
                     }
                 }
             }
         });
     });

        function ValidatePage() {

            if (typeof (Page_ClientValidate) == 'function') {
                Page_ClientValidate('Save');
            }

            if (Page_IsValid) {

                if (document.getElementById('<%=btnSave.ClientID%>').value.trim() == "Update") {
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

        $(document).ready(function () {
            // Main page DataTable
            initCustomDataTable('.datatable', 'Employee In-Out Register', 'Employee In-Out Register');
        });
    </script>


</asp:Content>

