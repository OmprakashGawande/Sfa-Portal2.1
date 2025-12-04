<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="ProjectPlan.aspx.cs" Inherits="mis_Transaction_ProjectPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .fs-badge {
            border: 1px dashed #cbd5e1;
            padding: 1rem;
            border-radius: 8px;
            margin: 1rem 0;
        }

            .fs-badge .legend-badge {
                display: inline-block;
                padding: 0.25rem 0.6rem;
                font-size: 0.85rem;
                border-radius: 999px;
                background: #eef2ff;
                color: #3730a3;
                font-weight: 600;
                border: 1px solid rgba(55,48,163,0.08);
            }

        /* make legend text scale a little on small screens */
        @media (max-width: 480px) {
            .fs-simple legend,
            .fs-overlap legend,
            .fs-badge .legend-badge {
                font-size: 0.82rem;
                padding-left: 0.4rem;
                padding-right: 0.4rem;
            }
        }
        /* prefer reduced motion for users who requested it */
        @media (prefers-reduced-motion: reduce) {
            .fs-overlap legend {
                transition: none;
            }
        }
    </style>
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
                        <h4>Project Plan</h4>

                    </div>
                    <div class="card-body">
                        <fieldset class="fs-badge">
                            <legend><span class="legend-badge">Project Detail</span></legend>
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
                                        <asp:DropDownList runat="server" ID="ddlProject"  CssClass="form-select select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <%--<span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvClientName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Client Name."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Client Name.'></i>"
                                                ControlToValidate="txtClientName"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>--%>
                                        <label runat="server">Client Name</label>
                                        <asp:TextBox autocomplete="off" ID="txtClientName" runat="server" placeholder="Enter Client Name" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <%--<span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvProjectId"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Project ID."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Project ID.'></i>"
                                                ControlToValidate="txtProjectId"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>--%>
                                        <label runat="server">Project ID<%--<span style="color: red;">*</span>--%></label>
                                        <asp:TextBox autocomplete="off" ID="txtProjectId" runat="server" placeholder="Enter Project ID" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvFromDate"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Project Start Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Project Start Date.'></i>"
                                                ControlToValidate="txtProjectStartDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Project Start Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtProjectStartDate" runat="server"
                                            placeholder="DD/MM/YYYY" autocomplete="off"
                                            CssClass="form-control datetime-local" />
                                    </div>
                                </div>

                                <!-- To Date -->
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvToDate"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Project End Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Project End Date.'></i>"
                                                ControlToValidate="txtProjectEndDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Project End Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtProjectEndDate" runat="server"
                                            placeholder="DD/MM/YYYY" autocomplete="off"
                                            CssClass="form-control datetime-local" />
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="fs-badge">
                            <legend><span class="legend-badge">Project Plan</span></legend>
                            <div class="row g-3">
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvPhaseTaskName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Phase/Task Name."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Phase/Task Name.'></i>"
                                                ControlToValidate="txtTaskName"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Phase/Task Name<span style="color: red;">*</span></label>
                                        <asp:TextBox autocomplete="off" ID="txtTaskName" runat="server" placeholder="Enter Phase/Task Name" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvDetailedDescription"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Detailed Description/Deliverable."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Detailed Description/Deliverable.'></i>"
                                                ControlToValidate="txtDetailedDescription"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Detailed Description/Deliverable<span style="color: red;">*</span></label>
                                        <asp:TextBox autocomplete="off" TextMode="MultiLine" MaxLength="100" ID="txtDetailedDescription" runat="server" placeholder="Enter Detailed Description/Deliverable" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="c"
                                                ErrorMessage="Select" ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Select Role'></i>"
                                                ControlToValidate="ddlRole" Display="Dynamic" runat="server" InitialValue="0">
                                            </asp:RequiredFieldValidator>
                                        </span>
                                        <label>Role <span style="color: red;">*</span></label>
                                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control select2">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <%-- <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Enter Phase/Task Name."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Enter Phase/Task Name.'></i>"
                                                ControlToValidate="txtTaskName"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>--%>
                                        <label runat="server">Manpower Count</label>
                                        <asp:TextBox autocomplete="off" ID="txtManpowerCount" runat="server" placeholder="Enter Manpower Count" CssClass="form-control" oninput="validateManpowerCount(this)"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="rfvEmployeeName"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Assign Resource."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Assign Resource.'></i>"
                                                ControlToValidate="ddlEmployee"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label runat="server">Assign Resource<span style="color: red;">*</span></label>
                                        <asp:ListBox ID="ddlEmployee" runat="server" SelectionMode="Multiple" multiselect-search="true" multiselect-select-all="true" multiselect-max-items="3" CssClass="form-control" Height="150px"></asp:ListBox>

                                        <%--<asp:DropDownList runat="server" ID="ddlEmployee" AutoPostBack="true" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" CssClass="form-select select2">
                                        </asp:DropDownList>--%>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select Start Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select Start Date.'></i>"
                                                ControlToValidate="txtTaskStartDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>Start Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtTaskStartDate" runat="server"
                                            placeholder="DD/MM/YYYY" autocomplete="off"
                                            CssClass="form-control datetime-local" />
                                    </div>
                                </div>

                                <!-- To Date -->
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">
                                        <span class="fa-pull-right">
                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator3"
                                                ValidationGroup="Save"
                                                ErrorMessage="Please Select End Date."
                                                ForeColor="Red"
                                                Text="<i class='fa fa-exclamation-circle' title='Please Select End Date.'></i>"
                                                ControlToValidate="txtTaskEndDate"
                                                Display="Dynamic"
                                                runat="server" />
                                        </span>
                                        <label>End Date<span style="color: red;">*</span></label>
                                        <asp:TextBox ID="txtTaskEndDate" runat="server"
                                            placeholder="DD/MM/YYYY" autocomplete="off"
                                            CssClass="form-control datetime-local" />
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Duration(Days)</label>
                                        <asp:TextBox autocomplete="off" ID="txtDuration" runat="server" placeholder="Enter Duration" Enabled="false" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Dependencies(in short)</label>
                                        <asp:TextBox autocomplete="off" ID="txtDependencies" runat="server" placeholder="Enter Dependencies" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Status</label>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control select2">
                                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Completed" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="In Progress" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Not Started" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
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
                                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="High" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Medium" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Low" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Completed(%)</label>
                                        <%--<asp:TextBox autocomplete="off" ID="txtCompleted" runat="server" placeholder="Enter Completed" CssClass="form-control"></asp:TextBox>--%>
                                        <asp:TextBox autocomplete="off" ID="txtCompleted" runat="server"
                                            placeholder="Enter Completed"
                                            CssClass="form-control"
                                            onkeypress="return isNumberKey(event)"
                                            oninput="limitPercent(this)">
                                        </asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Planned Milestone</label>
                                        <asp:TextBox autocomplete="off" ID="txtPlannedMilestone" runat="server" placeholder="Enter Planned Milestone" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Risk/Issue(if any)</label>
                                        <asp:TextBox autocomplete="off" ID="txtRiskIssue" runat="server" placeholder="Enter Risk/Issue" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-sm-6 position-relative">
                                    <div class="form-group">

                                        <label runat="server">Action Required</label>
                                        <asp:TextBox autocomplete="off" ID="txtActionRequired" runat="server" placeholder="Enter Action Required" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <hr />

                            <div class="col-xl-3" runat="server">
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                    <a href="ProjectPlan.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>

                <%--grid--%>
                <div class="card border-warning">
                    <div class="card-header">
                        <h4>Project Plan Detail</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvProjectPlan"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="ProjectPlanID">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                    <asp:Label runat="server" ID="lblProject_ID" Text='<%#Eval("Project_Id").ToString() %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectName" runat="server" Text='<%# Eval("ProjectName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblClientName" runat="server" Text='<%# Eval("ClientName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project ID" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectID" runat="server" Text='<%# Eval("ProjectID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project Start Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectStartDate" runat="server" Text='<%# Eval("ProjectStartDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project End Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectEndDate" runat="server" Text='<%# Eval("ProjectEndDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Phase/Task Name" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhaseTaskName" runat="server" Text='<%# Eval("PhaseTaskName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Detailed Description/Deliverable" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhaseTaskName" runat="server" Text='<%# Eval("DetailedDescription") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRole" runat="server" Text='<%# Eval("Role") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Manpower Count" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblManpowerCount" runat="server" Text='<%# Eval("ManpowerCount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Assign Resource" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssignResource" runat="server" Text='<%# Eval("EmployeeNames") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Start Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="End Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("EndDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Duration(Days)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDurationDays" runat="server" Text='<%# Eval("DurationDays") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dependencies(in short)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDependencies" runat="server" Text='<%# Eval("Dependencies") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Priority" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPriority" runat="server" Text='<%# Eval("Priority") %>'></asp:Label>
                                                    <%-- <asp:Label ID="lblPriorityType" runat="server" Text='<%# Eval("PriorityType") %>' Font-Bold="true"
                                                        ForeColor='<%#Eval("PriorityTypeId").ToString() == "1" ? System.Drawing.Color.Red : 
                                                                     Eval("PriorityTypeId").ToString() == "2" ? System.Drawing.Color.Orange : 
                                                                     System.Drawing.Color.Black %>'></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Completed(%)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCompletedPercent" runat="server" Text='<%# Eval("CompletedPercent") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Planned Milestone" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPlannedMilestone" runat="server" Text='<%# Eval("PlannedMilestone") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Risk/Issue(if any)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRiskIssue" runat="server" Text='<%# Eval("RiskIssue") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action Required" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActionRequired" runat="server" Text='<%# Eval("ActionRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action" ItemStyle-Width="180px">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="linkedit" runat="server" CommandArgument='<%# Eval("ProjectPlanID") %>' OnClientClick="return confirm('Are you sure you want to edit this requirement?');" CommandName="RecordEdit" ToolTip="Edit" CssClass="btn btn-info btn-sm"><i class="fa fa-edit"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="linkdelete" runat="server" CommandArgument='<%# Eval("ProjectPlanID") %>' OnClientClick="return confirm('Are you sure you want to delete this requirement?');" CommandName="RecordDelete" ToolTip="Delete" CssClass="btn btn-danger btn-sm"><i class="fa fa-trash"></i></asp:LinkButton>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">

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

        document.addEventListener("DOMContentLoaded", function () {
            var fromDate = document.getElementById("<%= txtProjectStartDate.ClientID %>");
            var toDate = document.getElementById("<%= txtProjectEndDate.ClientID %>");

            function parseDate(str) {
                // dd/MM/yyyy
                var parts = str.split("/");
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }

            fromDate.addEventListener("change", function () {
                toDate.value = "";
            });

            toDate.addEventListener("change", function () {
                if (fromDate.value && toDate.value) {
                    var fDate = parseDate(fromDate.value);
                    var tDate = parseDate(toDate.value);

                    if (tDate.getTime() < fDate.getTime()) {
                        alert("To Date cannot be earlier than Project Start Date!");
                        toDate.value = "";
                    }
                    else if (tDate.getTime() === fDate.getTime()) {
                        alert("To Date cannot be equal to Project Start Date!");
                        toDate.value = "";
                    }
                }
            });
        });

        document.addEventListener("DOMContentLoaded", function () {
            var TaskfromDate = document.getElementById("<%= txtTaskStartDate.ClientID %>");
            var TasktoDate = document.getElementById("<%= txtTaskEndDate.ClientID %>");
            var Duration = document.getElementById("<%= txtDuration.ClientID %>");

            // Disable duration field
            Duration.readOnly = true;

            function parseDate(str) {
                // Convert dd/MM/yyyy to JS Date
                var parts = str.split("/");
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }

            // Reset To Date when From Date changes
            TaskfromDate.addEventListener("change", function () {
                TasktoDate.value = "";
                Duration.value = "";
            });

            // On To Date change, validate and calculate duration
            TasktoDate.addEventListener("change", function () {
                if (TaskfromDate.value && TasktoDate.value) {
                    var fDate = parseDate(TaskfromDate.value);
                    var tDate = parseDate(TasktoDate.value);

                    if (tDate.getTime() < fDate.getTime()) {
                        alert("End Date cannot be earlier than Start Date!");
                        TasktoDate.value = "";
                        Duration.value = "";
                    }
                    else if (tDate.getTime() === fDate.getTime()) {
                        alert("End Date cannot be equal to Start Date!");
                        TasktoDate.value = "";
                        Duration.value = "";
                    }
                    else {
                        // Calculate difference in days
                        var diffTime = tDate.getTime() - fDate.getTime();
                        var diffDays = diffTime / (1000 * 3600 * 24);
                        Duration.value = diffDays;
                    }
                }
            });
        });

        function validateManpowerCount(input) {
            input.value = input.value.replace(/[^0-9]/g, '');

            // Limit to maximum 2 digits
            if (input.value.length > 2) {
                input.value = input.value.slice(0, 2);
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function limitPercent(input) {
            let val = parseFloat(input.value);
            if (isNaN(val)) return;
            if (val > 100) input.value = 100;
            if (val < 0) input.value = 0;
        }
    </script>
    <script>
        $(document).ready(function () {
            initCustomDataTable('.datatable', 'Project Plan Detail', 'Project Plan Detail', [20]);
        });
    </script>
</asp:Content>

