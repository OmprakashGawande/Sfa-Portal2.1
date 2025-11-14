<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="RptDeveloperCodeReviewStatus.aspx.cs" Inherits="mis_Reports_RptDeveloperCodeReviewStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
            </div>
            <div class="card mt-3  border-warning">
                <div class="card-header">
                    <h4>Developer Code Review Status Report</h4>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-xl-3 col-sm-6 position-relative">
                            <div class="form-group">
                                <span class="fa-pull-right">
                                    <asp:RequiredFieldValidator ID="RFV1" ValidationGroup="Save"
                                        ErrorMessage="Select Project." ForeColor="Red"
                                        Text="<i class='fa fa-exclamation-circle' title='Select Project.'></i>"
                                        ControlToValidate="ddlEmployee" Display="Dynamic" runat="server" InitialValue="0">
                                    </asp:RequiredFieldValidator>
                                </span>
                                <label runat="server">Tech Head<span style="color: red;">*</span></label>
                                <asp:DropDownList runat="server" ID="ddlEmployee" ClientIDMode="Static"
                                    CssClass="form-control select2">
                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-xl-3">
                            <div class="form-group">
                                <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" OnClick="btnSearch_Click" ValidationGroup="Save" ID="btnSearch" Text="Search" />
                                <a href="RptDeveloperCodeReviewStatus.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
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
                                    CssClass="datatable table table-bordered table-hover" DataKeyNames="DeveloperCodeReviewStatusID">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
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
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Workon Time" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWorkonTime" runat="server" Text='<%# Eval("WorkonTime") %>'></asp:Label>
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
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Leave Management" ItemStyle-CssClass="center-grid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLeaveManagement" runat="server" Text='<%# Eval("LeaveManagement") %>'></asp:Label>
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
       $(document).ready(function() {
           // Main page DataTable
           initCustomDataTable('.datatable', 'Developer Code Review Report', 'Developer Code Review Report');
       });
    </script>
</asp:Content>

