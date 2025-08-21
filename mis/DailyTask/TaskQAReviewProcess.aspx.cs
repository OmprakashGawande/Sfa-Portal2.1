using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskQAReviewProcess : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    private static string taskForwardedToQAId = string.Empty;
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

    private DataSet USP_QAReviewProcess(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_QAReviewProcess", columns, values, "ds");
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
        txtTotalTestCase.Text = string.Empty;
        txtPassTestCase.Text = string.Empty;
        txtFailTestCase.Text = string.Empty;
        btnSave.Text = "Save";
        FillProject();
        FillTaskName();
        FillGrid();
        dvTestCase.Visible = false;
        ddlProject.Enabled = true;
        ddlTaskName.Enabled = true;
        taskForwardedToQAId = string.Empty;
    }

    private void Initials()
    {
        try
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

            FillProject();
            FillGrid();
            FillStatus();
            FillTaskName();
            dvTestCase.Visible = false;

            //fill breadcrumb.
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
            ds = USP_QAReviewProcess(new string[] { "Flag", "EmployeeId_QA" }, new string[] { "1", Convert.ToString(ViewState["Emp_ID"]) });
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

    private void FillTaskName()
    {
        try
        {
            ddlTaskName.Items.Clear();
            ds = USP_QAReviewProcess(new string[] { "Flag", "EmployeeId_QA", "ProjectId" }, new string[] { "2", Convert.ToString(ViewState["Emp_ID"]), ddlProject.SelectedValue });
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
            ddlStatus.Items.Insert(0, new ListItem("Yes", "1"));
            ddlStatus.Items.Insert(0, new ListItem("No", "0"));
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

            ds = USP_QAReviewProcess(new string[] { "Flag", "EmployeeId" }, new string[] { "4", Convert.ToString(ViewState["Emp_ID"]) });
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

    protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            FillTaskName();
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlStatus.SelectedValue.Equals("1"))
            {
                dvTestCase.Visible = true;
            }
            else
            {
                dvTestCase.Visible = false;
                txtTotalTestCase.Text = string.Empty;
                txtPassTestCase.Text = string.Empty;
                txtFailTestCase.Text = string.Empty;
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

                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (ddlTaskName.SelectedValue == "0") { ErrorMsg += "Please Select Requirement Point.\\n"; }

                if (ddlStatus.SelectedValue.Equals("1"))
                {
                    int total = 0, pass = 0, fail = 0;

                    if (string.IsNullOrWhiteSpace(txtTotalTestCase.Text) || !int.TryParse(txtTotalTestCase.Text, out total) || total <= 0)
                    {
                        ErrorMsg += "Total Test Cases must be greater than 0.\n";
                    }

                    if (string.IsNullOrWhiteSpace(txtPassTestCase.Text) || !int.TryParse(txtPassTestCase.Text, out pass) || pass < 0)
                    {
                        ErrorMsg += "Pass Test Cases must be greater than 0.\n";
                    }

                    if (string.IsNullOrWhiteSpace(txtFailTestCase.Text) || !int.TryParse(txtFailTestCase.Text, out fail) || fail < 0)
                    {
                        ErrorMsg += "Fail Test Cases must be greater than 0.\n";
                    }

                    if (ErrorMsg == "")
                    {
                        if (pass == 0 && fail == 0)
                        {
                            ErrorMsg += "Either Pass Test Cases or Fail Test Cases must be greater than 0.\n";
                        }

                        if ((pass + fail) != total)
                        {
                            ErrorMsg += "Sum of Pass and Fail Test Cases must be exactly equal to Total Test Cases.\n";
                        }
                    }
                }

                else if (ddlStatus.SelectedValue.Equals("0"))
                {
                    txtTotalTestCase.Text = string.Empty;
                    txtPassTestCase.Text = string.Empty;
                    txtFailTestCase.Text = string.Empty;
                }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        taskForwardedToQAId = string.Empty;
                        flag = "3";
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "5";
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg("Something went wrong, Please try after sometime.");
                        return;
                    }

                    ds = USP_QAReviewProcess(
                          new string[]
                          {
                              "Flag",
                              "ProjectId",
                              "EmployeeId_QA",
                              "AllocationId",
                              "Status",
                              "TotalTestCase",
                              "PassTestCase",
                              "FailTestCase",
                              "CreatedBy",
                              "CreatedByIp",
                              "taskForwardedToQAId"
                          },
                          new string[]
                          {
                              flag,
                              ddlProject.SelectedValue,
                              Convert.ToString(ViewState["Emp_ID"]),
                              ddlTaskName.SelectedValue,
                              ddlStatus.SelectedValue,
                              txtTotalTestCase.Text,
                              txtPassTestCase.Text,
                              txtFailTestCase.Text,
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress(),
                              taskForwardedToQAId
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
            taskForwardedToQAId = e.CommandArgument.ToString();
            if (e.CommandName == "RecordEdit")
            {
                Label lblProjectId = (Label)row.FindControl("lblProjectId");
                Label lblAllocationId = (Label)row.FindControl("lblAllocationId");
                Label lblProject_Name = (Label)row.FindControl("lblProject_Name");
                Label lblTaskName = (Label)row.FindControl("lblTaskName");
                Label lblQAStatusId = (Label)row.FindControl("lblQAStatusId");
                Label lblTotalTestCase = (Label)row.FindControl("lblTotalTestCase");
                Label lblPassTestCase = (Label)row.FindControl("lblPassTestCase");
                Label lblFailTestCase = (Label)row.FindControl("lblFailTestCase");

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
                if (lblQAStatusId != null && ddlStatus.Items.FindByValue(lblQAStatusId.Text) != null)
                {
                    ddlStatus.ClearSelection();
                    ddlStatus.Items.FindByValue(lblQAStatusId.Text).Selected = true;

                    if (lblQAStatusId.Text.Equals("1"))
                    {
                        dvTestCase.Visible = true;
                    }
                }
                if (lblTotalTestCase != null)
                    txtTotalTestCase.Text = lblTotalTestCase.Text;

                if (lblPassTestCase != null)
                    txtPassTestCase.Text = lblPassTestCase.Text;

                if (lblFailTestCase != null)
                    txtFailTestCase.Text = lblFailTestCase.Text;

                btnSave.Text = "Update";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
}