using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TodayAllocatedTask : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();

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
                ViewState["IsProjectManager"] = IsProjectManager();
                ViewState["IsAdmin"] = CheckIfAdmin();
                lblCurrentDate.Text = DateTime.Now.ToString("dd/MM/yyyy (dddd)");

                FillEmployee();
                FillProject();
                LoadTodayAllocatedTasks();

                // Generate breadcrumb
                try
                {
                    string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                    MainMaster master = this.Master as MainMaster;
                    if (master != null)
                    {
                        master.GenerateBreadcrumb(currentPath);
                    }
                }
                catch { }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
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
            ddlEmployee.Items.Insert(0, new ListItem("All Employees", "0"));

            bool isAdmin = ViewState["IsAdmin"] != null ? Convert.ToBoolean(ViewState["IsAdmin"]) : CheckIfAdmin();
            bool isProjectManager = ViewState["IsProjectManager"] != null ? Convert.ToBoolean(ViewState["IsProjectManager"]) : IsProjectManager();

            // Pre-select current employee only for normal employees (NOT for Admin or Project Manager)
            if (!isAdmin && !isProjectManager)
            {
                if (ddlEmployee.Items.FindByValue(empId) != null)
                {
                    ddlEmployee.SelectedValue = empId;
                }
            }
            else
            {
                // For Admin and Project Manager, keep "All Employees" selected
                ddlEmployee.SelectedValue = "0";
            }
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
            ddlProject.Items.Insert(0, new ListItem("All Projects", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void LoadTodayAllocatedTasks()
    {
        try
        {
            lblMsg.Text = string.Empty;
            gvTodayTasks.DataSource = null;
            gvTodayTasks.DataBind();

            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);
            string selectedEmpId = ddlEmployee.SelectedValue;
            string selectedProjectId = ddlProject.SelectedValue;

            // Fetch allocated tasks using Flag 9 (Get Grid Already Allocated Task)
            string empIdToQuery = (selectedEmpId != "0" && !string.IsNullOrEmpty(selectedEmpId)) ? selectedEmpId : "0";
            string allocationDate = DateTime.Today.ToString("yyyy-MM-dd");

            DataSet dsAllocated = USP_TaskAllocation(
                new string[] { "Flag", "EmployeeId", "AllocationDate" },
                new string[] { "9", empIdToQuery, allocationDate }
            );

            DataTable dtTodayTasks = new DataTable();

            if (IsNullDataSet(dsAllocated))
            {
                dtTodayTasks = dsAllocated.Tables[0].Copy();
            }

            // Apply Employee Filter if selected
            if (dtTodayTasks != null && dtTodayTasks.Rows.Count > 0 && selectedEmpId != "0" && !string.IsNullOrEmpty(selectedEmpId))
            {
                DataView dvEmp = dtTodayTasks.DefaultView;
                if (dtTodayTasks.Columns.Contains("Emp_ID"))
                {
                    dvEmp.RowFilter = "Emp_ID = '" + selectedEmpId + "'";
                    dtTodayTasks = dvEmp.ToTable();
                }
                else if (dtTodayTasks.Columns.Contains("EmployeeId"))
                {
                    dvEmp.RowFilter = "EmployeeId = '" + selectedEmpId + "'";
                    dtTodayTasks = dvEmp.ToTable();
                }
            }

            // Apply Project Filter if selected
            if (dtTodayTasks != null && dtTodayTasks.Rows.Count > 0 && selectedProjectId != "0" && !string.IsNullOrEmpty(selectedProjectId))
            {
                DataView dvProj = dtTodayTasks.DefaultView;
                if (dtTodayTasks.Columns.Contains("Project_ID"))
                {
                    dvProj.RowFilter = "Project_ID = '" + selectedProjectId + "'";
                    dtTodayTasks = dvProj.ToTable();
                }
                else if (dtTodayTasks.Columns.Contains("ProjectId"))
                {
                    dvProj.RowFilter = "ProjectId = '" + selectedProjectId + "'";
                    dtTodayTasks = dvProj.ToTable();
                }
            }

            // Bind Grid and Update KPI Metrics
            if (dtTodayTasks != null && dtTodayTasks.Rows.Count > 0)
            {
                gvTodayTasks.DataSource = dtTodayTasks;
                gvTodayTasks.DataBind();

                if (gvTodayTasks.Rows.Count > 0)
                {
                    gvTodayTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvTodayTasks.UseAccessibleHeader = true;
                }

                CalculateMetrics(dtTodayTasks);
            }
            else
            {
                gvTodayTasks.DataSource = null;
                gvTodayTasks.DataBind();
                lblTotalTasks.Text = "0";
                lblTotalHours.Text = "0.00 Hrs";
                lblHighPriorityCount.Text = "0";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void CalculateMetrics(DataTable dt)
    {
        try
        {
            lblTotalTasks.Text = dt.Rows.Count.ToString();

            double totalHours = 0;
            int highPriority = 0;

            foreach (DataRow row in dt.Rows)
            {
                // Check priority
                string priorityName = dt.Columns.Contains("PriorityType") && row["PriorityType"] != null ? row["PriorityType"].ToString().ToLower() : "";
                string priorityId = dt.Columns.Contains("PriorityTypeId") && row["PriorityTypeId"] != null ? row["PriorityTypeId"].ToString() : "";

                if (priorityId == "1" || priorityName.Contains("high") || priorityName.Contains("critical"))
                {
                    highPriority++;
                }

                // Parse duration
                string durationStr = "";
                if (dt.Columns.Contains("TaskDuration") && row["TaskDuration"] != null && !string.IsNullOrEmpty(row["TaskDuration"].ToString()))
                {
                    durationStr = row["TaskDuration"].ToString();
                }
                else if (dt.Columns.Contains("AllocationTime") && row["AllocationTime"] != null && !string.IsNullOrEmpty(row["AllocationTime"].ToString()))
                {
                    durationStr = row["AllocationTime"].ToString();
                }

                if (!string.IsNullOrEmpty(durationStr))
                {
                    if (durationStr.Contains(":"))
                    {
                        string[] parts = durationStr.Split(':');
                        if (parts.Length >= 2)
                        {
                            double hrs = 0, mins = 0;
                            double.TryParse(parts[0], out hrs);
                            double.TryParse(parts[1], out mins);
                            totalHours += hrs + (mins / 60.0);
                        }
                    }
                    else
                    {
                        double parsedHrs = 0;
                        if (double.TryParse(durationStr.Replace("Hrs", "").Replace("hrs", "").Trim(), out parsedHrs))
                        {
                            totalHours += parsedHrs;
                        }
                    }
                }
            }

            lblTotalHours.Text = string.Format("{0:0.00} Hrs", totalHours);
            lblHighPriorityCount.Text = highPriority.ToString();
        }
        catch
        {
            lblTotalHours.Text = "0.00 Hrs";
            lblHighPriorityCount.Text = "0";
        }
    }

    protected string GetPriorityBadge(object priorityType, object priorityTypeId)
    {
        string pType = priorityType != null ? priorityType.ToString().Trim() : "Normal";
        string pId = priorityTypeId != null ? priorityTypeId.ToString().Trim() : "";

        if (pId == "1" || pType.Equals("High", StringComparison.OrdinalIgnoreCase) || pType.Equals("Critical", StringComparison.OrdinalIgnoreCase))
        {
            return string.Format("<span class='badge-priority-high'><i class='fa fa-arrow-up me-1'></i>{0}</span>", pType);
        }
        else if (pId == "2" || pType.Equals("Medium", StringComparison.OrdinalIgnoreCase))
        {
            return string.Format("<span class='badge-priority-medium'><i class='fa fa-minus me-1'></i>{0}</span>", pType);
        }
        else if (pId == "3" || pType.Equals("Low", StringComparison.OrdinalIgnoreCase))
        {
            return string.Format("<span class='badge-priority-low'><i class='fa fa-arrow-down me-1'></i>{0}</span>", pType);
        }
        else
        {
            return string.Format("<span class='badge-priority-default'>{0}</span>", pType);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadTodayAllocatedTasks();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddlEmployee.ClearSelection();
        bool isAdmin = ViewState["IsAdmin"] != null ? Convert.ToBoolean(ViewState["IsAdmin"]) : CheckIfAdmin();
        bool isPM = ViewState["IsProjectManager"] != null ? Convert.ToBoolean(ViewState["IsProjectManager"]) : IsProjectManager();

        if (!isAdmin && !isPM && ViewState["Emp_ID"] != null && ddlEmployee.Items.FindByValue(ViewState["Emp_ID"].ToString()) != null)
        {
            ddlEmployee.SelectedValue = ViewState["Emp_ID"].ToString();
        }
        else
        {
            ddlEmployee.SelectedIndex = 0;
        }

        ddlProject.ClearSelection();
        if (ddlProject.Items.Count > 0)
        {
            ddlProject.SelectedIndex = 0;
        }

        LoadTodayAllocatedTasks();
    }

    private bool IsProjectManager()
    {
        try
        {
            // 1. Check Session Designation_ID (8 = Project Manager, 13 = Tech Lead / Manager)
            if (Session["Designation_ID"] != null)
            {
                string desigId = Session["Designation_ID"].ToString().Trim();
                if (desigId == "8" || desigId == "13")
                {
                    return true;
                }
            }

            // 2. Check Session Designation_Name
            if (Session["Designation_Name"] != null)
            {
                string desig = Session["Designation_Name"].ToString().ToLower();
                if (desig.Contains("manager") || desig.Contains("lead"))
                {
                    return true;
                }
            }

            // 3. Check if user exists in Project Managers list via USP_TaskAllocationEntry Flag 6
            string currentEmpId = ViewState["Emp_ID"] != null ? ViewState["Emp_ID"].ToString().Trim() : (Session["Emp_ID"] != null ? Session["Emp_ID"].ToString().Trim() : "");
            if (!string.IsNullOrEmpty(currentEmpId))
            {
                DataSet dsPM = objdb.ByProcedure("USP_TaskAllocationEntry", new string[] { "Flag" }, new string[] { "6" }, "ds");
                if (dsPM != null && dsPM.Tables.Count > 0 && dsPM.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in dsPM.Tables[0].Rows)
                    {
                        if (dr.Table.Columns.Contains("Emp_ID") && dr["Emp_ID"].ToString().Trim() == currentEmpId)
                            return true;
                        if (dr.Table.Columns.Contains("Employee_Id") && dr["Employee_Id"].ToString().Trim() == currentEmpId)
                            return true;
                    }
                }
            }
        }
        catch { }
        return false;
    }

    private bool CheckIfAdmin()
    {
        try
        {
            // Project Manager is NOT an Admin!
            if (IsProjectManager())
            {
                return false;
            }

            // 1. Check Session Designation_ID (1 = Admin)
            if (Session["Designation_ID"] != null && Session["Designation_ID"].ToString().Trim() == "1")
            {
                return true;
            }

            // 2. Check Session Designation_Name contains "admin"
            if (Session["Designation_Name"] != null)
            {
                string desig = Session["Designation_Name"].ToString().ToLower();
                if (desig.Contains("admin"))
                {
                    return true;
                }
            }

            // 3. Check Session UserName
            if (Session["UserName"] != null)
            {
                string uName = Session["UserName"].ToString().ToLower();
                if (uName == "admin" || uName == "administrator" || uName == "e0001")
                {
                    return true;
                }
            }
        }
        catch { }
        return false;
    }

    protected void gvTodayTasks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView rowView = e.Row.DataItem as DataRowView;
            if (rowView != null)
            {
                string priorityType = "";
                string priorityTypeId = "";

                if (rowView.DataView.Table.Columns.Contains("PriorityType") && rowView["PriorityType"] != DBNull.Value)
                {
                    priorityType = rowView["PriorityType"].ToString().Trim();
                }
                if (rowView.DataView.Table.Columns.Contains("PriorityTypeId") && rowView["PriorityTypeId"] != DBNull.Value)
                {
                    priorityTypeId = rowView["PriorityTypeId"].ToString().Trim();
                }

                if (priorityTypeId == "1" || priorityType.Equals("High", StringComparison.OrdinalIgnoreCase) || priorityType.Equals("Critical", StringComparison.OrdinalIgnoreCase))
                {
                    e.Row.CssClass = (e.Row.CssClass + " high-priority-row").Trim();
                }

                // Determine whether to show the "Fill Task" action button
                bool isAdmin = ViewState["IsAdmin"] != null ? Convert.ToBoolean(ViewState["IsAdmin"]) : CheckIfAdmin();
                bool canFillTask = false;

                // Admin should NEVER see the "Fill Task" button.
                // For Project Manager or other employees, show "Fill Task" ONLY on their own allocated task.
                if (!isAdmin)
                {
                    string currentEmpId = ViewState["Emp_ID"] != null ? ViewState["Emp_ID"].ToString().Trim() : (Session["Emp_ID"] != null ? Session["Emp_ID"].ToString().Trim() : "");
                    string currentEmpName = Session["Emp_Name"] != null ? Session["Emp_Name"].ToString().Trim() : "";

                    string rowEmpId = "";
                    DataTable dt = rowView.DataView.Table;

                    if (dt.Columns.Contains("Emp_ID") && rowView["Emp_ID"] != DBNull.Value)
                    {
                        rowEmpId = rowView["Emp_ID"].ToString().Trim();
                    }
                    else if (dt.Columns.Contains("EmployeeId") && rowView["EmployeeId"] != DBNull.Value)
                    {
                        rowEmpId = rowView["EmployeeId"].ToString().Trim();
                    }
                    else if (dt.Columns.Contains("Employee_Id") && rowView["Employee_Id"] != DBNull.Value)
                    {
                        rowEmpId = rowView["Employee_Id"].ToString().Trim();
                    }
                    else if (dt.Columns.Contains("EmpId") && rowView["EmpId"] != DBNull.Value)
                    {
                        rowEmpId = rowView["EmpId"].ToString().Trim();
                    }

                    string rowEmpName = "";
                    if (dt.Columns.Contains("Employee_Name") && rowView["Employee_Name"] != DBNull.Value)
                    {
                        rowEmpName = rowView["Employee_Name"].ToString().Trim();
                    }
                    else if (dt.Columns.Contains("EmployeeName") && rowView["EmployeeName"] != DBNull.Value)
                    {
                        rowEmpName = rowView["EmployeeName"].ToString().Trim();
                    }
                    else if (dt.Columns.Contains("Emp_Name") && rowView["Emp_Name"] != DBNull.Value)
                    {
                        rowEmpName = rowView["Emp_Name"].ToString().Trim();
                    }

                    // Fallback to rendered label if rowEmpName is empty
                    if (string.IsNullOrEmpty(rowEmpName))
                    {
                        Label lblEmp = e.Row.FindControl("lblEmployee_Name") as Label;
                        if (lblEmp != null && !string.IsNullOrEmpty(lblEmp.Text))
                        {
                            rowEmpName = lblEmp.Text.Trim();
                        }
                    }

                    // Lookup rowEmpId from ddlEmployee using rowEmpName
                    if (string.IsNullOrEmpty(rowEmpId) && !string.IsNullOrEmpty(rowEmpName))
                    {
                        foreach (ListItem item in ddlEmployee.Items)
                        {
                            if (string.Equals(item.Text.Trim(), rowEmpName.Trim(), StringComparison.OrdinalIgnoreCase))
                            {
                                rowEmpId = item.Value.Trim();
                                break;
                            }
                        }
                    }

                    bool isOwnTask = false;

                    // Match 1: By ID
                    if (!string.IsNullOrEmpty(rowEmpId) && !string.IsNullOrEmpty(currentEmpId))
                    {
                        if (string.Equals(rowEmpId, currentEmpId, StringComparison.OrdinalIgnoreCase))
                        {
                            isOwnTask = true;
                        }
                    }

                    // Match 2: By looking up currentEmpId in ddlEmployee to match rowEmpName
                    if (!isOwnTask && !string.IsNullOrEmpty(currentEmpId) && !string.IsNullOrEmpty(rowEmpName))
                    {
                        ListItem myItem = ddlEmployee.Items.FindByValue(currentEmpId);
                        if (myItem != null && string.Equals(myItem.Text.Trim(), rowEmpName.Trim(), StringComparison.OrdinalIgnoreCase))
                        {
                            isOwnTask = true;
                        }
                    }

                    // Match 3: By clean Name comparison
                    if (!isOwnTask && !string.IsNullOrEmpty(rowEmpName) && !string.IsNullOrEmpty(currentEmpName))
                    {
                        string cleanRow = rowEmpName.Replace(" ", "").ToLower();
                        string cleanCurr = currentEmpName.Replace(" ", "").ToLower();
                        if (cleanRow == cleanCurr || cleanRow.Contains(cleanCurr) || cleanCurr.Contains(cleanRow))
                        {
                            isOwnTask = true;
                        }
                    }

                    canFillTask = isOwnTask;
                }

                HyperLink lnkFillTask = e.Row.FindControl("lnkFillTask") as HyperLink;
                Label lblNoAction = e.Row.FindControl("lblNoAction") as Label;

                if (lnkFillTask != null)
                {
                    lnkFillTask.Visible = canFillTask;
                }
                if (lblNoAction != null)
                {
                    lblNoAction.Visible = !canFillTask;
                }
            }
        }
    }
}
