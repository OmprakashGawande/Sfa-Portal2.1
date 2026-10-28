<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="MstProject.aspx.cs" Inherits="mis_Master_MstProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        #txtDiscription {
            width: 100%;
            min-height: calc(1.5em * 2 + 1rem); /* roughly 2 rows line height + padding */
            padding: 0.5rem 0.75rem;
            font-size: 1rem;
            line-height: 1.5;
            border: 1px solid #ced4da;
            border-radius: 0.375rem;
            resize: none; /* prevent manual resize */
            overflow-y: hidden; /* hide scrollbar */
            box-sizing: border-box;
            font-family: inherit;
            transition: border-color 0.2s ease;
        }

        #txtDiscription {
            border-color: #5c6ac4;
            outline: none;
            box-shadow: 0 0 0 3px rgba(92, 106, 196, 0.3);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">

    <div class="content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header">
                            <h3 class="box-title" style="margin-left: 2rem;">Project Master</h3>
                        </div>
                        <hr />
                        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                        <div class="box-body">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator ID="RFV1" ValidationGroup="a"
                                                        ErrorMessage="Select To Date" ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Enter Project Name !'></i>"
                                                        ControlToValidate="txtProjectName" Display="Dynamic" runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                                <label runat="server">PROJECT NAME <span style="color: red;">*</span></label>
                                                <asp:TextBox runat="server" ID="txtProjectName" placeholder="Enter Project Name" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator ID="RFV2" ValidationGroup="a"
                                                        ErrorMessage="Select To Date" ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Select Technology!'></i>"
                                                        ControlToValidate="ddlTechnology" InitialValue="0" Display="Dynamic" runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                                <label runat="server">TECHNOLOGY <span style="color: red;">*</span></label>
                                                <%--<asp:DropDownList runat="server" ID="ddlTechnology" ClientIDMode="Static"
                                                    CssClass="form-control select2">
                                                </asp:DropDownList>--%>
                                                <asp:ListBox ID="ddlTechnology" runat="server" ClientIDMode="Static" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator ID="RFV3" ValidationGroup="a"
                                                        ErrorMessage="Select To Date" ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Select TYPE OF PROJECT!'></i>"
                                                        ControlToValidate="ddlTypeofProject" InitialValue="0" Display="Dynamic" runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                                <label runat="server">TYPE OF PROJECT <span style="color: red;">*</span></label>
                                                <asp:DropDownList runat="server" ID="ddlTypeofProject"
                                                    CssClass="form-control select2">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator ID="rfv4" ValidationGroup="a"
                                                        ErrorMessage="Select Incharge Name" ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Select Incharge Name!'></i>"
                                                        ControlToValidate="ddlOwner" InitialValue="0" Display="Dynamic" runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                                <%-- old name Owner --%>
                                                <label runat="server">INCHARGE <span style="color: red;">*</span></label>
                                                <asp:DropDownList runat="server" ID="ddlOwner" ClientIDMode="Static"
                                                    CssClass="form-control select2">
                                                </asp:DropDownList>
                                            </div>
                                        </div>


                                    </div>
                                    <div class="row">

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator5"
                                                        ValidationGroup="a"
                                                        ErrorMessage="Select Start Date"
                                                        ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Select Work Start Date'></i>"
                                                        ControlToValidate="txtWorkOrderDate"
                                                        Display="Dynamic"
                                                        runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>

                                                <label>WORK START DATE  <span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtWorkOrderDate" runat="server"
                                                    data-provide="datepicker" placeholder="DD/MM/YYYY"
                                                    autocomplete="off" data-date-format="dd/mm/yyyy"
                                                    data-date-autoclose="true" CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator6"
                                                        ValidationGroup="a"
                                                        ErrorMessage="Select Start Date"
                                                        ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Select Target Date of Complition'></i>"
                                                        ControlToValidate="txtComplitionDate"
                                                        Display="Dynamic"
                                                        runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>

                                                <label>TARGET DATE OF COMPLITION <span style="color: red;">*</span></label>
                                                <asp:TextBox ID="txtComplitionDate" runat="server"
                                                    data-provide="datepicker" placeholder="DD/MM/YYYY"
                                                    autocomplete="off" data-date-format="dd/mm/yyyy"
                                                    data-date-autoclose="true" CssClass="form-control" />
                                            </div>
                                        </div>

                                        <div class="col-md-6">

                                            <div class="form-group">

                                                <span class="fa-pull-right">
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator7"
                                                        ValidationGroup="a"
                                                        ErrorMessage="Enter Description"
                                                        ForeColor="Red"
                                                        Text="<i class='fa fa-exclamation-circle' title='Enter Description!'></i>"
                                                        ControlToValidate="txtDiscription"
                                                        Display="Dynamic"
                                                        runat="server">
                                                    </asp:RequiredFieldValidator>
                                                </span>
                                                <label>DESCRIPTION<span style="color: red;"> *</span></label>
                                                <textarea
                                                    id="txtDiscription"
                                                    runat="server"
                                                    class="form-control"
                                                    oninput="autoResizeTextarea(this)"
                                                    rows="2" placeholder="Enter Description"></textarea>
                                                <asp:Label runat="server" ForeColor="Red" ID="lblCounter"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <asp:Button runat="server" Style="margin-top: 22px;" CssClass="btn btn-block btn-success" ID="btnSave1" Text="Save" ValidationGroup="a" OnClick="btnSave1_Click" />
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <a href="MstProject.aspx" style="margin-top: 22px;" class="btn btn-block btn-default">Clear</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr />

                            <%--grid--%>
                            <div class="card">
                                <div>
                                    <h4 style="margin-left: 2rem;">Project Detail</h4>
                                </div>
                                <hr />
                                <div class="card-body">
                                    <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">


                                        <div class="table-responsive">
                                            <div class="col-md-12">
                                                <asp:GridView ID="Grid" PageSize="50" runat="server" class="datatable  table table-hover table-bordered pagination-ys" ShowHeaderWhenEmpty="false" AutoGenerateColumns="False" OnRowCommand="Grid_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("ProjectId").ToString() %>' runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PROJECT NAME">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblProjectName" Text='<%# Eval("ProjectName").ToString() %>' runat="server" />
                                                                <asp:Label Visible="false" ID="lblTypeOfProjectId" Text='<%# Eval("TypeOfProjectId") %>' runat="server"></asp:Label>
                                                                <asp:Label Visible="false" ID="lblTechnologyId" Text='<%# Eval("TechnologyId") %>' runat="server"></asp:Label>

                                                                <asp:TextBox runat="server" ID="txtProjectName" AutoComplete="off" Text="Text Project Name" Visible="false"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="TECHNOLOGY ">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTechnologyName" Text='<%# Eval("TechnologyName").ToString() %>' runat="server" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="TYPE OF PROJECT ">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTypeOfProject" Text='<%# Eval("TypeOfProjectName").ToString() %>' runat="server" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="INCHARGE NAME ">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOwnerName" Text='<%# Eval("OwnerName").ToString() %>' runat="server" />
                                                                <asp:Label ID="lblOwnerId" Text='<%# Eval("OwnerId").ToString() %>' runat="server" Visible="false" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="WORK START DATE">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWorkOrderDate" Text='<%# Eval("WorkOrderDate").ToString() %>' runat="server" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="TARGET DATE OF COMPLITION">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblComplitionDate" Text='<%# Eval("ComplitionDate").ToString() %>' runat="server" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DESCRIPTION ">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDiscription" Text='<%# Eval("Discription").ToString() %>' runat="server" />

                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="30" HeaderText="STATUS">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkStatus"
                                                                    runat="server"
                                                                    CommandArgument='<%# Eval("ProjectId").ToString() %>'
                                                                    CssClass='<%# Eval("IsActive").ToString() == "True" ? "label label-success" : "label label-danger" %>'
                                                                    CausesValidation="False"
                                                                    CommandName="ChangeStatus"
                                                                    Text='<%# Eval("IsActive").ToString() == "True" ? "Active" : "Deactive" %>'
                                                                    Enabled='<%# Eval("IsTeamLead").ToString() != "1" %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="30px"></ItemStyle>
                                                        </asp:TemplateField>

                                                        <%--   <asp:TemplateField HeaderText="ADD MANPOWER">
                                                            <ItemTemplate>
                                                                <button type="button" class="label label-success" data-toggle="modal" data-target="#exampleModal">
                                                                    ADD 
                                                                </button>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="ADD MODULE">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="btnAddModule"
                                                                    runat="server"
                                                                    Text="Add"
                                                                    CssClass="label label-success"
                                                                    CommandName="AddModule"
                                                                    CommandArgument='<%# Eval("ProjectId") %>'
                                                                    />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="ADD MANPOWER">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="btnAddManpower"
                                                                    runat="server"
                                                                    Text="Add"
                                                                    CssClass="label label-success"
                                                                    CommandName="AddManpower"
                                                                    CommandArgument='<%# Eval("ProjectId") %>'
                                                                    Visible='<%# Eval("IsTeamLead").ToString() != "1" %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>


                                                        <asp:TemplateField HeaderText="ADD TASK">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="btnTask"
                                                                    runat="server"
                                                                    Text="Add"
                                                                    CssClass="label label-success"
                                                                    CommandName="AddTask"
                                                                    CommandArgument='<%# Eval("ProjectId") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                <asp:LinkButton
                                                                    ID="lnkEdit"
                                                                    runat="server"
                                                                    CssClass="label label-default"
                                                                    CommandArgument='<%# Eval("ProjectId").ToString() %>'
                                                                    CausesValidation="False"
                                                                    CommandName="EditRecord"
                                                                    Text="Edit"
                                                                    Visible='<%# Eval("IsTeamLead").ToString() != "1" %>' />
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
            <!-- Bootstrap Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLongTitle">Add Man Power</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="card">
                            <asp:Label runat="server" ID="lblMsgManPower" Text=""></asp:Label>
                            <div class="card-body fa-border">
                                <!-- Modal Body -->
                                <div class="modal-body">
                                    <asp:HiddenField ID="HiddenProjectID" runat="server" />
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row">

                                                <div class="col-md-3">
                                                    <div class="form-group ms">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator10"
                                                                ValidationGroup="b"
                                                                ErrorMessage="Select Employee Name"
                                                                ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Developer Name!'></i>"
                                                                ControlToValidate="ddlEmployee"
                                                                Display="Dynamic"
                                                                runat="server" InitialValue="0">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <label>EMPLOYEE <span style="color: red;">*</span></label>
                                                        <div class="ms form-group">

                                                            <asp:DropDownList ID="ddlEmployee" runat="server" AutoPostBack="true" CssClass="form-control select2" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group ms">
                                                        <label>TEAM LEAD</label>
                                                        <div class="ms form-group">
                                                            <asp:DropDownList ID="ddlTeamLead" runat="server" CssClass="form-control select2">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">

                                                    <div class="form-group ms">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator12"
                                                                ValidationGroup="b"
                                                                ErrorMessage="Select Role "
                                                                ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Role !'></i>"
                                                                ControlToValidate="ddlRole"
                                                                Display="Dynamic"
                                                                runat="server" InitialValue="0">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <label>ROLE <span style="color: red;">*</span></label>
                                                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control select2">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>CATEGOREY<span style="color: red;"> *</span></label>
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="b"
                                                                ErrorMessage="Select" ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Category'></i>"
                                                                ControlToValidate="ddlWorkCategoryId" Display="Dynamic" runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <asp:ListBox ID="ddlWorkCategoryId" runat="server" ClientIDMode="Static" CssClass="form-control" SelectionMode="Multiple"></asp:ListBox>
                                                        <%--    <asp:DropDownList runat="server" ID="ddlWorkCategoryId" ClientIDMode="Static"
                                                            CssClass="form-control">
                                                        </asp:DropDownList>--%>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator8"
                                                                ValidationGroup="b"
                                                                ErrorMessage="Select Allocation Date"
                                                                ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Allocation Date'></i>"
                                                                ControlToValidate="txtAllocationDate"
                                                                Display="Dynamic"
                                                                runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>

                                                        <label>ALLOCATION DATE <span style="color: red;">*</span></label>
                                                        <asp:TextBox ID="txtAllocationDate"
                                                            runat="server" CssClass="form-control"
                                                            data-provide="datepicker" placeholder="DD/MM/YYYY"
                                                            autocomplete="off" data-date-format="dd/mm/yyyy"
                                                            data-date-autoclose="true" />
                                                    </div>
                                                </div>

                                                <div class="col-md-2 mt-3">
                                                    <div class="form-group">
                                                        <asp:Button runat="server" Style="margin-top: 20px;" CssClass="btn btn-block btn-success" ID="btnAddManPower" Text="Add" OnClick="btnAddManPower_Click" ValidationGroup="b" />
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row">

                                                <div class="col-md-12">
                                                    <hr />
                                                    <h4>Man Power Detail</h4>

                                                    <asp:GridView ID="grdManpower" class="datatable  table table-hover table-bordered pagination-ys" runat="server" AutoGenerateColumns="false" OnRowCommand="grdManpower_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                                            <asp:BoundField DataField="TeamLead" HeaderText="Team Lead" />
                                                            <asp:BoundField DataField="RoleName" HeaderText="Role" />
                                                            <asp:BoundField DataField="WorkCategoreyName" HeaderText="Categorey" />
                                                            <asp:BoundField DataField="AllocationDate" HeaderText="Allocation Date" />
                                                            <asp:TemplateField HeaderText="Delete">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteRow" CommandArgument='<%# Container.DataItemIndex %>' Text="Delete" CssClass="btn btn-danger btn-sm" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="table-responsive">

                                                        <asp:GridView ID="GridManPowerDetail" class="datatable  table table-hover table-bordered pagination-ys" runat="server" AutoGenerateColumns="false" OnRowCommand="GridManPowerDetail_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("MainPowerId").ToString() %>' runat="server" />

                                                                        <asp:Label ID="lblEmpId" Text='<%# Eval("EmpId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblTeamLeadId" Text='<%# Eval("TeamLeadId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblEmpDesignationId" Text='<%# Eval("EmpDesignationId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblCategoreyId" Text='<%# Eval("CategoreyId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblAllocationDate" Text='<%# Eval("AllocationDate").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblProjectIdedit" Text='<%# Eval("ProjectId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                                                <asp:BoundField DataField="TeamLeadName" HeaderText="Team Lead" />
                                                                <asp:BoundField DataField="RoleName" HeaderText="Role" />
                                                                <asp:BoundField DataField="WorkCategory" HeaderText="Category" />
                                                                <asp:BoundField DataField="AllocationDate" HeaderText="Allocation Date" />
                                                                <asp:TemplateField HeaderText="STATUS">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkStatus" runat="server"
                                                                            CommandArgument='<%# Eval("MainPowerId").ToString()%>'
                                                                            CssClass='<%# Eval("IsActive").ToString() =="True" ? "label label-success" : "label label-danger"  %>'
                                                                            CausesValidation="False" CommandName="ChangeStatus"
                                                                            Text='<%# Eval("IsActive").ToString() =="True" ? "Active" : "Deactive"  %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="EDIT">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkEdit" runat="server"
                                                                            CommandArgument='<%# Eval("MainPowerId").ToString() %>'
                                                                            CommandName="EditRow"
                                                                            CssClass="btn btn-primary btn-sm"
                                                                            Text="Edit"
                                                                            Visible='<%# Eval("IsAdmin").ToString() == "1" %>'>
                                                                        </asp:LinkButton>
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
                                <!-- Modal Footer -->
                                <div class="modal-footer">
                                    <asp:Button
                                        ID="btnSaveManPower"
                                        runat="server"
                                        CssClass="btn btn-success"
                                        Text="Save"
                                        OnClick="btnSaveManPower_Click" />
                                    <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-dismiss="modal">
                                        Cancel
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap Modal -->
            <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLongTitle2">Task Detail</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <asp:Label ID="lblMsgTask" runat="server" Text=""></asp:Label>
                        <div class="card">
                            <div class="card-body fa-border">
                                <!-- Modal Body -->
                                <div class="modal-body">
                                    <asp:HiddenField ID="HiddenField1" runat="server" />


                                    <div class="card">
                                        <div class="card-body">

                                            <div class="row">
                                                <%--<div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>PROJECT NAME <span style="color: red;">*</span></label>
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="T"
                                                                ErrorMessage="Select Project Name" InitialValue="0" ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Project !'></i>"
                                                                ControlToValidate="ddlProjectName" Display="Dynamic" runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <asp:DropDownList runat="server" ID="ddlProjectName" ClientIDMode="Static"
                                                            CssClass="form-control">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>--%>
                                                  <div class="col-md-4">
                                                    <div class="form-group">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="T"
                                                                ErrorMessage="Select Module" ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Select Module !'></i>"
                                                                ControlToValidate="ddlModule" InitialValue="0" Display="Dynamic" runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <label>MODULE <span style="color: red;">*</span></label>
                                                        <asp:DropDownList runat="server" ID="ddlModule" ClientIDMode="Static" 
                                                            CssClass="form-control select2">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>PARENT TASK</label>
                                                        <asp:DropDownList runat="server" ID="ddlParentTask" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlParentTask_SelectedIndexChanged"
                                                            CssClass="form-control select2">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="T"
                                                                ErrorMessage="Enter Task Name" ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Enter Task Name !'></i>"
                                                                ControlToValidate="txtTaskName" Display="Dynamic" runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <label>TASK NAME<span style="color: red;"> *</span></label>
                                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Enter Task Name" ID="txtTaskName" onkeypress="javascript:tbx_fnAlphaOnly(event, this);"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">


                                                <div class="col-md-10">
                                                    <div class="form-group">
                                                        <label for="txtTaskDescription">TASK DESCRIPTION<span style="color: red;"> *</span></label>
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator15"
                                                                ValidationGroup="T"
                                                                ErrorMessage="Enter Task Description"
                                                                ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Enter Task Description!'></i>"
                                                                ControlToValidate="txtTaskDescription"
                                                                Display="Dynamic"
                                                                runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <textarea
                                                            id="txtTaskDescription"
                                                            runat="server"
                                                            class="form-control"
                                                            oninput="autoResizeTextarea(this)"
                                                            onkeypress="javascript:tbx_fnAlphaOnly(event, this);"
                                                            placeholder="Enter Task Description"
                                                            rows="2"></textarea>
                                                        <asp:Label runat="server" ForeColor="Red" ID="lblCounter2"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-block btn-success" ID="btnSaveTask" Text="Save" OnClick="btnSaveTask_Click" ValidationGroup="T" />
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <a href="MstProject.aspx" class="btn btn-block btn-default">Clear</a>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col-md-12">

                                                    <asp:GridView ID="GridTaskDetail" class="datatable  table table-hover table-bordered pagination-ys" runat="server" AutoGenerateColumns="false" OnRowCommand="GridTaskDetail_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("TaskId").ToString() %>' runat="server" />
                                                                    <asp:Label ID="lblModuleId" Text='<%# Eval("ModuleId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblParentTaskId" Text='<%# Eval("ParentTaskId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblTaskName" Text='<%# Eval("TaskName").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblTaskDescription" Text='<%# Eval("TaskDescription").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblTaskId" Text='<%# Eval("TaskId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblProjectIdTask" Text='<%# Eval("ProjectId").ToString() %>' runat="server" Visible="false"></asp:Label>

                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="ModuleName" HeaderText="MODULE NAME" />
                                                            <asp:BoundField DataField="ParentTaskName" HeaderText="PARENT TASK NAME" />
                                                            <asp:BoundField DataField="TaskName" HeaderText="TASK NAME" />
                                                            <asp:BoundField DataField="TaskCode" HeaderText="TASK CODE" />
                                                            <%--    <asp:BoundField DataField="WorkCategoryEng" HeaderText="TASK CATEGOERY" />--%>
                                                            <asp:BoundField DataField="TaskDescription" HeaderText="TASK DESCRIPTION" />

                                                            <asp:TemplateField HeaderText="STATUS">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkStatus" runat="server"
                                                                        CommandArgument='<%# Eval("TaskId").ToString()%>'
                                                                        CssClass='<%# Eval("IsActive").ToString() =="True" ? "label label-success" : "label label-danger"  %>'
                                                                        CausesValidation="False" CommandName="ChangeStatus"
                                                                        Text='<%# Eval("IsActive").ToString() =="True" ? "Active" : "Deactive"  %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="EDIT">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                                        CommandArgument='<%# Eval("TaskId").ToString() %>'
                                                                        CommandName="EditRow"
                                                                        CssClass="btn btn-primary btn-sm"
                                                                        Text="Edit">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>

                                    </div>


                                    <!-- Modal Footer -->
                                    <div class="modal-footer">
                                        <%--  <asp:Button
                                        ID="Button2"
                                        runat="server"
                                        CssClass="btn btn-success"
                                        Text="Save"
                                        ValidationGroup="b" />--%>
                                        <button
                                            type="button"
                                            class="btn btn-secondary"
                                            data-dismiss="modal">
                                            Close
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!--  Add Module -->
            <div class="modal fade" id="AddModuleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title" id="exampleModalLongTitle3">Module Detail</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        <div class="card">
                            <div class="card-body fa-border">
                                <!-- Modal Body -->
                                <div class="modal-body">
                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                    <div class="card">
                                        <asp:Label runat="server" ID="lblMsgModule" Text=""></asp:Label>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <span class="fa-pull-right">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="M"
                                                                ErrorMessage="Enter Module Name" ForeColor="Red"
                                                                Text="<i class='fa fa-exclamation-circle' title='Enter Module Name !'></i>"
                                                                ControlToValidate="txtModuleName" Display="Dynamic" runat="server">
                                                            </asp:RequiredFieldValidator>
                                                        </span>
                                                        <label>MODULE NAME<span style="color: red;"> *</span></label>
                                                        <asp:TextBox runat="server" AutoComplete="off" CssClass="form-control" placeholder="Enter Module Name" ID="txtModuleName"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-block btn-success" ID="btnSaveModule" Text="Save" OnClick="btnSaveModule_Click" ValidationGroup="M" />
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <a href="MstProject.aspx" class="btn btn-block btn-default">Clear</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <asp:GridView ID="GridModuleDetail" class="datatable  table table-hover table-bordered pagination-ys" runat="server" AutoGenerateColumns="false" OnRowCommand="GridModuleDetail_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' ToolTip='<%# Eval("ModuleId").ToString() %>' runat="server" />
                                                                    <asp:Label ID="lblProjectId" Text='<%# Eval("ProjectId").ToString() %>' runat="server" Visible="false"></asp:Label>
                                                                      <asp:Label ID="lblModuleName" Text='<%# Eval("ModuleName").ToString() %>' runat="server" Visible="false"></asp:Label>

                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="ModuleName" HeaderText="MODULE NAME" />


                                                            <asp:TemplateField HeaderText="STATUS">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkStatus" runat="server"
                                                                        CommandArgument='<%# Eval("ModuleId").ToString()%>'
                                                                        CssClass='<%# Eval("IsActive").ToString() =="True" ? "label label-success" : "label label-danger"  %>'
                                                                        CausesValidation="False" CommandName="ChangeStatus"
                                                                        Text='<%# Eval("IsActive").ToString() =="True" ? "Active" : "Deactive"  %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="EDIT">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                                        CommandArgument='<%# Eval("ModuleId").ToString() %>'
                                                                        CommandName="EditRow"
                                                                        CssClass="btn btn-primary btn-sm"
                                                                        Text="Edit">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>

                                    </div>


                                    <!-- Modal Footer -->
                                    <div class="modal-footer">
                                        <%--  <asp:Button
                                        ID="Button2"
                                        runat="server"
                                        CssClass="btn btn-success"
                                        Text="Save"
                                        ValidationGroup="b" />--%>
                                        <button
                                            type="button"
                                            class="btn btn-secondary"
                                            data-dismiss="modal">
                                            Close
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <style>
        .multiselect-native-select .multiselect {
            text-align: left !important;
        }

        .multiselect-native-select .multiselect-selected-text {
            width: 100% !important;
        }

        .multiselect-native-select .checkbox, .multiselect-native-select .dropdown-menu {
            width: 100% !important;
        }

        .multiselect-native-select .btn .caret {
            float: right !important;
            vertical-align: middle !important;
            margin-top: 8px;
            border-top: 6px dashed;
        }
    </style>
    <link href="../../../mis/css/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="../../../mis/js/bootstrap-multiselect.js" type="text/javascript"></script>
    <script>
        function autoResizeTextarea(ths) {
            ths.style.height = 'auto'; // Reset height to calculate new scrollHeight
            ths.style.height = ths.scrollHeight + 'px'; // Set height to fit content
        }
        $('[id*=ddlTechnology]').multiselect({
            includeSelectAllOption: true,
            includeSelectAllOption: true,
            buttonWidth: '100%'
        });
        $('[id*=ddlWorkCategoryId]').multiselect({
            includeSelectAllOption: true,
            includeSelectAllOption: true,
            buttonWidth: '100%'
        });
    </script>
    <script>
        const txtDiscription = document.getElementById('<%=txtDiscription.ClientID%>');
        const txtTaskDescription = document.getElementById('<%=txtTaskDescription.ClientID%>');
        const lblCount1 = document.getElementById('<%=lblCounter.ClientID%>'); // assuming this is for txtDiscription
        const lblCount2 = document.getElementById('<%=lblCounter2.ClientID%>'); // for txtTaskDescription

        // Add keyup event listeners
        txtDiscription.addEventListener("keyup", () => CharactersCount(txtDiscription, lblCount1, 150));
        txtTaskDescription.addEventListener("keyup", () => CharactersCount(txtTaskDescription, lblCount2, 150));

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
        CharactersCount(txtDiscription, lblCount1, 150);
        CharactersCount(txtTaskDescription, lblCount2, 150);
    </script>
</asp:Content>

