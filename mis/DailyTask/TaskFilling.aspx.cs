using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskFilling : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
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
                Initials();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
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
    private void Initials()
    {
        ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

        GetCurrentTaskCount();
        GetProjects();
        GetTaskStatus();
        GetTaskName();
        FillGrid();

        txtDate.Enabled = false;
        txtDate.Attributes.Add("readonly", "readonly");
        DateTime dd = DateTime.Now;
        txtDate.Text = (Convert.ToDateTime(dd, cult).ToString("dd/MM/yyyy"));
        //lblMsg.Text = string.Empty;

        string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
        ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
    }


    private void FillGrid()
    {
        GrvDailyTaskDetail.DataSource = ds.Tables[0];
        GrvDailyTaskDetail.DataBind();

        ds = objdb.ByProcedure("Usp_GetDailyTaskDetail", new string[] { "Emp_id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]) }, "dataset");

        if (IsNullDataSet(ds))
        {
            GrvDailyTaskDetail.DataSource = ds.Tables[0];
            GrvDailyTaskDetail.DataBind();
            Div_DailyTaskDetail.Visible = true;
        }
    }
    private void Clear()
    {
        Initials();
        txtRemark.Text = string.Empty;
        txtTaskRemark.Text = string.Empty;

        grvTaskDis.DataSource = null;
        grvTaskDis.DataBind();
        divTaskDis.Visible = false;
        Div_Status.Visible = false;
        Div_FwdToQa.Visible = false;
        Div_Remark.Visible = false;
        Div_OtherTask.Visible = false;
        Div_button.Visible = false;
        GetTaskStatus();
        txtRemark.Text = string.Empty;

    }
    private void GetCurrentTaskCount()
    {
        try
        {
            lblCurrentTaskCount.Text = string.Empty;
            ds = objdb.ByProcedure("Usp_GetCurrentTaskCount", new string[] { "Emp_id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]) }, "dataset");
            if (IsNullDataSet(ds))
            {
                lblCurrentTaskCount.Text = string.Format(
                                            "You are allocated to {0} project{1} with a total of {2} requirement{3}.",
                                            ds.Tables[0].Rows[0]["TotalProject"].ToString(),
                                            Convert.ToInt32(ds.Tables[0].Rows[0]["TotalProject"]) > 1 ? "s" : "",
                                            ds.Tables[0].Rows[0]["TotalTask"].ToString(),
                                            Convert.ToInt32(ds.Tables[0].Rows[0]["TotalTask"]) > 1 ? "s" : ""
                                            );
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void GetProjects()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetProjects", new string[] { "Emp_id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]) }, "dataset");
            ddlProject.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_Id";
                ddlProject.DataBind();
            }
            ddlProject.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    public void GetTaskName()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetTaskName", new string[] { "Emp_id", "Project_Id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]), ddlProject.SelectedValue }, "dataset");
            ddlTaskName.Items.Clear();
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
            ErrorMsg(ex);
        }
    }

    public void GetTaskStatus()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetTaskStatus", new string[] { }, new string[] { }, "dataset");
            ddlTaskStatus.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlTaskStatus.DataSource = ds.Tables[0];
                ddlTaskStatus.DataTextField = "TaskStatus";
                ddlTaskStatus.DataValueField = "TastStatusId";
                ddlTaskStatus.DataBind();
            }
            ddlTaskStatus.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlTaskName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            grvTaskDis.DataSource = null;
            grvTaskDis.DataBind();
            divTaskDis.Visible = false;
            Div_Status.Visible = false;
            Div_FwdToQa.Visible = false;
            Div_Remark.Visible = false;
            Div_OtherTask.Visible = false;
            Div_button.Visible = false;
            GetTaskStatus();
            txtRemark.Text = string.Empty;
            lblMsg.Text = string.Empty;
            ds = objdb.ByProcedure("Usp_GetTaskDetail", new string[] { "AllocationId", "Emp_id" }, new string[] { ddlTaskName.SelectedValue, Convert.ToString(ViewState["Emp_ID"]) }, "dataset");

            if (IsNullDataSet(ds))
            {
                grvTaskDis.DataSource = ds.Tables[0];
                grvTaskDis.DataBind();
                divTaskDis.Visible = true;
                Div_Status.Visible = true;
                Div_FwdToQa.Visible = true;
                Div_Remark.Visible = true;
                Div_OtherTask.Visible = true;
                Div_button.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            if (ddlProject.SelectedIndex <= 0)
            {
                grvTaskDis.DataSource = null;
                grvTaskDis.DataBind();
                divTaskDis.Visible = false;
                Div_Status.Visible = false;
                Div_FwdToQa.Visible = false;
                Div_Remark.Visible = false;
                Div_OtherTask.Visible = false;
                Div_button.Visible = false;
            }
            GetTaskName();
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlTaskStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            chkFwdToQa.Checked = false;
            if (ddlTaskStatus.SelectedIndex == 1)
            {
                chkFwdToQa.Checked = true;
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
                string ErrorMsg = string.Empty, fwdToQA = string.Empty;

                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (ddlTaskName.Text == "") { ErrorMsg += "Please Select Allocation Date.\\n"; }
                if (ddlTaskStatus.Text == "") { ErrorMsg += "Please Select Allocation Time.\\n"; }
                if (chkQualityCheck.Checked == false) { ErrorMsg += "Please confirm you have checked your development quality as per the checklist.\\n"; }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    if (btnSave.Text.Equals("Save"))
                    {
                        if (chkFwdToQa.Checked)
                        {
                            fwdToQA = "1";
                        }
                        else
                        {
                            fwdToQA = "0";
                        }
                        ds = objdb.ByProcedure("Usp_InsertTask",
                            new string[] { "ProjectId", "EmployeeId", "AllocationId", "TastStatusId", "FwdtoQA", "TaskRemark", "OtherTaskAndRemark", "CreatedBy", "CreatedByIp" },
                            new string[] { ddlProject.SelectedValue, Convert.ToString(ViewState["Emp_ID"]), ddlTaskName.SelectedValue, ddlTaskStatus.SelectedValue, fwdToQA, txtTaskRemark.Text, txtRemark.Text, Convert.ToString(ViewState["Emp_ID"]), objdb.GetLocalIPAddress() }, "dataset");
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
    protected void cvChkAgree_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = chkQualityCheck.Checked;
    }

}