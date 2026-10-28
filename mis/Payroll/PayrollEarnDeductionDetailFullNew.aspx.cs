using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Payroll_PayrollEarnDeductionDetailFullNew : System.Web.UI.Page
{
    private DataSet ds;
    private readonly AbstApiDBApi objdb = new APIProcedure();
    private readonly CultureInfo cult = new CultureInfo("gu-IN", true);

    public const decimal Max_ESI_Gross = 21000m;
    public const decimal ESIPercentage = 0.75m;

    public const int MaxEPFDeuduction = 3000;
    public const decimal EPFPercentage = 12.0m;

    public const decimal Max_Bonus_Basic = 21000m;
    public const decimal BonusPercentage = 8.33m;
    
    public const decimal Max_Gratuity_Basic = 21000m;
    public const decimal GratuityPercentage = 4.81m;

    public enum EarnDeductionId
    {
        DA = 2,
        EPF = 3,
        LEAVE_AMT = 9,
        BONUS = 10,
        ESI = 17,
        EARNED_LEAVE_REIMBURSEMENT = 18,
        EmployerEPF = 19,
        GRATUITY = 20
    }

    private class MonthMeta
    {
        public int MonthNo { get; set; }
        public string MonthName { get; set; }
        public string ShortName { get; set; }
        public bool IsNextYear { get; set; }

        public MonthMeta(int monthNo, string monthName, string shortName, bool isNextYear)
        {
            MonthNo = monthNo;
            MonthName = monthName;
            ShortName = shortName;
            IsNextYear = isNextYear;
        }
    }

    private class MonthCalculation
    {
        public decimal Basic { get; set; }
        public decimal DA { get; set; }
        public decimal EPF { get; set; }
        public decimal NPF { get; set; }
        public decimal ESI { get; set; }
        public decimal Leave { get; set; }
        public decimal Bonus { get; set; }
        public decimal Gratuity { get; set; }
    }

    // Processing order matching legacy code (Jan..Mar for Year+1, Apr..Dec for Year)
    private readonly MonthMeta[] MonthsInProcessOrder = new MonthMeta[]
    {
        new MonthMeta(1, "January", "Jan", true),
        new MonthMeta(2, "February", "Feb", true),
        new MonthMeta(3, "March", "Mar", true),
        new MonthMeta(4, "April", "Apr", false),
        new MonthMeta(5, "May", "May", false),
        new MonthMeta(6, "June", "Jun", false),
        new MonthMeta(7, "July", "Jul", false),
        new MonthMeta(8, "August", "Aug", false),
        new MonthMeta(9, "September", "Sep", false),
        new MonthMeta(10, "October", "Oct", false),
        new MonthMeta(11, "November", "Nov", false),
        new MonthMeta(12, "December", "Dec", false)
    };

    // Financial Year display order (April to March)
    private readonly MonthMeta[] MonthsInFyOrder = new MonthMeta[]
    {
        new MonthMeta(4, "April", "Apr", false),
        new MonthMeta(5, "May", "May", false),
        new MonthMeta(6, "June", "Jun", false),
        new MonthMeta(7, "July", "Jul", false),
        new MonthMeta(8, "August", "Aug", false),
        new MonthMeta(9, "September", "Sep", false),
        new MonthMeta(10, "October", "Oct", false),
        new MonthMeta(11, "November", "Nov", false),
        new MonthMeta(12, "December", "Dec", false),
        new MonthMeta(1, "January", "Jan", true),
        new MonthMeta(2, "February", "Feb", true),
        new MonthMeta(3, "March", "Mar", true)
    };

    private TextBox GetBasicTextBox(string monthShort)
    {
        switch (monthShort)
        {
            case "Apr": return txtEarTotApr;
            case "May": return txtEarTotMay;
            case "Jun": return txtEarTotJun;
            case "Jul": return txtEarTotJul;
            case "Aug": return txtEarTotAug;
            case "Sep": return txtEarTotSep;
            case "Oct": return txtEarTotOct;
            case "Nov": return txtEarTotNov;
            case "Dec": return txtEarTotDec;
            case "Jan": return txtEarTotJan;
            case "Feb": return txtEarTotFeb;
            case "Mar": return txtEarTotMar;
            default: return null;
        }
    }

    private TextBox GetGrossTextBox(string monthShort)
    {
        switch (monthShort)
        {
            case "Apr": return txtGrossToApr;
            case "May": return txtGrossToMay;
            case "Jun": return txtGrossToJun;
            case "Jul": return txtGrossToJul;
            case "Aug": return txtGrossToAug;
            case "Sep": return txtGrossToSep;
            case "Oct": return txtGrossToOct;
            case "Nov": return txtGrossToNov;
            case "Dec": return txtGrossToDec;
            case "Jan": return txtGrossToJan;
            case "Feb": return txtGrossToFeb;
            case "Mar": return txtGrossToMar;
            default: return null;
        }
    }

    private TextBox GetDedTotTextBox(string monthShort)
    {
        switch (monthShort)
        {
            case "Apr": return txtDedTotApr;
            case "May": return txtDedTotMay;
            case "Jun": return txtDedTotJun;
            case "Jul": return txtDedTotJul;
            case "Aug": return txtDedTotAug;
            case "Sep": return txtDedTotSep;
            case "Oct": return txtDedTotOct;
            case "Nov": return txtDedTotNov;
            case "Dec": return txtDedTotDec;
            case "Jan": return txtDedTotJan;
            case "Feb": return txtDedTotFeb;
            case "Mar": return txtDedTotMar;
            default: return null;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Emp_ID"] != null)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                ViewState["Office_ID"] = Session["Office_ID"].ToString();
                divDetail.Visible = false;
                FillDropdown();
            }
            else
            {
                Response.Redirect("~/mis/Login.aspx");
            }
        }
    }

    protected void FillDropdown()
    {
        try
        {
            ddlOfficeName.Items.Insert(0, new ListItem("Select", "0"));
            ddlYear.Items.Insert(0, new ListItem("Select", "0"));
            ddlEmployee.Items.Insert(0, new ListItem("Select", "0"));

            ds = objdb.ByProcedure("SpHrYear_Master", new string[] { "flag" }, new string[] { "2" }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlYear.DataSource = ds;
                ddlYear.DataTextField = "Financial_Year";
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
            ddlOfficeName.SelectedValue = ViewState["Office_ID"].ToString();

            ds = objdb.ByProcedure("SpHREmployee", new string[] { "flag", "Office_ID" }, new string[] { "40", ddlOfficeName.SelectedValue }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ddlEmployee.DataSource = ds;
                ddlEmployee.DataTextField = "Emp_Name";
                ddlEmployee.DataValueField = "Emp_ID";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, new ListItem("Select", "0"));
            }
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
            if (ddlYear.SelectedIndex <= 0 || ddlEmployee.SelectedIndex <= 0)
            {
                return;
            }

            string year = ddlYear.SelectedValue;
            string year2 = (int.Parse(year) + 1).ToString();
            string employeeId = ddlEmployee.SelectedValue;

            // 1. Calculate earning/deduction values per month
            Dictionary<int, MonthCalculation> monthCalcs = new Dictionary<int, MonthCalculation>();
            for (int i = 1; i <= 12; i++)
            {
                monthCalcs[i] = new MonthCalculation();
            }

            foreach (MonthMeta m in MonthsInProcessOrder)
            {
                string targetYear = m.IsNextYear ? year2 : year;
                DataSet dsNew = objdb.ByProcedure("SpPayrollEarnDeductionDetail_FY",
                    new string[] { "flag", "Year", "Emp_ID", "MonthNo", "MonthName" },
                    new string[] { "2", targetYear, employeeId, m.MonthNo.ToString(), m.MonthName },
                    "dataset");

                if (dsNew != null && dsNew.Tables.Count > 0 && dsNew.Tables[0].Rows.Count > 0)
                {
                    DataRow empRow = dsNew.Tables[0].Rows[0];
                    decimal basic = decimal.Parse(empRow["Salary_Basic"].ToString());
                    decimal emp_GrossSalery = decimal.Parse(empRow["Emp_GrossSalery"].ToString());
                    decimal emp_BasicSalery = decimal.Parse(empRow["Emp_BasicSalery"].ToString());
                    
                    decimal permDaRate = 0;
                    decimal fixedDaRate = 0;
                    if (dsNew.Tables.Count > 1 && dsNew.Tables[1].Rows.Count > 0)
                    {
                        permDaRate = decimal.Parse(dsNew.Tables[1].Rows[0]["Permanent_DARate"].ToString());
                    }
                    if (dsNew.Tables.Count > 2 && dsNew.Tables[2].Rows.Count > 0)
                    {
                        fixedDaRate = decimal.Parse(dsNew.Tables[2].Rows[0]["Fixed_DARate"].ToString());
                    }

                    lblPermanent_DARate.Text = permDaRate.ToString();
                    lblFixed_DARate.Text = fixedDaRate.ToString();

                    string postType = empRow["Emp_TypeOfPost"].ToString();
                    ViewState["Emp_TypeOfPost"] = postType;
                    ViewState["Emp_BasicSalery"] = emp_BasicSalery;
                    decimal da = 0;
                    if (postType == "Permanent" || postType == "Deputation Employee")
                    {
                        da = Math.Round((emp_BasicSalery * permDaRate) / 100);
                    }
                    else if (postType == "Fixed Employee")
                    {
                        da = Math.Round((emp_BasicSalery * fixedDaRate) / 100);
                    }

                    decimal epf = 0;
                    if (postType != "Deputation Employee")
                    {
                        if (emp_BasicSalery >= 25000m)
                        {
                            if (basic >= 25000m)
                            {
                                epf = 3000m;
                            }
                            else
                            {
                                epf = Math.Round((basic * EPFPercentage) / 100);
                            }
                        }
                        else
                        {
                            epf = Math.Round((basic * EPFPercentage) / 100);
                            if (epf > MaxEPFDeuduction)
                            {
                                epf = MaxEPFDeuduction;
                            }
                        }
                    }

                    decimal esi = 0;
                    if ((emp_GrossSalery) <= Max_ESI_Gross)
                    {
                        esi = Math.Round(((emp_GrossSalery) * ESIPercentage) / 100);
                    }

                    decimal bonus = 0;
                    if (emp_BasicSalery <= Max_Bonus_Basic)
                    {
                        bonus = Math.Round((emp_BasicSalery * BonusPercentage) / 100);
                    }

                    decimal gratuity = 0;
                    if (emp_BasicSalery > Max_Gratuity_Basic)
                    {
                        gratuity = Math.Round((emp_BasicSalery * GratuityPercentage) / 100);
                    }

                    decimal leave = 0;
                    if (dsNew.Tables.Count > 4 && dsNew.Tables[4].Rows.Count > 0)
                    {
                        leave = decimal.Parse(dsNew.Tables[4].Rows[0]["LeaveAmount"].ToString());
                    }

                    MonthCalculation calc = monthCalcs[m.MonthNo];
                    calc.Basic = basic;
                    calc.DA = da;
                    calc.EPF = epf;
                    calc.ESI = esi;
                    calc.Bonus = bonus;
                    calc.Gratuity = gratuity;
                    calc.Leave = leave;
                }
            }

            lblMsg.Text = "";
            Clear();

            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView2.DataSource = null;
            GridView2.DataBind();
            divDetail.Visible = false;

            string monthcount = "";
            ViewState["Monthcount"] = "";
            ViewState["EmployeeID"] = employeeId;

            ds = objdb.ByProcedure("SpPayrollEarnDeductionDetail_FY",
                new string[] { "flag", "Year", "Emp_ID" },
                new string[] { "1", year, employeeId },
                "dataset");

            bool isEPFDeduct = false;
            if (ds != null && ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
            {
                isEPFDeduct = Convert.ToBoolean(ds.Tables[4].Rows[0]["IsEPFDeduct"]);
                if (ds.Tables[4].Rows[0]["Emp_BasicSalery"] != DBNull.Value)
                {
                    decimal actualBasicFromProfile = 0m;
                    if (decimal.TryParse(ds.Tables[4].Rows[0]["Emp_BasicSalery"].ToString(), out actualBasicFromProfile))
                    {
                        ViewState["Emp_BasicSalery"] = actualBasicFromProfile;
                    }
                }
            }
            ViewState["IsEPFDeduct"] = isEPFDeduct;

            HashSet<int> disabledMonths = new HashSet<int>();
            if (ds != null && ds.Tables.Count > 2 && ds.Tables[2].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    monthcount += ds.Tables[2].Rows[i]["Salary_MonthNo"].ToString() + ", ";
                }
                ViewState["Monthcount"] = monthcount;

                string[] monthNoTokens = monthcount.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string token in monthNoTokens)
                {
                    int m;
                    if (int.TryParse(token.Trim(), out m))
                    {
                        disabledMonths.Add(m);
                    }
                }
            }

            // 2. Bind and configure GridView1 (Earnings)
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
                divDetail.Visible = true;

                foreach (GridViewRow gr in GridView1.Rows)
                {
                    if (gr.RowType == DataControlRowType.DataRow)
                    {
                        Label lblEarnDeduction_ID = (Label)gr.FindControl("lblEarnDeduction_ID");
                        int id;
                        int.TryParse((lblEarnDeduction_ID != null) ? lblEarnDeduction_ID.Text : "0", out id);
                        EarnDeductionId earnDedId = (EarnDeductionId)id;

                        foreach (MonthMeta m in MonthsInFyOrder)
                        {
                            TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                            if (txt != null)
                            {
                                if (disabledMonths.Contains(m.MonthNo))
                                {
                                    txt.Enabled = false;
                                }

                                if (earnDedId == EarnDeductionId.DA && txt.Enabled)
                                {
                                    txt.Text = monthCalcs[m.MonthNo].DA.ToString();
                                }
                                else if (earnDedId == EarnDeductionId.BONUS && txt.Enabled)
                                {
                                    txt.Text = monthCalcs[m.MonthNo].Bonus.ToString();
                                }
                                else if (earnDedId == EarnDeductionId.GRATUITY && txt.Enabled)
                                {
                                    txt.Text = monthCalcs[m.MonthNo].Gratuity.ToString();
                                }
                            }
                        }
                    }
                }

                // Populate Basic total row textboxes
                foreach (MonthMeta m in MonthsInFyOrder)
                {
                    TextBox txtBasic = GetBasicTextBox(m.ShortName);
                    if (txtBasic != null)
                    {
                        txtBasic.Text = monthCalcs[m.MonthNo].Basic.ToString();
                        txtBasic.Enabled = !disabledMonths.Contains(m.MonthNo);
                    }
                }

                // Calculate Monthly Gross Amount & update EPF and ESI based on monthly Basic and Gross
                string postTypeEmp = ViewState["Emp_TypeOfPost"] != null ? ViewState["Emp_TypeOfPost"].ToString() : "";
                decimal empActualBasic = ViewState["Emp_BasicSalery"] != null ? Convert.ToDecimal(ViewState["Emp_BasicSalery"]) : 0m;
                foreach (MonthMeta m in MonthsInFyOrder)
                {
                    decimal monthGross = 0m;
                    decimal bVal = 0m;
                    TextBox txtBasic = GetBasicTextBox(m.ShortName);
                    if (txtBasic != null && !string.IsNullOrWhiteSpace(txtBasic.Text))
                    {
                        if (decimal.TryParse(txtBasic.Text, out bVal))
                        {
                            monthGross += bVal;
                        }
                    }

                    // Update EPF based on monthly basic from Earning Detail
                    if (postTypeEmp != "Deputation Employee")
                    {
                        decimal epf = 0m;
                        if (empActualBasic >= 25000m)
                        {
                            if (bVal >= 25000m)
                            {
                                epf = 3000m;
                            }
                            else
                            {
                                epf = Math.Round((bVal * EPFPercentage) / 100);
                            }
                        }
                        else
                        {
                            epf = Math.Round((bVal * EPFPercentage) / 100);
                            if (epf > MaxEPFDeuduction)
                            {
                                epf = MaxEPFDeuduction;
                            }
                        }
                        monthCalcs[m.MonthNo].EPF = epf;
                    }

                    foreach (GridViewRow gr in GridView1.Rows)
                    {
                        if (gr.RowType == DataControlRowType.DataRow)
                        {
                            TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                            monthGross += EnsureValidDecimal(txt);
                        }
                    }

                    TextBox txtGross = GetGrossTextBox(m.ShortName);
                    if (txtGross != null)
                    {
                        txtGross.Text = monthGross.ToString();
                    }

                    decimal esi = 0m;
                    if (monthGross <= Max_ESI_Gross)
                    {
                        esi = Math.Round((monthGross * ESIPercentage) / 100);
                    }
                    monthCalcs[m.MonthNo].ESI = esi;
                }
            }

            // 3. Bind and configure GridView2 (Deductions)
            if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
            {
                DataTable dtDeductions = ds.Tables[1].Clone();
                foreach (DataRow row in ds.Tables[1].Rows)
                {
                    string idStr = row["EarnDeduction_ID"] != null ? row["EarnDeduction_ID"].ToString().Trim() : "";
                    string nameStr = row["EarnDeduction_Name"] != null ? row["EarnDeduction_Name"].ToString().Trim().ToUpper() : "";

                    // Exclude EMPLOYEES PROVIDENT FUND (EMPLOYER)
                    if (idStr == "19" || nameStr.Contains("EMPLOYER"))
                    {
                        continue;
                    }
                    dtDeductions.ImportRow(row);
                }

                GridView2.DataSource = dtDeductions;
                GridView2.DataBind();

                foreach (GridViewRow gr in GridView2.Rows)
                {
                    if (gr.RowType == DataControlRowType.DataRow)
                    {
                        Label lblEarnDeduction_ID = (Label)gr.FindControl("lblEarnDeduction_ID");
                        int id;
                        int.TryParse((lblEarnDeduction_ID != null) ? lblEarnDeduction_ID.Text : "0", out id);
                        EarnDeductionId earnDedId = (EarnDeductionId)id;

                        foreach (MonthMeta m in MonthsInFyOrder)
                        {
                            TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                            if (txt != null)
                            {
                                if (disabledMonths.Contains(m.MonthNo))
                                {
                                    txt.Enabled = false;
                                }

                                if (earnDedId == EarnDeductionId.EPF)
                                {
                                    if (txt.Enabled)
                                    {
                                        txt.Text = isEPFDeduct ? monthCalcs[m.MonthNo].EPF.ToString() : "0";
                                    }
                                }
                                else if (earnDedId == EarnDeductionId.ESI)
                                {
                                    if (txt.Enabled) txt.Text = monthCalcs[m.MonthNo].ESI.ToString();
                                }
                                else if (earnDedId == EarnDeductionId.BONUS)
                                {
                                    if (txt.Enabled) txt.Text = monthCalcs[m.MonthNo].Bonus.ToString();
                                }
                                else if (earnDedId == EarnDeductionId.GRATUITY)
                                {
                                    if (txt.Enabled) txt.Text = monthCalcs[m.MonthNo].Gratuity.ToString();
                                }
                                else if (earnDedId == EarnDeductionId.LEAVE_AMT)
                                {
                                    txt.Text = monthCalcs[m.MonthNo].Leave.ToString();
                                }
                            }
                        }

                        if (earnDedId == EarnDeductionId.EARNED_LEAVE_REIMBURSEMENT)
                        {
                            TextBox aprTxt = (TextBox)gr.FindControl("txtApr_Amount");
                            if (aprTxt != null && aprTxt.Enabled)
                            {
                                if (ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0 && ds.Tables[4].Rows[0]["Emp_BasicSalery"] != DBNull.Value)
                                {
                                    double basicSalDbl;
                                    if (double.TryParse(ds.Tables[4].Rows[0]["Emp_BasicSalery"].ToString(), out basicSalDbl))
                                    {
                                        aprTxt.Text = (((long)basicSalDbl) / 30).ToString();
                                    }
                                }
                            }
                        }
                    }
                }

                // GridView2 FooterRow
                if (GridView2.FooterRow != null)
                {
                    Label lblRowNumber = (Label)GridView2.FooterRow.FindControl("lblRowNumber");
                    if (lblRowNumber != null)
                    {
                        lblRowNumber.Text = (dtDeductions.Rows.Count + 1).ToString();
                    }

                    bool hasTable3 = (ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0);
                    foreach (MonthMeta m in MonthsInFyOrder)
                    {
                        TextBox fTxt = (TextBox)GridView2.FooterRow.FindControl("txt" + m.ShortName + "_Amount");
                        if (fTxt != null)
                        {
                            string colName = m.ShortName + "_Amount";
                            fTxt.Text = (hasTable3 && ds.Tables[3].Columns.Contains(colName) && ds.Tables[3].Rows[0][colName] != DBNull.Value)
                                ? ds.Tables[3].Rows[0][colName].ToString()
                                : "0";
                        }
                    }
                }

                // Employee account and insurance info
                if (ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
                {
                    DataRow drEmp = ds.Tables[4].Rows[0];
                    lblBank_AccountNo.Text = drEmp["Bank_AccountNo"].ToString();
                    lblSalary_NetSalary.Text = drEmp["Emp_BasicSalery"].ToString();
                    lblBank_Name.Text = drEmp["Bank_Name"].ToString();
                    lblIFSCCode.Text = drEmp["Bank_IfscCode"].ToString();
                    lblGroupInsurance_No.Text = drEmp["GroupInsurance_No"].ToString();
                    lblEPF_No.Text = drEmp["EPF_No"].ToString();
                }
            }

            FillGridTotal();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void FillGridTotal()
    {
        try
        {
            // 1. Earning Detail Total
            Dictionary<string, decimal> earnTotals = new Dictionary<string, decimal>();
            foreach (MonthMeta m in MonthsInFyOrder)
            {
                earnTotals[m.ShortName] = 0m;
            }

            foreach (GridViewRow gr in GridView1.Rows)
            {
                if (gr.RowType != DataControlRowType.DataRow) continue;

                foreach (MonthMeta m in MonthsInFyOrder)
                {
                    TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                    earnTotals[m.ShortName] += EnsureValidDecimal(txt);
                }
            }

            foreach (MonthMeta m in MonthsInFyOrder)
            {
                TextBox txtBasic = GetBasicTextBox(m.ShortName);
                decimal basicVal = 0m;
                if (txtBasic != null && !string.IsNullOrWhiteSpace(txtBasic.Text))
                {
                    decimal.TryParse(txtBasic.Text, out basicVal);
                }
                earnTotals[m.ShortName] += basicVal;

                TextBox txtGross = GetGrossTextBox(m.ShortName);
                if (txtGross != null)
                {
                    txtGross.Text = earnTotals[m.ShortName].ToString();
                }
            }

            bool isEPFDeductGrid = ViewState["IsEPFDeduct"] != null ? (bool)ViewState["IsEPFDeduct"] : true;
            string postTypeGrid = ViewState["Emp_TypeOfPost"] != null ? ViewState["Emp_TypeOfPost"].ToString() : "";
            decimal empActualBasicGrid = ViewState["Emp_BasicSalery"] != null ? Convert.ToDecimal(ViewState["Emp_BasicSalery"]) : 0m;

            // Recalculate EPF & ESI in GridView2 for enabled months based on monthly Basic & Gross Amount
            foreach (GridViewRow gr in GridView2.Rows)
            {
                if (gr.RowType != DataControlRowType.DataRow) continue;

                Label lblEarnDeduction_ID = (Label)gr.FindControl("lblEarnDeduction_ID");
                int id;
                int.TryParse((lblEarnDeduction_ID != null) ? lblEarnDeduction_ID.Text : "0", out id);
                EarnDeductionId earnDedId = (EarnDeductionId)id;

                if (earnDedId == EarnDeductionId.EPF)
                {
                    foreach (MonthMeta m in MonthsInFyOrder)
                    {
                        TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                        if (txt != null && txt.Enabled)
                        {
                            if (!isEPFDeductGrid || postTypeGrid == "Deputation Employee")
                            {
                                txt.Text = "0";
                            }
                            else
                            {
                                TextBox txtBasic = GetBasicTextBox(m.ShortName);
                                decimal bVal = 0m;
                                if (txtBasic != null)
                                {
                                    decimal.TryParse(txtBasic.Text, out bVal);
                                }
                                decimal epf = 0m;
                                if (empActualBasicGrid >= 25000m)
                                {
                                    if (bVal >= 25000m)
                                    {
                                        epf = 3000m;
                                    }
                                    else
                                    {
                                        epf = Math.Round((bVal * EPFPercentage) / 100);
                                    }
                                }
                                else
                                {
                                    epf = Math.Round((bVal * EPFPercentage) / 100);
                                    if (epf > MaxEPFDeuduction)
                                    {
                                        epf = MaxEPFDeuduction;
                                    }
                                }
                                txt.Text = epf.ToString();
                            }
                        }
                    }
                }
                else if (earnDedId == EarnDeductionId.ESI)
                {
                    foreach (MonthMeta m in MonthsInFyOrder)
                    {
                        TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                        if (txt != null && txt.Enabled)
                        {
                            decimal gross = earnTotals[m.ShortName];
                            decimal esi = 0m;
                            if (gross <= Max_ESI_Gross)
                            {
                                esi = Math.Round((gross * ESIPercentage) / 100);
                            }
                            txt.Text = esi.ToString();
                        }
                    }
                }
            }

            // 2. Deduction Detail Total
            Dictionary<string, decimal> dedTotals = new Dictionary<string, decimal>();
            foreach (MonthMeta m in MonthsInFyOrder)
            {
                dedTotals[m.ShortName] = 0m;
            }

            foreach (GridViewRow gr in GridView2.Rows)
            {
                if (gr.RowType != DataControlRowType.DataRow) continue;

                foreach (MonthMeta m in MonthsInFyOrder)
                {
                    TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                    dedTotals[m.ShortName] += EnsureValidDecimal(txt);
                }
            }

            if (GridView2.Rows.Count > 0 && GridView2.FooterRow != null)
            {
                foreach (MonthMeta m in MonthsInFyOrder)
                {
                    TextBox fTxt = (TextBox)GridView2.FooterRow.FindControl("txt" + m.ShortName + "_Amount");
                    dedTotals[m.ShortName] += EnsureValidDecimal(fTxt);

                    TextBox txtDedTot = GetDedTotTextBox(m.ShortName);
                    if (txtDedTot != null)
                    {
                        txtDedTot.Text = dedTotals[m.ShortName].ToString();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    private decimal EnsureValidDecimal(TextBox txt)
    {
        if (txt == null) return 0m;

        decimal val;
        if (string.IsNullOrWhiteSpace(txt.Text) || !objdb.isDecimal(txt.Text))
        {
            txt.Text = "0.00";
            return 0m;
        }

        if (decimal.TryParse(txt.Text, out val))
        {
            return val;
        }

        txt.Text = "0.00";
        return 0m;
    }

    protected void Clear()
    {
        lblBank_AccountNo.Text = "";
        lblSalary_NetSalary.Text = "";
        lblBank_Name.Text = "";
        lblIFSCCode.Text = "";
        lblGroupInsurance_No.Text = "";
        lblEPF_No.Text = "";

        foreach (MonthMeta m in MonthsInFyOrder)
        {
            TextBox txtEar = GetBasicTextBox(m.ShortName);
            if (txtEar != null) txtEar.Text = "";

            TextBox txtGross = GetGrossTextBox(m.ShortName);
            if (txtGross != null) txtGross.Text = "";

            TextBox txtDed = GetDedTotTextBox(m.ShortName);
            if (txtDed != null) txtDed.Text = "";
        }
    }

    protected void MonthWiseReport(string MonthNo)
    {
        try
        {
            GridView3.DataSource = null;
            GridView3.DataBind();
            if (ddlYear.SelectedIndex > 0 && ddlOfficeName.SelectedIndex > 0 && ddlEmployee.SelectedIndex > 0)
            {
                ds = objdb.ByProcedure("SpPayrollPolicyMonthWsDetail",
                    new string[] { "flag", "Emp_ID", "Year", "MonthNo" },
                    new string[] { "0", ddlEmployee.SelectedValue, ddlYear.SelectedValue, MonthNo },
                    "dataset");

                if (ds != null && ds.Tables.Count > 0)
                {
                    GridView3.DataSource = ds;
                    GridView3.DataBind();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "MonthDetail();", true);
                }
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
            if (ddlYear.SelectedIndex > 0 && ddlOfficeName.SelectedIndex > 0 && ddlEmployee.SelectedIndex > 0)
            {
                FillGrid();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void btnMonth_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        if (btn != null)
        {
            string monthNo = btn.CommandArgument;
            if (string.IsNullOrEmpty(monthNo))
            {
                if (btn.ID.Contains("Apr")) monthNo = "4";
                else if (btn.ID.Contains("May")) monthNo = "5";
                else if (btn.ID.Contains("Jun")) monthNo = "6";
                else if (btn.ID.Contains("Jul")) monthNo = "7";
                else if (btn.ID.Contains("Aug")) monthNo = "8";
                else if (btn.ID.Contains("Sep")) monthNo = "9";
                else if (btn.ID.Contains("Oct")) monthNo = "10";
                else if (btn.ID.Contains("Nov")) monthNo = "11";
                else if (btn.ID.Contains("Dec")) monthNo = "12";
                else if (btn.ID.Contains("Jan")) monthNo = "1";
                else if (btn.ID.Contains("Feb")) monthNo = "2";
                else if (btn.ID.Contains("Mar")) monthNo = "3";
            }
            if (!string.IsNullOrEmpty(monthNo))
            {
                MonthWiseReport(monthNo);
            }
        }
    }

    protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            divDetail.Visible = false;
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
            if (ddlEmployee.SelectedIndex == 0)
            {
                msg += "Select Employee. \\n";
            }
            if (ddlYear.SelectedIndex == 0)
            {
                msg += "Select Year. \\n";
            }

            if (msg.Trim() != "")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "alert('" + msg + "');", true);
                return;
            }

            string year = ddlYear.SelectedValue;
            string year2 = (int.Parse(year) + 1).ToString();
            string employee = ddlEmployee.SelectedValue;
            string updatedBy = ViewState["Emp_ID"].ToString();

            SaveGridRows(GridView1, "Earning", year, year2, employee, updatedBy);
            SaveGridRows(GridView2, "Deduction", year, year2, employee, updatedBy);
            SavePolicyDetail();

            lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Thank You!", "Operation Successfully Completed");
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    private void SaveGridRows(GridView gridView, string earnDeductionType, string year, string year2, string employee, string updatedBy)
    {
        foreach (GridViewRow gr in gridView.Rows)
        {
            if (gr.RowType != DataControlRowType.DataRow) continue;

            Label lblEarnDeduction_ID = (Label)gr.FindControl("lblEarnDeduction_ID");
            Label lblCalculation_Type = (Label)gr.FindControl("lblCalculation_Type");
            string earnDedId = (lblEarnDeduction_ID != null) ? lblEarnDeduction_ID.Text : "";
            string calcType = (lblCalculation_Type != null) ? lblCalculation_Type.Text : "";

            foreach (MonthMeta m in MonthsInFyOrder)
            {
                TextBox txt = (TextBox)gr.FindControl("txt" + m.ShortName + "_Amount");
                EnsureValidDecimal(txt);
            }

            TextBox aprTxt = (TextBox)gr.FindControl("txtApr_Amount");
            TextBox mayTxt = (TextBox)gr.FindControl("txtMay_Amount");
            TextBox junTxt = (TextBox)gr.FindControl("txtJun_Amount");
            TextBox julTxt = (TextBox)gr.FindControl("txtJul_Amount");
            TextBox augTxt = (TextBox)gr.FindControl("txtAug_Amount");
            TextBox sepTxt = (TextBox)gr.FindControl("txtSep_Amount");
            TextBox octTxt = (TextBox)gr.FindControl("txtOct_Amount");
            TextBox novTxt = (TextBox)gr.FindControl("txtNov_Amount");
            TextBox decTxt = (TextBox)gr.FindControl("txtDec_Amount");
            TextBox janTxt = (TextBox)gr.FindControl("txtJan_Amount");
            TextBox febTxt = (TextBox)gr.FindControl("txtFeb_Amount");
            TextBox marTxt = (TextBox)gr.FindControl("txtMar_Amount");

            // Flag 0: Apr to Dec for current Year
            objdb.ByProcedure("SpPayrollEarnDeductionDetail_FY",
                new string[] { "flag", "Emp_ID", "Year", "EarnDeduction_ID", "EarnDeduction_Type", "Calculation_Type", "Apr_Amount", "May_Amount", "Jun_Amount", "Jul_Amount", "Aug_Amount", "Sep_Amount", "Oct_Amount", "Nov_Amount", "Dec_Amount", "UpdatedBy" },
                new string[] { "0", employee, year, earnDedId, earnDeductionType, calcType, aprTxt.Text, mayTxt.Text, junTxt.Text, julTxt.Text, augTxt.Text, sepTxt.Text, octTxt.Text, novTxt.Text, decTxt.Text, updatedBy },
                "dataset");

            // Flag 3: Jan to Mar for next Year (Year_2)
            objdb.ByProcedure("SpPayrollEarnDeductionDetail_FY",
                new string[] { "flag", "Emp_ID", "Year", "EarnDeduction_ID", "EarnDeduction_Type", "Calculation_Type", "Jan_Amount", "Feb_Amount", "Mar_Amount", "UpdatedBy" },
                new string[] { "3", employee, year2, earnDedId, earnDeductionType, calcType, janTxt.Text, febTxt.Text, marTxt.Text, updatedBy },
                "dataset");
        }
    }

    protected void SavePolicyDetail()
    {
        try
        {
            string year = ddlYear.SelectedValue;
            string year2 = (int.Parse(year) + 1).ToString();
            string employee = ddlEmployee.SelectedValue;

            HashSet<int> processedMonths = new HashSet<int>();
            if (ViewState["Monthcount"] != null)
            {
                string[] tokens = ViewState["Monthcount"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string token in tokens)
                {
                    int m;
                    if (int.TryParse(token.Trim(), out m))
                    {
                        processedMonths.Add(m);
                    }
                }
            }

            for (int j = 1; j <= 12; j++)
            {
                if (!processedMonths.Contains(j))
                {
                    string yearFy = (j < 4) ? year2 : year;
                    objdb.ByProcedure("SpPayrollPolicyDeduction",
                        new string[] { "flag", "Emp_ID", "Office_ID", "Salary_Year", "PolicyDed_UpdatedBy" },
                        new string[] { j.ToString(), employee, ViewState["Office_ID"].ToString(), yearFy, ViewState["Emp_ID"].ToString() },
                        "dataset");
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message);
        }
    }

    protected void ddlOfficeName_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["Office_ID"] = ddlOfficeName.SelectedItem.Value;
        divDetail.Visible = false;
        FillDropdown();
        FillGrid();
    }
}