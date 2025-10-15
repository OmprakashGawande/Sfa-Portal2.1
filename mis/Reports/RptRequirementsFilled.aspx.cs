using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptRequirementsFilled : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds, ds1;
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
                BindDropdown();
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

    public void BindDropdown()
    {
        try
        {
            string empId = ViewState["Emp_ID"].ToString();
            DataSet ds3 = objdb.ByProcedure("UspGetEmpForReport", new string[] { "EmpId" }, new string[] { empId }, "dataset");
            if (ds3 != null && ds3.Tables[0].Rows.Count > 0)
            {
                ddlEmp.DataSource = ds3.Tables[0];
                ddlEmp.DataTextField = "Emp_Name";
                ddlEmp.DataValueField = "Emp_ID";
                ddlEmp.DataBind();
            }
            if (ds3.Tables[1].Rows[0]["Status"].ToString() == "Admin")
            {
                ddlEmp.Items.Insert(0, new ListItem("All", "0"));

            }
            else
            {
                //ddlEmp.SelectedIndex = 0;


            }

        }
        catch (Exception ex)
        {
            // Optional: log or show error
            throw new Exception("Error while binding Type of Project dropdown: " + ex.Message);
        }
    }
    public void GetProjecName()
    {
        try
        {
            //string FromDate = date != "" ? Convert.ToDateTime(date, cult).ToString("yyyy/MM/dd") : "";


            ///string empId = empId = ViewState["Emp_ID"].ToString();
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

            DataSet ds = objdb.ByProcedure("Usp_GetRptRequirementsFilled",
                new string[] { "EmpId", "ProjectId", "FromDate", "ToDate", "FillStatus" },
                new string[] { ddlEmp.SelectedValue, ddlProject.SelectedValue, FromDate, ToDate, ddlFilledStatus.SelectedValue },
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
    protected void dataGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblFillStatus = (Label)e.Row.FindControl("lblFillStatus");
            if (lblFillStatus != null)
            {
                if (lblFillStatus.Text == "Filled")
                {
                    hfExcelHeader.Value = "Requirements Filled Report";
                }
                else
                {
                    hfExcelHeader.Value = "Requirements Not Filled Report";
                }
            }
        }
    }

}