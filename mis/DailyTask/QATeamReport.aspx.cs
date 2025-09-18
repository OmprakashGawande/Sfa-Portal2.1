using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_QATeamReport : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    private static string QATeamTaskReportId = string.Empty;
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
                FillDetails();

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

    private DataSet USP_QATeam(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_QATeamTaskReportInsertUpdate", columns, values, "ds");
        return ds;
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
                        QATeamTaskReportId = string.Empty;
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

                    ds = USP_QATeam(
                          new string[]
                          {
                              "Flag",
                              "QATeamTaskReportId",
                              "TotalProject",
                              "AllocatedTask",
                              "BugMajor",
                              "BugMinor",
                              "TestCasesPrepared",
                              "Apply",
                              "Pass",
                              "Fail",
                              "VulnerabilityReport",
                              "OtherDetails",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              QATeamTaskReportId,
                              txtTotalProject.Text.Trim(),
                              txtAllocatedTask.Text.Trim(),
                              txtBugsMajor.Text.Trim(),
                              txtMinor.Text.Trim(),
                              txtTestCasesPrepared.Text.Trim(),
                              txtApply.Text.Trim(),
                              txtPass.Text.Trim(),
                              txtFail.Text.Trim(),
                              txtVulnerabilityReport.Text.Trim(),
                              txtOtherDetails.Text.Trim(),
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
        txtAllocatedTask.Text = string.Empty;
        txtBugsMajor.Text = string.Empty;
        txtMinor.Text = string.Empty;
        txtTestCasesPrepared.Text = string.Empty;
        txtApply.Text = string.Empty;
        txtPass.Text = string.Empty;
        txtFail.Text = string.Empty;
        txtVulnerabilityReport.Text = string.Empty;
        txtOtherDetails.Text = string.Empty;

    }
    private void FillDetails()

    {
        try
        {
            gvQATeamReport.DataSource = null;
            gvQATeamReport.DataBind();

            ds = USP_QATeam(new string[] { "Flag", "EmployeeId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvQATeamReport.DataSource = ds.Tables[0];
                gvQATeamReport.DataBind();
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
        if (gvQATeamReport.Rows.Count > 0)
        {
            gvQATeamReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvQATeamReport.UseAccessibleHeader = true;
        }
    }
}