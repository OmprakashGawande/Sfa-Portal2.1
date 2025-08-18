using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskAllocation : System.Web.UI.Page
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
                Initials();
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

    private void Clear()
    {
        ddlEmployee.SelectedIndex = 0;
        ddlProject.SelectedIndex = 0;
        txtAllocationDate.Text = string.Empty;
        txtAllocationTime.Text = string.Empty;
        txtTaskName.Text = string.Empty;
        txtTaskDescription.InnerHtml = string.Empty;
        FillGrid();
    }

    private void Initials()
    {
        try
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();
            ViewState["Office_ID"] = Session["Office_ID"].ToString();

            FillEmployee();
            FillProject();
            FillGrid();

            txtAllocationDate.Attributes.Add("readonly", "readonly");
            //fill breadcrumb.
            Session["PageTokan"] = Server.UrlEncode(System.DateTime.Now.ToString());
            string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
            ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    private void FillEmployee()
    {
        try
        {
            ddlEmployee.Items.Clear();
            ds = USP_TaskAllocation(new string[] { "Flag" }, new string[] { "1" });
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

    private void FillGrid()
    {
        try
        {
            gvTaskDetails.DataSource = null;
            gvTaskDetails.DataBind();

            ds = USP_TaskAllocation(new string[] { "Flag", "EmployeeId" }, new string[] { "4", Convert.ToString(ViewState["Emp_ID"]) });
            if (IsNullDataSet(ds))
            {
                gvTaskDetails.DataSource = ds.Tables[0];
                gvTaskDetails.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                lblMsg.Text = string.Empty;
                string ErrorMsg = string.Empty;

                if (ddlEmployee.SelectedValue == "0") { ErrorMsg += "Please Select Employee Name.\\n"; }
                if (ddlProject.SelectedValue == "0") { ErrorMsg += "Please Select Project Name.\\n"; }
                if (txtAllocationDate.Text == "") { ErrorMsg += "Please Select Allocation Date.\\n"; }
                if (txtAllocationTime.Text == "") { ErrorMsg += "Please Select Allocation Time.\\n"; }
                if (txtTaskName.Text == "") { ErrorMsg += "Please Enter Task Name.\\n"; }
                if (txtTaskDescription.InnerText == "") { ErrorMsg += "Please Enter Task Description.\\n"; }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    DateTime allocationDate = Convert.ToDateTime(txtAllocationDate.Text, cult);
                    ds = USP_TaskAllocation(
                        new string[] { "Flag", "EmployeeId", "ProjectId", "AllocationDate", "AllocationTime", "TaskName", "TaskDescription", "CreatedBy", "CreatedByIp" },
                        new string[] { "3", ddlEmployee.SelectedValue, ddlProject.SelectedValue, Convert.ToString(allocationDate), txtAllocationTime.Text, txtTaskName.Text, txtTaskDescription.InnerText, Convert.ToString(ViewState["Emp_ID"]), objdb.GetLocalIPAddress() });

                    if (IsNullDataSet(ds) && Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                    {
                        SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                        Clear();
                    }
                    else
                    {
                        WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void gvTaskDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            string taskAllocationId = e.CommandArgument.ToString();

            if (e.CommandName == "RecordDelete")
            {
                DataSet ds = new DataSet();
                ds = USP_TaskAllocation(new string[] { "Flag", "EmployeeId", "AllocationId" }, new string[] { "5", Convert.ToString(ViewState["Emp_ID"]), taskAllocationId });
                if (IsNullDataSet(ds) && Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                {
                    SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                    Clear();
                }
                else
                {
                    WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }

    }

}