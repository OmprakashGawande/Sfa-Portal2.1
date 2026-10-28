using System;
using System.Data;
using System.Globalization;
using System.Web;
using System.Web.UI.WebControls;

public partial class mis_Payroll_PayrollEmpSalarySlip : System.Web.UI.Page
{
    DataSet ds;
    AbstApiDBApi objdb = new APIProcedure();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] != null)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Emp_ID"] != null && Request.QueryString["Office_ID"] != null && Request.QueryString["Year"] != null && Request.QueryString["MonthNo"] != null && Request.QueryString["GenStatus"] != null)
                {
                    string Emp_ID = objdb.Decrypt(Request.QueryString["Emp_ID"].ToString());
                    string Office_ID = objdb.Decrypt(Request.QueryString["Office_ID"].ToString());
                    string Year = objdb.Decrypt(Request.QueryString["Year"].ToString());
                    string MonthNo = objdb.Decrypt(Request.QueryString["MonthNo"].ToString());
                    string GenStatus = objdb.Decrypt(Request.QueryString["GenStatus"].ToString());
                    if (GenStatus == "NotGenerated")
                    {
                        lblGenStatus.InnerHtml = "( Not Generated )";
                    }

                    FillOffice(Office_ID);
                    FillDetail(Emp_ID, Office_ID, Year, MonthNo);
                }
                else
                {
                    Response.Redirect("~/mis/Payroll/PayrollEmpSalaryDetails.aspx");
                }
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    protected void FillOffice(string Office_ID)
    {
        try
        {
            DataSet dsOffice = objdb.ByProcedure("SpAdminOffice", new string[] { "flag" }, new string[] { "9" }, "dataset");
            if (dsOffice != null && dsOffice.Tables.Count > 0 && dsOffice.Tables[0].Rows.Count > 0)
            {
                DataRow[] rows = dsOffice.Tables[0].Select("Office_ID = " + Office_ID);
                if (rows.Length > 0)
                {
                    HOfficeName.InnerText = rows[0]["Office_Name"].ToString();
                    return;
                }
            }
            HOfficeName.InnerText = "SFA TECHNOLOGIES PVT. LTD.";
        }
        catch
        {
            HOfficeName.InnerText = "SFA TECHNOLOGIES PVT. LTD.";
        }
    }

    protected void FillDetail(string Emp_ID, string Office_ID, string Year, string MonthNo)
    {
        try
        {
            ds = objdb.ByProcedure("SpPayrollSalaryDetail", new string[] { "flag", "Emp_ID", "Office_ID", "Year", "MonthNo" }, new string[] { "2", Emp_ID, Office_ID, Year, MonthNo }, "dataset");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblEmp_Name.Text = ds.Tables[0].Rows[0]["Emp_Name"].ToString();
                    lblDesignation_Name.Text = ds.Tables[0].Rows[0]["Designation_Name"].ToString();
                    lblUserName.Text = ds.Tables[0].Rows[0]["UserName"].ToString();
                    lblBank_AccountNo.Text = ds.Tables[0].Rows[0]["Bank_AccountNo"].ToString();
                    lblFinancialYear.InnerHtml = ds.Tables[0].Rows[0]["FinancialYear"].ToString();
                    lblMonth.InnerHtml = ds.Tables[0].Rows[0]["Month"].ToString();
                    lblSalary_Basic.Text = ds.Tables[0].Rows[0]["Salary_Basic"].ToString();
                    lblSalary_NoDayDeduAmt.Text = ds.Tables[0].Rows[0]["Salary_NoDayDeduAmt"].ToString();
                    lblSalary_NetSalary.Text = ds.Tables[0].Rows[0]["Salary_NetSalary"].ToString();
                    lblSalary_EarningTotal.Text = ds.Tables[0].Rows[0]["Salary_EarningTotal"].ToString();
                    lblPolicyDeduction.Text = ds.Tables[0].Rows[0]["PolicyDeduction"].ToString();
                    lblSalary_DeductionTotal.Text = ds.Tables[0].Rows[0]["Salary_DeductionTotal"].ToString();
                    lblBank_Name.Text = ds.Tables[0].Rows[0]["Bank_Name"].ToString();
                    lblIFSCCode.Text = ds.Tables[0].Rows[0]["Bank_IfscCode"].ToString();
                    lblGroupInsurance_No.Text = ds.Tables[0].Rows[0]["GroupInsurance_No"].ToString();

                    string epf = ds.Tables[0].Rows[0]["EPF_No"].ToString();
                    string uan = ds.Tables[0].Columns.Contains("UAN_No") ? ds.Tables[0].Rows[0]["UAN_No"].ToString() : "";
                    if (!string.IsNullOrEmpty(uan))
                    {
                        lblEPF_No.Text = epf + " / " + uan;
                    }
                    else
                    {
                        lblEPF_No.Text = epf;
                    }

                    if (ds.Tables[0].Columns.Contains("Department_Name"))
                    {
                        string dept = ds.Tables[0].Rows[0]["Department_Name"].ToString();
                        if (!string.IsNullOrEmpty(dept))
                        {
                            lblDepartment_Name.Text = dept;
                        }
                    }

                    if (ds.Tables[0].Columns.Contains("TotalDayOfMonth"))
                    {
                        TotalDayOfMonth.InnerText = ds.Tables[0].Rows[0]["TotalDayOfMonth"].ToString();
                    }
                    if (ds.Tables[0].Columns.Contains("NotPayableDays"))
                    {
                        NotPayableDays.InnerText = ds.Tables[0].Rows[0]["NotPayableDays"].ToString();
                    }
                    if (ds.Tables[0].Columns.Contains("PayableDays"))
                    {
                        PayableDays.InnerText = ds.Tables[0].Rows[0]["PayableDays"].ToString();
                    }
                    if (ds.Tables[0].Columns.Contains("LeaveDays"))
                    {
                        totlleavedays.InnerText = ds.Tables[0].Rows[0]["LeaveDays"].ToString();
                    }
                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    RepeaterEarning.DataSource = ds.Tables[1];
                    RepeaterEarning.DataBind();
                }
                if (ds.Tables[2].Rows.Count > 0)
                {
                    RepeaterDeduction.DataSource = ds.Tables[2];
                    RepeaterDeduction.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            //lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message.ToString());
        }
    }
}