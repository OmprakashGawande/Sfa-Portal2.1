<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskFilling.aspx.cs" Inherits="mis_DailyTask_TaskFilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Fill Process</h4>
                        <h6 class="float-end text-white">
                            <asp:Label runat="server" ID="lblCurrentTaskCount"></asp:Label></h6>

                    </div>
                    <div class="card-body">
                        <div class="row g-3 needs-validation custom-input">

                            <div class="col-xl-12 col-sm-6 position-relative text-end">
                                <div class="form-group">
                                    <asp:LinkButton runat="server" href="../DailyTaskDoc/CodingStandardChecklist/Coding-StandardChecklist-Part1.docx" download="CodingStandardChecklist" class="btn btn-sm btn-info">Download Coding Standard Checklist</asp:LinkButton>
                                </div>
                            </div>
                            <div class="col-xl-2 col-sm-6 position-relative">
                                <label runat="server">
                                    Date 
                                </label>
                                <div class="form-group">
                                    <asp:TextBox runat="server" ID="txtDate"
                                        data-provide="timepicker" placeholder="DD/MM/YYYY"
                                        autocomplete="off" data-date-format="dd/mm/yyyy"
                                        data-date-autoclose="true" CssClass="form-control disableFuturedate"
                                        AutoPostBack="true"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Save"
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
                                        <asp:RequiredFieldValidator ID="RFV1" ValidationGroup="Save"
                                            ErrorMessage="Select Requirement Point." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Select Requirement Point!'></i>"
                                            ControlToValidate="ddlTaskName" Display="Dynamic" runat="server" InitialValue="0">
                                        </asp:RequiredFieldValidator>
                                    </span>
                                    <label runat="server">Requirement Point <span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlTaskName" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlTaskName_SelectedIndexChanged"
                                        CssClass="form-control select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-2 col-sm-6 position-relative" runat="server" id="Div_Status" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Save"
                                            ErrorMessage="Select Status" ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Select Status !'></i>"
                                            ControlToValidate="ddlTaskStatus" Display="Dynamic" runat="server" InitialValue="0">
                                        </asp:RequiredFieldValidator>
                                    </span>
                                    <label runat="server">Status<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlTaskStatus" OnSelectedIndexChanged="ddlTaskStatus_SelectedIndexChanged" AutoPostBack="true" ClientIDMode="Static"
                                        CssClass="form-control select2">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-xl-2 col-sm-6 position-relative mt-4" runat="server" id="Div_FwdToQa" visible="false">
                                <div class="form-check mt-4">
                                    <asp:CheckBox
                                        ID="chkFwdToQa"
                                        runat="server"
                                        Enabled="false" />
                                    <label class="form-check-label" for="chkMeOut">Fwd to QA</label>
                                </div>
                            </div>

                            <div class="col-xl-6 col-sm-6 position-relative" runat="server" id="Div_Remark" visible="false">
                                <div class="form-group">
                                    <label runat="server">Remark</label>
                                    <asp:TextBox placeholder="Enter Remark" runat="server" ID="txtTaskRemark" MaxLength="2000" oninput="sanitizeInput(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:Label runat="server" ForeColor="Red" ID="lblCounter"></asp:Label>
                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6 position-relative" runat="server" id="Div_OtherTask" visible="false">
                                <div class="form-group">
                                    <label runat="server">Other Task</label>
                                    <asp:TextBox placeholder="ex: Project Name: Requirement Point." runat="server" ID="txtRemark" MaxLength="2000" oninput="sanitizeInput(this)" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    <asp:Label runat="server" ForeColor="Red" ID="lblCounter2"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row g-3 needs-validation custom-input" runat="server" id="divTaskDis" visible="false">
                            <div class="col-xl-12 col-sm-12 position-relative" runat="server">
                                <div class="table-responsive" runat="server">
                                    <div class="col-md-12">
                                        <asp:GridView ID="grvTaskDis" PageSize="50" runat="server" class="table table-hover table-bordered pagination-ys" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Project ">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProjectName" Text='<%# Eval("ProjectName").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Description">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDescription" Text='<%# Eval("TaskDescription").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Priority">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPriorityType" Text='<%# Eval("PriorityType").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Assigned By">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAssignedBy" Text='<%# Eval("AssignedBy").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Allocation Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllocationDate" Text='<%# Eval("AllocationDate").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Duration">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllocationTime" Text='<%# Eval("AllocationTime").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Fill Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskFillDate" Text='<%# Eval("TaskFillDate").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskStatus" Text='<%# Eval("TaskStatus").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-12 col-sm-6 position-relative">
                                <div class="form-check">
                                    <asp:CheckBox onclick="hideErrorMsg()" runat="server" ID="chkQualityCheck" />

                                    <label class="form-check-label" for="<%= chkQualityCheck.ClientID %>">
                                        I have checked my development quality &amp; it's proper as per checklist.
                                    </label>

                                    <div id="errorMsg" style="color: red; display: none; margin-top: 5px;">
                                        Please confirm you have checked your development quality as per the checklist.
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server" id="Div_button" visible="false">
                            <div class="form-group">
                                <asp:Button runat="server" OnClientClick="return validateCheckbox();" CssClass="btn btn-block btn-outline-success" ID="btnSave" OnClick="btnSave_Click" Text="Save" ValidationGroup="Save" />
                                <a href="TaskFilling.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-3 border-warning" runat="server" id="Div_DailyTaskDetail" visible="false">
                    <div class="card-header">
                        <h4>Filled Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3 needs-validation custom-input">
                            <div class="col-xl-12 col-sm-12 position-relative" runat="server">
                                <div class="table-responsive">
                                    <div class="col-md-12">
                                        <asp:GridView ID="GrvDailyTaskDetail" PageSize="50" runat="server" class="table table-hover table-bordered pagination-ys" ShowHeaderWhenEmpty="false" AutoGenerateColumns="False">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Project">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProjectName" Text='<%# Eval("ProjectName").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Point">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskName" Text='<%# Eval("TaskName").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Description">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDescription" Text='<%# Eval("TaskDescription").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Priority">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPriorityType" Text='<%# Eval("PriorityType").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Assigned By">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAssignedBy" Text='<%# Eval("AssignedBy").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Allocation Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllocationDate" Text='<%# Eval("AllocationDate").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Duration">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllocationTime" Text='<%# Eval("AllocationTime").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskStatus"
                                                            runat="server"
                                                            Text='<%# Eval("TaskStatus") %>'
                                                            Font-Bold="true"
                                                            ForeColor='<%# 
                                                                Eval("TaskStatus").ToString() == "Complete" ? System.Drawing.Color.Green : 
                                                                Eval("TaskStatus").ToString() == "Partial Complete" ? System.Drawing.Color.Orange : 
                                                                Eval("TaskStatus").ToString() == "Pending" ? System.Drawing.Color.Red : 
                                                                System.Drawing.Color.Black %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Fwd to QA">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFwdtoQA" Text='<%# Eval("FwdtoQA").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remark">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskRemark" Text='<%# Eval("TaskRemark").ToString() %>' runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Other Task">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOtherTask" Text='<%# Eval("OtherTask").ToString() %>' runat="server"></asp:Label>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        function validateCheckbox() {
            debugger;
            var checkbox = document.getElementById('<%= chkQualityCheck.ClientID %>');
            var errorMsg = document.getElementById('errorMsg');

            if (!checkbox.checked) {
                errorMsg.style.display = 'block';
                return false;
            } else {
                errorMsg.style.display = 'none';
                return true;
            }
        }
        function hideErrorMsg() {
            var errorMsg = document.getElementById('errorMsg');
            errorMsg.style.display = 'none';
        }
    </script>

    <script>
        const txtTaskRemark = document.getElementById('<%=txtTaskRemark.ClientID%>');
        const txtRemark = document.getElementById('<%=txtRemark.ClientID%>');
        const lblCount1 = document.getElementById('<%=lblCounter.ClientID%>'); // assuming this is for txtDiscription
        const lblCount2 = document.getElementById('<%=lblCounter2.ClientID%>'); // for txtTaskDescription

        // Add keyup event listeners
        txtTaskRemark.addEventListener("keyup", () => CharactersCount(txtTaskRemark, lblCount1, 2000));
        txtRemark.addEventListener("keyup", () => CharactersCount(txtRemark, lblCount2, 2000));

        // Character counter function (reusable for any textbox/label)
        function CharactersCount(textbox, label, maxLength) {
            if (textbox.value.length > maxLength) {
                textbox.value = textbox.value.substring(0, maxLength);
            }
            const remaining = maxLength - textbox.value.length;
            label.innerHTML = `${remaining} characters remaining`;
        }

        // Prevent input beyond max length
        function checkTextAreaMaxLength(textBox, e, length) {
            var mLen = textBox["MaxLength"] || length;
            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event) // IE
                        e.returnValue = false;
                    else // Firefox/Chrome/Edge
                        e.preventDefault();
                }
            }
        }

        function checkSpecialKeys(e) {
            return [8, 46, 37, 38, 39, 40].includes(e.keyCode);
        }

        // Initial call to set remaining count on page load
        CharactersCount(txtTaskRemark, lblCount1, 2000);
        CharactersCount(txtRemark, lblCount2, 2000);
    </script>

</asp:Content>

