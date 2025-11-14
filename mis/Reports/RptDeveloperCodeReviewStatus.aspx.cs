using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptDeveloperCodeReviewStatus : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] == null)
        {
            Response.Redirect("~/mis/Login.aspx");
            return;
        }
        if (!IsPostBack)
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
            lblMsg.Text = string.Empty;
            FillEmployee();
            string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
            ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
        }
    }
    private DataSet Usp_DeveloperCodeReviewStatus(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("Usp_DeveloperCodeReviewStatus", columns, values, "ds");
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
    private void FillEmployee()
    {
        try
        {
            ddlEmployee.Items.Clear();

            string empId = ViewState["Emp_ID"].ToString();
            ds = Usp_DeveloperCodeReviewStatus(new string[] { "Flag" }, new string[] { "1" });
            if (IsNullDataSet(ds))
            {
                ddlEmployee.DataTextField = "Employee_Name";
                ddlEmployee.DataValueField = "Employee_Id";
                ddlEmployee.DataSource = ds.Tables[0];
                ddlEmployee.DataBind();
            }
            ddlEmployee.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;

            ds = Usp_DeveloperCodeReviewStatus(new string[] { "Flag", "TechHeadID" }, new string[] { "4" ,ddlEmployee.SelectedValue});

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvDeveloperCodeReviewStatus.DataSource = ds.Tables[0];
                gvDeveloperCodeReviewStatus.DataBind();
                Datatable();

            }
            else
            {
                gvDeveloperCodeReviewStatus.DataSource = null;
                gvDeveloperCodeReviewStatus.DataBind();
                lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Record Found");
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    protected void Datatable()
    {
        if (gvDeveloperCodeReviewStatus.Rows.Count > 0)
        {
            gvDeveloperCodeReviewStatus.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvDeveloperCodeReviewStatus.UseAccessibleHeader = true;
        }
    }
}