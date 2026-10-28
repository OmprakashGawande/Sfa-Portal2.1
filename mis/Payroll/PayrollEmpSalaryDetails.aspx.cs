using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Payroll_PayrollEmpSalaryDetails : System.Web.UI.Page
{
    DataSet ds;
    AbstApiDBApi objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] != null)
        {
            if (!IsPostBack)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                ViewState["Office_ID"] = Session["Office_ID"].ToString();
                Session["Page"] = Server.UrlEncode(System.DateTime.Now.ToString());
                DivDetail.Visible = false;
                FillDropdown();
                FillMonth();
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["UPage"] = Session["Page"];
    }

    protected void FillDropdown()
    {
        try
        {
            ddlYear.Items.Clear();
            ddlYear.Items.Insert(0, new ListItem("Select Financial Year", "0"));

            ds = objdb.ByProcedure("SpHrYear_Master", new string[] { "flag" }, new string[] { "2" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlYear.DataSource = ds;
                ddlYear.DataTextField = "Year";
                ddlYear.DataValueField = "Year";
                ddlYear.DataBind();
                ddlYear.Items.Insert(0, new ListItem("Select Financial Year", "0"));
            }

            ds = null;
            ddlOfficeName.Items.Clear();
            ddlOfficeName.Items.Insert(0, new ListItem("Select Office", "0"));

            ds = objdb.ByProcedure("SpAdminOffice", new string[] { "flag" }, new string[] { "9" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlOfficeName.DataSource = ds;
                ddlOfficeName.DataTextField = "Office_Name";
                ddlOfficeName.DataValueField = "Office_ID";
                ddlOfficeName.DataBind();
                ddlOfficeName.Items.Insert(0, new ListItem("Select Office", "0"));
            }

            if (ViewState["Office_ID"] != null && ddlOfficeName.Items.FindByValue(ViewState["Office_ID"].ToString()) != null)
            {
                ddlOfficeName.SelectedValue = ViewState["Office_ID"].ToString();
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
            for (int i = 12; i >= 1; i--)
            {
                DateTime date = new DateTime(DateTime.Now.Year, i, 1);
                if (i <= DateTime.Now.Month)
                {
                    ddlMonth.Items.Insert(0, new ListItem(date.ToString("MMMM"), i.ToString()));
                }
            }

            if (DateTime.Now.Month == 1 && ddlYear.SelectedValue == (DateTime.Now.Year - 1).ToString())
            {
                ddlMonth.Items.Clear();
                DateTime date = new DateTime(DateTime.Now.Year, 12, 1);
                ddlMonth.Items.Insert(0, new ListItem(date.ToString("MMMM"), "12"));
            }

            ddlMonth.DataBind();
            ddlMonth.Items.Insert(0, new ListItem("Select Month", "0"));
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
            DivDetail.Visible = false;
            ds = objdb.ByProcedure("SpPayrollSalaryDetail",
                new string[] { "flag", "Year", "MonthNo", "Office_ID", "Emp_TypeOfPost" },
                new string[] { "1", ddlYear.SelectedValue, ddlMonth.SelectedValue, ddlOfficeName.SelectedValue, ddlEmp_TypeOfPost.SelectedValue },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
                DivDetail.Visible = true;
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                lblMsg.Text = objdb.Alert("fa-info-circle", "alert-info", "Information", "No salary records found for the selected criteria.");
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    private void InsertLoanInstallmentOfEmployee()
    {
        DataSet ds1 = new DataSet();
        try
        {
            string LoginUserID = ViewState["Emp_ID"].ToString();
            ds1 = objdb.ByProcedure("USP_PayrollEmpLoanUpdate",
                new string[] { "SalaryYear", "SalaryMonth", "Office_ID", "UpdatedBy" },
                new string[] { ddlYear.SelectedValue, ddlMonth.SelectedValue, ddlOfficeName.SelectedValue, LoginUserID },
                "dataset");

            if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
            {
                if (ds1.Tables[0].Rows[0]["Msg"].ToString() != "Ok")
                {
                    string error = ds1.Tables[0].Rows[0]["ErrorMsg"].ToString();
                    lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", "Loan Update Error: " + error);
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
        finally
        {
            if (ds1 != null) { ds1.Dispose(); }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            if (ddlYear.SelectedIndex > 0 && ddlOfficeName.SelectedIndex > 0 && ddlMonth.SelectedIndex > 0 && ddlEmp_TypeOfPost.SelectedIndex > 0)
            {
                InsertLoanInstallmentOfEmployee();
                FillGrid();
            }
            else
            {
                lblMsg.Text = objdb.Alert("fa-warning", "alert-warning", "Warning!", "Please select all required search fields.");
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnGenerated_Click(object sender, EventArgs e)
    {
        ProcessSalaryStatus("Generated");
    }

    protected void btnHold_Click(object sender, EventArgs e)
    {
        ProcessSalaryStatus("Hold");
    }

    private void ProcessSalaryStatus(string targetStatus)
    {
        try
        {
            string IPAddress = Request.ServerVariables["REMOTE_ADDR"];
            lblMsg.Text = "";
            string msg = "";

            if (ddlOfficeName.SelectedIndex <= 0)
            {
                msg += "Select Office Name.\\n";
            }
            if (ddlYear.SelectedIndex <= 0)
            {
                msg += "Select Financial Year.\\n";
            }
            if (ddlMonth.SelectedIndex <= 0)
            {
                msg += "Select Month.\\n";
            }
            if (ddlEmp_TypeOfPost.SelectedIndex <= 0)
            {
                msg += "Select Type of Post.\\n";
            }

            if (!string.IsNullOrEmpty(msg))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('" + msg + "');", true);
                return;
            }

            if (ViewState["UPage"] != null && Session["Page"] != null && ViewState["UPage"].ToString() == Session["Page"].ToString())
            {
                string Year = ddlYear.SelectedValue;
                string MonthNo = ddlMonth.SelectedValue;
                string Month = ddlMonth.SelectedItem.Text;
                string LoginUserID = ViewState["Emp_ID"].ToString();
                string Office_ID = ddlOfficeName.SelectedValue;

                int processedCount = 0;

                foreach (GridViewRow gr in GridView1.Rows)
                {
                    CheckBox chkSelect = (CheckBox)gr.FindControl("chkSelect");
                    Label lblGenStatus = (Label)gr.FindControl("lblGenStatus");

                    string genStatus = (lblGenStatus != null) ? lblGenStatus.Text.Trim() : "";

                    if (chkSelect != null && chkSelect.Checked && !string.Equals(genStatus, "Generated", StringComparison.OrdinalIgnoreCase))
                    {
                        Label lblRowNumber = (Label)gr.FindControl("lblRowNumber");
                        Label lblSalary_Basic = (Label)gr.FindControl("lblSalary_Basic");
                        Label lblSalary_BasicPayScale = (Label)gr.FindControl("lblSalary_BasicPayScale");
                        Label lblSalary_PayableDays = (Label)gr.FindControl("lblSalary_PayableDays");
                        Label lblSalary_EarningTotal = (Label)gr.FindControl("lblSalary_EarningTotal");
                        Label lblSalary_DeductionTotal = (Label)gr.FindControl("lblSalary_DeductionTotal");
                        Label lblSalary_NetSalary = (Label)gr.FindControl("lblSalary_NetSalary");
                        Label lblSalary_NoDayDeduAmt = (Label)gr.FindControl("lblSalary_NoDayDeduAmt");
                        Label lblSalary_NoDayEarnAmt = (Label)gr.FindControl("lblSalary_NoDayEarnAmt");

                        string empId = (lblRowNumber != null) ? lblRowNumber.ToolTip.ToString() : "";
                        string basic = (lblSalary_Basic != null) ? lblSalary_Basic.Text.Trim() : "0";
                        string payScale = (lblSalary_BasicPayScale != null) ? lblSalary_BasicPayScale.Text.Trim() : "";
                        string payableDays = (lblSalary_PayableDays != null) ? lblSalary_PayableDays.Text.Trim() : "0";
                        string earningTotal = (lblSalary_EarningTotal != null) ? lblSalary_EarningTotal.Text.Trim() : "0";
                        string deductionTotal = (lblSalary_DeductionTotal != null) ? lblSalary_DeductionTotal.Text.Trim() : "0";
                        string netSalary = (lblSalary_NetSalary != null) ? lblSalary_NetSalary.Text.Trim() : "0";
                        string noDayDeduAmt = (lblSalary_NoDayDeduAmt != null) ? lblSalary_NoDayDeduAmt.Text.Trim() : "0";
                        string noDayEarnAmt = (lblSalary_NoDayEarnAmt != null) ? lblSalary_NoDayEarnAmt.Text.Trim() : "0";

                        objdb.ByProcedure("SpPayrollSalaryDetail",
                            new string[] { "flag", "Emp_ID", "Office_ID", "Year", "MonthNo", "Salary_Month", "Salary_Basic", "Salary_BasicPayScale", "Salary_PayableDays", "Salary_EarningTotal", "Salary_DeductionTotal", "Salary_NetSalary", "Salary_NoDayDeduAmt", "Salary_NoDayEarnAmt", "Salary_UpdatedBy", "SalaryStatus", "CreatedByIP" },
                            new string[] { "0", empId, Office_ID, Year, MonthNo, Month, basic, payScale, payableDays, earningTotal, deductionTotal, netSalary, noDayDeduAmt, noDayEarnAmt, LoginUserID, targetStatus, IPAddress },
                            "dataset");

                        processedCount++;
                    }
                }

                Session["Page"] = Server.UrlEncode(System.DateTime.Now.ToString());

                if (processedCount > 0)
                {
                    FillGrid();
                    string actionText = (targetStatus == "Generated") ? "Salary generated" : "Salary put on hold";
                    lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Success!", actionText + " successfully for " + processedCount + " employee(s).");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('Please select at least one employee with pending salary.');", true);
                }
            }
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
                string genStatus = (drv["GenStatus"] != DBNull.Value) ? drv["GenStatus"].ToString().Trim() : "Not Generated";
                string status = (drv["Status"] != DBNull.Value) ? drv["Status"].ToString().Trim() : "";

                bool isGenerated = string.Equals(genStatus, "Generated", StringComparison.OrdinalIgnoreCase);

                e.Row.Attributes["data-gen-status"] = genStatus;
                e.Row.Attributes["data-status"] = status;

                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    chkSelect.Enabled = !isGenerated;
                    if (isGenerated)
                    {
                        chkSelect.Checked = false;
                    }
                }

                if (isGenerated)
                {
                    e.Row.CssClass = (e.Row.CssClass + " salary-locked").Trim();
                    e.Row.ToolTip = "Salary Already Generated";
                }
                else if (string.Equals(status, "Hold", StringComparison.OrdinalIgnoreCase))
                {
                    e.Row.CssClass = (e.Row.CssClass + " salary-hold").Trim();
                }
            }
        }
        catch (Exception ex)
        {
            // Do not break page rendering on row format issue
        }
    }

    protected void ddlOfficeName_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["Office_ID"] = ddlOfficeName.SelectedValue;
        DivDetail.Visible = false;
    }

    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillMonth();
        DivDetail.Visible = false;
    }
}