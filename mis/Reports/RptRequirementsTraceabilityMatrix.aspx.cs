using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IdentityModel.Protocols.WSTrust;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Reports_RptRequirementsTraceabilityMatrix : System.Web.UI.Page
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
                txtAllocationDate.Text = currentdate.ToString("dd/MM/yyyy");
                GetProjecName(txtAllocationDate.Text);
                txtAllocationDate_TextChanged(sender, e);

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
            //else if (ds3.Tables[1].Rows[0]["Status"].ToString() == "Emp")
            //{
            //    DivAllocationStatus.Visible = false;

            //}
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
    public void GetProjecName(string date)
    {
        try
        {
            string FromDate = date != "" ? Convert.ToDateTime(date, cult).ToString("yyyy/MM/dd") : "";


            string empId = empId = ViewState["Emp_ID"].ToString();
            DataSet ds = objdb.ByProcedure("Usp_GetProject", new string[] { "EmpId", "Date" }, new string[] { empId, FromDate }, "dataset");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataTextField = "ProjectName";
                ddlProject.DataValueField = "ProjectId";
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
    protected void txtAllocationDate_TextChanged(object sender, EventArgs e)
    {
        GetProjecName(txtAllocationDate.Text);
        Datatable();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        string Date = txtAllocationDate.Text != "" ? Convert.ToDateTime(txtAllocationDate.Text, cult).ToString("yyyy-MM-dd") : "";

        DataSet ds = objdb.ByProcedure("Usp_GetRptRequirementsTraceabilityMatrix",
            new string[] { "EmpId", "ProjectId", "Date", "AllocationStatus" },
            new string[] { ddlEmp.SelectedValue, ddlProject.SelectedValue, Date, ddlAllocationStatus.SelectedItem.Text },
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
        // ===== Hide/Show Based on Status =====
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblStatus = (Label)e.Row.FindControl("lblStatus");
            if (lblStatus != null)
            {
                string status = lblStatus.Text;
                hfExcelHeader.Value = status == "Not Allocated"
                    ? "Requirements Not Allocated Report"
                    : "Requirements Allocated Report";

                // Hide columns when Not Allocated
                if (status == "Not Allocated")
                {
                    for (int i = 0; i < e.Row.Cells.Count; i++)
                    {
                        if (i != 0 && i != 5 && i != 10)
                            e.Row.Cells[i].Visible = false;
                    }

                    // Hide headers also for Not Allocated
                    GridView gv = (GridView)sender;
                    if (gv.HeaderRow != null)
                    {
                        for (int i = 0; i < gv.HeaderRow.Cells.Count; i++)
                        {
                            if (i != 0 && i != 5 && i != 10)
                                gv.HeaderRow.Cells[i].Visible = false;
                        }
                    }
                }
                else
                {
                    // Show all columns if allocated
                    GridView gv = (GridView)sender;
                    if (gv.HeaderRow != null)
                    {
                        for (int i = 0; i < gv.HeaderRow.Cells.Count; i++)
                            gv.HeaderRow.Cells[i].Visible = true;
                    }
                }
            }
        }

        // ===== Hide Allocation Time for non-admin users =====
        string userRole = Convert.ToString(Session["Role_ID"]);
        int allocationTimeColumnIndex = 9; // "Allocation Time" column index

        // Hide for header and data rows both
        if ((e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
            && allocationTimeColumnIndex < e.Row.Cells.Count)
        {
            if (string.IsNullOrEmpty(userRole) || userRole != "2")
            {
                e.Row.Cells[allocationTimeColumnIndex].Visible = false;

            }
        }
    }

    protected void dataGrid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        // Show "Allocation Time" only for Role_ID = 2
        string userRole = Convert.ToString(Session["Role_ID"]);

        if (userRole == "2")
        {
            // Get the GridView instance
            GridView gv = (GridView)sender;

            // Make the 9th column (Allocation Time) visible
            gv.Columns[9].Visible = true;  // 👈 yahan 9 index apke "Allocation Time" ka hai (0-based)
        }
    }


}