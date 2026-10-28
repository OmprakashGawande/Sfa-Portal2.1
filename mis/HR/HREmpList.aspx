<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HREmpList.aspx.cs" Inherits="mis_HR_HREmpList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .emp-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 18px 12px;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
        }

        .emp-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 22px rgba(0, 0, 0, 0.09);
            border-color: #38bdf8;
        }

        .emp-avatar-wrapper {
            position: relative;
            margin-bottom: 12px;
        }

        .emp-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e0f2fe;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }

        .emp-card:hover .emp-avatar {
            transform: scale(1.05);
            border-color: #0284c7;
        }

        .emp-name {
            font-size: 14px;
            font-weight: 700;
            color: #1e293b;
            text-decoration: none;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 4px;
        }

        .emp-name:hover {
            color: #0284c7;
            text-decoration: underline;
        }

        .emp-designation {
            font-size: 12px;
            font-weight: 600;
            color: #0369a1;
            background: #f0f9ff;
            padding: 2px 8px;
            border-radius: 20px;
            margin-bottom: 6px;
            display: inline-block;
        }

        .emp-dept {
            font-size: 11px;
            color: #64748b;
            margin-bottom: 8px;
            display: block;
        }

        .btn-service-book {
            font-size: 11px;
            font-weight: 600;
            color: #0284c7;
            background: #ffffff;
            border: 1px solid #bae6fd;
            padding: 3px 10px;
            border-radius: 16px;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-service-book:hover {
            background: #0284c7;
            color: #ffffff;
            border-color: #0284c7;
        }

        .card-main-header {
            background: linear-gradient(135deg, #1e3a8a, #0284c7);
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 14px 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm border-0" style="border-radius: 12px; overflow: hidden;">
            <div class="card-header card-main-header">
                <div class="row align-items-center">
                    <div class="col-md-6 col-sm-12">
                        <h4 class="mb-0 text-white font-weight-bold">
                            <i class="fa fa-users me-2"></i> Officers & Employee Directory
                            <asp:Label ID="lblNoOfEmployee" CssClass="hidden" runat="server"></asp:Label>
                        </h4>
                    </div>
                    <div class="col-md-6 col-sm-12 text-md-end mt-2 mt-md-0">
                        <div class="d-inline-flex align-items-center">
                            <label class="text-white me-2 mb-0 font-weight-bold">Office : </label>
                            <asp:DropDownList ID="ddlAdminOffice_ID" runat="server" CssClass="form-control select2" Style="min-width: 250px;" OnSelectedIndexChanged="ddlAdminOffice_ID_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body p-4 bg-light">
                <asp:Label ID="lblMsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                <div class="row g-3">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3">
                                <div class="emp-card">
                                    <div class="emp-avatar-wrapper">
                                        <img src='<%# Eval("Emp_ProfileImage").ToString()%>' alt="User Image" class="emp-avatar" onerror="this.onerror=null;this.src='../image/User_Default.png';" />
                                    </div>
                                    <div class="text-center w-100">
                                        <a class="emp-name" href='<%# String.Format("HREmpDetailView.aspx?Emp_ID="+ APIProcedure.Client_Encrypt(Eval("Emp_ID").ToString())) %>' target="_blank" title='<%# Eval("Emp_Name").ToString()%>'>
                                            <%# Eval("Emp_Name").ToString()%>
                                        </a>
                                        <span class="emp-designation" title='<%# Eval("Designation_Name").ToString()%>'>
                                            <%# Eval("Designation_Name").ToString()%>
                                        </span>
                                        <asp:Label ID="lblDept" CssClass="emp-dept" ToolTip='<%# Eval("Dept")%>' Text='<%# "["+ Eval("Department_Name") + "]" %>' runat="server"></asp:Label>
                                    </div>
                                    <div class="mt-2">
                                        <a class="btn-service-book" href='<%# String.Format("HREmpServiceBookDetail.aspx?Emp_ID="+ APIProcedure.Client_Encrypt(Eval("Emp_ID").ToString())) %>' target="_blank">
                                            <i class="fa fa-book me-1"></i> Service Book
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div id="divFillList" runat="server"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer bg-white text-center py-3">
                <asp:LinkButton ID="lnkViewAllEmployee" runat="server" CssClass="btn btn-outline-primary px-4 rounded-pill" OnClick="lnkViewAllEmployee_Click">
                    <i class="fa fa-list me-1"></i> View All Employee
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
</asp:Content>
