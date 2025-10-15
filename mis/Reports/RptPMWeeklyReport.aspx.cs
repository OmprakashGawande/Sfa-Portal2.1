using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptPMWeeklyReport : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds;
    CultureInfo cult = new CultureInfo("gu-IN", true);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] != null)
        {
            if (!IsPostBack)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                ViewState["Office_ID"] = Session["Office_ID"].ToString();
                ViewState["UserTypeId"] = Session["UserTypeId"].ToString();
                ViewState["Designation_ID"] = Session["Designation_ID"].ToString();
                DateTime today = DateTime.Now;
                DateTime start = today.AddDays(-(int)today.DayOfWeek + (int)DayOfWeek.Monday);
                if (today.DayOfWeek == DayOfWeek.Sunday) start = today.AddDays(-6);

                txtFromDate.Text = start.ToString("dd/MM/yyyy");        // Monday
                txtToDate.Text = start.AddDays(4).ToString("dd/MM/yyyy"); // Friday

                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    private string ErrorMsg(Exception ex)
    {
        lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry! : Error ", ex.Message.ToString());
        return lblMsg.Text;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            string FromDate = txtFromDate.Text != "" ? Convert.ToDateTime(txtFromDate.Text, cult).ToString("yyyy/MM/dd") : "";
            string ToDate = txtToDate.Text != "" ? Convert.ToDateTime(txtToDate.Text, cult).ToString("yyyy/MM/dd") : "";

            DataSet ds = objdb.ByProcedure("Usp_PMWeeklyReportInsertUpdate",
                new string[] { "Flag", "FromDate", "ToDate" },
                new string[] { "3", FromDate, ToDate },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvPMWeeklyReport.DataSource = ds.Tables[0];
                gvPMWeeklyReport.DataBind();
                Datatable();

            }
            else
            {
                gvPMWeeklyReport.DataSource = null;
                gvPMWeeklyReport.DataBind();
                lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Record Found");
            }
        }
        catch (Exception ex)
        {

            ErrorMsg(ex);
        }
    }
    protected void gvPMWeeklyReport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
        string reportId = e.CommandArgument.ToString();


        // Basic Info
        string employeeName = (row.FindControl("lblEmployee_Name") as Label).Text;
        string weekStart = Convert.ToDateTime((row.FindControl("lblWeekStartDate") as Label).Text).ToString("dd/MM/yyyy");
        string weekEnd = Convert.ToDateTime((row.FindControl("lblWeekEndDate") as Label).Text).ToString("dd/MM/yyyy");
        string totalProject = (row.FindControl("lblTotalProject") as Label).Text;
        string totalTask = (row.FindControl("lblTotalTask") as Label).Text;

        // Tasks & Reporting
        string TaskATATM = (row.FindControl("lblTaskATATM") as Label).Text;
        string TaskATATMReason = (row.FindControl("lblTaskATATMReaso") as Label).Text;
        string ReportingSubmittedbyAllTeam = (row.FindControl("lblReportingSubmittedbyAllTeam") as Label).Text;
        string ReportingSubmittedbyAllTeamReason = (row.FindControl("lblReportingSubmittedbyAllTeamReason") as Label).Text;

        // Time & Meetings
        string TimeOverrun = (row.FindControl("lblIsTimeOverrun") as Label).Text;
        string TimeOverrunReason = (row.FindControl("lblTimeOverrunReason") as Label).Text;
        string ClientMeeting = (row.FindControl("lblIsClientMeeting") as Label).Text;
        string NumberOfMeetings = (row.FindControl("lblNumberOfMeetings") as Label).Text;

        // Audit & Testing
        string AuditedFromAuditTeam = (row.FindControl("lblIsAuditedFromAuditTeam") as Label).Text;
        string TestCasesPassed = (row.FindControl("lblTestCasesPassed") as Label).Text;
        string TestCasesFail = (row.FindControl("lblTestCasesFail") as Label).Text;
        string CodeUpload = (row.FindControl("lblIsCodeUpload") as Label).Text;

        // Project Delay & Challenges
        string ProjectDelay = (row.FindControl("lblIsProjectDelay") as Label).Text;
        string ProjectDelayReason = (row.FindControl("lblProjectDelayReason") as Label).Text;
        string MajorChallenges = (row.FindControl("lblIsMajorChallenges") as Label).Text;
        string MajorChallengesDetail = (row.FindControl("lblMajorChallengesDetail") as Label).Text;

        // Internal & External Support
        string AnyInternalSupportRequired = (row.FindControl("lblIsInternalSupportRequired") as Label).Text;
        string InternalSupportDetail = (row.FindControl("lblInternalSupportDetail") as Label).Text;
        string AnyExternalSupportRequired = (row.FindControl("lblIsExternalSupportRequired") as Label).Text;
        string ExternalSupportDetail = (row.FindControl("lblExternalSupportDetail") as Label).Text;

        // Team Utilization & Standup
        string TeamUtilization = (row.FindControl("lblTeamUtilization") as Label).Text;
        string TeamUtilizationDetail = (row.FindControl("lblTeamUtilizationDetail") as Label).Text;
        string DailyStandupMeeting = (row.FindControl("lblDailyStandupMeeting") as Label).Text;
        string DailyStandupDetail = (row.FindControl("lblDailyStandupMeetingDetail") as Label).Text;

        // MOM & Underutilized
        string AllMOMEmailShared = (row.FindControl("lblAllMOMEmailShered") as Label).Text;
        string AllMOMEmailSharedDetail = (row.FindControl("lblAllMOMEmailSheredDetail") as Label).Text;
        string AnyTeamMembersU = (row.FindControl("lblAnyTeamMemberesU") as Label).Text;
        string AnyTeamMembersUDetail = (row.FindControl("lblAnyTeamMemberesUDetail") as Label).Text;


        if (e.CommandName == "ViewReport")
        {
            litWeeklyReport.Text = @"
<div class='pm-report-paper'>
    <h1>Weekly Report (Project Manager)</h1>
    <div class='meta'>
        <div>Name: <strong>" + employeeName + @"</strong></div>
        <div>Week from: <strong>" + weekStart + @"</strong></div>
        <div>To: <strong>" + weekEnd + @"</strong></div>
    </div>

    <table>
        <thead>
            <tr>
                <th class='col-sno'>S.No.</th>
                <th class='col-activity'>Activities</th>
                <th class='col-weekly'>Weekly Process</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style='text-align: center;'>1.</td>
                <td><div class='label'>Task Allotted to all team members</div><div class='label'>(developers, QA, Coordinators)</div></td>
                <td><div class='label'>Y/N :- " + TaskATATM + @"</div><div class='label reason-text'>Details (if No) :- " + TaskATATMReason + @" </div><div class='big-empty'></div>
</td>
            </tr>
                      <tr>
                <td style='text-align: center;'>2.</td>
                <td><div class='label'>Reporting submitted by all team members (5 days)</div></td>
                <td><div class='label'>Y/N :- " + ReportingSubmittedbyAllTeam + @"</div><div class='label reason-text'>Details (if No) :- " + ReportingSubmittedbyAllTeamReason + @"</div><div class='medium-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>3.</td>
                <td><div class='label'>Team Utilization %</div></td>
                <td><div class='label'> " + TeamUtilization + @" %</div><div class='label reason-text'>Details :- " + TeamUtilizationDetail + @"</div><div class='small-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>4.</td>
                <td><div class='label'>Daily Standup Meeting</div></td>
                <td><div class='label'>Y/N :- " + DailyStandupMeeting + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>5.</td>
                <td><div class='label'>No of meetings with clients</div></td>
                <td><div class='label'>" + NumberOfMeetings + @" No's</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>6.</td>
                <td><div class='label'>All MOM / Email shared</div></td>
                <td><div class='label'>Y/N :- " + AllMOMEmailShared + @" </div><div class='label reason-text'>Details (if No) :- " + AllMOMEmailSharedDetail + @"</div><div class='small-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>7.</td>
                <td><div class='label'>Any team members (Underutilized)</div></td>
                <td><div class='label'>Y/N :- " + AnyTeamMembersU + @" </div><div style='margin-top:5px' class='label reason-text'>Reason With Name :- " + AnyTeamMembersUDetail + @"</div><div class='small-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>8.</td>
                <td><div class='label'>Any major Challenges / requirements</div></td>
                <td><div class='label reason-text'>Internal :- " + InternalSupportDetail + @"</div><div class='medium-empty'></div><div class='label reason-text'>External :- " + ExternalSupportDetail + @"</div><div class='big-empty'></div></td>
            </tr>
        </tbody>
    </table>

    <div class='footer-space'></div>

<style>
    .pm-report-paper {
        font-family: 'Segoe UI', Arial, sans-serif;
        margin: 0 auto;
        color: #222;
        background: #fff;
        padding: 25px 30px;
        border-radius: 10px;
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
        max-width: 850px;
        font-size: 12px;
    }
    .pm-report-paper h1 {
        text-align: center;
        font-size: 18px;
        margin-bottom: 15px;
        color: #333;
        text-decoration: underline;
    }
    .pm-report-paper .meta {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        font-size: 15px;
        color: #555;
        font-weight: bold;
    }
    .pm-report-paper table {
        width: 100%;
        border-collapse: collapse;
        border: 1px solid #ccc;
        table-layout: fixed;
        font-size: 16px;
    }
    .pm-report-paper th, .pm-report-paper td {
        border: 1px solid #ccc;
        padding: 6px 5px;
        vertical-align: top;
    }
    .pm-report-paper th {
        background: #f1f1f1;
        font-weight: 600;
        text-align: center;
    }
.label {
    border-radius: 2px;
    color: #141414;
    font-size: 14px;
    line-height: 1;
    margin-bottom: 0;
    text-transform: capitalize;
}

.pm-report-paper .label {
    font-weight: 600; 
    display: block;
    margin-bottom: 4px;
    word-wrap: break-word;  
    white-space: normal;
}
.reason-text {
    word-wrap: break-word;
    white-space: normal;
}
    .pm-report-paper .col-sno { width: 6%; text-align:center; }
    .pm-report-paper .col-activity { width: 44%; }
    .pm-report-paper .col-weekly { width: 50%; }
    .pm-report-paper .big-empty { height: 60px; }
    .pm-report-paper .medium-empty { height: 40px; }
    .pm-report-paper .small-empty { height: 20px; }
    .pm-report-paper .label {
        font-weight: 600; 
        display: block;
        margin-bottom: 4px;
    }
    .pm-report-paper .muted { color: #666; font-size: 11px; }
    .pm-report-paper .footer-space { height: 20px }

    @media print {
        body * { visibility: hidden; }
        .pm-report-paper, .pm-report-paper * { visibility: visible; }
        .pm-report-paper {
            position: absolute;
            left: 0;
            top: 0;
            width: 210mm;
            max-width: 210mm;
            padding: 15mm;
            box-shadow: none;
            border: none;
            font-size: 11px;
        }
        .btn { display: none !important; }
    }
</style>
";
            weeklyReportContainer.Visible = true;
            weeklyReportContainer2.Visible = false;
            weeklyReportContainer.Style["display"] = "block";
            weeklyReportContainer2.Style["display"] = "none";


        }
        if (e.CommandName == "ViewFullReport")
        {
            litWeeklyReportFull.Text = @"
<div class='pm-report-paper'>
    <h1>Weekly Report (Project Manager)</h1>
    <div class='meta'>
        <div>Name: <strong>" + employeeName + @"</strong></div>
        <div>Week from: <strong>" + weekStart + @"</strong></div>
        <div>To: <strong>" + weekEnd + @"</strong></div>
        <div>Total Project: <strong>" + totalProject + @"</strong></div>
        <div>Total Task: <strong>" + totalTask + @"</strong></div>
    </div>

    <table>
        <thead>
            <tr>
                <th class='col-sno'>S.No.</th>
                <th class='col-activity'>Activities</th>
                <th class='col-weekly'>Weekly Process</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style='text-align: center;'>1.</td>
                <td><div class='label'>Task Allocated to all team members</div></td>
                <td><div class='label'>Y/N: " + TaskATATM + @"</div><div class='label'>Details: " + TaskATATMReason + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>2.</td>
                <td><div class='label'>Task Reporting submitted by all team</div></td>
                <td><div class='label'>Y/N: " + ReportingSubmittedbyAllTeam + @"</div><div class='label'>Details: " + ReportingSubmittedbyAllTeamReason + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>3.</td>
                <td><div class='label'>Time Overrun</div></td>
                <td><div class='label'>Y/N: " + TimeOverrun + @"</div><div class='label'>Reason: " + TimeOverrunReason + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>4.</td>
                <td><div class='label'>Client Meeting</div></td>
                <td><div class='label'>Y/N: " + ClientMeeting + @"</div><div class='label'>No. of Meetings: " + NumberOfMeetings + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>5.</td>
                <td><div class='label'>Audited from Audit Team</div></td>
                <td><div class='label'>Y/N: " + AuditedFromAuditTeam + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>6.</td>
                <td><div class='label'>Test Cases Passed / Failed</div></td>
                <td><div class='label'>Passed: " + TestCasesPassed + @"</div><div class='label'>Failed: " + TestCasesFail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>7.</td>
                <td><div class='label'>Code Upload</div></td>
                <td><div class='label'>" + CodeUpload + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>8.</td>
                <td><div class='label'>Project Delay</div></td>
                <td><div class='label'>Y/N: " + ProjectDelay + @"</div><div class='label'>Reason: " + ProjectDelayReason + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>9.</td>
                <td><div class='label'>Major Challenges</div></td>
                <td><div class='label'>Y/N: " + MajorChallenges + @"</div><div class='label'>Details: " + MajorChallengesDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>10.</td>
                <td><div class='label'>Internal Support Required</div></td>
                <td><div class='label'>Y/N: " + AnyInternalSupportRequired + @"</div><div class='label'>Details: " + InternalSupportDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>11.</td>
                <td><div class='label'>External Support Required</div></td>
                <td><div class='label'>Y/N: " + AnyExternalSupportRequired + @"</div><div class='label'>Details: " + ExternalSupportDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>12.</td>
                <td><div class='label'>Team Utilization %</div></td>
                <td><div class='label'>" + TeamUtilization + @"%</div><div class='label'>Details: " + TeamUtilizationDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>13.</td>
                <td><div class='label'>Daily Standup Meeting</div></td>
                <td><div class='label'>Y/N: " + DailyStandupMeeting + @"</div><div class='label'>Details: " + DailyStandupDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>14.</td>
                <td><div class='label'>All MOM / Email Shared</div></td>
                <td><div class='label'>Y/N: " + AllMOMEmailShared + @"</div><div class='label'>Details: " + AllMOMEmailSharedDetail + @"</div></td>
            </tr>
            <tr>
                <td style='text-align: center;'>15.</td>
                <td><div class='label'>Any Team Members Underutilized</div></td>
                <td><div class='label'>Y/N: " + AnyTeamMembersU + @"</div><div class='label'>Details: " + AnyTeamMembersUDetail + @"</div></td>
            </tr>
        </tbody>
    </table>

    <div class='footer-space'></div>

<style>
.pm-report-paper {
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 0 auto;
    color: #222;
    background: #fff;
    padding: 25px 30px;
    border-radius: 10px;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
    max-width: 850px;
    font-size: 12px;
}
.pm-report-paper h1 {
    text-align: center;
    font-size: 18px;
    margin-bottom: 15px;
    color: #333;
    text-decoration: underline;
}
.pm-report-paper .meta {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    font-size: 15px;
    color: #555;
    font-weight: bold;
}
.pm-report-paper table {
    width: 100%;
    border-collapse: collapse;
    border: 1px solid #ccc;
    table-layout: fixed;
    font-size: 16px;
}
.pm-report-paper th, .pm-report-paper td {
    border: 1px solid #ccc;
    padding: 6px 5px;
    vertical-align: top;
}
.pm-report-paper th {
    background: #f1f1f1;
    font-weight: 600;
    text-align: center;
}
.label {
    border-radius: 2px;
    color: #141414;
    font-size: 14px;
    line-height: 1;
    text-transform: capitalize;
    font-weight: 600;
    display: block;
    margin-bottom: 4px;
}
.pm-report-paper .col-sno { width: 6%; text-align:center; }
.pm-report-paper .col-activity { width: 44%; }
.pm-report-paper .col-weekly { width: 50%; }
.pm-report-paper .big-empty { height: 60px; }
.pm-report-paper .medium-empty { height: 40px; }
.pm-report-paper .small-empty { height: 20px; }
.pm-report-paper .footer-space { height: 20px; }
@media print {
    body * { visibility: hidden; }
    .pm-report-paper, .pm-report-paper * { visibility: visible; }
    .pm-report-paper {
        position: absolute;
        left: 0;
        top: 0;
        width: 210mm;
        max-width: 210mm;
        padding: 15mm;
        box-shadow: none;
        border: none;
        font-size: 11px;
    }
    .btn { display: none !important; }
}
</style>
";



            //string script2 = "var myModal = new bootstrap.Modal(document.getElementById('AddModuleModal')); myModal.show();";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "AddModuleModal", script2, true);
            weeklyReportContainer.Visible = false;
            weeklyReportContainer2.Visible = true;
            weeklyReportContainer.Style["display"] = "none";
            weeklyReportContainer2.Style["display"] = "block";
            //Datatable();
        }

        string script1 = "var myModal = new bootstrap.Modal(document.getElementById('AddModuleModal')); myModal.show();";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowAddModuleModal", script1, true);
       

        Datatable();
    }


    protected void Datatable()
    {
        if (gvPMWeeklyReport.Rows.Count > 0)
        {
            gvPMWeeklyReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvPMWeeklyReport.UseAccessibleHeader = true;
        }
    }


}