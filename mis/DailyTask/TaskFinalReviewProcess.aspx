<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskFinalReviewProcess.aspx.cs" Inherits="mis_DailyTask_TaskFinalReviewProcess" %>

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
                            <h4>Requirement Audit Team Review</h4>
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

                                <div class="col-xl-6 col-sm-6 position-relative">
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
                                        <label runat="server">Requirement Point Done By Project Manager<span style="color: red;">*</span></label>
                                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlTaskName_SelectedIndexChanged" runat="server" ID="ddlTaskName" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvStatus"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Status"
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Status.'></i>"
                                                ControlToValidate="ddlStatus"
                                                InitialValue="0"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Audit Status<span style="color: red;">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <%--grid--%>
                            <div class="row" id="dvAllocatedDetails" runat="server">
                                <div class="table-responsive dt-ext ">
                                    <hr />
                                    <div class="col-md-12">
                                        <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvAllocatedRequirements" CssClass="table table-bordered table-hover">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Employee" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmployee_Name" runat="server" Text='<%# Eval("Employee_Name") %>'></asp:Label>
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
                                                <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDescription" runat="server" Text='<%# Eval("TaskDescription") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Priority" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPriorityType" runat="server" Text='<%# Eval("PriorityType") %>' Font-Bold="true"
                                                            ForeColor='<%#Eval("PriorityTypeId").ToString() == "1" ? System.Drawing.Color.Red : 
               Eval("PriorityTypeId").ToString() == "2" ? System.Drawing.Color.Orange : 
               System.Drawing.Color.Black %>'>></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Allocation Date" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAllocationDate" runat="server" Text='<%# Eval("AllocationDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requirement Duration" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDuration" runat="server" Text='<%# Eval("TaskDuration") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Assigned By" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAssignedBy" runat="server" Text='<%# Eval("AssignedBy") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Reviewed By QA" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmployee_Name_QA" runat="server" Text='<%# Eval("Employee_Name_QA") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Reviewed By Project Manager" ItemStyle-CssClass="center-grid">
                                                         <ItemTemplate>
                                                             <asp:Label ID="lblPmReviewBy" runat="server" Text='<%# Eval("PmReviewBy") %>'></asp:Label>
                                                         </ItemTemplate>
                                                     </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                            <hr />

                            <div class="row">
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" ValidationGroup="Save" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                                        <a href="TaskFinalReviewProcess.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

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
                                            CssClass="table table-bordered table-hover" DataKeyNames="FinalReviewId">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                        <asp:Label runat="server" ID="lblFinalReviewId" Text='<%#Eval("FinalReviewId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblProjectId" Text='<%#Eval("ProjectId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblAllocationId" Text='<%#Eval("AllocationId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblTaskStatusId" Text='<%#Eval("TaskStatusId").ToString() %>' Visible="false"></asp:Label>
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
                                                <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblallocatedByEmp_Name" runat="server" Text='<%# Eval("TaskStatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QA Status" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQAStatusId" runat="server" Text='<%# Eval("TaskStatus").ToString() %>' Font-Bold="true"
                                                            ForeColor='<%#Eval("TaskStatusId").ToString() == "1" ? System.Drawing.Color.Green : 
                                                                                       Eval("TaskStatusId").ToString() == "2" ? System.Drawing.Color.Orange : 
                                                                                       Eval("TaskStatusId").ToString() == "3" ? System.Drawing.Color.Red : 
                                                                                       System.Drawing.Color.Black %>'>></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action" ItemStyle-Width="180px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="linkedit" runat="server" CommandArgument='<%# Eval("FinalReviewId") %>' OnClientClick="return confirm('Are you sure you want to edit this requirement?');" CommandName="RecordEdit" ToolTip="Edit" CssClass="btn btn-info btn-sm"><i class="fa fa-edit"></i></asp:LinkButton>
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
</asp:Content>



