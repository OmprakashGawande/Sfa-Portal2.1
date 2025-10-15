using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptDevelopmentTeamWeeklyReport : System.Web.UI.Page
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

            DataSet ds = objdb.ByProcedure("Usp_DevelopmentTeamWeeklyReportInsertUpdate",
                new string[] { "Flag", "FromDate", "ToDate" },
                new string[] { "3", FromDate, ToDate },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvDevWeeklyReport.DataSource = ds.Tables[0];
                gvDevWeeklyReport.DataBind();
                Datatable();

            }
            else
            {
                gvDevWeeklyReport.DataSource = null;
                gvDevWeeklyReport.DataBind();
                lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Record Found");
            }
        }
        catch (Exception ex)
        {

            ErrorMsg(ex);
        }
    }

    protected void gvDevWeeklyReport_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            string reportId = e.CommandArgument.ToString();


            // Basic Info
            string employeeName = (row.FindControl("lblEmployee_Name") as Label).Text;
            string weekStart = Convert.ToDateTime((row.FindControl("lblWeekStartDate") as Label).Text).ToString("dd/MM/yyyy");
            string weekEnd = Convert.ToDateTime((row.FindControl("lblWeekEndDate") as Label).Text).ToString("dd/MM/yyyy");
            string TaskReceived = (row.FindControl("lblNoOfTaskReceivedFromPM") as Label).Text;
            string DailyReportSubmitted = (row.FindControl("lblDailyReportSubmitted") as Label).Text;
            string QAFeedback = (row.FindControl("lblQAFeedbackReceived") as Label).Text;
            string CodeAudited = (row.FindControl("lblCodeAudited") as Label).Text;
            string CodeAuditedBy = (row.FindControl("lblCodeAuditedBy") as Label).Text;
            string CodeAuditReason = (row.FindControl("lblReason") as Label).Text;
            string CodingStandard = (row.FindControl("lblCodingStandardsFollowed") as Label).Text;
            string TotalQueries = (row.FindControl("lblNoOfSQLQueriesTotal") as Label).Text;
            string QueriesOptimized = (row.FindControl("lblNoOfSQLQueriesOptimize") as Label).Text;
            string TotalProcedures = (row.FindControl("lblNoOfProceduresTotal") as Label).Text;
            string ProceduresOptimized = (row.FindControl("lblNoOfProceduresOptimize") as Label).Text;
            string MajorChallengesInternal = (row.FindControl("lblInternalNote") as Label).Text;
            string MajorChallengesExternal = (row.FindControl("lblExternalNote") as Label).Text;
            string MajorRequirementsInternal = (row.FindControl("lblRequirementsInternalNote") as Label).Text;
            string MajorRequirementsExternal = (row.FindControl("lblRequirementsExternalNote") as Label).Text;


            if (e.CommandName == "ViewReport")
            {
                litWeeklyReport.Text = @"
<div class='dev-report-paper'>
    <h1>Weekly Report (Development Team)</h1>
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
                <td style='text-align:center;'>1.</td>
                <td><div class='label'>No of task received from Project Manager</div></td>
                <td><div class='label'>" + TaskReceived + @"</div></td>
            </tr>
            <tr>
                <td style='text-align:center;'>2.</td>
                <td><div class='label'>Daily report submitted</div></td>
                <td><div class='label'>Y/N :- " + DailyReportSubmitted + @"</div></td>
            </tr>
            <tr>
                <td style='text-align:center;'>3.</td>
                <td><div class='label'>QA feedback received</div></td>
                <td><div class='label'>Y/N :- " + QAFeedback + @"</div><div class='medium-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align:center;'>4.</td>
                <td><div class='label'>Code audited by " + CodeAuditedBy + @"</div></td>
                <td><div class='label'>Y/N :- " + CodeAudited + @"</div><div class='label reason-text'>Reason (if No) :- " + CodeAuditReason + @"</div><div class='medium-empty'></div></td>
            </tr>
            <tr>
                <td style='text-align:center;'>5.</td>
                <td><div class='label'>Coding standard followed</div></td>
                <td><div class='label'>Y/N :- " + CodingStandard + @"</div></td>
            </tr>
            <tr>
                <td style='text-align:center;'>6.</td>
                <td><div class='label'>No of SQL Queries</div></td>
                <td>
                    <div class='label'>(Total Queries) :- " + TotalQueries + @" No's</div>
                    <div class='label'>Optimize No's :- " + QueriesOptimized + @"</div>
                    <div class='small-empty'></div>
                </td>
            </tr>
            <tr>
                <td style='text-align:center;'>7.</td>
                <td><div class='label'>No of Procedures</div></td>
                <td>
                    <div class='label'>(Total Procedures) :- " + TotalProcedures + @" No's</div>
                    <div class='label'>Optimize No's :- " + ProceduresOptimized + @"</div>
                    <div class='small-empty'></div>
                </td>
            </tr>
            <tr>
                <td style='text-align:center;'>8.</td>
                <td><div class='label'>Any major Challenges</div></td>
                <td>
                    <div class='label reason-text'>Internal :- " + MajorChallengesInternal + @"</div><div class='medium-empty'></div>
                    <div class='label reason-text'>External :- " + MajorChallengesExternal + @"</div><div class='big-empty'></div>
                </td>
            </tr>
            <tr>
                <td style='text-align:center;'>9.</td>
                <td><div class='label'>Any major Requirements</div></td>
                <td>
                    <div class='label reason-text'>Internal :- " + MajorRequirementsInternal + @"</div><div class='medium-empty'></div>
                    <div class='label reason-text'>External :- " + MajorRequirementsExternal + @"</div><div class='big-empty'></div>
                </td>
            </tr>
        </tbody>
    </table>

    <div class='footer-space'></div>

<style>
    .dev-report-paper {
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
    .dev-report-paper h1 {
        text-align: center;
        font-size: 20px;
        margin-bottom: 15px;
        color: #333;
        text-decoration: underline;
        font-weight: bold;
    }
    .dev-report-paper .meta {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        font-size: 15px;
        color: #555;
        font-weight: bold;
    }
    .dev-report-paper table {
        width: 100%;
        border-collapse: collapse;
        border: 1px solid #ccc;
        table-layout: fixed;
        font-size: 16px;
    }
    .dev-report-paper th, .dev-report-paper td {
        border: 1px solid #ccc;
        padding: 6px 5px;
        vertical-align: top;
    }
    .dev-report-paper th {
        background: #f1f1f1;
        font-weight: 600;
        text-align: center;
    }
    .label {
        border-radius: 2px;
        color: #141414;
        font-size: 16px;
        line-height: 1;
        margin-bottom: 0;
        text-transform: capitalize;
        font-weight: 600;
        display: block;
        margin-bottom: 4px;
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
    .dev-report-paper .col-sno { width: 6%; text-align:center;font-weight: bold; }
    .dev-report-paper .col-activity { width: 44%;font-weight: bold;font-weight: bold; }
    .dev-report-paper .col-weekly { width: 50%;font-weight: bold; }
    .dev-report-paper .big-empty { height: 60px; }
    .dev-report-paper .medium-empty { height: 40px; }
    .dev-report-paper .small-empty { height: 20px; }
    .dev-report-paper .footer-space { height: 20px }

    @media print {
        body * { visibility: hidden; }
        .dev-report-paper, .dev-report-paper * { visibility: visible; }
        .dev-report-paper {
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
            }

            string script1 = "var myModal = new bootstrap.Modal(document.getElementById('AddModuleModal')); myModal.show();";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowAddModuleModal", script1, true);


            Datatable();
        }

    }
    protected void Datatable()
    {
        if (gvDevWeeklyReport.Rows.Count > 0)
        {
            gvDevWeeklyReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvDevWeeklyReport.UseAccessibleHeader = true;
        }
    }
}