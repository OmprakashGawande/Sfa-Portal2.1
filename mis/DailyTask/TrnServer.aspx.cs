using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TrnServer : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    private static string ServertId = string.Empty;
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
                FillEmployee();
                Clear(sender, e);
                FillGridServerDetails();
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

    private DataSet USP_ServerReport(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_InsertUpdateServer", columns, values, "ds");
        return ds;
    }
    private bool IsNullDataSet(DataSet ds)
    {
        return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0;
    }

    private DataSet USP_Server(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_ServerInsertUpdate", columns, values, "ds");
        return ds;
    }
    private void FillEmployee()
    {
        try
        {
            ddlAllBackups.Items.Clear();

            string empId = ViewState["Emp_ID"].ToString();
            ds = USP_Server(new string[] { "Flag" }, new string[] { "1", empId });
            if (IsNullDataSet(ds))
            {
                ddlAllBackups.DataTextField = "TaskStatus2";
                ddlAllBackups.DataValueField = "TastStatusId";
                ddlAllBackups.DataSource = ds.Tables[0];
                ddlAllBackups.DataBind();
            }
            ddlAllBackups.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlVulnerabilityReportAll_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlVulnerabilityReportAll.SelectedValue == "1")
        {
            Div_NoofReprot.Visible = true;
        }
        else
        {
            Div_NoofReprot.Visible = false;
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
                        ServertId = string.Empty;
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

                    ds = USP_ServerReport(
                          new string[]
                          {
                              "Flag",
                              "PMWeeklyReportId",
                              "ServerDate",
                              "TotalProjectUpload",
                              "TotalDatabase",
                              "TotalSpaceGB",
                              "AllBackups",
                              "BackupChallenges",
                              "AnyInternalSupportRequired",
                              "AnyActionToBeTaken",
                              "AverageUtilization",
                              "IsAuditedFromAuditTeam",
                              "VulnerabilityReportAll",
                              "NoOfReports",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              ServertId,
                              Convert.ToString(Date),
                              txtTotalProjectUpload.Text.Trim(),
                              txtDatabase.Text.Trim(),
                              txtTotalSpace.Text.Trim(),
                              ddlAllBackups.SelectedValue,
                              ddlBackupChallenges.SelectedValue,
                              txtAISR.Text.Trim(),
                              txtAATBT.Text.Trim(),
                              txtAverageUtilization.Text.Trim(),
                              ddlVulnerabilityReportAll.SelectedValue,
                              txtNoofReprot.Text.Trim(),
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress()
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            FillGridServerDetails();
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
        txtDate.Text = string.Empty;
        txtTotalProjectUpload.Text = string.Empty;
        txtDatabase.Text = string.Empty;
        txtTotalSpace.Text = string.Empty;
        ddlAllBackups.ClearSelection();
        ddlBackupChallenges.ClearSelection();
        ddlVulnerabilityReportAll.ClearSelection();
        txtAISR.Text = string.Empty;
        txtAATBT.Text = string.Empty;
        txtAverageUtilization.Text = string.Empty;
        txtNoofReprot.Text = string.Empty;
        ddlVulnerabilityReportAll_SelectedIndexChanged(sender, e);
    }
    private void FillGridServerDetails()
    {
        try
        {
            gvServerReport.DataSource = null;
            gvServerReport.DataBind();

            ds = USP_ServerReport(new string[] { "Flag", "EmployeeId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvServerReport.DataSource = ds.Tables[0];
                gvServerReport.DataBind();
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
        if (gvServerReport.Rows.Count > 0)
        {
            gvServerReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvServerReport.UseAccessibleHeader = true;
        }
    }
}