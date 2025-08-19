using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

public partial class mis_DailyTask_TaskFilling : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
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
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
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

    private void Initials()
    {
        ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

        GetProjects();
        GetTaskStatus();
        GetTaskName();

        txtDate.Enabled = false;
        txtDate.Attributes.Add("readonly", "readonly");
        DateTime dd = DateTime.Now;
        txtDate.Text = (Convert.ToDateTime(dd, cult).ToString("dd/MM/yyyy"));

        string currentPath = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1);
        ((MainMaster)this.Master).GenerateBreadcrumb(currentPath);
    }

    private void GetProjects()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetProjects", new string[] { "Emp_id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]) }, "dataset");
            ddlProject.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlProject.DataSource = ds.Tables[0];
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataValueField = "Project_Id";
                ddlProject.DataBind();
            }
            ddlProject.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    public void GetTaskName()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetTaskName", new string[] { "Emp_id", "Project_Id" }, new string[] { Convert.ToString(ViewState["Emp_ID"]), ddlProject.SelectedValue }, "dataset");
            ddlTaskName.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlTaskName.DataSource = ds.Tables[0];
                ddlTaskName.DataTextField = "TaskName";
                ddlTaskName.DataValueField = "AllocationId";
                ddlTaskName.DataBind();
            }
            ddlTaskName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    public void GetTaskStatus()
    {
        try
        {
            ds = objdb.ByProcedure("Usp_GetTaskStatus", new string[] { }, new string[] { }, "dataset");
            ddlTaskStatus.Items.Clear();
            if (IsNullDataSet(ds))
            {
                ddlTaskStatus.DataSource = ds.Tables[0];
                ddlTaskStatus.DataTextField = "TaskStatus";
                ddlTaskStatus.DataValueField = "TastStatusId";
                ddlTaskStatus.DataBind();
            }
            ddlTaskStatus.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlTaskName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            grvTaskDis.DataSource = null;
            grvTaskDis.DataBind();
            divTaskDis.Visible = false;
            GetTaskStatus();
            txtRemark.Text = string.Empty;
            ds = objdb.ByProcedure("Usp_GetTaskDetail", new string[] { "AllocationId", "Emp_id" }, new string[] { ddlTaskName.SelectedValue, Convert.ToString(ViewState["Emp_ID"]) }, "dataset");

            if (IsNullDataSet(ds))
            {
                grvTaskDis.DataSource = ds.Tables[0];
                grvTaskDis.DataBind();
                divTaskDis.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlProject.SelectedIndex <= 0)
            {
                grvTaskDis.DataSource = null;
                grvTaskDis.DataBind();
                divTaskDis.Visible = false;
            }
            GetTaskName();
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }

    protected void ddlTaskStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            chkFwdToQa.Checked = false;
            if (ddlTaskStatus.SelectedIndex == 1)
            {
                chkFwdToQa.Checked = true;
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
}