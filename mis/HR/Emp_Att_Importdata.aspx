<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="Emp_Att_Importdata.aspx.cs" Inherits="mis_HR_Emp_Att_Importdata" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Upload Attendance</h5>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Select Date<span style="color: red;">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                <asp:TextBox ID="txtAttDate" runat="server" CssClass="form-control datetime-local" autocomplete="off" onpaste="return false" placeholder="DD/MM/YYYY" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Upload mdb File <span style="color: red;">*</span></label>
                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" ClientIDMode="Static" />
                            <small class="text-danger font-weight-bold d-block mt-1">(Allow only .mdb format for file upload.)</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <asp:Button ID="btnImport" CssClass="btn btn-block btn-success" Style="margin-top: 24px;" runat="server" Text="Import" OnClientClick="return validateform()" OnClick="btnImport_Click" />
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-hover table-striped datatable" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true" EmptyDataText="No Record Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblrownumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server"></asp:Label>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=FileUpload1.ClientID%>').on('change', function () {
                var fileExtension = ['mdb'];
                var filename = $(this).val();
                if (filename) {
                    var ext = filename.split('.').pop().toLowerCase();
                    if ($.inArray(ext, fileExtension) == -1) {
                        alert("Allow only .mdb format for file upload.");
                        this.value = '';
                    }
                }
            });
        });

        function validateform() {
            var msg = "";
            if (document.getElementById('<%=txtAttDate.ClientID%>').value.trim() == "") {
                msg += "Enter Attendance Date \n";
            }
            var uploadCtrl = document.getElementById('<%=FileUpload1.ClientID%>');
            if (!uploadCtrl.files || uploadCtrl.files.length == 0) {
                msg += "Please Select Upload File \n";
            }
            if (msg != "") {
                alert(msg);
                return false;
            }
            else {
                return confirm("Do you really want to Save Details ?");
            }
        }
    </script>
</asp:Content>

