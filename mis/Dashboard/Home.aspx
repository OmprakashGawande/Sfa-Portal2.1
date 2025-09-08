<%@ Page Title="" Language="C#" MasterPageFile="~/mis/MainMaster.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="mis_Dashboard_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHeader" runat="Server">
    <style>
        .LinkbtnFont {
            font-weight: 900 !important;
            font-size: xx-large !important;
        }

        .BoxLabel {
            font-size: x-large !important;
            font-weight: bold !important;
        }

        .f-light {
            color: #000000 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <div class="container-fluid">
        <div class="row mt-3">

            <div class="col-xl-12 col-sm-6 position-relative text-end">
                <div class="form-group">
                    <asp:Button ID="btnOldSFA" runat="server"
                        Text="Access Leave & Salary Management (Old SFA Portal)"
                        OnClientClick="window.open('https://portal2.sfatechnologies.com/','_blank'); return false;"
                        CssClass="btn btn-sm btn-primary" />
                </div>
            </div>
        </div>
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h4>Dashboard (<span runat="server" id="SpCDate"></span>)</h4>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Dashboard/Home.aspx">
                            <svg class="stroke-icon">
                                <use href="../assets/svg/icon-sprite.svg#stroke-home"></use>
                            </svg></a></li>
                        <li class="breadcrumb-item">Dashboard</li>
                    </ol>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xml-4 col-sm-4">
                <div class="card">
                    <div class="card-header">
                        <h4>Requirement Allocation</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-xl-6 col-sm-6" runat="server" id="Div_DailyTask">
                                <div class="bounce-card">
                                    <div class="card o-hidden small-widget">
                                        <div class="card-body total-P border-b-primary border-2">
                                            <span class="f-light f-w-500 f-14">Total Assigned</span>
                                            <div class="project-details">
                                                <div class="project-counter">
                                                    <asp:LinkButton ID="LBAllocatedCount" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton>
                                                    <span class="f-12 f-w-600">(No's)</span>
                                                </div>

                                                <div class="product-sub bg-primary-light">
                                                    <svg class="invoice-icon">
                                                        <use href="../assets/svg/icon-sprite.svg#task-square"></use>
                                                    </svg>
                                                </div>
                                            </div>
                                            <ul class="bubbles">
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                            </ul>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-xl-6 col-sm-6" runat="server" id="Div_ResourcesOnProjects">
                                <div class="bounce-card">
                                    <div class="card o-hidden small-widget">
                                        <div class="card-body daily-task border-b-purple border-2">
                                            <span class="f-light f-w-500 f-14">Free Man Power</span>
                                            <div class="project-details">
                                                <div class="project-counter">

                                                    <asp:LinkButton ID="LBNotAllocatedCount" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton>

                                                    <span class="f-12 f-w-400">(No's)</span>
                                                </div>
                                                <div class="product-sub bg-purple-light">
                                                    <svg class="invoice-icon">
                                                        <use href="../assets/svg/icon-sprite.svg#color-swatch"></use>
                                                    </svg>
                                                </div>
                                            </div>
                                            <ul class="bubbles">
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                                <li class="bubble"></li>
                                            </ul>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-xml-8 col-sm-8">
                <div class="card">
                    <div class="card-header">
                        <h4>Total Requirement Assigned</h4>
                    </div>

                    <div class="card-body">
                        <div class="row">
                            <div class="col-xl-3 col-sm-3" runat="server" id="Div_ResourcesOnBench">
                                <div class="card o-hidden small-widget">
                                    <div class="card-body total-Progress border-b-warning border-2">
                                        <span class="f-light f-w-500 f-14">Requirement Completed</span>
                                        <div class="project-details">
                                            <div class="project-counter">
                                                <h2 class="f-w-900">
                                                    <asp:LinkButton ID="LBReqCompleted" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton>
                                                </h2>
                                                <span class="f-12 f-w-400">(No's)</span>
                                            </div>
                                            <div class="product-sub bg-warning-light">
                                                <svg class="invoice-icon">
                                                    <use href="../assets/svg/icon-sprite.svg#tick-circle"></use>
                                                </svg>
                                            </div>
                                        </div>
                                        <ul class="bubbles">
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-sm-3">
                                <div class="card o-hidden small-widget">
                                    <div class="card-body total-Complete border-b-secondary border-2">
                                        <span class="f-light f-w-500 f-14">Requirement Pending</span>
                                        <div class="project-details">
                                            <div class="project-counter">
                                                <h2 class="f-w-600">
                                                    <asp:LinkButton ID="LBReqPending" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton>
                                                </h2>
                                                <span class="f-12 f-w-400">(No's)</span>
                                            </div>
                                            <div class="product-sub bg-secondary-light">
                                                <svg class="invoice-icon">
                                                    <use href="../assets/svg/icon-sprite.svg#add-square"></use>
                                                </svg>
                                            </div>
                                        </div>
                                        <ul class="bubbles">
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-3">
                                <div class="card o-hidden small-widget">
                                    <div class="card-body total-upcoming">
                                        <span class="f-light f-w-500 f-14">Partial Complete</span>
                                        <div class="project-details">
                                            <div class="project-counter">
                                                <h2 class="f-w-600">
                                                    <asp:LinkButton ID="LBPartialComplete" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton></h2>
                                                <span class="f-12 f-w-400">(No's)</span>
                                            </div>
                                            <div class="product-sub bg-light-light">
                                                <svg class="invoice-icon">
                                                    <use href="../assets/svg/icon-sprite.svg#spam"></use>
                                                </svg>
                                            </div>
                                        </div>
                                        <ul class="bubbles">
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-3">
                                <div class="card o-hidden small-widget">
                                    <div class="card-body total-upcoming">
                                        <span class="f-light f-w-500 f-14">Not Filled</span>
                                        <div class="project-details">
                                            <div class="project-counter">
                                                <h2 class="f-w-600">
                                                    <asp:LinkButton ID="LBNotFilledCount" CssClass="LinkbtnFont" runat="server" Text="00"></asp:LinkButton></h2>
                                                <span class="f-12 f-w-400">(No's)</span>
                                            </div>
                                            <div class="product-sub bg-light-light">
                                                <svg class="invoice-icon">
                                                    <use href="../assets/svg/icon-sprite.svg#spam"></use>
                                                </svg>
                                            </div>
                                        </div>
                                        <ul class="bubbles">
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                            <li class="bubble"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>




            </div>





        </div>
        <hr />

        <h4>QA Process Completed   <span class="f-12 f-w-400">(No's)</span></h4>
        <div class="row mt-3">

            <div class="col-xl-4 col-sm-6">
                <div class="card o-hidden small-widget">
                    <div class="card-body total-pendingleave">
                        <span class="f-light f-w-500 f-14">Total Test Cases</span>
                        <div class="project-details">
                            <div class="project-counter">
                                <h2 class="f-w-600">
                                    <asp:LinkButton ID="lblMyPendingLeave" CssClass="LinkbtnFont" runat="server" Text="0"></asp:LinkButton></h2>
                                <span class="f-12 f-w-400">(No's)</span>
                            </div>
                            <div class="product-sub bg-light-light2">
                                <svg class="invoice-icon">
                                    <use href="../assets/svg/icon-sprite.svg#clock"></use>
                                </svg>
                            </div>
                        </div>
                        <ul class="bubbles">
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 col-sm-6">
                <div class="card o-hidden small-widget">
                    <div class="card-body total-leaveapproval">
                        <span class="f-light f-w-500 f-14">Pass Test Cases</span>
                        <div class="project-details">
                            <div class="project-counter">
                                <h2 class="f-w-600">
                                    <asp:LinkButton ID="lblOtherPendingLeave" CssClass="LinkbtnFont" runat="server" Text="0"></asp:LinkButton>
                                </h2>
                                <span class="f-12 f-w-400">(No's)</span>
                            </div>
                            <div class="product-sub bg-light-light3">
                                <svg class="invoice-icon">
                                    <use href="../assets/svg/icon-sprite.svg#clock"></use>
                                </svg>
                            </div>
                        </div>
                        <ul class="bubbles">
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xl-4 col-sm-6">
                <div class="card o-hidden small-widget">
                    <div class="card-body total-leaveapproval">
                        <span class="f-light f-w-500 f-14">Fail Test Cases</span>
                        <div class="project-details">
                            <div class="project-counter">
                                <h2 class="f-w-600">
                                    <asp:LinkButton ID="lblFailTestCases" CssClass="LinkbtnFont" runat="server" Text="0"></asp:LinkButton>
                                </h2>
                                <span class="f-12 f-w-400">(No's)</span>
                            </div>
                            <div class="product-sub bg-light-light3">
                                <svg class="invoice-icon">
                                    <use href="../assets/svg/icon-sprite.svg#clock"></use>
                                </svg>
                            </div>
                        </div>
                        <ul class="bubbles">
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                            <li class="bubble"></li>
                        </ul>
                    </div>
                </div>
            </div>


            <div class="col-md-4" style="display: none">
                <div class="info-box">
                    <a href="../mis/Daily_Task/Daily_Reporting.aspx" runat="server" id="a1">
                        <span class="info-box-icon bg-green "><i class="fa fa-tasks" aria-hidden="true"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">Daily Task</span>
                            <%--<asp:Label ID="lblReportStatus" runat="server" class="info-box-number" Text=""></asp:Label>--%>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-md-4" style="display: none">
                <div class="info-box">

                    <span class="info-box-icon bg-yellow"><i class="fa fa-calendar" aria-hidden="true"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Your Pending Leave Application </span>

                    </div>

                </div>
            </div>
            <div class="col-md-4" style="display: none">
                <div class="info-box">
                    <a href="../HR/HREmpLeaveRequests.aspx" runat="server" id="aPendingLeave">
                        <span class="info-box-icon bg-red"><i class="fa fa-calendar-o" aria-hidden="true"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text"></span>
                            <asp:Label ID="lbl2" runat="server" class="info-box-number" Text=""></asp:Label>
                        </div>
                    </a>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFooter" runat="Server">
</asp:Content>

