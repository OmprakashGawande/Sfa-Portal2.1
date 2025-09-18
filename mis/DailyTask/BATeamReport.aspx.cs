using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_BATeamReport : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    private static string BATeamReportId = string.Empty;
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
                FillProjectPlprebyPM();
                Clear(sender, e);
                FillDetails();
                //DateTime currentdate = DateTime.Now;
                //string Date = currentdate.ToString("yyyy/MM/dd", cult);
                //txtDate.Text = currentdate.ToString("dd/MM/yyyy");

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

    private DataSet USP_ServerReport(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_ServerInsertUpdate", columns, values, "ds");
        return ds;
    }
    private bool IsNullDataSet(DataSet ds)
    {
        return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0;
    }

    private DataSet USP_BATeam(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_BATeamReportInsertUpdate", columns, values, "ds");
        return ds;
    }
    private void FillProjectPlprebyPM()
    {
        try
        {
            ddlProjectPlprebyPM.Items.Clear();

            string empId = ViewState["Emp_ID"].ToString();
            ds = USP_ServerReport(new string[] { "Flag" }, new string[] { "1", empId });
            if (IsNullDataSet(ds))
            {
                ddlProjectPlprebyPM.DataTextField = "TaskStatus2";
                ddlProjectPlprebyPM.DataValueField = "TastStatusId";
                ddlProjectPlprebyPM.DataSource = ds.Tables[0];
                ddlProjectPlprebyPM.DataBind();
            }
            ddlProjectPlprebyPM.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }


    protected void ddlAnyMajorChangesRequiredforClient_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAnyMajorChangesRequiredforClient.SelectedValue == "1")
        {
            Div_AMCRfCDetails.Visible = true;
        }
        else
        {
            Div_AMCRfCDetails.Visible = false;
        }
    }

    protected void ddlInternalChallenges_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlInternalChallenges.SelectedValue == "1")
        {
            Div_ACDetail.Visible = true;
        }
        else
        {
            Div_ACDetail.Visible = false;
        }
    }

    protected void ddlProjectonTime_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlProjectonTime.SelectedValue == "2")
        {
            Div_Reason.Visible = true;
        }
        else
        {
            Div_Reason.Visible = false;
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
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        BATeamReportId = string.Empty;
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

                    ds = USP_BATeam(
                          new string[]
                          {
                              "Flag",
                              "BATeamReportId",
                              "TotalProject",
                              "TotalTask",
                              "ClientMeeting",
                              "ProjectPlanPrepared",
                              "AnyMajorChangesRequired",
                              "MajorChangesDetail",
                              "InternalChallenges",
                              "InternalChallengesDetail",
                              "ProjectOnTime",
                              "ProjectOnTimeNoReason",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              BATeamReportId,
                              txtTotalProject.Text.Trim(),
                              txtTotalTask.Text.Trim(),
                              txtClientMeeting.Text.Trim(),
                              ddlProjectPlprebyPM.SelectedValue,
                              ddlAnyMajorChangesRequiredforClient.SelectedValue,
                              txtAMCRfCDetails.Text.Trim(),
                              ddlInternalChallenges.SelectedValue,
                              txtICDetail.Text.Trim(),
                              ddlProjectonTime.SelectedValue,
                              txtReason.Text.Trim(),
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress()
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            Clear(sender, e);
                            FillDetails();
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
        txtTotalProject.Text = string.Empty;
        txtTotalTask.Text = string.Empty;
        txtClientMeeting.Text = string.Empty;
        ddlProjectPlprebyPM.ClearSelection();
        ddlAnyMajorChangesRequiredforClient.ClearSelection();
        ddlAnyMajorChangesRequiredforClient_SelectedIndexChanged(sender, e);
        txtAMCRfCDetails.Text = string.Empty;
        ddlInternalChallenges.ClearSelection();
        ddlInternalChallenges_SelectedIndexChanged(sender, e);
        txtICDetail.Text= string.Empty;
        ddlProjectonTime.ClearSelection();
        ddlProjectonTime_SelectedIndexChanged(sender, e);
        txtReason.Text = string.Empty;

    }
    private void FillDetails()
    
    {
        try
        {
            gvBATeamReport.DataSource = null;
            gvBATeamReport.DataBind();

            ds = USP_BATeam(new string[] { "Flag", "EmployeeId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvBATeamReport.DataSource = ds.Tables[0];
                gvBATeamReport.DataBind();
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
        if (gvBATeamReport.Rows.Count > 0)
        {
            gvBATeamReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvBATeamReport.UseAccessibleHeader = true;
        }
    }
}