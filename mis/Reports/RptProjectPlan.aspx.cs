using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptProjectPlan : System.Web.UI.Page
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
                FillProject();
                string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
                ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/mis/Login.aspx");
        }
    }

    private DataSet USP_TaskAllocation(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_TaskAllocation", columns, values, "ds");
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

    private void FillProject()
    {
        try
        {
            ddlProject.Items.Clear();
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "2" });
            if (IsNullDataSet(ds))
            {
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_Id";
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataBind();
            }
            ddlProject.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    //protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlProject.SelectedValue != "0")
    //    {
    //        LoadProjectDetails(ddlProject.SelectedValue);
    //        BindProjectPlan(ddlProject.SelectedValue);
    //    }
    //    else
    //    {
    //        grdProjectPlan.DataSource = null;
    //        grdProjectPlan.DataBind();
    //    }
    //}

    private DataSet USP_ProjectPlan(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_ProjectPlan", columns, values, "ds");
        return ds;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;

            string projectId = ddlProject.SelectedValue;

            ds = USP_ProjectPlan(
                new string[] { "Flag", "Project_Id" },
                new string[] { "3", projectId }
            );

            if (ds != null && ds.Tables.Count > 1)
            {
                DivButton.Visible = true;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].Rows[0];
                    lblProjectName.Text = dr["ProjectName"].ToString();
                    lblProjectID.Text = dr["ProjectID"].ToString();
                    lblClientName.Text = dr["ClientName"].ToString();
                    lblStartDate.Text = dr["ProjectStartDate"].ToString();
                    lblEndDate.Text = dr["ProjectEndDate"].ToString();
                }

                if (ds.Tables[1].Rows.Count > 0)
                {
                    grdProjectPlan.DataSource = ds.Tables[1];
                    grdProjectPlan.DataBind();
                }
                else
                {
                    grdProjectPlan.DataSource = null;
                    grdProjectPlan.DataBind();
                    lblMsg.Text = objdb.Alert("fa-ban", "alert-warning", "Sorry!", "No Plan Data Found");
                }

                Datatable();
            }
            else
            {
                grdProjectPlan.DataSource = null;
                grdProjectPlan.DataBind();
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
        if (grdProjectPlan.Rows.Count > 0)
        {
            grdProjectPlan.HeaderRow.TableSection = TableRowSection.TableHeader;
            grdProjectPlan.UseAccessibleHeader = true;
        }
    }

}
