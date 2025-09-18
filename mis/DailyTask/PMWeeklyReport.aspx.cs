using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_PMWeeklyReport : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    private static string PMWeeklyReportId = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Emp_ID"] == null)
            {
                Response.Redirect("~/mis/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                Clear(sender, e);
                FillGridTakDetails();
                DateTime currentdate = DateTime.Now;
                string Date = currentdate.ToString("yyyy/MM/dd", cult);
                txtDate.Text = currentdate.ToString("dd/MM/yyyy");

                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    private string ErrorMsg(Exception ex)
    {
        lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry! : Error ", ex.Message.ToString());
        return lblMsg.Text;
    }
    private string SuccessMsg(string msg)
    {
        lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Thank You!", msg);
        return lblMsg.Text;
    }
    private string WarningMsg(string msg)
    {
        lblMsg.Text = objdb.Alert("fa-warning", "alert-warning", "Warning!", "Info :" + msg);
        return lblMsg.Text;
    }

    private bool IsNullDataSet(DataSet ds)
    {
        return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0;
    }

    private DataSet USP_PMWeeklyReport(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_PMWeeklyReportInsertUpdate", columns, values, "ds");
        return ds;
    }
    protected void ddlTimeOverrun_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlTimeOverrun.SelectedValue == "1")
        {
            Div_TOReason.Visible = true;
            RFV4.Enabled = true;
        }
        else
        {
            Div_TOReason.Visible = false;
            RFV4.Enabled = false;
        }
    }

    protected void ddlClientMeeting_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlClientMeeting.SelectedValue == "1")
        {
            Div_NoofMeeting.Visible = true;
            RFV6.Enabled = true;
        }
        else
        {
            Div_NoofMeeting.Visible = false;
            RFV6.Enabled = false;
        }
    }

    protected void ddlProjectDelay_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlProjectDelay.SelectedValue == "1")
        {
            Div_PDReason.Visible = true;
            RFV12.Enabled = true;
        }
        else
        {
            Div_PDReason.Visible = false;
            RFV12.Enabled = false;
        }
    }

    protected void ddlMajorChallenges_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlMajorChallenges.SelectedValue == "1")
        {
            Div_MCDetail.Visible = true;
            RFV14.Enabled = true;
        }
        else
        {
            Div_MCDetail.Visible = false;
            RFV14.Enabled = false;
        }
    }

    protected void ddlAnyInternalSupportRequired_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAnyInternalSupportRequired.SelectedValue == "1")
        {
            Div_AISRDetail.Visible = true;
            RFV16.Enabled = true;
        }
        else
        {
            Div_AISRDetail.Visible = false;
            RFV16.Enabled = false;
        }
    }

    protected void ddlAnyExternalSupportRequired_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAnyExternalSupportRequired.SelectedValue == "1")
        {
            Div_AESRDetail.Visible = true;
            RFV18.Enabled = true;
        }
        else
        {
            Div_AESRDetail.Visible = false;
            RFV18.Enabled = false;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                lblMsg.Text = string.Empty;
                string ErrorMsg = string.Empty;

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    string Date = txtDate.Text != "" ? Convert.ToDateTime(txtDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        PMWeeklyReportId = string.Empty;
                        flag = "1";
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "6";
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg("Something went wrong, Please try after sometime.");
                        return;
                    }

                    ds = USP_PMWeeklyReport(
                          new string[]
                          {
                              "Flag",
                              "PMWeeklyReportId",
                              "WeeklyReportDate",
                              "TotalProject",
                              "TotalTask",
                              "IsTimeOverrun",
                              "TimeOverrunReason",
                              "IsClientMeeting",
                              "NumberOfMeetings",
                              "TestCasesPassed",
                              "TestCasesFail",
                              "IsCodeUpload",
                              "IsAuditedFromAuditTeam",
                              "IsProjectDelay",
                              "ProjectDelayReason",
                              "IsMajorChallenges",
                              "MajorChallengesDetail",
                              "IsInternalSupportRequired",
                              "InternalSupportDetail",
                              "IsExternalSupportRequired",
                              "ExternalSupportDetail",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              PMWeeklyReportId,
                              Convert.ToString(Date),
                              txtTotalProject.Text.Trim(),
                              txtTotalTask.Text.Trim(),
                              ddlTimeOverrun.SelectedValue,
                              txtTOReason.Text.Trim(),
                              ddlClientMeeting.SelectedValue,
                              txtNoofMeeting.Text.Trim(),
                              txtTestCasesPassed.Text.Trim(),
                              txtTestCasesFail.Text.Trim(),
                              ddlCodeUpload.SelectedValue,
                              ddlAuditedfromAuditTeam.SelectedValue,
                              ddlProjectDelay.SelectedValue,
                              txtPDReason.Text.Trim(),
                              ddlMajorChallenges.SelectedValue,
                              txtMCDetail.Text.Trim(),
                              ddlAnyInternalSupportRequired.SelectedValue,
                              txtAISRDetail.Text.Trim(),
                              ddlAnyExternalSupportRequired.SelectedValue,
                              txtAESRDetail.Text.Trim(),
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress()
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            Clear(sender, e);
                        }
                        else
                        {
                            WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

            ErrorMsg(ex);
        }
    }

    private void Clear(object sender, EventArgs e)
    {
        //txtDate.Text = string.Empty;
        txtTotalProject.Text = string.Empty;
        txtTotalTask.Text = string.Empty;
        ddlTimeOverrun.ClearSelection();
        ddlTimeOverrun_SelectedIndexChanged(sender, e);
        txtTOReason.Text = string.Empty;
        ddlClientMeeting.ClearSelection();
        ddlClientMeeting_SelectedIndexChanged(sender, e);
        txtNoofMeeting.Text = string.Empty;
        txtTestCasesPassed.Text = string.Empty;
        txtTestCasesFail.Text = string.Empty;
        ddlCodeUpload.ClearSelection();
        ddlAuditedfromAuditTeam.ClearSelection();
        ddlProjectDelay.ClearSelection();
        ddlProjectDelay_SelectedIndexChanged(sender, e);
        txtPDReason.Text = string.Empty;
        ddlMajorChallenges.ClearSelection();
        ddlMajorChallenges_SelectedIndexChanged(sender, e);
        txtMCDetail.Text = string.Empty;
        ddlAnyInternalSupportRequired.ClearSelection();
        ddlAnyInternalSupportRequired_SelectedIndexChanged(sender, e);
        txtAISRDetail.Text = string.Empty;
        ddlAnyExternalSupportRequired.ClearSelection();
        ddlAnyExternalSupportRequired_SelectedIndexChanged(sender, e);
        txtAESRDetail.Text = string.Empty;
    }
    private void FillGridTakDetails()
    {
        try
        {
            gvPMWeeklyReport.DataSource = null;
            gvPMWeeklyReport.DataBind();

            ds = USP_PMWeeklyReport(new string[] { "Flag", "EmployeeId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvPMWeeklyReport.DataSource = ds.Tables[0];
                gvPMWeeklyReport.DataBind();
                Datatable();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    protected void Datatable()
    {
        if (gvPMWeeklyReport.Rows.Count > 0)
        {
            gvPMWeeklyReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvPMWeeklyReport.UseAccessibleHeader = true;
        }
    }


    protected void ddlTaskATATM_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlTaskATATM.SelectedValue == "2")
        {
            Div_TaskATATMReason.Visible = true;
            RFV20.Enabled = true;
        }
        else
        {
            Div_TaskATATMReason.Visible = false;
            RFV20.Enabled = false;
        }
    }

    protected void ddlReportingSubmittedbyAllTeam_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlReportingSubmittedbyAllTeam.SelectedValue == "2")
        {
            Div_ReportingSubmittedbyAllTeamReason.Visible = true;
            RFV22.Enabled = true;
        }
        else
        {
            Div_ReportingSubmittedbyAllTeamReason.Visible = false;
            RFV22.Enabled = false;
        }
    }

    protected void ddlDailyStandupMeeting_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlDailyStandupMeeting.SelectedValue == "2")
        {
            Div_DailyStandupMeeting.Visible = true;
            RFV25.Enabled = true;
        }
        else
        {
            Div_DailyStandupMeeting.Visible = false;
            RFV25.Enabled = false;
        }
    }

    protected void ddlAllMOMEmailShered_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAllMOMEmailShered.SelectedValue == "2")
        {
            Div_AllMOMEmailShered.Visible = true;
            RFV25.Enabled = true;
        }
        else
        {
            Div_AllMOMEmailShered.Visible = false;
            RFV25.Enabled = false;
        }
    }

    protected void ddlAnyTeamMemberesU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAnyTeamMemberesU.SelectedValue == "1")
        {
            Div_AnyTeamMemberesU.Visible = true;
            RFV29.Enabled = true;
        }
        else
        {
            Div_AnyTeamMemberesU.Visible = false;
            RFV29.Enabled = false;
        }
    }
}