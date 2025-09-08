<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="TrnServer.aspx.cs" Inherits="mis_DailyTask_TrnServer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
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
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="btnYes" OnClick="btnSave_Click" />
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
                        <h4>Server</h4>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="rfvDate"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Date."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Date.'></i>"
                                            ControlToValidate="txtDate"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label>Date<span style="color: red;">*</span></label>
                                    <asp:TextBox ID="txtDate" runat="server" placeholder="DD/MM/YYYY" autocomplete="off"
                                        data-date-format="dd/mm/yyyy" data-date-autoclose="true" CssClass="form-control datetime-local" />
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="EFV1"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Project Upload."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Project Upload.'></i>"
                                            ControlToValidate="txtTotalProjectUpload"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Project Upload<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtTotalProjectUpload" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV2"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Database."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Database.'></i>"
                                            ControlToValidate="txtDatabase"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Database<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="sanitizeInput(this)" ID="txtDatabase" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV3"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Total Space."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Total Space.'></i>"
                                            ControlToValidate="txtTotalSpace"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Total Space (GB)<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" oninput="allowDecimal(this)" ID="txtTotalSpace" runat="server" placeholder="ex:00" CssClass="form-control"></asp:TextBox>

                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV4"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select All Backups."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select All Backups.'></i>"
                                            ControlToValidate="ddlAllBackups"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">All Backups<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlAllBackups" CssClass="form-select select2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV5"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Backup Challenges."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Backup Challenges.'></i>"
                                            ControlToValidate="ddlBackupChallenges"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Backup Challenges<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlBackupChallenges" CssClass="form-select select2">
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
                                            ID="RFV6"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Any Internal Support Required."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Any Internal Support Required.'></i>"
                                            ControlToValidate="txtAISR"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Internal Support Required<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAISR" runat="server" TextMode="MultiLine" placeholder="Enter Any Internal Support Required" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV7"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Any Action to be Taken." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Any Action to be Taken.'></i>"
                                            ControlToValidate="txtAATBT" Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Any Action to be Taken<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAATBT" runat="server" TextMode="MultiLine" placeholder="Enter Any Action to be Taken" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV8"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter Average Utilization." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter Average Utilization.'></i>"
                                            ControlToValidate="txtAverageUtilization" Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Average Utilization<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtAverageUtilization" runat="server" TextMode="MultiLine" placeholder="Enter Average Utilization" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV9"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Select Vulnerability Report All."
                                            ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Select Vulnerability Report All.'></i>"
                                            ControlToValidate="ddlVulnerabilityReportAll"
                                            InitialValue="0"
                                            Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">Vulnerability Report All<span style="color: red;">*</span></label>
                                    <asp:DropDownList runat="server" ID="ddlVulnerabilityReportAll" CssClass="form-select select2" OnSelectedIndexChanged="ddlVulnerabilityReportAll_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 position-relative" runat="server" id="Div_NoofReprot" visible="false">
                                <div class="form-group">
                                    <span class="fa-pull-right">
                                        <asp:RequiredFieldValidator
                                            ID="RFV10"
                                            ValidationGroup="Save"
                                            ErrorMessage="Please Enter No. of Report's." ForeColor="Red"
                                            Text="<i class='fa fa-exclamation-circle' title='Please Enter No. of Report's.'></i>"
                                            ControlToValidate="txtNoofReprot" Display="Dynamic"
                                            runat="server" />
                                    </span>
                                    <label runat="server">No. of Report's<span style="color: red;">*</span></label>
                                    <asp:TextBox autocomplete="off" ID="txtNoofReprot" runat="server" placeholder="Enter No. of Report's" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <hr />

                        <div class="col-xl-3" runat="server">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-block btn-outline-success" ID="btnSave" Text="Save" OnClientClick="return ValidatePage()" ValidationGroup="Save" />
                                <a href="TrnServer.aspx" class="btn btn-block btn-outline-danger">Clear</a>
                            </div>
                        </div>
                    </div>
                </div>

                <hr />
                <div class="card border-warning">
                    <div class="card-header">
                        <h4>Details</h4>
                    </div>
                    <div class="card-body">
                        <div class="row" style="padding: 0px 9px 2px 15px;" id="div1" runat="server">
                            <div class="table-responsive dt-ext ">
                                <div class="col-md-12">
                                    <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvServerReport"
                                        CssClass="datatable table table-bordered table-hover" DataKeyNames="ServerId">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S. No." ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70px">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblServerDate" runat="server" Text='<%# Eval("ServerDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Project Upload" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalProjectUpload" runat="server" Text='<%# Eval("TotalProjectUpload") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Database" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalDatabase" runat="server" Text='<%# Eval("TotalDatabase") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Space (GB)" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalSpaceGB" runat="server" Text='<%# Eval("TotalSpaceGB") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="All Backups" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAllBackups" runat="server" Text='<%# Eval("AllBackups") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Backup Challenges" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBackupChallenges" runat="server" Text='<%# Eval("BackupChallenges") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Internal Support Required" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyInternalSupportRequired" runat="server" Text='<%# Eval("AnyInternalSupportRequired") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Any Action to be Taken" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnyActionToBeTaken" runat="server" Text='<%# Eval("AnyActionToBeTaken") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Average Utilization" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAverageUtilization" runat="server" Text='<%# Eval("AverageUtilization") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vulnerability Report All" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVulnerabilityReportAll" runat="server" Text='<%# Eval("VulnerabilityReportAll") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Report's" ItemStyle-CssClass="center-grid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNoOfReports" runat="server" Text='<%# Eval("NoOfReports") %>'></asp:Label>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script>
        function allowDecimal(input) {
            input.value = input.value.replace(/[^0-9.]/g, '');
            if ((input.value.match(/\./g) || []).length > 1) {
                input.value = input.value.substring(0, input.value.length - 1);
            }
        }

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
</asp:Content>

