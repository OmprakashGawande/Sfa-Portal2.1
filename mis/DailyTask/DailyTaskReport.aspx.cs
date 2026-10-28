using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_DailyTaskReport : System.Web.UI.Page
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

                // Set default dates: 1st of current month to today
                DateTime now = DateTime.Now;
                DateTime firstDayOfMonth = new DateTime(now.Year, now.Month, 1);
                txtFromDate.Text = firstDayOfMonth.ToString("dd/MM/yyyy", cult);
                txtToDate.Text = now.ToString("dd/MM/yyyy", cult);

                CheckUserRole();
                FillPriority();

                // Generate Breadcrumb
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

                // Load initial report
                LoadReport();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void CheckUserRole()
    {
        try
        {
            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);
            bool isAdminOrManager = false;

            // Query Flag 7 to check if user has Admin or Project Manager role
            DataSet dsRole = objdb.ByProcedure("USP_TaskAllocationEntry",
                new string[] { "Flag", "EmpId" },
                new string[] { "7", currentEmpId }, "ds");

            if (IsNullDataSet(dsRole))
            {
                int count = Convert.ToInt32(dsRole.Tables[0].Rows[0]["IsAdminOrManager"]);
                isAdminOrManager = (count > 0);
            }

            ViewState["IsAdminOrManager"] = isAdminOrManager;

            if (isAdminOrManager)
            {
                divEmployeeFilter.Visible = true;
                lblRoleBadge.Text = "Role: Administrator / Manager View";
                lblRoleBadge.CssClass = "badge bg-primary text-white px-3 py-2 fs-6";
                FillEmployees();
            }
            else
            {
                // Non-admin / regular employee can only view their own records
                divEmployeeFilter.Visible = false;
                lblRoleBadge.Text = "Role: My Daily Tasks View";
                lblRoleBadge.CssClass = "badge bg-info text-white px-3 py-2 fs-6";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillEmployees()
    {
        try
        {
            ddlEmployee.Items.Clear();
            DataSet dsEmp = objdb.ByProcedure("USP_TaskAllocation",
                new string[] { "Flag" },
                new string[] { "1" }, "ds");

            if (IsNullDataSet(dsEmp))
            {
                ddlEmployee.DataTextField = "Employee_Name";
                ddlEmployee.DataValueField = "Employee_Id";
                ddlEmployee.DataSource = dsEmp.Tables[0];
                ddlEmployee.DataBind();
            }
            ddlEmployee.Items.Insert(0, new ListItem("All Employees", "0"));
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
            ddlPriority.Items.Clear();
            DataSet dsPriority = objdb.ByProcedure("USP_TaskAllocation",
                new string[] { "Flag" },
                new string[] { "7" }, "ds");

            if (IsNullDataSet(dsPriority))
            {
                ddlPriority.DataTextField = "PriorityType";
                ddlPriority.DataValueField = "PriorityTypeId";
                ddlPriority.DataSource = dsPriority.Tables[0];
                ddlPriority.DataBind();
            }
            ddlPriority.Items.Insert(0, new ListItem("All Priorities", "0"));
        }
        catch
        {
            ddlPriority.Items.Clear();
            ddlPriority.Items.Insert(0, new ListItem("All Priorities", "0"));
        }
    }

    private void LoadReport()
    {
        try
        {
            lblMsg.Text = string.Empty;

            // 1. Validate Dates
            if (string.IsNullOrWhiteSpace(txtFromDate.Text))
            {
                WarningMsg("Please select From Date.");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtToDate.Text))
            {
                WarningMsg("Please select To Date.");
                return;
            }

            DateTime fromDate, toDate;
            string[] formats = new string[] { "dd/MM/yyyy", "d/M/yyyy" };

            bool fromParsed = DateTime.TryParseExact(txtFromDate.Text.Trim(), formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out fromDate) ||
                              DateTime.TryParse(txtFromDate.Text.Trim(), cult, DateTimeStyles.None, out fromDate);

            bool toParsed = DateTime.TryParseExact(txtToDate.Text.Trim(), formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out toDate) ||
                            DateTime.TryParse(txtToDate.Text.Trim(), cult, DateTimeStyles.None, out toDate);

            if (!fromParsed || !toParsed)
            {
                WarningMsg("Invalid Date format. Please enter date as DD/MM/YYYY.");
                return;
            }

            if (fromDate > toDate)
            {
                WarningMsg("From Date cannot be greater than To Date.");
                return;
            }

            // 2. Determine Scope (Admin vs Employee Security Enforcement)
            bool isAdminOrManager = ViewState["IsAdminOrManager"] != null && Convert.ToBoolean(ViewState["IsAdminOrManager"]);
            string currentEmpId = Convert.ToString(ViewState["Emp_ID"]);
            string empIdToQuery = null;

            if (isAdminOrManager)
            {
                if (ddlEmployee.SelectedValue != "0" && !string.IsNullOrEmpty(ddlEmployee.SelectedValue))
                {
                    empIdToQuery = ddlEmployee.SelectedValue;
                }
            }
            else
            {
                // Strict Server-Side Security: Force logged-in employee ID
                empIdToQuery = currentEmpId;
            }

            string priorityIdToQuery = (ddlPriority.SelectedValue != "0" && !string.IsNullOrEmpty(ddlPriority.SelectedValue))
                ? ddlPriority.SelectedValue
                : null;

            // 3. Query via USP_TaskAllocationEntry Flag 4
            ds = objdb.ByProcedure("USP_TaskAllocationEntry",
                new string[] { "Flag", "EmpId", "PriorityId", "FromDate", "ToDate" },
                new string[] { 
                    "4", 
                    empIdToQuery, 
                    priorityIdToQuery, 
                    fromDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture), 
                    toDate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture) 
                }, "ds");

            gvReport.DataSource = null;
            gvReport.DataBind();

            if (IsNullDataSet(ds))
            {
                DataTable dt = ds.Tables[0];
                gvReport.DataSource = dt;
                gvReport.DataBind();

                if (gvReport.Rows.Count > 0)
                {
                    gvReport.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvReport.UseAccessibleHeader = true;
                }

                lblRecordCount.Text = dt.Rows.Count.ToString();
                double totalHours = 0;
                foreach (DataRow row in dt.Rows)
                {
                    if (row["WorkingHours"] != DBNull.Value && !string.IsNullOrWhiteSpace(row["WorkingHours"].ToString()))
                    {
                        double h = 0;
                        if (double.TryParse(row["WorkingHours"].ToString(), out h))
                        {
                            totalHours += h;
                        }
                    }
                }
                lblTotalHours.Text = totalHours.ToString("0.00");
            }
            else
            {
                lblRecordCount.Text = "0";
                lblTotalHours.Text = "0.00";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        DateTime now = DateTime.Now;
        DateTime firstDayOfMonth = new DateTime(now.Year, now.Month, 1);
        txtFromDate.Text = firstDayOfMonth.ToString("dd/MM/yyyy", cult);
        txtToDate.Text = now.ToString("dd/MM/yyyy", cult);

        if (ddlEmployee.Items.Count > 0)
        {
            ddlEmployee.SelectedIndex = 0;
        }
        if (ddlPriority.Items.Count > 0)
        {
            ddlPriority.SelectedIndex = 0;
        }

        lblMsg.Text = string.Empty;
        LoadReport();
    }

    protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string priority = Convert.ToString(drv["Priority"]).ToLower();
                string priorityId = drv.Row.Table.Columns.Contains("PriorityId") ? Convert.ToString(drv["PriorityId"]) : "";

                // High Priority Complete Row Red
                if (priority.Contains("high") || priority.Contains("critical") || priorityId == "1")
                {
                    e.Row.CssClass = (e.Row.CssClass + " row-high-priority").Trim();
                }
            }
        }
    }

    protected string GetPriorityBadge(object priority, object priorityId)
    {
        string p = priority != null ? priority.ToString().Trim() : "";
        string pid = priorityId != null ? priorityId.ToString().Trim() : "";
        string pLower = p.ToLower();

        if (pLower.Contains("high") || pLower.Contains("critical") || pid == "1")
            return string.Format("<span class='badge-priority-high'><i class='fa fa-bolt me-1'></i>{0}</span>", p);
        if (pLower.Contains("medium") || pLower.Contains("normal") || pid == "2")
            return string.Format("<span class='badge-priority-medium'>{0}</span>", p);
        if (pLower.Contains("low") || pid == "3")
            return string.Format("<span class='badge-priority-low'>{0}</span>", p);
        if (pLower.Contains("spot") || pid == "4")
            return string.Format("<span class='badge-priority-spot'><i class='fa fa-crosshairs me-1'></i>{0}</span>", p);

        return string.Format("<span class='badge-priority-default'>{0}</span>", p);
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
}
