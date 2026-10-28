using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Payroll_PayrollAllEmpEarnDedDetailNew : System.Web.UI.Page
{
    private DataSet ds;
    private AbstApiDBApi objdb = new APIProcedure();

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
                ViewState["Office_ID"] = Session["Office_ID"].ToString();

                ddlOffice.Enabled = ViewState["Office_ID"].ToString() == "1";
                DivHead.Visible = false;

                BindOffice();
                FillDropdown();
                GetSection();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    private void BindOffice()
    {
        ds = objdb.ByProcedure("SpAdminOffice", new string[] { "flag" }, new string[] { "10" }, "dataset");
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            ddlOffice.DataSource = ds;
            ddlOffice.DataTextField = "Office_Name";
            ddlOffice.DataValueField = "Office_ID";
            ddlOffice.DataBind();
            ddlOffice.Items.Insert(0, new ListItem("Select Office", "0"));

            string userOfficeId = ViewState["Office_ID"] != null ? ViewState["Office_ID"].ToString() : "0";
            if (ddlOffice.Items.FindByValue(userOfficeId) != null)
            {
                ddlOffice.SelectedValue = userOfficeId;
            }
        }
    }

    private void GetSection()
    {
        DataSet ds1 = null;
        try
        {
            string officeId = ddlOffice.SelectedValue;
            if ((string.IsNullOrEmpty(officeId) || officeId == "0") && ViewState["Office_ID"] != null)
            {
                officeId = ViewState["Office_ID"].ToString();
            }

            ddlSection.Items.Clear();

            if (!string.IsNullOrEmpty(officeId) && officeId != "0")
            {
                ds1 = objdb.ByProcedure("SpPayrollSalaryFinalSummary",
                    new string[] { "flag", "Office_ID" },
                    new string[] { "4", officeId },
                    "dataset");

                if (ds1 != null && ds1.Tables.Count > 0 && ds1.Tables[0].Rows.Count > 0)
                {
                    ddlSection.DataSource = ds1.Tables[0];
                    ddlSection.DataTextField = "SalarySec_No";
                    ddlSection.DataValueField = "SalarySec_No";
                    ddlSection.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Section Bind!", ex.Message);
        }
        finally
        {
            if (ds1 != null) { ds1.Dispose(); }
        }
    }

    protected void FillDropdown()
    {
        try
        {
            ddlFinancialYear.Items.Clear();
            ds = objdb.ByProcedure("SpHrYear_Master", new string[] { "flag" }, new string[] { "8" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlFinancialYear.DataSource = ds;
                ddlFinancialYear.DataTextField = "Year";
                ddlFinancialYear.DataValueField = "Year";
                ddlFinancialYear.DataBind();
            }
            ddlFinancialYear.Items.Insert(0, new ListItem("Select Year", "0"));

            string currentYear = DateTime.Now.Year.ToString();
            if (ddlFinancialYear.Items.FindByValue(currentYear) != null)
            {
                ddlFinancialYear.SelectedValue = currentYear;
            }

            string currentMonth = DateTime.Now.Month.ToString();
            if (ddlMonth.Items.FindByValue(currentMonth) != null)
            {
                ddlMonth.SelectedValue = currentMonth;
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void ddlOffice_SelectedIndexChanged(object sender, EventArgs e)
    {
        ResetReportDisplay();
        GetSection();
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            ResetReportDisplay();

            bool isOfficeValid = ddlOffice.SelectedIndex > 0 || (ViewState["Office_ID"] != null && ViewState["Office_ID"].ToString() != "0");
            if (isOfficeValid && ddlFinancialYear.SelectedIndex > 0 && ddlMonth.SelectedIndex > 0 && ddlEmp_TypeOfPost.SelectedIndex > 0)
            {
                string officeText = (ddlOffice.SelectedItem != null && ddlOffice.SelectedIndex > 0) ? ddlOffice.SelectedItem.Text : "";
                if (string.IsNullOrEmpty(officeText) && ViewState["Office_ID"] != null)
                {
                    ListItem li = ddlOffice.Items.FindByValue(ViewState["Office_ID"].ToString());
                    if (li != null) officeText = li.Text;
                }
                lblOffice.Text = officeText;
                FillSalary();
            }
            else
            {
                lblMsg.Text = objdb.Alert("fa-warning", "alert-warning", "Warning!", "Please select all mandatory fields.");
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            ResetReportDisplay();
            if (ddlOffice.Enabled)
            {
                ddlOffice.SelectedIndex = 0;
            }
            ddlFinancialYear.SelectedIndex = 0;
            ddlMonth.SelectedIndex = 0;
            ddlEmp_TypeOfPost.SelectedIndex = 0;
            ddlSection.ClearSelection();
            GetSection();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(DivDetail.InnerHtml))
            {
                lblMsg.Text = objdb.Alert("fa-warning", "alert-warning", "Warning!", "Please search and view records before exporting.");
                return;
            }

            Response.Clear();
            string fileName = "Payroll_EarnDed_Details_" + DateTime.Now.ToString("ddMMyyyy_HHmmss") + ".xls";
            Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    DivDetail.RenderControl(hw);
                    Response.Write(sw.ToString());
                    Response.End();
                }
            }
        }
        catch (System.Threading.ThreadAbortException)
        {
            // Expected on Response.End()
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        // Required for exporting controls rendered to HtmlTextWriter
    }

    private void ResetReportDisplay()
    {
        DivDetail.InnerHtml = string.Empty;
        lblMsg.Text = string.Empty;
        lblSession.Text = string.Empty;
        lblPosttype.Text = string.Empty;
        lblOffice.Text = string.Empty;
        DivHead.Visible = false;
    }

    protected void FillSalary()
    {
        try
        {
            string multiSection = GetSelectedSections();
            if (string.IsNullOrEmpty(multiSection))
            {
                lblMsg.Text = objdb.Alert("fa-exclamation-triangle", "alert-warning", "Warning!", "Kindly Select Section");
                return;
            }

            string officeId = ddlOffice.SelectedValue;
            if ((string.IsNullOrEmpty(officeId) || officeId == "0") && ViewState["Office_ID"] != null)
            {
                officeId = ViewState["Office_ID"].ToString();
            }

            string officeName = (ddlOffice.SelectedItem != null && ddlOffice.SelectedIndex > 0) ? ddlOffice.SelectedItem.Text : "";
            if (string.IsNullOrEmpty(officeName) && ddlOffice.Items.FindByValue(officeId) != null)
            {
                officeName = ddlOffice.Items.FindByValue(officeId).Text;
            }

            string salaryYear = ddlFinancialYear.SelectedValue;
            string salaryMonthNo = ddlMonth.SelectedValue;
            string sessionText = ddlMonth.SelectedItem.Text + " " + salaryYear;
            string postType = ddlEmp_TypeOfPost.SelectedValue;

            lblSession.Text = sessionText;
            lblPosttype.Text = postType;
            lblOffice.Text = officeName;
            DivHead.Visible = false;

            ds = objdb.ByProcedure("SpPayrollSalaryDetail",
                new string[] { "flag", "Office_ID", "Salary_Year", "Salary_MonthNo", "Emp_TypeOfPost", "MultiSalarySec_No", "SalaryType" },
                new string[] { "10", officeId, salaryYear, salaryMonthNo, ddlEmp_TypeOfPost.SelectedValue, multiSection, rbnlist.SelectedValue },
                "dataset");

            if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                lblMsg.Text = objdb.Alert("fa-info", "alert-info", "Info!", "No Record Found");
                DivHead.Visible = false;
                return;
            }

            DataTable dtEmployees = ds.Tables[0];
            int empCount = dtEmployees.Rows.Count;

            // Pre-fetch employee salary datasets using flag 2 (same as Salary Slip)
            List<DataSet> empDataList = new List<DataSet>();
            List<string> allEarningHeadsInOrder = new List<string>();
            List<string> deductionHeads = new List<string>();
            Dictionary<string, decimal> earningHeadTotals = new Dictionary<string, decimal>(StringComparer.OrdinalIgnoreCase);

            for (int i = 0; i < empCount; i++)
            {
                string empId = dtEmployees.Rows[i]["Emp_ID"].ToString();
                DataSet dsEmp = objdb.ByProcedure("SpPayrollSalaryDetail",
                    new string[] { "flag", "Emp_ID", "Office_ID", "Year", "MonthNo" },
                    new string[] { "2", empId, officeId, salaryYear, salaryMonthNo },
                    "dataset");

                empDataList.Add(dsEmp);

                if (dsEmp != null && dsEmp.Tables.Count >= 3 && dsEmp.Tables[0].Rows.Count > 0)
                {
                    if (allEarningHeadsInOrder.Count == 0 && dsEmp.Tables.Count > 1)
                    {
                        foreach (DataRow r in dsEmp.Tables[1].Rows)
                        {
                            string hName = r["EarnDeduction_Name"].ToString().Trim();
                            if (!allEarningHeadsInOrder.Contains(hName))
                            {
                                allEarningHeadsInOrder.Add(hName);
                            }
                        }
                    }

                    if (deductionHeads.Count == 0 && dsEmp.Tables.Count > 2)
                    {
                        foreach (DataRow r in dsEmp.Tables[2].Rows)
                        {
                            string headName = r["EarnDeduction_Name"].ToString().Trim();
                            if (!headName.Equals("EMPLOYEES PROVIDENT FUND (EMPLOYER)", StringComparison.OrdinalIgnoreCase)
                                && !headName.Equals("ESI", StringComparison.OrdinalIgnoreCase)
                                && !headName.ToUpper().Contains("ESI"))
                            {
                                deductionHeads.Add(headName);
                            }
                        }
                    }

                    if (dsEmp.Tables.Count > 1)
                    {
                        foreach (DataRow r in dsEmp.Tables[1].Rows)
                        {
                            string hName = r["EarnDeduction_Name"].ToString().Trim();
                            decimal val = ParseDecimal(r["Earning"]);
                            if (!earningHeadTotals.ContainsKey(hName))
                            {
                                earningHeadTotals[hName] = 0m;
                            }
                            earningHeadTotals[hName] += val;
                        }
                    }
                }
            }

            if (allEarningHeadsInOrder.Count == 0 && deductionHeads.Count == 0)
            {
                lblMsg.Text = objdb.Alert("fa-info", "alert-info", "Info!", "No salary records found for the selected criteria.");
                DivHead.Visible = false;
                return;
            }

            // Same logic as Salary Slip: Only show earning heads where total across employees > 0
            List<string> earningHeads = new List<string>();
            foreach (string hName in allEarningHeadsInOrder)
            {
                decimal headTot = 0m;
                earningHeadTotals.TryGetValue(hName, out headTot);
                if (headTot > 0)
                {
                    earningHeads.Add(hName);
                }
            }
            if (earningHeads.Count == 0)
            {
                earningHeads = allEarningHeadsInOrder;
            }

            int earnCount = earningHeads.Count;
            int dedCount = deductionHeads.Count;
            int maxCols = Math.Max(earnCount + 2, Math.Max(dedCount + 1, 7));

            int snoSpan, nameSpan, ifscSpan, actSpan, epfSpan, uanSpan, giSpan;
            CalculateRow1Spans(maxCols, out snoSpan, out nameSpan, out ifscSpan, out actSpan, out epfSpan, out uanSpan, out giSpan);

            decimal totalBasic = 0m;
            decimal[] totalEarnings = new decimal[earnCount];
            decimal totalGrossPay = 0m;
            decimal[] totalDeductions = new decimal[dedCount];
            decimal totalDedAll = 0m;
            decimal totalNetSalary = 0m;

            StringBuilder htmlReport = new StringBuilder();
            htmlReport.Append("<table class='pay-sheet-table' id='SalaryTable'>");

            // 1. Unified Table Header (repeats on ALL pages in print)
            AppendHeaderHtml(htmlReport, officeName, sessionText, postType, earningHeads, deductionHeads, maxCols, snoSpan, nameSpan, ifscSpan, actSpan, epfSpan, uanSpan, giSpan);

            // 2. Employees (each employee is in its own protected tbody that never breaks across pages)
            for (int i = 0; i < empCount; i++)
            {
                DataRow empRow = dtEmployees.Rows[i];
                DataSet dsEmp = empDataList[i];

                if (dsEmp == null || dsEmp.Tables.Count < 3 || dsEmp.Tables[0].Rows.Count == 0)
                {
                    continue;
                }

                AppendEmployeeRowsHtml(htmlReport, i + 1, empRow, dsEmp, earningHeads, deductionHeads, maxCols,
                    snoSpan, nameSpan, ifscSpan, actSpan, epfSpan, uanSpan, giSpan,
                    ref totalBasic, totalEarnings, ref totalGrossPay, totalDeductions, ref totalDedAll, ref totalNetSalary);
            }

            // 3. Table Summary - single tbody at the end of the report
            AppendSummaryRowsHtml(htmlReport, earningHeads, deductionHeads, maxCols,
                totalBasic, totalEarnings, totalGrossPay, totalDeductions, totalDedAll, totalNetSalary);

            htmlReport.Append("</table>");

            DivDetail.InnerHtml = htmlReport.ToString();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    private void CalculateRow1Spans(int maxCols, out int snoSpan, out int nameSpan, out int ifscSpan, out int actSpan, out int epfSpan, out int uanSpan, out int giSpan)
    {
        snoSpan = 1;
        nameSpan = 1;
        ifscSpan = 1;
        actSpan = 1;
        epfSpan = 1;
        uanSpan = 1;
        giSpan = 1;

        int extra = maxCols - 7;
        if (extra > 0)
        {
            nameSpan += 1;
            extra -= 1;
        }
        if (extra > 0)
        {
            actSpan += 1;
            extra -= 1;
        }
        if (extra > 0)
        {
            nameSpan += 1;
            extra -= 1;
        }
        if (extra > 0)
        {
            giSpan += extra;
            extra = 0;
        }
    }

    private string GetSelectedSections()
    {
        List<string> selected = new List<string>();
        foreach (ListItem item in ddlSection.Items)
        {
            if (item.Selected)
            {
                selected.Add(item.Value);
            }
        }

        // Fallback: Check Request.Form in case postback didn't sync item.Selected
        if (selected.Count == 0)
        {
            string formVal = Request.Form[ddlSection.UniqueID];
            if (string.IsNullOrEmpty(formVal))
            {
                formVal = Request.Form["ddlSection"];
            }
            if (!string.IsNullOrEmpty(formVal))
            {
                string[] parts = formVal.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string p in parts)
                {
                    string v = p.Trim();
                    if (!string.IsNullOrEmpty(v) && !selected.Contains(v))
                    {
                        selected.Add(v);
                        ListItem li = ddlSection.Items.FindByValue(v);
                        if (li != null)
                        {
                            li.Selected = true;
                        }
                    }
                }
            }
        }

        return string.Join(",", selected.ToArray());
    }

    private void AppendHeaderHtml(StringBuilder sb, string officeName, string sessionText, string postType,
        List<string> earningHeads, List<string> deductionHeads, int maxCols,
        int snoSpan, int nameSpan, int ifscSpan, int actSpan, int epfSpan, int uanSpan, int giSpan)
    {
        int earnCount = earningHeads.Count;
        int dedCount = deductionHeads.Count;

        sb.Append("<thead>");

        // Row 0: Selected Office Name, Month/Year & Post Type (Repeats on EVERY page in print)
        sb.Append("<tr class='tbl-title-row' style='background: white;'>");
        sb.Append("<th colspan='" + maxCols + "' style='border: none; background: #ffffff !important; padding: 4px 2px 6px 2px; text-align: center;'>");
        sb.Append("<div style='position: relative; width: 100%; text-align: center;'>");
        sb.Append("<div style='font-size: 14px; font-weight: 700; color: #111; letter-spacing: 0.3px;'>" + officeName + "</div>");
        sb.Append("<div style='font-size: 11px; font-weight: 600; color: #222; text-decoration: underline dotted; margin-top: 2px;'>Pay Sheet For the Month of " + sessionText + "</div>");
        sb.Append("</div>");
        sb.Append("</th>");
        sb.Append("</tr>");

        // Row 1: Employee Information Headers
        sb.Append("<tr class='tblheadingslip header-row-info'>");
        sb.Append("<th class='text-left' colspan='" + snoSpan + "'>SNo.</th>");
        sb.Append("<th class='text-left' colspan='" + nameSpan + "'>Name Of Employee</th>");
        sb.Append("<th colspan='" + ifscSpan + "'>IFSC Code</th>");
        sb.Append("<th colspan='" + actSpan + "'>Bank Account No.</th>");
        sb.Append("<th colspan='" + epfSpan + "'>EPF No.</th>");
        sb.Append("<th colspan='" + uanSpan + "'>UAN No.</th>");
        sb.Append("<th colspan='" + giSpan + "'>GI No.</th>");
        sb.Append("</tr>");

        // Row 2: Earnings Headers
        sb.Append("<tr class='tblheadingslip header-row-earn'>");
        sb.Append("<th class='alignright'>Basic Pay</th>");
        for (int e = 0; e < earnCount; e++)
        {
            sb.Append("<th class='alignright'>" + earningHeads[e] + "</th>");
        }
        for (int c = 1 + earnCount; c < maxCols - 1; c++)
        {
            sb.Append("<th></th>");
        }
        sb.Append("<th class='alignright' style='font-weight: bold;'>Total Pay</th>");
        sb.Append("</tr>");

        // Row 3: Deductions Headers
        sb.Append("<tr class='tblheadingslip header-row-ded'>");
        for (int d = 0; d < dedCount; d++)
        {
            sb.Append("<th class='alignright'>" + deductionHeads[d] + "</th>");
        }
        for (int c = dedCount; c < maxCols - 1; c++)
        {
            sb.Append("<th></th>");
        }
        sb.Append("<th class='alignright' style='font-weight: bold;'>Total Ded</th>");
        sb.Append("</tr>");

        sb.Append("</thead>");
    }

    private void AppendEmployeeRowsHtml(StringBuilder sb, int serialNo, DataRow empInfo, DataSet dsEmp,
        List<string> earningHeads, List<string> deductionHeads, int maxCols,
        int snoSpan, int nameSpan, int ifscSpan, int actSpan, int epfSpan, int uanSpan, int giSpan,
        ref decimal totalBasic, decimal[] totalEarnings, ref decimal totalGrossPay,
        decimal[] totalDeductions, ref decimal totalDedAll, ref decimal totalNetSalary)
    {
        int earnCount = earningHeads.Count;
        int dedCount = deductionHeads.Count;

        decimal empBasic = ParseDecimal(dsEmp.Tables[0].Rows[0]["Salary_Basic"]);
        decimal empGross = ParseDecimal(dsEmp.Tables[0].Rows[0]["Salary_EarningTotal"]);
        decimal empTotalDed = ParseDecimal(dsEmp.Tables[0].Rows[0]["Salary_DeductionTotal"]);
        decimal empNet = ParseDecimal(dsEmp.Tables[0].Rows[0]["Salary_NetSalary"]);

        totalBasic += empBasic;
        totalGrossPay += empGross;
        totalDedAll += empTotalDed;
        totalNetSalary += empNet;

        Dictionary<string, decimal> empEarningDict = new Dictionary<string, decimal>(StringComparer.OrdinalIgnoreCase);
        foreach (DataRow row in dsEmp.Tables[1].Rows)
        {
            empEarningDict[row["EarnDeduction_Name"].ToString().Trim()] = ParseDecimal(row["Earning"]);
        }

        Dictionary<string, decimal> empDeductionDict = new Dictionary<string, decimal>(StringComparer.OrdinalIgnoreCase);
        foreach (DataRow row in dsEmp.Tables[2].Rows)
        {
            string headName = row["EarnDeduction_Name"].ToString().Trim();
            if (!headName.Equals("EMPLOYEES PROVIDENT FUND (EMPLOYER)", StringComparison.OrdinalIgnoreCase)
                && !headName.Equals("ESI", StringComparison.OrdinalIgnoreCase)
                && !headName.ToUpper().Contains("ESI"))
            {
                empDeductionDict[headName] = ParseDecimal(row["Earning"]);
            }
        }

        sb.Append("<tbody class='emp-group'>");

        // Row 1: Employee Info
        sb.Append("<tr class='emp-info'>");
        sb.Append("<th class='text-left' colspan='" + snoSpan + "' title='SNo.'>" + serialNo + "</th>");
        sb.Append("<th class='text-left' colspan='" + nameSpan + "' title='Name Of Employee'>" + empInfo["Emp_Name"] + "</th>");
        sb.Append("<th colspan='" + ifscSpan + "' title='IFSC Code'>" + empInfo["Bank_IfscCode"] + "</th>");
        sb.Append("<th colspan='" + actSpan + "' title='Bank Account No.' style='mso-number-format:\"\\@\";'>" + empInfo["Bank_AccountNo"] + "</th>");
        sb.Append("<th colspan='" + epfSpan + "' title='EPF No.'>" + empInfo["EPF_No"] + "</th>");
        sb.Append("<th colspan='" + uanSpan + "' title='UAN No.'>" + empInfo["UAN_No"] + "</th>");
        sb.Append("<th colspan='" + giSpan + "' title='GI No.'>" + empInfo["GroupInsurance_No"] + "</th>");
        sb.Append("</tr>");

        // Row 2: Earnings
        sb.Append("<tr class='emp-earn'>");
        sb.Append("<td class='alignright' title='Basic Pay'>" + empBasic.ToString("0.00") + "</td>");
        for (int e = 0; e < earnCount; e++)
        {
            decimal val = 0m;
            empEarningDict.TryGetValue(earningHeads[e], out val);
            totalEarnings[e] += val;
            string headTitle = HttpUtility.HtmlAttributeEncode(earningHeads[e]);
            string displayVal = (val > 0) ? val.ToString("0.00") : "";
            sb.Append("<td class='alignright' title='" + headTitle + "'>" + displayVal + "</td>");
        }
        for (int c = 1 + earnCount; c < maxCols - 1; c++)
        {
            sb.Append("<td class='alignright'></td>");
        }
        sb.Append("<td class='alignright' style='font-weight: bold;' title='Total Pay'>" + empGross.ToString("0.00") + "</td>");
        sb.Append("</tr>");

        // Row 3: Deductions
        sb.Append("<tr class='emp-ded'>");
        for (int d = 0; d < dedCount; d++)
        {
            decimal val = 0m;
            empDeductionDict.TryGetValue(deductionHeads[d], out val);
            totalDeductions[d] += val;
            string headTitle = HttpUtility.HtmlAttributeEncode(deductionHeads[d]);
            sb.Append("<td class='alignright' title='" + headTitle + "'>" + val.ToString("0.00") + "</td>");
        }
        for (int c = dedCount; c < maxCols - 1; c++)
        {
            sb.Append("<td class='alignright'></td>");
        }
        sb.Append("<td class='alignright' style='font-weight: bold;' title='Total Ded'>" + empTotalDed.ToString("0.00") + "</td>");
        sb.Append("</tr>");

        // Row 4: Net Pay
        sb.Append("<tr class='emp-net'>");
        sb.Append("<td colspan='" + (maxCols - 1) + "' class='alignright' style='text-align: right !important; font-weight: bold;' title='Net Pay'>Net Pay:</td>");
        sb.Append("<td class='alignright' style='font-weight: bold; color: darkblue;' title='Net Pay'>" + empNet.ToString("0.00") + "</td>");
        sb.Append("</tr>");

        sb.Append("</tbody>");
    }

    private void AppendSummaryRowsHtml(StringBuilder sb, List<string> earningHeads, List<string> deductionHeads, int maxCols,
        decimal totalBasic, decimal[] totalEarnings, decimal totalGrossPay,
        decimal[] totalDeductions, decimal totalDedAll, decimal totalNetSalary)
    {
        int earnCount = earningHeads.Count;
        int dedCount = deductionHeads.Count;

        sb.Append("<tbody class='summary-group'>");
        sb.Append("<tr class='summary-spacer' style='height: 10px; border: none;'><td colspan='" + maxCols + "' style='border: none; background: white;'></td></tr>");
        sb.Append("<tr class='summary-title'>");
        sb.Append("<th colspan='" + maxCols + "'>Report Summary</th>");
        sb.Append("</tr>");

        // Summary Row 1: Earning Totals
        sb.Append("<tr class='summary-earn'>");
        sb.Append("<td class='alignright' style='font-weight: bold;' title='Total Basic Pay'>" + totalBasic.ToString("0.00") + "</td>");
        for (int e = 0; e < earnCount; e++)
        {
            string headTitle = HttpUtility.HtmlAttributeEncode("Total " + earningHeads[e]);
            string displayVal = (totalEarnings[e] > 0) ? totalEarnings[e].ToString("0.00") : "";
            sb.Append("<td class='alignright' style='font-weight: bold;' title='" + headTitle + "'>" + displayVal + "</td>");
        }
        for (int c = 1 + earnCount; c < maxCols - 1; c++)
        {
            sb.Append("<td class='alignright'></td>");
        }
        sb.Append("<td class='alignright' style='font-weight: bold; color: green;' title='Total Gross Pay'>" + totalGrossPay.ToString("0.00") + "</td>");
        sb.Append("</tr>");

        // Summary Row 2: Deduction Totals
        sb.Append("<tr class='summary-ded'>");
        for (int d = 0; d < dedCount; d++)
        {
            string headTitle = HttpUtility.HtmlAttributeEncode("Total " + deductionHeads[d]);
            sb.Append("<td class='alignright' style='font-weight: bold;' title='" + headTitle + "'>" + totalDeductions[d].ToString("0.00") + "</td>");
        }
        for (int c = dedCount; c < maxCols - 1; c++)
        {
            sb.Append("<td class='alignright'></td>");
        }
        sb.Append("<td class='alignright' style='font-weight: bold; color: red;' title='Total Deductions'>" + totalDedAll.ToString("0.00") + "</td>");
        sb.Append("</tr>");

        // Summary Row 3: Net Salary Total
        sb.Append("<tr class='summary-net'>");
        sb.Append("<td colspan='" + (maxCols - 1) + "' class='alignright' style='text-align: right !important; font-weight: bold; font-size: 13px;' title='Grand Total Net Pay'>Grand Total Net Pay:</td>");
        sb.Append("<td class='alignright' style='font-weight: bold; font-size: 13px; color: darkblue;' title='Grand Total Net Pay'>" + totalNetSalary.ToString("0.00") + "</td>");
        sb.Append("</tr>");
        sb.Append("</tbody>");
    }

    private decimal ParseDecimal(object val)
    {
        if (val == null || val == DBNull.Value) return 0m;
        decimal res;
        if (decimal.TryParse(val.ToString().Trim(), out res)) return res;
        return 0m;
    }
}
