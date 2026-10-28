<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="HRHolidayCalenderForAllEmp.aspx.cs" Inherits="mis_HR_HRHolidayCalenderForAllEmp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .calendar-wrapper {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            padding: 15px;
            margin-bottom: 25px;
        }

        #<%= Calendar1.ClientID %> {
            width: 100% !important;
            border-collapse: separate;
            border-spacing: 4px;
            border: none !important;
            font-family: inherit;
        }

        #<%= Calendar1.ClientID %> title {
            font-size: 16px;
        }

        #<%= Calendar1.ClientID %> td {
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        #<%= Calendar1.ClientID %> td:hover:not(:empty) {
            transform: scale(1.02);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .calendar-header-banner {
            background: linear-gradient(135deg, #1e40af, #3b82f6);
            color: #ffffff;
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="card mt-3 shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 text-white">
                        <i class="fa fa-calendar-check-o me-2"></i> Holiday Calendar (शासकीय अवकाश तालिका)
                    </h5>
                </div>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                <div class="row">
                    <div class="col-md-12">
                        <div class="calendar-wrapper">
                            <div class="calendar-header-banner">
                                <h4 class="mb-0 font-weight-bold">
                                    <asp:Label ID="Label1" runat="server" ForeColor="White">शासकीय अवकाश तालिका</asp:Label>
                                </h4>
                            </div>
                            <div class="table-responsive">
                                <asp:Calendar
                                    ID="Calendar1"
                                    runat="server"
                                    BackColor="#FFFFFF"
                                    BorderColor="#E2E8F0"
                                    BorderWidth="1px"
                                    DayNameFormat="Full"
                                    Font-Names="inherit"
                                    Font-Size="9pt"
                                    ForeColor="#1e293b"
                                    ShowGridLines="False"
                                    OnDayRender="Calendar1_DayRender"
                                    OnSelectionChanged="Calendar1_SelectionChanged"
                                    OnVisibleMonthChanged="Calendar1_VisibleMonthChanged">
                                    <SelectedDayStyle BackColor="#3B82F6" ForeColor="White" Font-Bold="True" />
                                    <SelectorStyle BackColor="#F1F5F9" />
                                    <TodayDayStyle BackColor="#EFF6FF" ForeColor="#1D4ED8" Font-Bold="True" BorderColor="#3B82F6" BorderWidth="1px" />
                                    <OtherMonthDayStyle ForeColor="#94A3B8" BackColor="#F8FAFC" />
                                    <NextPrevStyle Font-Size="10pt" ForeColor="White" Font-Bold="True" />
                                    <DayHeaderStyle BackColor="#F1F5F9" Font-Bold="True" Height="36px" ForeColor="#475569" />
                                    <TitleStyle BackColor="#1E40AF" Font-Bold="True" Font-Size="11pt" ForeColor="White" Height="40px" />
                                </asp:Calendar>
                            </div>
                            <div class="mt-2 text-center">
                                <b><asp:Label ID="LabelAction" runat="server" ClientIDMode="Static" CssClass="badge bg-info text-white p-2" Text=""></asp:Label></b>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-light py-2">
                                <h6 class="mb-0 font-weight-bold text-secondary">
                                    <i class="fa fa-list me-1"></i> Annual Holiday List (वर्ष भर के अवकाशों की सूची)
                                </h6>
                            </div>
                            <div class="card-body p-3">
                                <div class="table-responsive">
                                    <asp:GridView ID="GridView1" PageSize="50" runat="server" CssClass="datatable table table-hover table-bordered" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo." ItemStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Holiday_Date" HeaderText="Holiday Date" HeaderStyle-Width="140" />
                                            <asp:BoundField DataField="Holiday_Name" HeaderText="Holiday Name" />
                                            <asp:BoundField DataField="Holiday_Type" HeaderText="Holiday Type" HeaderStyle-Width="120" />
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
        $(document).ready(function () {
            if (typeof initCustomDataTable === 'function') {
                initCustomDataTable('.datatable', 'Holiday Calendar', 'Holiday Calendar');
            }
        });
    </script>
</asp:Content>
