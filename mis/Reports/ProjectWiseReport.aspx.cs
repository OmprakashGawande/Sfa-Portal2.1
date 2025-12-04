using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Reports_ProjectWiseReport : System.Web.UI.Page
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
                txtFromDate.Text = currentdate.ToString("dd/MM/yyyy");
                GetProjecName();

                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        else
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }


    public void GetProjecName()
    {
        try
        {
            DataSet ds = objdb.ByProcedure("USP_TaskAllocation", new string[] { "Flag" }, new string[] { "2" }, "dataset");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_Id";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, new ListItem("All", "0"));
            }
            else
            {
                ddlProject.Items.Clear();
                ddlProject.Items.Insert(0, new ListItem("Select", ""));
            }

        }
        catch (Exception ex)
        {
            throw new Exception("Error while binding Type of Project dropdown: " + ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            string FromDate = txtFromDate.Text != "" ? Convert.ToDateTime(txtFromDate.Text, cult).ToString("yyyy/MM/dd") : "";
            string ToDate = txtToDate.Text != "" ? Convert.ToDateTime(txtToDate.Text, cult).ToString("yyyy/MM/dd") : "";

            DataSet ds = objdb.ByProcedure("Usp_ProjectWiseReport",
                new string[] { "ProjectId", "FromDate", "ToDate" },
                new string[] { ddlProject.SelectedValue, FromDate, ToDate },
                "dataset");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dataGrid.DataSource = ds.Tables[0];
                dataGrid.DataBind();
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