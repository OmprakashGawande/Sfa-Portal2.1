using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptEmployeeFreeHours : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds;
    CultureInfo cult = new CultureInfo("gu-IN", true);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Emp_ID"] != null)
        {
            if (!IsPostBack)
            {
                ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
                ViewState["Office_ID"] = Session["Office_ID"].ToString();
                ViewState["UserTypeId"] = Session["UserTypeId"].ToString();
                ViewState["Designation_ID"] = Session["Designation_ID"].ToString();
                DateTime currentdate = DateTime.Now;
                string Date = currentdate.ToString("yyyy/MM/dd", cult);
                txtAllocationDate.Text = currentdate.ToString("dd/MM/yyyy");

                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            string Date = txtAllocationDate.Text != "" ? Convert.ToDateTime(txtAllocationDate.Text, cult).ToString("yyyy-MM-dd") : "";

            DataSet ds = objdb.ByProcedure("Usp_RptEmployeeFreeHours",


                new string[] { "Date" },
                new string[] { Date },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dataGrid.DataSource = ds.Tables[0];
                dataGrid.DataBind();
                dataGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
                dataGrid.UseAccessibleHeader = true;
                Datatable();
                Div_Detail.Visible = true;

            }
            else
            {
                dataGrid.DataSource = null;
                dataGrid.DataBind();
                lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Record Found");
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void Datatable()
    {
        if (dataGrid.Rows.Count > 0)
        {
            dataGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
            dataGrid.UseAccessibleHeader = true;
        }


    }
}