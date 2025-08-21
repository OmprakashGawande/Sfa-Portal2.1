using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Transaction_ProjectManagerProcess : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds, ds2;
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
                BindDropdown();

                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }
    private bool IsNullDataSet(DataSet ds)
    {
        return ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0;
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

    public void BindDropdown()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetProjectForProjectManager", new string[] { }, new string[] { }, "dataset");
            ddlProject.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_ID";
                ddlProject.DataBind();
            }
            ddlProject.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            throw new Exception("Error while binding Type of Employee dropdown: " + ex.Message);
        }
    }

    protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlTaskName.Items.Clear();
            ds = objdb.ByProcedure("Usp_GetTaskNameForProjectManager", new string[] { "ProjectId" }, new string[] { ddlProject.SelectedValue }, "dataset");
            if (IsNullDataSet(ds))
            {
                ddlTaskName.DataSource = ds.Tables[0];
                ddlTaskName.DataTextField = "TaskName";
                ddlTaskName.DataValueField = "AllocationId";
                ddlTaskName.DataBind();

            }
            ddlTaskName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {

            throw new Exception("Error while binding Type of Requirement Point dropdown: " + ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = objdb.ByProcedure("Usp_GetTaskDetailforProjectManagerReviewProcess",
           new string[] { "ProjectId", "AllocationId" },
           new string[] { ddlProject.SelectedValue, ddlTaskName.SelectedValue },
           "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dataGrid.DataSource = ds.Tables[0];
                dataGrid.DataBind();
                dataGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                dataGrid.UseAccessibleHeader = true;
                divCheck.Visible = true;
            }
            else
            {
                dataGrid.DataSource = null;
                dataGrid.DataBind();
                lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Record Found");
            }
        }
        catch (Exception ex)
        {

            ErrorMsg(ex);
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
                string DevQuality = string.Empty; string ReqFullField = string.Empty; string SendToAudit = string.Empty;

                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (ddlTaskName.Text == "") { ErrorMsg += "Please Select Allocation Date.\\n"; }
                if (chkQualityCheck.Checked == false) { ErrorMsg += "Please confirm you have checked your development quality / processes.\\n"; }
                if (chkReqFullField.Checked == false) { ErrorMsg += "Please confirm client requirement has been fulfilled properly.\\n"; }
                if (chkSendToAudit.Checked == false) { ErrorMsg += "Please confirm you are sending this to the audit team.\\n"; }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    if (btnSave.Text.Equals("Send"))
                    {
                        DevQuality = chkQualityCheck.Checked ? "1" : "0";
                        ReqFullField = chkReqFullField.Checked ? "1" : "0";
                        SendToAudit = chkSendToAudit.Checked ? "1" : "0";

                        ds = objdb.ByProcedure("Usp_InsertProjectManagerReviewProcess",
                            new string[] { "ProjectId", "AllocationId", "DevQuality", "ReqFullField", "SendToAudit", "CreatedBy", "CreatedByIp" },
                            new string[] { ddlProject.SelectedValue, ddlTaskName.SelectedValue, DevQuality, ReqFullField, SendToAudit, Convert.ToString(ViewState["Emp_ID"]), objdb.GetLocalIPAddress() }, "dataset");
                        if (IsNullDataSet(ds))
                        {
                            if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                            {
                                SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                                Clear();
                            }
                            else
                            {
                                WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            }
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

    private void Clear()
    {
        ddlProject.ClearSelection();
        ddlTaskName.Items.Clear();

        dataGrid.DataSource = null;
        dataGrid.DataBind();
        divCheck.Visible = false;
        chkQualityCheck.Checked = false;
        chkReqFullField.Checked = false;
        chkSendToAudit.Checked = false;
    }
}