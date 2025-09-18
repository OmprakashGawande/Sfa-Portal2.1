<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="QATeamReport.aspx.cs" Inherits="mis_DailyTask_QATeamReport" %>

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
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="btnYes" OnClick="btnSave_Click" />
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
                        <h4>QA Team</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Project."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Project.'></i>"
                                            ControlToValidate="txtTotalProject"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Project<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalProject" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Allocated Task."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Allocated Task.'></i>"
                                            ControlToValidate="txtAllocatedTask"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Allocated Task<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtAllocatedTask" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Bug's Major."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Bug's Major.'></i>"
                                            ControlToValidate="txtBugsMajor"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Bug's Major<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtBugsMajor" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Minor."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Minor.'></i>"
                                            ControlToValidate="txtMinor"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Minor<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtMinor" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV5"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Test Cases Prepared."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Test Cases Prepared.'></i>"
                                            ControlToValidate="txtTestCasesPrepared"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Test Cases Prepared <span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTestCasesPrepared" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV6"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Apply."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Apply.'></i>"
                                            ControlToValidate="txtApply"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Apply<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtApply" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV7"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Pass."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Pass.'></i>"
                                            ControlToValidate="txtPass"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Pass<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtPass" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV8"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Fail."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Fail.'></i>"
                                            ControlToValidate="txtFail"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Fail<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtFail" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV9"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Vulnerability Report."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Vulnerability Report.'></i>"
                                            ControlToValidate="txtVulnerabilityReport"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Vulnerability Report (No. of Project)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtVulnerabilityReport" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-9 position-relative">
                                <div class="form-group">

                                    <label>Other Detail's</label>
                                    <asp:TextBox
                                        autocomplete="off"
                                        MaxLength="2000"
                                        ID="txtOtherDetails" TextMode="MultiLine"
                                        runat="server"
                                        class="form-control"
                                        Rows="2" placeholder="Enter Other Detail"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="QATeamReport.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
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
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvQATeamReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="QATeamTaskReportId">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Submitted By" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("SubmittedBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Project" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalProject" runat="server" Text='<%# Eval("TotalProject") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Allocated Task" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllocatedTask" runat="server" Text='<%# Eval("AllocatedTask") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bug's Major" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBugMajor" runat="server" Text='<%# Eval("BugMajor") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Minorr" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBugMinor" runat="server" Text='<%# Eval("BugMinor") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Test Cases Prepared" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTestCasesPrepared" runat="server" Text='<%# Eval("TestCasesPrepared") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Apply" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApply" runat="server" Text='<%# Eval("Apply") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Pass" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPass" runat="server" Text='<%# Eval("Pass") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fail" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFail" runat="server" Text='<%# Eval("Fail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vulnerability Report" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVulnerabilityReport" runat="server" Text='<%# Eval("VulnerabilityReport") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Other's Details" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOtherDetails" runat="server" Text='<%# Eval("OtherDetails") %>'></asp:Label>
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
      <script>
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
      function sanitizeInput(el) {
          let v = (el.value || '').replace(/\D+/g, '');
          // max 2 digit
          if (v.length > 2) v = v.slice(0, 2);
          // agar 0 ya 00 hai to empty kar do
          if (v === "0" || v === "00") v = "";
          el.value = v;
      }
      function sanitizeInput2(el) {
          // sirf digit lo
          let v = (el.value || '').replace(/\D+/g, '');
          //if (v === "0" || v === "00") v = "";
          el.value = v;
      }
  </script>
  <script>
      $(document).ready(function () {
          // Main page DataTable
          initCustomDataTable('.datatable', 'QA Team Weekly Report', 'QA Team Weekly Report');
      });
  </script>
</asp:Content>

