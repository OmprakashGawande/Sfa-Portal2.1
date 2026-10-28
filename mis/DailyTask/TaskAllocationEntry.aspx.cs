using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskAllocationEntry : System.Web.UI.Page
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

                txtStartDate.Text = DateTime.Now.ToString("dd/MM/yyyy", cult);
                txtEndDate.Text = DateTime.Now.ToString("dd/MM/yyyy", cult);
                txtStartTime.Text = "01:30 PM";
                txtEndTime.Text = "05:30 PM";
                txtWorkingHours.Text = "4.00 Hrs";

                FillProject();
                FillPriority();
                FillAllocated(false);
                InitializeTasksTable();
                LoadSavedHistory();

                // Breadcrumb
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

    private DataSet USP_TaskAllocationEntry(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_TaskAllocationEntry", columns, values, "ds");
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
        lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Success!", msg);
        return lblMsg.Text;
    }

    private string WarningMsg(string msg)
    {
        lblMsg.Text = objdb.Alert("fa-warning", "alert-warning", "Warning! ", msg);
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
            ddlProject.Items.Insert(0, new ListItem("Select Project", "0"));

            // Check if employee has allocated task(s) for a project
            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);
            if (!string.IsNullOrEmpty(currentEmpId))
            {
                DataSet dsProj = USP_TaskAllocationEntry(new string[] { "Flag", "EmpId", "CreatedBy" }, new string[] { "8", currentEmpId, currentEmpId });
                if (IsNullDataSet(dsProj) && dsProj.Tables[0].Rows.Count == 1)
                {
                    string allocatedProjectId = dsProj.Tables[0].Rows[0]["ProjectId"].ToString();
                    if (ddlProject.Items.FindByValue(allocatedProjectId) != null)
                    {
                        ddlProject.SelectedValue = allocatedProjectId;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillPriority()
    {
        try
        {
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "7" });
            if (IsNullDataSet(ds))
            {
                ddlPriority.Items.Clear();
                ddlPriority.DataTextField = "PriorityType";
                ddlPriority.DataValueField = "PriorityTypeId";
                ddlPriority.DataSource = ds.Tables[0];
                ddlPriority.DataBind();
                ddlPriority.Items.Insert(0, new ListItem("Select Priority", "0"));
            }
        }
        catch
        {
            // Keep default items if DB fetch fails
        }
    }

    private void FillAllocated(bool isOnSpot = false)
    {
        try
        {
            ddlAllocated.Items.Clear();
            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);

            DataSet dsAlloc = null;
            if (isOnSpot)
            {
                // User Requirement: When 'On-Spot Allotment' is selected, show ALL Project Managers!
                dsAlloc = USP_TaskAllocationEntry(new string[] { "Flag" }, new string[] { "6" });
            }
            else
            {
                // PMs from tasks allocated to employee
                dsAlloc = USP_TaskAllocationEntry(new string[] { "Flag", "EmpId", "CreatedBy" }, new string[] { "5", currentEmpId, currentEmpId });
            }

            if (IsNullDataSet(dsAlloc))
            {
                ddlAllocated.DataTextField = "Emp_Name";
                ddlAllocated.DataValueField = "Emp_ID";
                ddlAllocated.DataSource = dsAlloc.Tables[0];
                ddlAllocated.DataBind();
                ddlAllocated.Items.Insert(0, new ListItem("Select Assignee", "0"));

                // If not on-spot and exactly 1 manager available, auto-select
                if (!isOnSpot && dsAlloc.Tables[0].Rows.Count == 1)
                {
                    ddlAllocated.SelectedIndex = 1;
                }
                else
                {
                    ddlAllocated.SelectedIndex = 0;
                }
            }
            else
            {
                ddlAllocated.Items.Insert(0, new ListItem("No Project Manager Assigned", "0"));
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlPriority_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string selectedPriorityText = ddlPriority.SelectedItem != null ? ddlPriority.SelectedItem.Text.Trim() : "";
            string selectedPriorityVal = ddlPriority.SelectedValue;

            bool isOnSpot = (selectedPriorityVal == "4" || selectedPriorityText.IndexOf("On-Spot", StringComparison.OrdinalIgnoreCase) >= 0);
            bool isHigh = (selectedPriorityVal == "1" || selectedPriorityText.IndexOf("High", StringComparison.OrdinalIgnoreCase) >= 0);

            string prevAllocated = ddlAllocated.SelectedValue;
            FillAllocated(isOnSpot);
            if (!string.IsNullOrEmpty(prevAllocated) && ddlAllocated.Items.FindByValue(prevAllocated) != null)
            {
                ddlAllocated.SelectedValue = prevAllocated;
            }

            // High priority text red formatting
            if (isHigh)
            {
                txtRemark.Attributes["style"] = "color: #dc3545 !important; font-weight: 600 !important; border-color: #dc3545 !important;";
                if (!txtRemark.CssClass.Contains("text-high-priority"))
                {
                    txtRemark.CssClass = (txtRemark.CssClass + " text-high-priority").Trim();
                }
            }
            else
            {
                txtRemark.Attributes.Remove("style");
                txtRemark.CssClass = txtRemark.CssClass.Replace("text-high-priority", "").Trim();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "UpdateColor", "if(typeof updateActivityColor === 'function'){ updateActivityColor(); }", true);
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void InitializeTasksTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Id", typeof(int));
        dt.Columns.Add("ProjectId", typeof(string));
        dt.Columns.Add("ProjectName", typeof(string));
        dt.Columns.Add("StartDate", typeof(string));
        dt.Columns.Add("StartTime", typeof(string));
        dt.Columns.Add("Allocated", typeof(string));
        dt.Columns.Add("PriorityId", typeof(string));
        dt.Columns.Add("Priority", typeof(string));
        dt.Columns.Add("TicketType", typeof(string));
        dt.Columns.Add("EndDate", typeof(string));
        dt.Columns.Add("EndTime", typeof(string));
        dt.Columns.Add("WorkingHours", typeof(double));
        dt.Columns.Add("TaskStatus", typeof(string));
        dt.Columns.Add("Remark", typeof(string));
        dt.Columns.Add("IsSameDay", typeof(bool));

        ViewState["TasksTable"] = dt;
        BindStagedGrid();
    }

    private void BindStagedGrid()
    {
        DataTable dt = ViewState["TasksTable"] as DataTable;
        gvAddedTasks.DataSource = dt;
        gvAddedTasks.DataBind();

        if (dt != null)
        {
            lblAddedCount.Text = dt.Rows.Count.ToString();
            double totalHours = 0;
            foreach (DataRow row in dt.Rows)
            {
                totalHours += Convert.ToDouble(row["WorkingHours"]);
            }
            lblTotalStagedHours.Text = totalHours.ToString("0.00");
        }
        else
        {
            lblAddedCount.Text = "0";
            lblTotalStagedHours.Text = "0.00";
        }
    }

    private void LoadSavedHistory()
    {
        try
        {
            gvSavedHistory.DataSource = null;
            gvSavedHistory.DataBind();

            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);
            DataSet dsHistory = USP_TaskAllocationEntry(
                new string[] { "Flag", "CreatedBy" },
                new string[] { "2", currentEmpId }
            );

            if (IsNullDataSet(dsHistory))
            {
                gvSavedHistory.DataSource = dsHistory.Tables[0];
                gvSavedHistory.DataBind();

                if (gvSavedHistory.Rows.Count > 0)
                {
                    gvSavedHistory.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvSavedHistory.UseAccessibleHeader = true;
                }
            }
        }
        catch
        {
            // Table/proc may not be created yet in DB
        }
    }

    protected void btnAddRow_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;

            // 1. Validation for Required Fields
            if (ddlProject.SelectedValue == "0" || string.IsNullOrEmpty(ddlProject.SelectedValue))
            {
                WarningMsg("Please select Project Name.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtStartDate.Text))
            {
                WarningMsg("Please select Start Date.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtStartTime.Text))
            {
                WarningMsg("Please select Start Time.");
                return;
            }
            if (ddlAllocated.SelectedValue == "0" || string.IsNullOrEmpty(ddlAllocated.SelectedValue))
            {
                WarningMsg("Please select Allocated / Assignee (Project Manager).");
                return;
            }
            if (ddlPriority.SelectedValue == "0" || string.IsNullOrEmpty(ddlPriority.SelectedValue))
            {
                WarningMsg("Please select Priority.");
                return;
            }
            if (ddlTicketType.SelectedValue == "0" || string.IsNullOrEmpty(ddlTicketType.SelectedValue))
            {
                WarningMsg("Please select Ticket Type.");
                return;
            }
            if (ddlStatus.SelectedValue == "0" || string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                WarningMsg("Please select Status (Complete, Partially Complete, or Pending).");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtRemark.Text))
            {
                WarningMsg("Please enter Remark / Task Details.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtEndDate.Text))
            {
                WarningMsg("Please select End Date.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtEndTime.Text))
            {
                WarningMsg("Please select End Time.");
                return;
            }

            // 2. Parse Dates and Times
            DateTime startDateTime, endDateTime;
            string startCombined = txtStartDate.Text.Trim() + " " + txtStartTime.Text.Trim();
            string endCombined = txtEndDate.Text.Trim() + " " + txtEndTime.Text.Trim();

            string[] formats = new string[] { 
                "dd/MM/yyyy hh:mm tt", "d/M/yyyy hh:mm tt", "dd/MM/yyyy h:mm tt", "d/M/yyyy h:mm tt",
                "dd/MM/yyyy hh:mm:ss tt", "d/M/yyyy hh:mm:ss tt",
                "dd/MM/yyyy HH:mm", "d/M/yyyy HH:mm", "dd/MM/yyyy H:mm", "d/M/yyyy H:mm"
            };

            bool startParsed = DateTime.TryParseExact(startCombined, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDateTime) ||
                               DateTime.TryParse(startCombined, CultureInfo.InvariantCulture, DateTimeStyles.None, out startDateTime) ||
                               DateTime.TryParse(startCombined, cult, DateTimeStyles.None, out startDateTime);

            bool endParsed = DateTime.TryParseExact(endCombined, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDateTime) ||
                             DateTime.TryParse(endCombined, CultureInfo.InvariantCulture, DateTimeStyles.None, out endDateTime) ||
                             DateTime.TryParse(endCombined, cult, DateTimeStyles.None, out endDateTime);

            if (!startParsed || !endParsed)
            {
                WarningMsg("Invalid Date or Time format. Please select valid dates and times.");
                return;
            }

            if (endDateTime <= startDateTime)
            {
                WarningMsg("End Date & Time must be greater than Start Date & Time.");
                return;
            }

            // 3. Calculate Working Hours
            TimeSpan duration = endDateTime - startDateTime;
            double currentTaskHours = Math.Round(duration.TotalHours, 2);
            bool isSameDay = (startDateTime.Date == endDateTime.Date);

            // 4. Check 8-Hour Rule for Same-Day Allocations
            if (isSameDay)
            {
                if (currentTaskHours > 8.00)
                {
                    WarningMsg(string.Format("Task duration ({0:0.00} Hrs) exceeds the maximum 8.00 Hours daily limit.", currentTaskHours));
                    return;
                }
            }

            // If in Edit Mode, update the database record directly
            if (ViewState["EditTaskEntryId"] != null)
            {
                string editId = ViewState["EditTaskEntryId"].ToString();

                ds = objdb.ByProcedure("USP_TaskAllocationEntry",
                    new string[] { 
                        "Flag", "TaskEntryId", "ProjectId", "ProjectName", "StartDate", "StartTime", 
                        "Allocated", "PriorityId", "Priority", "TicketType", 
                        "EndDate", "EndTime", "WorkingHours", "TaskStatus", 
                        "Remark"
                    },
                    new string[] { 
                        "9", 
                        editId,
                        ddlProject.SelectedValue,
                        ddlProject.SelectedItem.Text,
                        startDateTime.ToString("dd/MM/yyyy"),
                        txtStartTime.Text.Trim(),
                        ddlAllocated.SelectedItem != null ? ddlAllocated.SelectedItem.Text : "",
                        ddlPriority.SelectedValue,
                        ddlPriority.SelectedItem != null ? ddlPriority.SelectedItem.Text : "",
                        ddlTicketType.SelectedValue,
                        endDateTime.ToString("dd/MM/yyyy"),
                        txtEndTime.Text.Trim(),
                        currentTaskHours.ToString("0.00"),
                        ddlStatus.SelectedValue,
                        txtRemark.Text.Trim().Replace(Environment.NewLine, "<br />")
                    }, "ds");

                if (IsNullDataSet(ds) && Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                {
                    SuccessMsg(string.Format("Task #{0} for '{1}' updated successfully!", editId, ddlProject.SelectedItem.Text));
                    ResetEditMode();
                    btnClearInput_Click(sender, e);
                    LoadSavedHistory();
                }
                else
                {
                    string errMsg = IsNullDataSet(ds) ? Convert.ToString(ds.Tables[0].Rows[0]["Msg"]) : "Failed to update record.";
                    WarningMsg("Update failed: " + errMsg);
                }
                return;
            }

            if (isSameDay)
            {
                DataTable dtCurrent = ViewState["TasksTable"] as DataTable;
                if (dtCurrent != null && dtCurrent.Rows.Count > 0)
                {
                    double existingHoursOnDate = 0;
                    string startDateString = startDateTime.ToString("dd/MM/yyyy");

                    foreach (DataRow row in dtCurrent.Rows)
                    {
                        string rowStartDate = row["StartDate"].ToString();
                        bool rowIsSameDay = Convert.ToBoolean(row["IsSameDay"]);

                        if (rowStartDate == startDateString && rowIsSameDay)
                        {
                            existingHoursOnDate += Convert.ToDouble(row["WorkingHours"]);
                        }
                    }

                    if ((existingHoursOnDate + currentTaskHours) > 8.0001)
                    {
                        WarningMsg(string.Format(
                            "Cannot add task! Total working hours on {0} will exceed 8.00 Hours. (Already added: {1:0.00} Hrs + New Task: {2:0.00} Hrs = Total: {3:0.00} Hrs > 8.00 Hrs limit)",
                            startDateString, existingHoursOnDate, currentTaskHours, (existingHoursOnDate + currentTaskHours)
                        ));
                        return;
                    }
                }
            }

            // 5. Add Task into Staging Table
            DataTable dt = ViewState["TasksTable"] as DataTable;
            if (dt == null)
            {
                InitializeTasksTable();
                dt = ViewState["TasksTable"] as DataTable;
            }

            DataRow newRow = dt.NewRow();
            newRow["Id"] = dt.Rows.Count + 1;
            newRow["ProjectId"] = ddlProject.SelectedValue;
            newRow["ProjectName"] = ddlProject.SelectedItem.Text;
            newRow["StartDate"] = startDateTime.ToString("dd/MM/yyyy");
            newRow["StartTime"] = txtStartTime.Text.Trim();
            newRow["Allocated"] = ddlAllocated.SelectedItem != null ? ddlAllocated.SelectedItem.Text : "";
            newRow["PriorityId"] = ddlPriority.SelectedValue;
            newRow["Priority"] = ddlPriority.SelectedItem.Text;
            newRow["TicketType"] = ddlTicketType.SelectedValue;
            newRow["EndDate"] = endDateTime.ToString("dd/MM/yyyy");
            newRow["EndTime"] = txtEndTime.Text.Trim();
            newRow["WorkingHours"] = currentTaskHours;
            newRow["TaskStatus"] = ddlStatus.SelectedValue;
            newRow["Remark"] = txtRemark.Text.Trim().Replace(Environment.NewLine, "<br />");
            newRow["IsSameDay"] = isSameDay;

            dt.Rows.Add(newRow);
            ViewState["TasksTable"] = dt;

            BindStagedGrid();
            SuccessMsg(string.Format("Task for '{0}' added to list successfully ({1:0.00} Hrs).", ddlProject.SelectedItem.Text, currentTaskHours));

            // Reset specific fields for convenient next entry
            ddlTicketType.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            txtRemark.Text = string.Empty;
            txtRemark.Attributes.Remove("style");
            txtRemark.CssClass = txtRemark.CssClass.Replace("text-high-priority", "").Trim();
            txtWorkingHours.Text = "0.00 Hrs";
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void gvAddedTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "RemoveTask")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                DataTable dt = ViewState["TasksTable"] as DataTable;

                if (dt != null && rowIndex >= 0 && rowIndex < dt.Rows.Count)
                {
                    string projectName = dt.Rows[rowIndex]["ProjectName"].ToString();
                    double hours = Convert.ToDouble(dt.Rows[rowIndex]["WorkingHours"]);

                    dt.Rows.RemoveAt(rowIndex);
                    ViewState["TasksTable"] = dt;
                    BindStagedGrid();

                    SuccessMsg(string.Format("Removed task for '{0}' ({1:0.00} Hrs).", projectName, hours));
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void btnFinalSave_Click(object sender, EventArgs e)
    {
        btnConfirmSave_Click(sender, e);
    }

    protected void btnConfirmSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = ViewState["TasksTable"] as DataTable;
            if (dt == null || dt.Rows.Count == 0)
            {
                WarningMsg("No tasks to save.");
                return;
            }

            int savedCount = 0;
            string lastError = string.Empty;

            foreach (DataRow row in dt.Rows)
            {
                try
                {
                    ds = objdb.ByProcedure("USP_TaskAllocationEntry",
                        new string[] { 
                            "Flag", "ProjectId", "ProjectName", "StartDate", "StartTime", 
                            "Allocated", "PriorityId", "Priority", "TicketType", 
                            "EndDate", "EndTime", "WorkingHours", "TaskStatus", 
                            "Remark", "CreatedBy", "CreatedByIp" 
                        },
                        new string[] { 
                            "1", 
                            row["ProjectId"].ToString(),
                            row["ProjectName"].ToString(),
                            row["StartDate"].ToString(),
                            row["StartTime"].ToString(),
                            row["Allocated"].ToString(),
                            row["PriorityId"].ToString(),
                            row["Priority"].ToString(),
                            row["TicketType"].ToString(),
                            row["EndDate"].ToString(),
                            row["EndTime"].ToString(),
                            row["WorkingHours"].ToString(),
                            row["TaskStatus"].ToString(),
                            row["Remark"].ToString().Replace(Environment.NewLine, "<br />"),
                            Convert.ToString(ViewState["Emp_ID"]),
                            objdb.GetLocalIPAddress()
                        }, "ds");

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            savedCount++;
                        }
                        else
                        {
                            lastError = Convert.ToString(ds.Tables[0].Rows[0]["Msg"]);
                        }
                    }
                }
                catch (Exception ex)
                {
                    lastError = ex.Message;
                }
            }

            if (savedCount > 0)
            {
                SuccessMsg(string.Format("Thank You! Successfully saved {0} of {1} task(s) to the database.", savedCount, dt.Rows.Count));
                InitializeTasksTable();
                btnClearInput_Click(sender, e);
                LoadSavedHistory();
            }
            else
            {
                WarningMsg("Could not save tasks. Please ensure the database table 'Tbl_TaskAllocationEntry' and procedure 'USP_TaskAllocationEntry' have been created. Error: " + lastError);
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void gvSavedHistory_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ToggleActive")
            {
                string taskEntryId = e.CommandArgument.ToString();
                DataSet dsStatus = objdb.ByProcedure("USP_TaskAllocationEntry",
                    new string[] { "Flag", "TaskEntryId" },
                    new string[] { "10", taskEntryId }, "ds");

                if (IsNullDataSet(dsStatus) && Convert.ToString(dsStatus.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                {
                    SuccessMsg("Task status updated successfully.");
                    LoadSavedHistory();
                }
                else
                {
                    WarningMsg("Failed to update task status.");
                }
            }
            else if (e.CommandName == "EditTask")
            {
                string taskEntryId = e.CommandArgument.ToString();
                DataSet dsTask = objdb.ByProcedure("USP_TaskAllocationEntry",
                    new string[] { "Flag", "TaskEntryId" },
                    new string[] { "11", taskEntryId }, "ds");

                if (IsNullDataSet(dsTask))
                {
                    DataRow row = dsTask.Tables[0].Rows[0];
                    ViewState["EditTaskEntryId"] = taskEntryId;

                    // 1. Project
                    string projId = row["ProjectId"].ToString();
                    if (ddlProject.Items.FindByValue(projId) != null)
                    {
                        ddlProject.ClearSelection();
                        ddlProject.SelectedValue = projId;
                    }

                    // 2. Dates and Times
                    txtStartDate.Text = row["StartDate"].ToString();
                    txtStartTime.Text = row["StartTime"].ToString();
                    txtEndDate.Text = row["EndDate"].ToString();
                    txtEndTime.Text = row["EndTime"].ToString();
                    txtWorkingHours.Text = Convert.ToString(row["WorkingHours"]) + " Hrs";

                    // 3. Priority
                    string prioId = row["PriorityId"].ToString();
                    string prioName = row["Priority"].ToString();
                    if (ddlPriority.Items.FindByValue(prioId) != null)
                    {
                        ddlPriority.ClearSelection();
                        ddlPriority.SelectedValue = prioId;
                    }
                    else if (ddlPriority.Items.FindByText(prioName) != null)
                    {
                        ddlPriority.ClearSelection();
                        ddlPriority.Items.FindByText(prioName).Selected = true;
                    }

                    // 4. Fill Allocated dropdown based on priority (On-Spot vs Normal)
                    bool isOnSpot = (prioName.ToLower().Contains("on-spot") || (ddlPriority.SelectedItem != null && ddlPriority.SelectedItem.Text.ToLower().Contains("on-spot")));
                    FillAllocated(isOnSpot);

                    string alloc = row["Allocated"].ToString();
                    if (ddlAllocated.Items.FindByText(alloc) != null)
                    {
                        ddlAllocated.ClearSelection();
                        ddlAllocated.Items.FindByText(alloc).Selected = true;
                    }
                    else if (ddlAllocated.Items.FindByValue(alloc) != null)
                    {
                        ddlAllocated.ClearSelection();
                        ddlAllocated.Items.FindByValue(alloc).Selected = true;
                    }
                    else if (!string.IsNullOrEmpty(alloc))
                    {
                        ddlAllocated.Items.Add(new ListItem(alloc, alloc));
                        ddlAllocated.ClearSelection();
                        ddlAllocated.Items.FindByText(alloc).Selected = true;
                    }

                    // 5. Ticket Type
                    string ticketType = row["TicketType"].ToString();
                    if (ddlTicketType.Items.FindByValue(ticketType) != null)
                    {
                        ddlTicketType.ClearSelection();
                        ddlTicketType.SelectedValue = ticketType;
                    }
                    else if (ddlTicketType.Items.FindByText(ticketType) != null)
                    {
                        ddlTicketType.ClearSelection();
                        ddlTicketType.Items.FindByText(ticketType).Selected = true;
                    }

                    // 6. Status
                    string status = row["TaskStatus"].ToString();
                    if (ddlStatus.Items.FindByValue(status) != null)
                    {
                        ddlStatus.ClearSelection();
                        ddlStatus.SelectedValue = status;
                    }
                    else if (ddlStatus.Items.FindByText(status) != null)
                    {
                        ddlStatus.ClearSelection();
                        ddlStatus.Items.FindByText(status).Selected = true;
                    }

                    // 7. Remark
                    string remark = row["Remark"].ToString().Replace("<br />", Environment.NewLine).Replace("<br/>", Environment.NewLine);
                    txtRemark.Text = remark;

                    // Priority style on remark
                    if (ddlPriority.SelectedItem != null && (ddlPriority.SelectedItem.Text.ToLower().Contains("high") || ddlPriority.SelectedItem.Text.ToLower().Contains("critical")))
                    {
                        txtRemark.CssClass = "form-control text-high-priority";
                        txtRemark.Attributes["style"] = "color: #dc3545 !important; font-weight: 600 !important; border-color: #dc3545 !important;";
                    }
                    else
                    {
                        txtRemark.CssClass = "form-control";
                        txtRemark.Attributes.Remove("style");
                    }

                    // Switch UI to edit mode
                    btnAddRow.Text = "Update Task";
                    btnAddRow.CssClass = "btn btn-warning px-4 text-dark font-weight-bold";
                    btnCancelEdit.Visible = true;

                    SuccessMsg(string.Format("Task #{0} loaded for editing. Update fields above and click 'Update Task'.", taskEntryId));

                    // Scroll smoothly to form
                    ClientScript.RegisterStartupScript(this.GetType(), "ScrollToTop", "$('html, body').animate({ scrollTop: $('#cardMain').offset().top - 20 }, 500);", true);
                }
                else
                {
                    WarningMsg("Could not find task record details to edit.");
                }
            }
            else if (e.CommandName == "DeleteSavedTask")
            {
                string taskEntryId = e.CommandArgument.ToString();
                DataSet dsDel = objdb.ByProcedure("USP_TaskAllocationEntry",
                    new string[] { "Flag", "TaskEntryId" },
                    new string[] { "3", taskEntryId }, "ds");

                if (IsNullDataSet(dsDel) && Convert.ToString(dsDel.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                {
                    SuccessMsg("Saved task record deleted successfully.");
                    LoadSavedHistory();
                }
                else
                {
                    WarningMsg("Failed to delete record.");
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        ResetEditMode();
        btnClearInput_Click(sender, e);
        SuccessMsg("Edit mode cancelled.");
    }

    private void ResetEditMode()
    {
        ViewState["EditTaskEntryId"] = null;
        btnAddRow.Text = "+ Add Task to List";
        btnAddRow.CssClass = "btn btn-success px-4";
        btnCancelEdit.Visible = false;
    }

    protected void btnClearInput_Click(object sender, EventArgs e)
    {
        ResetEditMode();
        ddlProject.SelectedIndex = 0;
        ddlPriority.SelectedIndex = 0;
        ddlTicketType.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
        FillAllocated(false);
        txtRemark.Text = string.Empty;
        txtRemark.Attributes.Remove("style");
        txtRemark.CssClass = txtRemark.CssClass.Replace("text-high-priority", "").Trim();
        txtStartDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        txtEndDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        txtStartTime.Text = "01:30 PM";
        txtEndTime.Text = "05:30 PM";
        txtWorkingHours.Text = "4.00 Hrs";
        lblMsg.Text = string.Empty;
    }

    protected void btnResetAll_Click(object sender, EventArgs e)
    {
        ResetEditMode();
        btnClearInput_Click(sender, e);
        InitializeTasksTable();
        SuccessMsg("All staged tasks have been cleared.");
    }

    protected string GetPriorityClass(object priority)
    {
        string p = priority != null ? priority.ToString().ToLower() : "";
        if (p.Contains("high") || p.Contains("critical") || p == "1" || p == "4")
            return "bg-danger";
        if (p.Contains("medium") || p == "2")
            return "bg-warning text-dark";
        if (p.Contains("low") || p == "3")
            return "bg-success";
        return "bg-secondary";
    }

    protected string GetTicketTypeClass(object ticketType)
    {
        string t = ticketType != null ? ticketType.ToString() : "";
        if (t.Contains("Support") && !t.Contains("Production"))
            return "badge-ticket-a";
        if (t.Contains("Ongoing") || t.Contains("On going"))
            return "badge-ticket-b";
        if (t.Contains("Enhancement"))
            return "badge-ticket-c";
        if (t.Contains("Production Support"))
            return "badge-ticket-d";
        if (t.Contains("Production Development"))
            return "badge-ticket-e";
        if (t.Contains("CR Activity"))
            return "badge-ticket-f";
        return "bg-secondary";
    }

    protected string GetStatusBadge(object taskStatus)
    {
        string s = taskStatus != null ? taskStatus.ToString().Trim() : "";
        if (s.Equals("Complete", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class='badge-status-complete'><i class='fa fa-check-circle me-1'></i>Complete</span>";
        }
        else if (s.Equals("Partially Complete", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class='badge-status-partial'><i class='fa fa-adjust me-1'></i>Partially Complete</span>";
        }
        else if (s.Equals("Pending", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class='badge-status-pending'><i class='fa fa-clock-o me-1'></i>Pending</span>";
        }
        else
        {
            return string.Format("<span class='badge bg-secondary'>{0}</span>", s);
        }
    }

    protected void gvAddedTasks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string priority = Convert.ToString(drv["Priority"]).ToLower();
                string priorityId = drv.Row.Table.Columns.Contains("PriorityId") ? Convert.ToString(drv["PriorityId"]) : "";
                if (priority.Contains("high") || priority.Contains("critical") || priorityId == "1")
                {
                    e.Row.CssClass = (e.Row.CssClass + " row-high-priority").Trim();
                }
            }
        }
    }

    protected void gvSavedHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string priority = Convert.ToString(drv["Priority"]).ToLower();
                string priorityId = drv.Row.Table.Columns.Contains("PriorityId") ? Convert.ToString(drv["PriorityId"]) : "";
                if (priority.Contains("high") || priority.Contains("critical") || priorityId == "1")
                {
                    e.Row.CssClass = (e.Row.CssClass + " row-high-priority").Trim();
                }

                string isActive = drv.Row.Table.Columns.Contains("IsActive") ? Convert.ToString(drv["IsActive"]) : "1";
                if (isActive == "False" || isActive == "0")
                {
                    e.Row.CssClass = (e.Row.CssClass + " table-secondary text-muted").Trim();
                }
            }
        }
    }
}
