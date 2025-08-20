using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskAllocation : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();
    private static string taskAllocationId = string.Empty;
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

    private DataSet USP_TaskAllocation(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_TaskAllocation", columns, values, "ds");
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
        ddlEmployee.ClearSelection();
        ddlProject.ClearSelection();
        ddlPriorityType.ClearSelection();
        ddlQA.ClearSelection();
        txtAllocationDate.Text = string.Empty;
        txtAllocationTime.Text = string.Empty;
        txtTaskName.Text = string.Empty;
        txtTaskDescription.InnerHtml = string.Empty;
        FillGridTakDetails();
        FillGridAlreadyAllocatedTask();
        btnSave.Text = "Save";
    }

    private void Initials()
    {
        try
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

            FillEmployee();
            FillProject();
            FillGridTakDetails();
            FillPriorityType();
            FillQA();

            txtAllocationDate.Attributes.Add("readonly", "readonly");
            dvAllocatedRequirements.Visible = false;    
            //fill breadcrumb.
            Session["PageTokan"] = Server.UrlEncode(System.DateTime.Now.ToString());
            string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
            ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillEmployee()
    {
        try
        {
            ddlEmployee.Items.Clear();
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "1" });
            if (IsNullDataSet(ds))
            {
                ddlEmployee.DataTextField = "Employee_Name";
                ddlEmployee.DataValueField = "Employee_Id";
                ddlEmployee.DataSource = ds.Tables[0];
                ddlEmployee.DataBind();
            }
            ddlEmployee.Items.Insert(0, new ListItem("Select", "0"));
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
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "2" });
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

    private void FillPriorityType()
    {
        try
        {
            ddlPriorityType.Items.Clear();
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "7" });
            if (IsNullDataSet(ds))
            {
                ddlPriorityType.DataTextField = "PriorityType";
                ddlPriorityType.DataValueField = "PriorityTypeId";
                ddlPriorityType.DataSource = ds.Tables[0];
                ddlPriorityType.DataBind();
            }
            ddlPriorityType.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillQA()
    {
        try
        {
            ddlQA.Items.Clear();
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "8" });
            if (IsNullDataSet(ds))
            {
                ddlQA.DataTextField = "Emp_Name";
                ddlQA.DataValueField = "Emp_ID";
                ddlQA.DataSource = ds.Tables[0];
                ddlQA.DataBind();
            }
            ddlQA.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillGridTakDetails()
    {
        try
        {
            gvTaskDetails.DataSource = null;
            gvTaskDetails.DataBind();

            ds = USP_TaskAllocation(new string[] { "Flag", "EmployeeId" }, new string[] { "4", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvTaskDetails.DataSource = ds.Tables[0];
                gvTaskDetails.DataBind();
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
            dvAllocatedRequirements.Visible=false;
            gvAllocatedRequirements.DataSource = null;
            gvAllocatedRequirements.DataBind();
            string allocationDate = !string.IsNullOrWhiteSpace(txtAllocationDate.Text)? Convert.ToDateTime(txtAllocationDate.Text, cult).ToString("yyyy/MM/dd"): DateTime.Now.ToString("yyyy/MM/dd");

            ds = USP_TaskAllocation(new string[] { "Flag", "CreatedBy", "EmployeeId", "AllocationDate" }, new string[] { "9", Convert.ToString(ViewState["Emp_ID"]),ddlEmployee.SelectedValue, allocationDate });
            if (IsNullDataSet(ds))
            {
                lblEmployeeName.Text = ddlEmployee.SelectedItem.Text;
                dvAllocatedRequirements.Visible = true;
                gvAllocatedRequirements.DataSource = ds.Tables[0];
                gvAllocatedRequirements.DataBind();
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

                if (ddlEmployee.SelectedValue == "0") { ErrorMsg += "Please Select Employee Name.\\n"; }
                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (ddlPriorityType.SelectedValue == "0") { ErrorMsg += "Please Select Priority.\\n"; }
                if (txtAllocationDate.Text == "") { ErrorMsg += "Please Select Allocation Date.\\n"; }
                if (txtAllocationTime.Text == "") { ErrorMsg += "Please Select Allocation Time.\\n"; }
                if (txtTaskName.Text == "") { ErrorMsg += "Please Enter Task Name.\\n"; }
                if (txtTaskDescription.InnerText == "") { ErrorMsg += "Please Enter Task Description.\\n"; }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    string allocationDate = txtAllocationDate.Text != "" ? Convert.ToDateTime(txtAllocationDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        taskAllocationId = string.Empty;
                        flag = "3";
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "6";
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                        return;
                    }

                    ds = USP_TaskAllocation(
                          new string[]
                          {
                              "Flag",
                              "AllocationId",
                              "EmployeeId",
                              "ProjectId",
                              "AllocationDate",
                              "AllocationTime",
                              "TaskName",
                              "TaskDescription",
                              "CreatedBy",
                              "CreatedByIp",
                              "PriorityTypeId",
                              "EmployeeId_QA"
                          },
                          new string[]
                          {
                              flag,
                              taskAllocationId,
                              ddlEmployee.SelectedValue,
                              ddlProject.SelectedValue,
                              Convert.ToString(allocationDate),
                              txtAllocationTime.Text,
                              txtTaskName.Text,
                              txtTaskDescription.InnerText,
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress(),
                              ddlPriorityType.SelectedValue,
                              ddlQA.SelectedValue
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

    protected void gvTaskDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            taskAllocationId = e.CommandArgument.ToString();

            if (e.CommandName == "RecordDelete")
            {
                DataSet ds = new DataSet();
                ds = USP_TaskAllocation(new string[] { "Flag", "EmployeeId", "AllocationId" }, new string[] { "5", Convert.ToString(ViewState["Emp_ID"]), taskAllocationId });
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
            else if (e.CommandName == "RecordEdit")
            {
                Label lblEmp_ID = (Label)row.FindControl("lblEmp_ID");
                Label lblProject_ID = (Label)row.FindControl("lblProject_ID");
                Label lblAllocationDate = (Label)row.FindControl("lblAllocationDate");
                Label lblTaskDuration = (Label)row.FindControl("lblAllocationTime");
                Label lblTaskName = (Label)row.FindControl("lblTaskName");
                Label lblTaskDescription = (Label)row.FindControl("lblTaskDescription");
                Label lblPriorityTypeId = (Label)row.FindControl("lblPriorityTypeId");
                Label lblEmployeeId_QA = (Label)row.FindControl("lblEmployeeId_QA");

                if (lblEmp_ID != null && ddlEmployee.Items.FindByValue(lblEmp_ID.Text) != null)
                {
                    ddlEmployee.ClearSelection();
                    ddlEmployee.Items.FindByValue(lblEmp_ID.Text).Selected = true;
                }
                if (lblProject_ID != null && ddlProject.Items.FindByValue(lblProject_ID.Text) != null)
                {
                    ddlProject.ClearSelection();
                    ddlProject.Items.FindByValue(lblProject_ID.Text).Selected = true;
                }
                if (lblPriorityTypeId != null && ddlPriorityType.Items.FindByValue(lblPriorityTypeId.Text) != null)
                {
                    ddlPriorityType.ClearSelection();
                    ddlPriorityType.Items.FindByValue(lblPriorityTypeId.Text).Selected = true;
                }
                if (lblEmployeeId_QA != null && ddlQA.Items.FindByValue(lblEmployeeId_QA.Text) != null)
                {
                    ddlQA.ClearSelection();
                    ddlQA.Items.FindByValue(lblEmployeeId_QA.Text).Selected = true;
                }
                if (lblAllocationDate != null)
                    txtAllocationDate.Text = lblAllocationDate.Text;

                if (lblTaskDuration != null)
                    txtAllocationTime.Text = lblTaskDuration.Text;

                if (lblTaskName != null)
                    txtTaskName.Text = lblTaskName.Text;

                if (lblTaskDescription != null)
                    txtTaskDescription.InnerText = lblTaskDescription.Text;

                btnSave.Text = "Update";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }

    }

    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlProject.ClearSelection();
        ddlPriorityType.ClearSelection();
        ddlQA.ClearSelection();
        txtAllocationDate.Text = string.Empty;
        txtAllocationTime.Text = string.Empty;
        txtTaskName.Text = string.Empty;
        txtTaskDescription.InnerHtml = string.Empty;
        taskAllocationId = string.Empty;
        btnSave.Text = "Save";
        FillGridAlreadyAllocatedTask();
    }
}