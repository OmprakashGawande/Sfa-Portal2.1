<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="DeveloperCodeReviewStatus.aspx.cs" Inherits="mis_Transaction_DeveloperCodeReviewStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
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
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" OnClick="btnSave_Click" ID="btnYes" />
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
            </div>
            <div class="card mt-3  border-warning">
                <div class="card-header">
                    <h4>Developer Code Review Status</h4>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator ID="RFV1" ValidationGroup="Save"
                                        ErrorMessage="Select Tech Head." ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Select Tech Head.'></i>"
                                        ControlToValidate="ddlEmployee" Display="Dynamic" runat="server" InitialValue="0">
                                    </asp:RequiredFieldValidator>
                                </span>
                                <label runat="server">Tech Head<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlEmployee" ClientIDMode="Static"
                                    CssClass="form-control select2">
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator ID="RFV2" ValidationGroup="Save"
                                        ErrorMessage="Select Developer Name." ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Select Developer Name.'></i>"
                                        ControlToValidate="ddlDeveloperName" Display="Dynamic" runat="server" InitialValue="0">
                                    </asp:RequiredFieldValidator>
                                </span>
                                <label runat="server">Developer Name<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlDeveloperName" ClientIDMode="Static"
                                    CssClass="form-control select2">
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvClientName"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Code Quality."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Code Quality.'></i>"
                                        ControlToValidate="txtCodeQuality"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Code Quality<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtCodeQuality" runat="server" placeholder="Enter Code Quality" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvCodeReviewByTechHead"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Code Review by Tech Heads."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Code Review by Tech Heads.'></i>"
                                        ControlToValidate="txtCodeReviewByTechHead"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Code Review by Tech Heads<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtCodeReviewByTechHead" runat="server" placeholder="Enter Code Review by Tech Heads" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvWeeklyReviewWithRitesh"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Select Weekly Review with Ritesh Sir."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Select Weekly Review with Ritesh Sir.'></i>"
                                        ControlToValidate="ddlWeeklyReviewWithRitesh"
                                        Display="Dynamic" InitialValue="0"
                                        runat="server" />
                                </span>
                                <label runat="server">Weekly Review with Ritesh Sir<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlWeeklyReviewWithRitesh" CssClass="form-control select2">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvWorkonTime"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Select Work on Time."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Select Work on Time.'></i>"
                                        ControlToValidate="ddlWorkonTime"
                                        Display="Dynamic" InitialValue="0"
                                        runat="server" />
                                </span>
                                <label runat="server">Work on Time<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlWorkonTime" CssClass="form-control select2">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvBugfixing"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Bug fixing."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Bug fixing.'></i>"
                                        ControlToValidate="txtBugfixing"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Bug fixing<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtBugfixing" runat="server" placeholder="Enter Bug fixing" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvCoordinationwithQA"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Coordination with QA."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Coordination with QA.'></i>"
                                        ControlToValidate="txtCoordinationwithQA"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Coordination with QA<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtCoordinationwithQA" runat="server" placeholder="Enter Coordination with QA" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvPunctuality"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Select Punctuality."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Select Punctuality.'></i>"
                                        ControlToValidate="ddlPunctuality"
                                        Display="Dynamic" InitialValue="0"
                                        runat="server" />
                                </span>
                                <label runat="server">Punctuality<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlPunctuality" CssClass="form-control select2">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvLeaveManagement"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Select Leave Management."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Select Leave Management.'></i>"
                                        ControlToValidate="ddlLeaveManagement"
                                        Display="Dynamic" InitialValue="0"
                                        runat="server" />
                                </span>
                                <label runat="server">Leave Management<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlLeaveManagement" CssClass="form-control select2">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvReactTraining"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter React Training."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter React Training.'></i>"
                                        ControlToValidate="txtReactTraining"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">React Training<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtReactTraining" runat="server" placeholder="Enter React Training" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvWorkDeviationfromAssignedorPortal"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Select Work deviation from assigned or portal."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Select Work deviation from assigned or portal.'></i>"
                                        ControlToValidate="ddlWorkDeviationfromAssignedorPortal"
                                        Display="Dynamic" InitialValue="0"
                                        runat="server" />
                                </span>
                                <label runat="server">Work Deviation from Assigned or Portal<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlWorkDeviationfromAssignedorPortal" CssClass="form-control select2">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvBehaviour"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Behaviour."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Behaviour.'></i>"
                                        ControlToValidate="txtBehaviour"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Behaviour<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtBehaviour" runat="server" placeholder="Enter Behaviour" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator
                                        ID="rfvPortalTaskFilled"
                                        ValidationGroup="Save"
                                        ErrorMessage="Please Enter Portal Task Filled."
                                        ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Please Enter Portal Task Filled.'></i>"
                                        ControlToValidate="txtPortalTaskFilled"
                                        Display="Dynamic"
                                        runat="server" />
                                </span>
                                <label runat="server">Portal Task Filled<span style="color: red;">*</span></label>
                                <asp:TextBox autocomplete="off" ID="txtPortalTaskFilled" runat="server" placeholder="Enter Portal Task Filled" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="col-xl-3" runat="server">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                            <a href="DeveloperCodeReviewStatus.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                        </div>
                    </div>
                </div>
            </div>
            <%--grid--%>
            <div class="card border-warning">
                <div class="card-header">
                    <h4>Developer Code Review Detail</h4>
                </div>
                <div class="card-body">
                    <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                        <div class="table-responsive dt-ext ">
                            <div class="col-md-12">
                                <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvDeveloperCodeReviewStatus"
                                    CssClass="datatable table table-bordered table-hover" DataKeyNames="DeveloperCodeReviewStatusID" OnRowCommand="gvDeveloperCodeReviewStatus_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                <asp:Label runat="server" ID="lblTechHeadID" Text='<%#Eval("TechHeadID").ToString() %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tech Head" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTechHead" runat="server" Text='<%# Eval("TechHead") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Developer Name" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDeveloperName" runat="server" Text='<%# Eval("DeveloperName") %>'></asp:Label>
                                                <asp:Label ID="lblDeveloperNameID" runat="server" Text='<%# Eval("DeveloperNameID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Code Quality" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCodeQuality" runat="server" Text='<%# Eval("CodeQuality") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Code Review by Tech Heads" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCodeReviewbyTechHeads" runat="server" Text='<%# Eval("CodeReviewbyTechHeads") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Weekly Review with Ritesh Sir" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWeeklyReviewwithRiteshSir" runat="server" Text='<%# Eval("WeeklyReviewwithRiteshSir") %>'></asp:Label>
                                                <asp:Label ID="lblWeeklyReviewwithRiteshSirID" runat="server" Visible="false" Text='<%# Eval("WeeklyReviewwithRiteshSirID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Workon Time" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWorkonTime" runat="server" Text='<%# Eval("WorkonTime") %>'></asp:Label>
                                                <asp:Label ID="lblWorkonTimeID" runat="server" Text='<%# Eval("WorkonTimeID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bug fixing" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBugfixing" runat="server" Text='<%# Eval("Bugfixing") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Coordination with QA" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCoordinationwithQA" runat="server" Text='<%# Eval("CoordinationwithQA") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Punctuality" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPunctuality" runat="server" Text='<%# Eval("Punctuality") %>'></asp:Label>
                                                <asp:Label ID="lblPunctualityID" runat="server" Text='<%# Eval("PunctualityID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Leave Management" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLeaveManagement" runat="server" Text='<%# Eval("LeaveManagement") %>'></asp:Label>
                                                <asp:Label ID="lblLeaveManagementID" runat="server" Text='<%# Eval("LeaveManagementID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="React Training" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReactTraining" runat="server" Text='<%# Eval("ReactTraining") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Work Deviation from Assigned or Portal" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWorkDeviationfromAssignedorPortal" runat="server" Text='<%# Eval("WorkDeviationfromAssignedorPortal") %>'></asp:Label>
                                                <asp:Label ID="lblWorkDeviationfromAssignedorPortalID" runat="server" Text='<%# Eval("WorkDeviationfromAssignedorPortalID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Behaviour" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBehaviour" runat="server" Text='<%# Eval("Behaviour") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Portal Task Filled" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPortalTaskFilled" runat="server" Text='<%# Eval("PortalTaskFilled") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="180px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="linkedit" runat="server" CommandArgument='<%# Eval("DeveloperCodeReviewStatusID") %>' OnClientClick="return confirm('Are you sure you want to edit this requirement?');" CommandName="RecordEdit" ToolTip="Edit" CssClass="btn btn-info btn-sm"><i class="fa fa-edit"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
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
    </script>

    <script>
      $(document).ready(function() {
          initCustomDataTable('.datatable', 'Developer Code Review Status', 'Developer Code Review Status', [14]);
      });
    </script>
</asp:Content>

