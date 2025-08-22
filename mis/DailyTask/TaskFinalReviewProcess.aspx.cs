using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskFinalReviewProcess : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    private static string finalReviewId = string.Empty;
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
        catch (Exception)
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    private DataSet USP_FinalReviewProcess(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_FinalReviewProcess", columns, values, "ds");
        return ds;
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

    private void Clear()
    {
        ddlProject.ClearSelection();
        ddlTaskName.ClearSelection();
        ddlStatus.ClearSelection();
        FillGrid();
        btnSave.Text = "Save";
        finalReviewId = string.Empty;
        dvAllocatedDetails.Visible = false;
    }

    private void Initials()
    {
        try
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

            FillProject();
            FillTask();
            FillStatus();
            FillGrid();
            dvAllocatedDetails.Visible = false;

            string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
            ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillProject()
    {
        try
        {
            ddlProject.Items.Clear();
            ds = USP_FinalReviewProcess(new string[] { "Flag" }, new string[] { "1" });
            if (IsNullDataSet(ds))
            {
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_Id";
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataBind();
            }
            ddlProject.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillTask()
    {
        try
        {
            ddlTaskName.Items.Clear();
            ds = USP_FinalReviewProcess(new string[] { "Flag", "ProjectId" }, new string[] { "2", ddlProject.SelectedValue });
            if (IsNullDataSet(ds))
            {
                ddlTaskName.DataTextField = "TaskName";
                ddlTaskName.DataValueField = "AllocationId";
                ddlTaskName.DataSource = ds.Tables[0];
                ddlTaskName.DataBind();
            }
            ddlTaskName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillStatus()
    {
        try
        {
            ddlStatus.Items.Clear();
            ds = USP_FinalReviewProcess(new string[] { "Flag" }, new string[] { "3" });
            if (IsNullDataSet(ds))
            {
                ddlStatus.DataTextField = "TaskStatus";
                ddlStatus.DataValueField = "TastStatusId";
                ddlStatus.DataSource = ds.Tables[0];
                ddlStatus.DataBind();
            }
            ddlStatus.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillGrid()
    {
        try
        {
            gvDetails.DataSource = null;
            gvDetails.DataBind();
            ds = null;

            ds = USP_FinalReviewProcess(new string[] { "Flag", "EmployeeId" }, new string[] { "5", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvDetails.DataSource = ds.Tables[0];
                gvDetails.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillGridAlreadyAllocatedTask()
    {
        try
        {
            dvAllocatedDetails.Visible = false;
            gvAllocatedRequirements.DataSource = null;
            gvAllocatedRequirements.DataBind();

            ds = USP_FinalReviewProcess(new string[] { "Flag", "AllocationId", "ProjectId" }, new string[] { "7", ddlTaskName.SelectedValue, ddlProject.SelectedValue });
            if (IsNullDataSet(ds))
            {
                dvAllocatedDetails.Visible = true;
                gvAllocatedRequirements.DataSource = ds.Tables[0];
                gvAllocatedRequirements.DataBind();
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
            FillTask();
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
            FillGridAlreadyAllocatedTask();
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

                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (ddlTaskName.SelectedValue == "0") { ErrorMsg += "Please Select Requirement Point.\\n"; }
                if (ddlStatus.Text == "") { ErrorMsg += "Please Select Status.\\n"; }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        finalReviewId = string.Empty;
                        flag = "4";
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

                    ds = USP_FinalReviewProcess(
                          new string[]
                          {
                              "Flag",
                              "ProjectId",
                              "AllocationId",
                              "TaskStatusId",
                              "CreatedBy",
                              "CreatedByIp",
                              "FinalReviewId"
                          },
                          new string[]
                          {
                              flag,
                              ddlProject.SelectedValue,
                              ddlTaskName.SelectedValue,
                              ddlStatus.SelectedValue,
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress(),
                              finalReviewId
                          });

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
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            finalReviewId = e.CommandArgument.ToString();

            if (e.CommandName == "RecordEdit")
            {
                Label lblProjectId = (Label)row.FindControl("lblProjectId");
                Label lblProject_Name = (Label)row.FindControl("lblProject_Name");
                Label lblAllocationId = (Label)row.FindControl("lblAllocationId");
                Label lblTaskName = (Label)row.FindControl("lblTaskName");
                Label lblTaskStatusId = (Label)row.FindControl("lblTaskStatusId");

                if (lblProjectId != null && lblProject_Name != null)
                {
                    ddlProject.Enabled = false;
                    ddlProject.Items.Clear();
                    ddlProject.Items.Insert(0, new ListItem(lblProject_Name.Text, lblProjectId.Text));
                }
                if (lblAllocationId != null && lblTaskName != null)
                {
                    ddlTaskName.Enabled = false;
                    ddlTaskName.Items.Clear();
                    ddlTaskName.Items.Insert(0, new ListItem(lblTaskName.Text, lblAllocationId.Text));
                }
                if (lblTaskStatusId != null && ddlStatus.Items.FindByValue(lblTaskStatusId.Text) != null)
                {
                    ddlStatus.ClearSelection();
                    ddlStatus.Items.FindByValue(lblTaskStatusId.Text).Selected = true;
                }


                btnSave.Text = "Update";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }

    }

}