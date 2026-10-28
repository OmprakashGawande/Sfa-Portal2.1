using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Payroll_PayrollEmpSetAttendance : System.Web.UI.Page
{
    private DataSet ds;
    private readonly AbstApiDBApi objdb = new APIProcedure();
    private readonly CultureInfo cult = new CultureInfo("gu-IN", true);
    private static readonly string[] AttendanceCodes = new string[] { "P", "A", "FH","SH", "CL", "CoF" };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] != null)
        {
            if (!IsPostBack)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                ViewState["Office_ID"] = Session["Office_ID"].ToString();
                DivDetail.Visible = false;
                btnSave.Visible = false;
                CountSunday();
                FillDropdown();
                FillMonth();
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    protected void CountSunday()
    {
        try
        {
            DateTime today = DateTime.Today;
            int daysInMonth = DateTime.DaysInMonth(today.Year, today.Month);
            int count = 0;

            for (int i = 1; i <= daysInMonth; i++)
            {
                DateTime d = new DateTime(today.Year, today.Month, i);
                if (d.DayOfWeek == DayOfWeek.Sunday)
                {
                    count++;
                }
            }
            ViewState["SundayCoun"] = count.ToString();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void FillDropdown()
    {
        try
        {
            ddlOfficeName.Items.Clear();
            ddlYear.Items.Clear();
            ddlOfficeName.Items.Insert(0, new ListItem("Select", "0"));
            ddlYear.Items.Insert(0, new ListItem("Select", "0"));

            ds = objdb.ByProcedure("SpHrYear_Master", new string[] { "flag" }, new string[] { "2" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlYear.DataSource = ds;
                ddlYear.DataTextField = "Year";
                ddlYear.DataValueField = "Year";
                ddlYear.DataBind();
                ddlYear.Items.Insert(0, new ListItem("Select", "0"));
            }

            ds = objdb.ByProcedure("SpAdminOffice", new string[] { "flag" }, new string[] { "9" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlOfficeName.DataSource = ds;
                ddlOfficeName.DataTextField = "Office_Name";
                ddlOfficeName.DataValueField = "Office_ID";
                ddlOfficeName.DataBind();
                ddlOfficeName.Items.Insert(0, new ListItem("Select", "0"));
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void FillMonth()
    {
        try
        {
            ddlMonth.Items.Clear();
            int currentYear = DateTime.Now.Year;
            int currentMonth = DateTime.Now.Month;

            for (int i = 12; i >= 1; i--)
            {
                DateTime date = new DateTime(currentYear, i, 1);
                if (i <= currentMonth)
                {
                    ddlMonth.Items.Insert(0, new ListItem(date.ToString("MMMM"), i.ToString()));
                }
            }

            if (currentMonth == 1 && ddlYear.SelectedValue == (currentYear - 1).ToString())
            {
                ddlMonth.Items.Clear();
                DateTime date = new DateTime(currentYear, 12, 1);
                ddlMonth.Items.Insert(0, new ListItem(date.ToString("MMMM"), "12"));
            }

            ddlMonth.DataBind();
            ddlMonth.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void FillGrid()
    {
        try
        {
            int year = int.Parse(ddlYear.SelectedValue);
            int month = int.Parse(ddlMonth.SelectedValue);
            int totalDaysInMonth = DateTime.DaysInMonth(year, month);
            ViewState["days"] = totalDaysInMonth.ToString();

            ds = objdb.ByProcedure("SpPayrollEmpAttendance",
                new string[] { "flag", "Year", "MonthNo", "Office_ID", "Emp_TypeOfPost" },
                new string[] { "1", ddlYear.SelectedValue, ddlMonth.SelectedValue, ddlOfficeName.SelectedValue, ddlEmp_TypeOfPost.SelectedValue },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();

                DivDetail.Visible = true;
                btnSave.Visible = true;

                // Configure Day 29, 30, 31 column visibility (indices 31, 32, 33)
                GridView1.Columns[31].Visible = (totalDaysInMonth >= 29);
                GridView1.Columns[32].Visible = (totalDaysInMonth >= 30);
                GridView1.Columns[33].Visible = (totalDaysInMonth >= 31);

                lblSelectedItems.Text = "Attendance of office <b>" + ddlOfficeName.SelectedItem.Text + "</b> for month " + ddlMonth.SelectedItem.Text + ", " + ddlYear.SelectedItem.Text + " ( " + ddlEmp_TypeOfPost.SelectedItem.Text + " )";
                lblAttDate.Text = DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss");
            }
            else
            {
                lblMsg.Text = "";
                GridView1.DataSource = null;
                GridView1.DataBind();
                DivDetail.Visible = false;
                btnSave.Visible = false;
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            if (ddlYear.SelectedIndex > 0 && ddlOfficeName.SelectedIndex > 0 && ddlMonth.SelectedIndex > 0)
            {
                FillGrid();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            string msg = "";
            if (ddlYear.SelectedIndex == 0)
            {
                msg += "Select Year.\\n";
            }
            if (ddlMonth.SelectedIndex == 0)
            {
                msg += "Select Month.\\n";
            }

            if (!string.IsNullOrEmpty(msg))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('" + msg + "');", true);
                return;
            }

            string year = ddlYear.SelectedValue;
            string monthNo = ddlMonth.SelectedValue;
            string month = ddlMonth.SelectedItem.Text;
            int totalDays = int.Parse(ViewState["days"].ToString());
            string loginUserId = ViewState["Emp_ID"].ToString();
            string officeId = ViewState["Office_ID"].ToString();

            // Build stored procedure parameter names array
            List<string> paramNames = new List<string> { "flag", "Emp_ID", "Office_ID", "Year", "MonthNo", "Month" };
            for (int d = 1; d <= 31; d++)
            {
                paramNames.Add("Day" + d);
            }
            paramNames.AddRange(new string[] { "TotalDayOfMonth", "PayableDays", "NotPayableDays", "Attendance_UpdatedBy" });
            string[] paramNameArr = paramNames.ToArray();

            foreach (GridViewRow gr in GridView1.Rows)
            {
                CheckBox chkSelect = (CheckBox)gr.FindControl("chkSelect");
                Label lblGenerateStatus = (Label)gr.FindControl("lblGenerateStatus");
                Label lblChecked = (Label)gr.FindControl("lblChecked");

                string status = (lblGenerateStatus != null) ? lblGenerateStatus.Text.Trim() : "";
                string isCheckedVal = (lblChecked != null) ? lblChecked.Text.Trim().ToLower() : "false";

                if (chkSelect != null && chkSelect.Checked && !string.Equals(status, "Generated", StringComparison.OrdinalIgnoreCase) && isCheckedVal != "true")
                {
                    Label lblEmpId = (Label)gr.FindControl("lblEmp_ID");
                    TextBox txtPayableDays = (TextBox)gr.FindControl("txtPayableDays");

                    decimal countAbsentDays = 0;
                    string[] dayValues = new string[31];

                    for (int d = 1; d <= 31; d++)
                    {
                        DropDownList ddlDay = (DropDownList)gr.FindControl("ddlDay" + d);
                        string val = (ddlDay != null) ? ddlDay.SelectedValue : "P";
                        dayValues[d - 1] = val;

                        if (d <= totalDays && val == "A")
                        {
                            countAbsentDays++;
                        }
                        else if (d <= totalDays && (val == "H" || val == "FH" || val == "SH"))
                        {
                            countAbsentDays += 0.5m;
                        }
                    }

                    if (countAbsentDays > totalDays)
                    {
                        countAbsentDays = totalDays;
                    }

                    decimal payableDays = totalDays - countAbsentDays;
                    if (txtPayableDays != null)
                    {
                        txtPayableDays.Text = payableDays.ToString();
                    }

                    List<string> paramValues = new List<string>
                    {
                        "0",
                        (lblEmpId != null) ? lblEmpId.Text : "",
                        officeId,
                        year,
                        monthNo,
                        month
                    };
                    paramValues.AddRange(dayValues);
                    paramValues.AddRange(new string[]
                    {
                        totalDays.ToString(),
                        payableDays.ToString(),
                        countAbsentDays.ToString(),
                        loginUserId
                    });

                    objdb.ByProcedure("SpPayrollEmpAttendance", paramNameArr, paramValues.ToArray(), "dataset");
                }
            }

            FillGrid();
            lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Thank You!", "Operation Successfully Completed");
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            FillMonth();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;

                // Check if attendance is already set in tblPayrollEmpAttendance
                string isCheckedVal = (drv.DataView.Table.Columns.Contains("Checked") && drv["Checked"] != DBNull.Value)
                    ? drv["Checked"].ToString().Trim().ToLower()
                    : "false";
                bool isAttendanceSet = (isCheckedVal == "true");

                // Check if salary is already generated
                string genStatus = (drv["GenerateStatus"] != DBNull.Value) ? drv["GenerateStatus"].ToString().Trim() : "Not Generated";
                bool isGenerated = string.Equals(genStatus, "Generated", StringComparison.OrdinalIgnoreCase);

                // Lock attendance if salary is generated OR attendance has already been set
                bool isLocked = isGenerated || isAttendanceSet;
                bool isEditable = !isLocked;

                e.Row.Attributes["data-generate-status"] = genStatus;
                e.Row.Attributes["data-attendance-set"] = isAttendanceSet ? "true" : "false";

                // Disable row checkbox if locked
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    chkSelect.Enabled = isEditable;
                    chkSelect.Checked = false;
                }

                if (isGenerated)
                {
                    e.Row.CssClass = (e.Row.CssClass + " attendance-locked").Trim();
                    e.Row.ToolTip = "Salary Generated - Attendance is Locked";
                }
                else if (isAttendanceSet)
                {
                    e.Row.CssClass = (e.Row.CssClass + " attendance-locked attendance-submitted").Trim();
                    e.Row.ToolTip = "Attendance Already Set - Locked";
                }

                for (int d = 1; d <= 31; d++)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("ddlDay" + d);
                    if (ddl != null)
                    {
                        ddl.Items.Clear();
                        for (int i = 0; i < AttendanceCodes.Length; i++)
                        {
                            ddl.Items.Add(new ListItem(AttendanceCodes[i], AttendanceCodes[i]));
                        }

                        string colName = "Day" + d;
                        string dayVal = (drv.DataView.Table.Columns.Contains(colName) && drv[colName] != DBNull.Value)
                            ? drv[colName].ToString()
                            : "P";

                        if (!string.IsNullOrEmpty(dayVal) && ddl.Items.FindByValue(dayVal) != null)
                        {
                            ddl.SelectedValue = dayVal;
                        }

                        // Fully disable dropdown if Locked (Attendance set or Generated)
                        ddl.Enabled = isEditable;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlOfficeName_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["Office_ID"] = ddlOfficeName.SelectedValue;
        DivDetail.Visible = false;
        btnSave.Visible = false;
    }
}