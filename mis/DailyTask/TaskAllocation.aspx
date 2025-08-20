<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskAllocation.aspx.cs" Inherits="mis_DailyTask_TaskAllocation" %>

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
                            <h4>Requirement Allocation</h4>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
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
                                        <label runat="server">Allocation to<span style="color: red;">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlEmployee" AutoPostBack="true" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

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
                                        <asp:DropDownList runat="server" ID="ddlProject" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvAllocationDate"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Allocation Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Allocation Date.'></i>"
                                                ControlToValidate="txtAllocationDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Allocation Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtAllocationDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                            data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control datetime-local" />
                                    </div>
                                </div>

                                <div class="col-xl-2 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvAllocationTime"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Requirement Duration."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Requirement Duration.'></i>"
                                                ControlToValidate="txtAllocationTime"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Requirement Duration<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtAllocationTime" placeholder="HH:MM" runat="server" CssClass="form-control" autocomplete="off" />
                                    </div>
                                </div>

                                <div class="col-xl-12 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvTaskName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Requirement Point."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Requirement Point.'></i>"
                                                ControlToValidate="txtTaskName"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Requirement Point<span style="color: red;">*</span></label>
                                        <asp:TextBox autocomplete="off" MaxLength="200" oninput="sanitizeInput(this)" ID="txtTaskName" runat="server" placeholder="Enter Requirement Point" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-xl-2 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvPriorityType"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Priority."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Priority.'></i>"
                                                ControlToValidate="ddlPriorityType"
                                                InitialValue="0"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Priority<span style="color: red;">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlPriorityType" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-2 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <label runat="server">
                                            QA
                                        </label>
                                        <asp:DropDownList runat="server" ID="ddlQA" CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-xl-8 col-sm-9 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvTaskDescription"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Description."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Task Description.'></i>"
                                                ControlToValidate="txtTaskDescription"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Description <span style="color: red;">*</span></label>
                                        <textarea
                                            autocomplete="off"
                                            maxlength="2000"
                                            oninput="sanitizeInput(this)"
                                            id="txtTaskDescription"
                                            runat="server"
                                            class="form-control"
                                            rows="2" placeholder="Enter Description"></textarea>
                                        <asp:Label runat="server" ForeColor="Red" ID="lblCounter"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-outline-success" ValidationGroup="Save" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                                        <a href="TaskAllocation.aspx" style="margin-top: 22px;" class="btn btn-block   btn-outline-danger">Clear</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <%--grid--%>
                    <div class="card border-warning" runat="server" id="dvAllocatedRequirements">
                        <div class="card-header">
                            <h4>Requirements already allocated by other managers to <asp:Label runat="server" ID="lblEmployeeName"></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <div class="row" style="padding: 0px 9px 2px 15px;" id="div2" runat="server">
                                <div class="table-responsive dt-ext ">
                                    <div class="col-md-12">
                                        <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvAllocatedRequirements" CssClass="table table-bordered table-hover" >
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
                                                <asp:TemplateField HeaderText="Requirement Point" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
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
                                                <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDescription" runat="server" Text='<%# Eval("TaskDescription") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QA" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmployee_Name_QA" runat="server" Text='<%# Eval("Employee_Name_QA") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%--grid--%>
                    <div class="card border-warning">
                        <div class="card-header">
                            <h4>Allocated Requirements</h4>
                        </div>
                        <div class="card-body">
                            <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                                <div class="table-responsive dt-ext ">
                                    <div class="col-md-12">
                                        <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvTaskDetails" OnRowCommand="gvTaskDetails_RowCommand"
                                            CssClass="table table-bordered table-hover" DataKeyNames="AllocationId">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                        <asp:Label runat="server" ID="lblAllocationId" Text='<%#Eval("AllocationId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblEmp_ID" Text='<%#Eval("Emp_ID").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblProject_ID" Text='<%#Eval("Project_ID").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblAllocationTime" Text='<%#Eval("AllocationTime").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblPriorityTypeId" Text='<%#Eval("PriorityTypeId").ToString() %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" ID="lblEmployeeId_QA" Text='<%#Eval("EmployeeId_QA").ToString() %>' Visible="false"></asp:Label>
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
                                                <asp:TemplateField HeaderText="Requirement Point" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
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
                                                <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDescription" runat="server" Text='<%# Eval("TaskDescription") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QA" ItemStyle-CssClass="center-grid">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmployee_Name_QA" runat="server" Text='<%# Eval("Employee_Name_QA") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action" ItemStyle-Width="180px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="linkedit" runat="server" CommandArgument='<%# Eval("AllocationId") %>' OnClientClick="return confirm('Are you sure you want to edit this requirement?');" CommandName="RecordEdit" ToolTip="Edit" CssClass="btn btn-info btn-sm"><i class="fa fa-edit"></i></asp:LinkButton>
                                                        <asp:LinkButton ID="linkdelete" runat="server" CommandArgument='<%# Eval("AllocationId") %>' OnClientClick="return confirm('Are you sure you want to delete this requirement?');" CommandName="RecordDelete" ToolTip="Delete" CssClass="btn btn-danger btn-sm"><i class="fa fa-trash"></i></asp:LinkButton>
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
        document.addEventListener('DOMContentLoaded', function () {
            flatpickr("#<%= txtAllocationTime.ClientID %>", {
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",       // 24-hour format, like 01:30
                time_24hr: true,
                minuteIncrement: 6,      // 0.1 hour = 6 minutes step
                defaultHour: 0,
                minTime: "00:06",        // minimum 6 minutes (0.1 hour)
                maxTime: "09:00",        // maximum 9 hours
                disableMobile: "true"    // force desktop version on mobile for consistent UI
            });
            flatpickr(".datetime-local", {
                dateFormat: "d/m/Y",
                minDate: "today",
                enableTime: false,
            });
        });

        function sanitizeInput(el) {
            let val = el.value;
            val = val.replace(/[^a-zA-Z0-9 ,.!()-/&]/g, '');
            val = val.replace(/\s+/g, ' ');
            val = val.trimStart();
            el.value = val;
        }
    </script>
</asp:Content>


