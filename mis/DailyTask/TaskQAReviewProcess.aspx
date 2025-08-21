<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskQAReviewProcess.aspx.cs" Inherits="mis_DailyTask_TaskQAReviewProcess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div>
                    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    <div class="card mt-3  border-warning">
                        <div class="card-header">
                            <h4>QA Requirement Review</h4>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvProjectName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Project Name."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Project Name.'></i>"
                                                ControlToValidate="ddlProject"
                                                InitialValue="0"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Project<span style="color: red;">*</span></label>
                                        <asp:DropDownList OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" AutoPostBack="true" runat="server" ID="ddlProject" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvTaskName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Requirement Point"
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Requirement Point.'></i>"
                                                ControlToValidate="ddlTaskName"
                                                InitialValue="0"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Requirement Point<span style="color: red;">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlTaskName" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <label runat="server">Status<span style="color: red;">*</span></label>
                                        <asp:DropDownList OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true" runat="server" ID="ddlStatus" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                            </div>
                            <br />
                            <div class="row g-3" runat="server" id="dvTestCase">

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <label runat="server">Total Test Cases (No.)<span style="color: red;">*</span></label>
                                        <asp:TextBox TextMode="Number" autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalTestCase"
                                            runat="server" placeholder="Enter Total Test Cases" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <label runat="server">Pass Test Cases (No.)<span style="color: red;">*</span></label>
                                        <asp:TextBox TextMode="Number" autocomplete="off" oninput="sanitizeInput(this)" ID="txtPassTestCase"
                                            runat="server" placeholder="Enter Pass Test Cases" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <label runat="server">Fail Test Cases (No.)<span style="color: red;">*</span></label>
                                        <asp:TextBox TextMode="Number" autocomplete="off" oninput="sanitizeInput(this)" ID="txtFailTestCase"
                                            runat="server" placeholder="Enter Fail Test Cases" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <asp:Button OnClientClick="return validateTestCases();" runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" ValidationGroup="Save" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                                        <a href="TaskQAReviewProcess.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <%--grid--%>
                    <div class="card border-warning">
                        <div class="card-header">
                            <h4>Details</h4>
                        </div>
                        <div class="card-body">
                            <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                                <div class="table-responsive dt-ext ">
                                    <div class="col-md-12">
                                        <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvDetails" OnRowCommand="gvDetails_RowCommand"
                                            CssClass="table table-bordered table-hover" DataKeyNames="TaskForwardedToQAId">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                        <asp:Label runat="server" ID="lblTaskForwardedToQAId" Text='<%#Eval("TaskForwardedToQAId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblProjectId" Text='<%#Eval("ProjectId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblAllocationId" Text='<%#Eval("AllocationId").ToString() %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Project" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProject_Name" runat="server" Text='<%# Eval("Project_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Point" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Allocated By" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblallocatedByEmp_Name" runat="server" Text='<%# Eval("allocatedByEmp_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Allocated To" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblallocatedToEmp_Name" runat="server" Text='<%# Eval("allocatedToEmp_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QA Status" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQAStatusId" runat="server" Text='<%# Eval("QAStatusId").ToString() == "1" ? "Yes" : "No" %>' Font-Bold="true"
                                                            ForeColor='<%#Eval("QAStatus").ToString() == "True" ? System.Drawing.Color.Green : 
                                                                                       Eval("QAStatus").ToString() == "False" ? System.Drawing.Color.Red : 
                                                                                       System.Drawing.Color.Black %>'>></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Total Test Cases" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotalTestCase" runat="server" Text='<%# Eval("TotalTestCase") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Passed Test Cases" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPassTestCase" runat="server" Text='<%# Eval("PassTestCase") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Failed Test Cases" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFailTestCase" runat="server" Text='<%# Eval("FailTestCase") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action" ItemStyle-Width="180px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="linkedit" runat="server" CommandArgument='<%# Eval("TaskForwardedToQAId") %>' OnClientClick="return confirm('Are you sure you want to edit this requirement?');" CommandName="RecordEdit" ToolTip="Edit" CssClass="btn btn-info btn-sm"><i class="fa fa-edit"></i></asp:LinkButton>
                                                        <%--<asp:LinkButton ID="linkdelete" runat="server" CommandArgument='<%# Eval("AllocationId") %>' OnClientClick="return confirm('Are you sure you want to delete this requirement?');" CommandName="RecordDelete" ToolTip="Delete" CssClass="btn btn-danger btn-sm"><i class="fa fa-trash"></i></asp:LinkButton>--%>
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        function sanitizeInput(el) {
            let val = el.value;
            val = val.replace(/[^0-9]/g, '');
            val = val.replace(/^0+/, '');
            if (val.length > 4) {
                val = val.slice(0, 4);
            }
            el.value = val;
        }
        function validateTestCases() {
            var ddlStatus = document.getElementById('<%= ddlStatus.ClientID %>');
            var statusValue = ddlStatus.value;

            if (statusValue === "1") {
                var totalTestCaseEl = document.getElementById('<%= txtTotalTestCase.ClientID %>');
                var passTestCaseEl = document.getElementById('<%= txtPassTestCase.ClientID %>');
                var failTestCaseEl = document.getElementById('<%= txtFailTestCase.ClientID %>');

                var totalTestCase = totalTestCaseEl.value.trim();
                var passTestCase = passTestCaseEl.value.trim();
                var failTestCase = failTestCaseEl.value.trim();

                var errorMsg = "";

                if (!totalTestCase) errorMsg += "Please fill Total Test Cases.\n";
                if (!passTestCase) errorMsg += "Please fill Pass Test Cases.\n";
                if (!failTestCase) errorMsg += "Please fill Fail Test Cases.\n";

                if (errorMsg) {
                    alert(errorMsg);
                    if (!totalTestCase) totalTestCaseEl.focus();
                    else if (!passTestCase) passTestCaseEl.focus();
                    else failTestCaseEl.focus();
                    return false;
                }

                var total = parseInt(totalTestCase, 10);
                var pass = parseInt(passTestCase, 10);
                var fail = parseInt(failTestCase, 10);

                if (isNaN(total) || total <= 0) {
                    alert("Total Test Cases must be a number greater than 0.");
                    totalTestCaseEl.focus();
                    return false;
                }
                if (isNaN(pass) || pass < 0) {
                    alert("Pass Test Cases must be a number 0 or greater.");
                    passTestCaseEl.focus();
                    return false;
                }
                if (isNaN(fail) || fail < 0) {
                    alert("Fail Test Cases must be a number 0 or greater.");
                    failTestCaseEl.focus();
                    return false;
                }

                if (pass === 0 && fail === 0) {
                    alert("Either Pass Test Cases or Fail Test Cases must be greater than 0.");
                    passTestCaseEl.focus();
                    return false;
                }

                if ((pass + fail) !== total) {
                    alert("Sum of Pass and Fail Test Cases must be exactly equal to Total Test Cases.");
                    failTestCaseEl.focus();
                    return false;
                }
            }
            return true;
        }
    </script>
</asp:Content>


