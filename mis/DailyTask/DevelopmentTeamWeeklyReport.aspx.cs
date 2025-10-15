using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_DevelopmentTeamWeeklyReport : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    private static string DevReportId = string.Empty;
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
                FillGridDetails();
                DateTime currentdate = DateTime.Now;
                txtDate.Enabled = false;
                txtDate.Attributes.Add("readonly", "readonly");
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

    private DataSet USP_DevWeeklyReport(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_DevelopmentTeamWeeklyReportInsertUpdate", columns, values, "ds");
        return ds;
    }
    protected void ddlCodeAudited_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlCodeAudited.SelectedValue == "2")
        {
            Div_CodeAuditedReason.Visible = true;
            RFV5.Enabled = true;
            Div_CodeAuditedby.Visible = false;
            RFVCodeAuditedby.Enabled = false;
        }
        else if (ddlCodeAudited.SelectedValue == "1")
        {
            Div_CodeAuditedby.Visible = true;
            RFVCodeAuditedby.Enabled = true;
            Div_CodeAuditedReason.Visible = false;
            RFV5.Enabled = false;
        }
        else
        {
            Div_CodeAuditedReason.Visible = false;
            RFV5.Enabled = false;
            Div_CodeAuditedby.Visible = false;
            RFVCodeAuditedby.Enabled = false;
        }
    }



    protected void ddlAnyMajorChallenges_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAnyMajorChallenges.SelectedValue == "1")
        {
            Div_Internal.Visible = true;
            RFV12.Enabled = true;
            Div_External.Visible = true;
            RFV13.Enabled = true;
        }
        else
        {
            Div_Internal.Visible = false;
            RFV12.Enabled = false;
            Div_External.Visible = false;
            RFV13.Enabled = false;
        }
    }

    protected void ddlAnyMajorRequirements_SelectedIndexChanged(object sender, EventArgs e)
    {
        Datatable();
        if (ddlAnyMajorRequirements.SelectedValue == "1")
        {
            Div_RequirementsInternal.Visible = true;
            RFV15.Enabled = true;
            Div_RequirementsExternal.Visible = true;
            RFV16.Enabled = true;
        }
        else
        {
            Div_RequirementsInternal.Visible = false;
            RFV15.Enabled = false;
            Div_RequirementsExternal.Visible = false;
            RFV16.Enabled = false;
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
                        DevReportId = string.Empty;
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

                    ds = USP_DevWeeklyReport(
                          new string[]
                          {
                              "Flag",
                              "DevReportId",
                              "ReportDate",
                              "NoOfTaskReceivedFromPM",
                              "DailyReportSubmitted",
                              "QAFeedbackReceived",
                              //"CodeAuditedByRiteshSir",
                              "CodeAudited",
                              "CodeAuditedBy",
                              "Reason",
                              "CodingStandardsFollowed",
                              "NoOfSQLQueriesTotal",
                              "NoOfSQLQueriesOptimize",
                              "NoOfProceduresTotal",
                              "NoOfProceduresOptimize",
                              "AnyMajorChallenges",
                              "InternalNote",
                              "ExternalNote",
                              "AnyMajorRequirements",
                              "RequirementsInternalNote",
                              "RequirementsExternalNote",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              DevReportId,
                              Convert.ToString(Date),
                              txtNoofTRFPM.Text.Trim(),
                              ddlDailyReportSubmitted.SelectedValue,
                              ddlQAFeedbackReceived.SelectedValue,
                              ddlCodeAudited.SelectedValue,
                              txtCodeAuditedby.Text.Trim(),
                              txtCodeAuditedReason.Text.Trim(),
                              ddlCodingStandardsFollowed.SelectedValue,
                              txtNoofSQLQueries.Text.Trim(),
                              txtNoofSQLQueriesOptimize.Text.Trim(),
                              txtNoofProcedures.Text.Trim(),
                              txtNoofProceduresOptimize.Text.Trim(),
                              ddlAnyMajorChallenges.SelectedValue,
                              txtInternal.Text.Trim(),
                              txtExternal.Text.Trim(),
                              ddlAnyMajorRequirements.SelectedValue,
                              txtRequirementsInternal.Text.Trim(),
                              txtRequirementsExternal.Text.Trim(),
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress()
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            FillGridDetails();
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
        txtNoofTRFPM.Text = string.Empty;
        ddlDailyReportSubmitted.ClearSelection();
        ddlQAFeedbackReceived.ClearSelection();
        ddlCodeAudited.ClearSelection();
        ddlCodeAudited_SelectedIndexChanged(sender, e);
        txtCodeAuditedby.Text = string.Empty;
        txtCodeAuditedReason.Text = string.Empty;
        ddlCodingStandardsFollowed.ClearSelection();
        txtNoofSQLQueries.Text = string.Empty;
        txtNoofSQLQueriesOptimize.Text = string.Empty;
        txtNoofProcedures.Text = string.Empty;
        txtNoofProceduresOptimize.Text = string.Empty;
        ddlAnyMajorChallenges.ClearSelection();
        ddlAnyMajorChallenges_SelectedIndexChanged(sender ,e);
        txtInternal.Text = string.Empty;
        txtExternal.Text = string.Empty;
        ddlAnyMajorRequirements.ClearSelection();
        ddlAnyMajorRequirements_SelectedIndexChanged(sender, e);
        txtRequirementsInternal.Text = string.Empty;
        txtRequirementsExternal.Text = string.Empty;
    }
    private void FillGridDetails()
    {
        try
        {
            gvDevReport.DataSource = null;
            gvDevReport.DataBind();

            ds = USP_DevWeeklyReport(new string[] { "Flag", "EmployeeId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvDevReport.DataSource = ds.Tables[0];
                gvDevReport.DataBind();
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
        if (gvDevReport.Rows.Count > 0)
        {
            gvDevReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvDevReport.UseAccessibleHeader = true;
        }
    }
}