using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Transaction_ProjectPlan : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();
    private static string ProjectPlanID = string.Empty;
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
                FillProject();
                FillRole();
                FillEmployee();
                FillGridDetails();
                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
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
    private void FillRole()
    {
        try
        {
            ddlRole.Items.Clear();
            DataSet dsDesig = objdb.ByProcedure("Usp_GetDesignation", new string[] { }, new string[] { }, "dataset");
            if (dsDesig != null && dsDesig.Tables[0].Rows.Count > 0)
            {
                ddlRole.DataSource = dsDesig.Tables[0];
                ddlRole.DataTextField = "Designation_Name";
                ddlRole.DataValueField = "Designation_ID";
                ddlRole.DataBind();
            }
            ddlRole.Items.Insert(0, new ListItem("Select", "0"));
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

            string empId = ViewState["Emp_ID"].ToString();
            ds = USP_TaskAllocation(new string[] { "Flag", "EmpId" }, new string[] { "1", empId });
            if (IsNullDataSet(ds))
            {
                ddlEmployee.DataTextField = "Employee_Name";
                ddlEmployee.DataValueField = "Employee_Id";
                ddlEmployee.DataSource = ds.Tables[0];
                ddlEmployee.DataBind();
            }
            //ddlEmployee.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    private void FillGridDetails()
    {

        try
        {
            gvProjectPlan.DataSource = null;
            gvProjectPlan.DataBind();

            ds = USP_ProjectPlan(new string[] { "Flag" }, new string[] { "2" });
            if (IsNullDataSet(ds))
            {
                gvProjectPlan.DataSource = ds.Tables[0];
                gvProjectPlan.DataBind();
                Datatable();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private DataSet USP_ProjectPlan(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_ProjectPlan", columns, values, "ds");
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
                    string ProjectStartDate = txtProjectStartDate.Text != "" ? Convert.ToDateTime(txtProjectStartDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string ProjectEndDate = txtProjectEndDate.Text != "" ? Convert.ToDateTime(txtProjectEndDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string TaskStartDate = txtTaskStartDate.Text != "" ? Convert.ToDateTime(txtTaskStartDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string TaskEndDate = txtTaskEndDate.Text != "" ? Convert.ToDateTime(txtTaskEndDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string Employee = "";
                    foreach (ListItem item in ddlEmployee.Items)
                    {
                        if (item.Selected)
                        {
                            Employee += item.Value + ",";
                        }
                    }
                    string flag = string.Empty;
                    string CreatedBy = string.Empty;
                    string CreatedByIp = string.Empty;
                    string UpdatedBy = string.Empty;
                    string UpdatedByIp = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        ProjectPlanID = string.Empty;
                        flag = "1";
                        CreatedBy = Convert.ToString(ViewState["Emp_ID"]);
                        CreatedByIp = objdb.GetLocalIPAddress();
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "2";
                        UpdatedBy = Convert.ToString(ViewState["Emp_ID"]);
                        UpdatedByIp = objdb.GetLocalIPAddress();
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg("Something went wrong, Please try after sometime.");
                        return;
                    }
                    ds = USP_ProjectPlan(
                          new string[]
                          {
                              "Flag",
                              "ProjectPlanID",
                              "Project_Id",
                              "ClientName",
                              "ProjectID",
                              "ProjectStartDate",
                              "ProjectEndDate",
                              "PhaseTaskName",
                              "DetailedDescription",
                              "RoleID",
                              "ManpowerCount",
                              "AssignResource",
                              "StartDate",
                              "EndDate",
                              "DurationDays",
                              "Dependencies",
                              "StatusId",
                              "PriorityID",
                              "CompletedPercent",
                              "PlannedMilestone",
                              "RiskIssue",
                              "ActionRequired",
                              "CreatedBy",
                              "CreatedByIp",
                              "UpdatedBy",
                              "UpdatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              ProjectPlanID,
                              ddlProject.SelectedValue,
                              txtClientName.Text.Trim(),
                              txtProjectId.Text.Trim(),
                              Convert.ToString(ProjectStartDate),
                              Convert.ToString(ProjectEndDate),
                              txtTaskName.Text.Trim(),
                              txtDetailedDescription.Text.Trim(),
                              ddlRole.SelectedValue,
                              txtManpowerCount.Text.Trim(),
                              Employee,
                              Convert.ToString(TaskStartDate),
                              Convert.ToString(TaskEndDate),
                              txtDuration.Text.Trim(),
                              txtDependencies.Text.Trim(),
                              ddlStatus.SelectedValue,
                              ddlPriorityType.SelectedValue,
                              txtCompleted.Text.Trim(),
                              txtPlannedMilestone.Text.Trim(),
                              txtRiskIssue.Text.Trim(),
                              txtActionRequired.Text.Trim(),
                              CreatedBy,
                              CreatedByIp,
                              UpdatedBy,
                              UpdatedByIp
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            FillGridDetails();
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

    protected void Clear()
    {
        btnSave.Text = "Save";
        ddlEmployee.ClearSelection();
        txtClientName.Text = string.Empty;
        txtProjectId.Text = string.Empty;
        txtProjectStartDate.Text = string.Empty;
        txtProjectEndDate.Text = string.Empty;
        txtTaskName.Text = string.Empty;
        txtDetailedDescription.Text = string.Empty;
        ddlRole.ClearSelection();
        txtManpowerCount.Text = string.Empty;
        txtTaskStartDate.Text = string.Empty;
        txtTaskEndDate.Text = string.Empty;
        txtDuration.Text = string.Empty;
        txtDependencies.Text = string.Empty;
        ddlStatus.ClearSelection();
        ddlPriorityType.ClearSelection();
        txtCompleted.Text = string.Empty;
        txtPlannedMilestone.Text = string.Empty;
        txtRiskIssue.Text = string.Empty;
        txtActionRequired.Text = string.Empty;

    }

    protected void Datatable()
    {
        if (gvProjectPlan.Rows.Count > 0)
        {
            gvProjectPlan.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvProjectPlan.UseAccessibleHeader = true;
        }
    }
}