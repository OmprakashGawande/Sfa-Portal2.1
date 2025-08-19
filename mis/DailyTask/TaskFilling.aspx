<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TaskFilling.aspx.cs" Inherits="mis_DailyTask_TaskFilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Save" ShowMessageBox="true" ShowSummary="false" />
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="card mt-3  border-warning">
                    <div class="card-header">
                        <h4>Fill Requirement </h4> <h6 class="float-end text-white"> <asp:Label runat="server" ID="lblCurrentTaskCount"></asp:Label></h6>
                        
                    </div>
                    <div class="card-body">
                        <div class="row g-3 needs-validation custom-input">
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
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-6 position-relative" runat="server">
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

                            <div class="col-xl-2 col-sm-6 position-relative" style="text-align:center" runat="server">
                                <div class="form-check mt-4">
                                    <asp:CheckBox
                                        ID="chkFwdToQa"
                                        runat="server"
                                        Enabled="false" />
                                    <label class="form-check-label" for="chkMeOut">Fwd to QA</label>
                                </div>
                            </div>

                            <div class="col-xl-7 col-sm-6 position-relative" runat="server">
                                <div class="form-group">
                                    <label runat="server">Other Task (Remark)</label>
                                    <asp:TextBox placeholder="ex: Project Name: Requirement Point." runat="server" ID="txtRemark" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                            <hr />
                            <div class="col-xl-3">
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" OnClick="btnSave_Click" Text="Save" ValidationGroup="Save" />
                                    <a href="TaskFilling.aspx" class="btn btn-block   btn-outline-danger">Clear</a>
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

