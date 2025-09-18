<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="BATeamReport.aspx.cs" Inherits="mis_DailyTask_BATeamReport" %>

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
                        <h4>BA Team</h4>
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
                                            ErrorMessage="Please Enter Total Task."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Task.'></i>"
                                            ControlToValidate="txtTotalTask"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Task<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalTask" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-9 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Client Meeting."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Client Meeting.'></i>"
                                            ControlToValidate="txtClientMeeting"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Client Meeting (Detail Date Wise)<span style="color: red;">*</span></label>
                                    <asp:TextBox
                                        autocomplete="off"
                                        MaxLength="2000"
                                        ID="txtClientMeeting" TextMode="MultiLine"
                                        runat="server"
                                        class="form-control"
                                        Rows="2" placeholder="Enter Client Meeting"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Project Plan prepared by Project Manager."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Project Plan prepared by Project Manager.'></i>"
                                            ControlToValidate="ddlProjectPlprebyPM"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Project Plan prepared by Project Manager<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlProjectPlprebyPM" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV5"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Any Major Changes Required for Client."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Any Major Changes Required for Client.'></i>"
                                            ControlToValidate="ddlAnyMajorChangesRequiredforClient"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Major Changes Required for Client<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAnyMajorChangesRequiredforClient" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlAnyMajorChangesRequiredforClient_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-9 position-relative" runat="server" visible="false" id="Div_AMCRfCDetails">
                                <div class="form-group">

                                    <label>Detail's</label>
                                    <asp:TextBox
                                        autocomplete="off"
                                        MaxLength="2000"
                                        ID="txtAMCRfCDetails" TextMode="MultiLine"
                                        runat="server"
                                        class="form-control"
                                        Rows="2" placeholder="Enter Detail"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV6"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Internal Challenges."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Internal Challenges.'></i>"
                                            ControlToValidate="ddlInternalChallenges"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Internal Challenges<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlInternalChallenges" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlInternalChallenges_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-9 position-relative" runat="server" visible="false" id="Div_ACDetail">
                                <div class="form-group">

                                    <label>Detail's</label>
                                    <asp:TextBox
                                        autocomplete="off"
                                        MaxLength="2000"
                                        ID="txtICDetail" TextMode="MultiLine"
                                        runat="server"
                                        class="form-control"
                                        Rows="2" placeholder="Enter Detail"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Project on Time."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Project on Time.'></i>"
                                            ControlToValidate="ddlProjectonTime"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Project on Time<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlProjectonTime" CssClass="form-select select2" AutoPostBack="true" OnSelectedIndexChanged="ddlProjectonTime_SelectedIndexChanged">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-9 position-relative" runat="server" visible="false" id="Div_Reason">
                                <div class="form-group">

                                    <label>Reason</label>
                                    <asp:TextBox
                                        autocomplete="off"
                                        MaxLength="2000"
                                        ID="txtReason" TextMode="MultiLine"
                                        runat="server"
                                        class="form-control"
                                        Rows="2" placeholder="Enter Detail"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="BATeamReport.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
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
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvBATeamReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="BATeamReportId">
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
                                            <asp:TemplateField HeaderText="Total Task" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalTask" runat="server" Text='<%# Eval("TotalTask") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client Meeting" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblClientMeeting" runat="server" Text='<%# Eval("ClientMeeting") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Plan prepared by Project Manager" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectPlanPrepared" runat="server" Text='<%# Eval("ProjectPlanPrepared") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Major Changes Required for Client" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMajorChangesRequired" runat="server" Text='<%# Eval("MajorChangesRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Detail's" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMajorChangesDetail" runat="server" Text='<%# Eval("MajorChangesDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Internal Challenges" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInternalChallenges" runat="server" Text='<%# Eval("InternalChallenges") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Detail's" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInternalChallengesDetail" runat="server" Text='<%# Eval("InternalChallengesDetail") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project on Time" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectOnTime" runat="server" Text='<%# Eval("ProjectOnTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectOnTimeNoReason" runat="server" Text='<%# Eval("ProjectOnTimeNoReason") %>'></asp:Label>
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
            initCustomDataTable('.datatable', 'BA Team Weekly Report', 'BA Team Weekly Report');
        });
    </script>
</asp:Content>

