using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class mis_HR_HRMyProfile : System.Web.UI.Page
{
    DataSet ds;
    AbstApiDBApi objdb = new APIProcedure();  
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Emp_ID"] != null && Session["Emp_ID"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                    FillPersonalDetail();
                    FillDetail();
                }
            }
            else
            {
                Response.Redirect("~/mis/Login.aspx");
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message.ToString());
        }
    }

    protected void FillDetail()
    {
        try
        {
            ds = null;
            ds = objdb.ByProcedure("Sp_DashboardAllEmployee", new string[] { "flag", "emp_ID" }, new string[] { "0", Session["Emp_ID"].ToString() }, "dataset");

            if (ds != null && ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
            {
                lblSalaryMonth.Text = ds.Tables[4].Rows[0]["Salary_Month"].ToString();
                lblSalaryYear.Text = ds.Tables[4].Rows[0]["Salary_Year"].ToString();
                lblTotalEarnings.Text = string.Format("{0:N2}", Convert.ToDecimal(ds.Tables[4].Rows[0]["Salary_EarningTotal"]));
                lblTotalDeductions.Text = string.Format("{0:N2}", Convert.ToDecimal(ds.Tables[4].Rows[0]["Salary_DeductionTotal"]));
                lblNetSalary.Text = string.Format("{0:N2}", Convert.ToDecimal(ds.Tables[4].Rows[0]["Salary_NetSalary"]));
            }
            else
            {
                lblSalaryMonth.Text = DateTime.Now.ToString("MMMM");
                lblSalaryYear.Text = DateTime.Now.Year.ToString();
                lblTotalEarnings.Text = "0.00";
                lblTotalDeductions.Text = "0.00";
                lblNetSalary.Text = "0.00";
            }
        }
        catch (Exception)
        {
            lblSalaryMonth.Text = DateTime.Now.ToString("MMMM");
            lblSalaryYear.Text = DateTime.Now.Year.ToString();
            lblTotalEarnings.Text = "0.00";
            lblTotalDeductions.Text = "0.00";
            lblNetSalary.Text = "0.00";
        }
    }

    protected void FillPersonalDetail()
    {
        try
        {
            ds = null;
            ds = objdb.ByProcedure("SpHREmployee", new string[] { "flag", "Emp_ID" }, new string[] { "24", ViewState["Emp_ID"].ToString() }, "dataset");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                lblHeroEmpName.Text = dr["Emp_Name"] != DBNull.Value ? dr["Emp_Name"].ToString() : "Employee";
                
                string desig = dr["Designation_Name"] != DBNull.Value ? dr["Designation_Name"].ToString().Trim('(', ')', ' ') : "";
                lblHeroDesignation.Text = string.IsNullOrEmpty(desig) ? "Designation Not Assigned" : desig;
                
                string dept = dr["Department_Name"] != DBNull.Value ? dr["Department_Name"].ToString().Trim('[', ']', ' ') : "";
                lblHeroDepartment.Text = string.IsNullOrEmpty(dept) ? "General Department" : dept;
                
                lblHeroMobile.Text = dr["Emp_MobileNo"] != DBNull.Value && !string.IsNullOrEmpty(dr["Emp_MobileNo"].ToString()) ? dr["Emp_MobileNo"].ToString() : "N/A";
                lblHeroEmail.Text = dr["Emp_Email"] != DBNull.Value && !string.IsNullOrEmpty(dr["Emp_Email"].ToString()) ? dr["Emp_Email"].ToString() : "N/A";
                lblHeroUserName.Text = dr["UserName"] != DBNull.Value ? dr["UserName"].ToString() : "-";
                lblHeroDOB.Text = dr["Emp_Dob"] != DBNull.Value ? dr["Emp_Dob"].ToString() : "N/A";
                lblHeroOffice.Text = dr["OfficeType_Title"] != DBNull.Value && !string.IsNullOrEmpty(dr["OfficeType_Title"].ToString()) ? dr["OfficeType_Title"].ToString() : "Head Office";

                string imgPath = dr["Emp_ProfileImage"] != DBNull.Value ? dr["Emp_ProfileImage"].ToString().Trim() : "";
                if (string.IsNullOrEmpty(imgPath))
                {
                    imgHeroProfile.ImageUrl = (dr["Emp_Gender"] != DBNull.Value && dr["Emp_Gender"].ToString() == "Female") ? "ProfileImg/female.jpg" : "ProfileImg/male.jpg";
                }
                else
                {
                    imgHeroProfile.ImageUrl = imgPath;
                }

                DVPersonalDetail.DataSource = ds.Tables[0];
                DVPersonalDetail.DataBind();

                DVOfficialDetail.DataSource = ds.Tables[0];
                DVOfficialDetail.DataBind();
            }
            else
            {
                DVPersonalDetail.DataSource = null;
                DVPersonalDetail.DataBind();

                DVOfficialDetail.DataSource = null;
                DVOfficialDetail.DataBind();
            }

            if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
            {
                divBankDetail.Visible = true;
                GVBankDetail.DataSource = ds.Tables[1];
                GVBankDetail.DataBind();
            }
            else
            {
                divBankDetail.Visible = false;
                GVBankDetail.DataSource = null;
                GVBankDetail.DataBind();
            }

            if (ds != null && ds.Tables.Count > 2 && ds.Tables[2].Rows.Count > 0)
            {
                divChildDetail.Visible = true;
                GVChildDetail.DataSource = ds.Tables[2];
                GVChildDetail.DataBind();
            }
            else
            {
                divChildDetail.Visible = false;
                GVChildDetail.DataSource = null;
                GVChildDetail.DataBind();
            }

            if (ds != null && ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0)
            {
                divFixedAssetsDetail.Visible = true;
                GVFixedAssetsDetail.DataSource = ds.Tables[3];
                GVFixedAssetsDetail.DataBind();
            }
            else
            {
                divFixedAssetsDetail.Visible = false;
                GVFixedAssetsDetail.DataSource = null;
                GVFixedAssetsDetail.DataBind();
            }

            if (ds != null && ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
            {
                divNomineeDetail.Visible = true;
                GVNomineeDetail.DataSource = ds.Tables[4];
                GVNomineeDetail.DataBind();
            }
            else
            {
                divNomineeDetail.Visible = false;
                GVNomineeDetail.DataSource = null;
                GVNomineeDetail.DataBind();
            }

            if (ds != null && ds.Tables.Count > 5 && ds.Tables[5].Rows.Count > 0)
            {
                divOtherDetail.Visible = true;
                GVOtherDetail.DataSource = ds.Tables[5];
                GVOtherDetail.DataBind();
            }
            else
            {
                divOtherDetail.Visible = false;
                GVOtherDetail.DataSource = null;
                GVOtherDetail.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message.ToString());
        }
    }
}