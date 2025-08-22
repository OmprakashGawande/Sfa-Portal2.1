<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="ProjectManagerProcess.aspx.cs" Inherits="mis_Transaction_ProjectManagerProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Project Manager Review Process</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator ID="RFV1" ValidationGroup="Save"
                                            ErrorMessage="Select Project." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Select Project.'></i>"
                                            ControlToValidate="ddlProject" Display="Dynamic" runat="server" InitialValue="0">
                                        </asp:RequiredFieldValidator>
                                    </span>
                                    <label runat="server">Project<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlProject" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged"
                                        CssClass="form-control select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator ID="RFV2" ValidationGroup="Save"
                                            ErrorMessage="Select Requirement Point." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Select Requirement Point!'></i>"
                                            ControlToValidate="ddlTaskName" Display="Dynamic" runat="server" InitialValue="0">
                                        </asp:RequiredFieldValidator>
                                    </span>
                                    <label runat="server">Requirement Point <span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlTaskName" ClientIDMode="Static"
                                        CssClass="form-control select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-xl-3">
                                <div class="form-group">
                                    <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-info" ValidationGroup="Save" OnClick="btnSearch_Click" ID="btnSearch" Text="Search" />
                                    <a href="ProjectManagerProcess.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="dataGrid"
                                        CssClass="table table-bordered table-hover">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectName" runat="server" Text='<%# Eval("ProjectName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Requirement Point" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("TaskDescription") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Priority" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPriorityType" runat="server" Text='<%# Eval("PriorityType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Assigned By" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssignedBy" runat="server" Text='<%# Eval("AssignedBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Allocation Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllocationDate" runat="server" Text='<%# Eval("AllocationDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Requirement Duration" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllocationTime" runat="server" Text='<%# Eval("AllocationTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskStatus" runat="server" Text='<%# Eval("TaskStatus") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remark" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskRemark" runat="server" Text='<%# Eval("TaskRemark") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Other Task" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOtherTask" runat="server" Text='<%# Eval("OtherTask") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Forward To QA" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFwdtoQA" runat="server" Text='<%# Eval("FwdtoQA") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Test Cases (No.)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalTestCase" runat="server" Text='<%# Eval("TotalTestCase") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Passed Test Cases (No.)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPassTestCase" runat="server" Text='<%# Eval("PassTestCase") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Failed Test Cases (No.)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFailTestCase" runat="server" Text='<%# Eval("FailTestCase") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mt-3" runat="server" id="divCheck" visible="false">
                            <div class="col-xl-12 col-sm-12 position-relative">
                                <!-- Checkbox 1 -->
                                <div class="form-check">
                                    <asp:CheckBox runat="server" ID="chkQualityCheck" onclick="hideErrorMsg('errorMsg1')" />
                                    <label class="form-check-label" for="<%= chkQualityCheck.ClientID %>">
                                        I have checked development quality / processes.
                                    </label>
                                    <div id="errorMsg1" style="color: red; display: none; margin-top: 5px;">
                                        Please confirm you have checked your development quality / processes.
                                    </div>
                                </div>

                                <!-- Checkbox 2 -->
                                <div class="form-check ">
                                    <asp:CheckBox runat="server" ID="chkReqFullField" onclick="hideErrorMsg('errorMsg2')" />
                                    <label class="form-check-label" for="<%= chkReqFullField.ClientID %>">
                                        Client requirement has been fulfilled properly.
                                    </label>
                                    <div id="errorMsg2" style="color: red; display: none; margin-top: 5px;">
                                        Please confirm client requirement has been fulfilled properly.
                                    </div>
                                </div>

                                <!-- Checkbox 3 -->
                                <div class="form-check ">
                                    <asp:CheckBox runat="server" ID="chkSendToAudit" onclick="hideErrorMsg('errorMsg3')" />
                                    <label class="form-check-label" for="<%= chkSendToAudit.ClientID %>">
                                        Sending to audit team.
                                    </label>
                                    <div id="errorMsg3" style="color: red; display: none; margin-top: 5px;">
                                        Please confirm you are sending this to the audit team.
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12" runat="server" >
                                <div class="form-group">
                                    <asp:Button runat="server" OnClientClick="return validateCheckboxes();" CssClass="btn btn-block btn-success" ID="btnSave" OnClick="btnSave_Click" Text="Send" ValidationGroup="Save" />
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
        function validateCheckboxes() {
            var valid = true;

            var checkboxes = [
                { id: '<%= chkQualityCheck.ClientID %>', error: 'errorMsg1' },
                { id: '<%= chkReqFullField.ClientID %>', error: 'errorMsg2' },
                { id: '<%= chkSendToAudit.ClientID %>', error: 'errorMsg3' }
            ];

            checkboxes.forEach(function (cb) {
                var checkbox = document.getElementById(cb.id);
                var errorMsg = document.getElementById(cb.error);

                if (!checkbox.checked) {
                    errorMsg.style.display = 'block';
                    valid = false;
                } else {
                    errorMsg.style.display = 'none';
                }
            });

            return valid;
        }

        function hideErrorMsg(errorId) {
            var errorMsg = document.getElementById(errorId);
            errorMsg.style.display = 'none';
        }
    </script>
</asp:Content>

