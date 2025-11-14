using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_Transaction_DeveloperCodeReviewStatus : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();
    private static string DeveloperCodeReviewStatusID = string.Empty;
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
            FillDeveloperName();
            FillGridDetails();
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
    private void FillDeveloperName()
    {
        try
        {
            ddlDeveloperName.Items.Clear();

            string empId = ViewState["Emp_ID"].ToString();
            ds = Usp_DeveloperCodeReviewStatus(new string[] { "Flag" }, new string[] { "6" });
            if (IsNullDataSet(ds))
            {
                ddlDeveloperName.DataTextField = "Employee_Name";
                ddlDeveloperName.DataValueField = "Employee_Id";
                ddlDeveloperName.DataSource = ds.Tables[0];
                ddlDeveloperName.DataBind();
            }
            ddlDeveloperName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    protected void Clear()
    {
        ddlEmployee.ClearSelection();
        ddlDeveloperName.ClearSelection();
        txtCodeQuality.Text = string.Empty;
        txtCodeReviewByTechHead.Text = string.Empty;
        ddlWeeklyReviewWithRitesh.ClearSelection();
        ddlWorkonTime.ClearSelection();
        txtBugfixing.Text = string.Empty;
        txtCoordinationwithQA.Text = string.Empty;
        ddlPunctuality.ClearSelection();
        ddlLeaveManagement.ClearSelection();
        txtReactTraining.Text = string.Empty;
        ddlWorkDeviationfromAssignedorPortal.Text = string.Empty;
        txtBehaviour.Text = string.Empty;
        txtPortalTaskFilled.Text = string.Empty;
        btnSave.Text = "Save";
    }
    private void FillGridDetails()
    {

        try
        {
            gvDeveloperCodeReviewStatus.DataSource = null;
            gvDeveloperCodeReviewStatus.DataBind();

            ds = Usp_DeveloperCodeReviewStatus(new string[] { "Flag" }, new string[] { "3" });
            if (IsNullDataSet(ds))
            {
                gvDeveloperCodeReviewStatus.DataSource = ds.Tables[0];
                gvDeveloperCodeReviewStatus.DataBind();
                Datatable();
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                lblMsg.Text = string.Empty;
                string ErrorMsg = string.Empty;


                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {

                    string flag = string.Empty;
                    string CreatedBy = string.Empty;
                    string CreatedByIp = string.Empty;
                    string UpdatedBy = string.Empty;
                    string UpdatedByIp = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        DeveloperCodeReviewStatusID = string.Empty;
                        flag = "2";
                        CreatedBy = Convert.ToString(ViewState["Emp_ID"]);
                        CreatedByIp = objdb.GetLocalIPAddress();
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "5";
                        UpdatedBy = Convert.ToString(ViewState["Emp_ID"]);
                        UpdatedByIp = objdb.GetLocalIPAddress();
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg("Something went wrong, Please try after sometime.");
                        return;
                    }
                    ds = Usp_DeveloperCodeReviewStatus(
                          new string[]
                          {
                              "Flag",
                              "DeveloperCodeReviewStatusID",
                              "TechHeadID",
                              "DeveloperNameID",
                              "CodeQuality",
                              "CodeReviewbyTechHeads",
                              "WeeklyReviewwithRiteshSir",
                              "WorkonTimeID",
                              "Bugfixing",
                              "CoordinationwithQA",
                              "PunctualityID",
                              "LeaveManagementID",
                              "ReactTraining",
                              "WorkDeviationfromAssignedorPortalID",
                              "Behaviour",
                              "PortalTaskFilled",
                              "CreatedBy",
                              "CreatedByIp",
                              "UpdatedBy",
                              "UpdatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              DeveloperCodeReviewStatusID,
                              ddlEmployee.SelectedValue,
                              ddlDeveloperName.SelectedValue,
                              txtCodeQuality.Text.Trim(),
                              txtCodeReviewByTechHead.Text.Trim(),
                              ddlWeeklyReviewWithRitesh.SelectedValue,
                              ddlWorkonTime.SelectedValue,
                              txtBugfixing.Text.Trim(),
                              txtCoordinationwithQA.Text.Trim(),
                              ddlPunctuality.SelectedValue,
                              ddlLeaveManagement.SelectedValue,
                              txtReactTraining.Text.Trim(),
                              ddlWorkDeviationfromAssignedorPortal.SelectedValue,
                              txtBehaviour.Text.Trim(),
                              txtPortalTaskFilled.Text.Trim(),
                              CreatedBy,
                              CreatedByIp,
                              UpdatedBy,
                              UpdatedByIp
                          });

                    if (IsNullDataSet(ds))
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["Stat"]).Equals("Ok"))
                        {
                            SuccessMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                            FillGridDetails();
                            Clear();
                        }
                        else
                        {
                            WarningMsg(Convert.ToString(ds.Tables[0].Rows[0]["Msg"]));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    protected void gvDeveloperCodeReviewStatus_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            lblMsg.Text = string.Empty;
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            DeveloperCodeReviewStatusID = e.CommandArgument.ToString();


            if (e.CommandName == "RecordEdit")
            {
                Label lblTechHeadID = (Label)row.FindControl("lblTechHeadID");
                Label lblCodeQuality = (Label)row.FindControl("lblCodeQuality");
                Label lblDeveloperNameID = (Label)row.FindControl("lblDeveloperNameID");
                Label lblCodeReviewbyTechHeads = (Label)row.FindControl("lblCodeReviewbyTechHeads");
                Label lblWeeklyReviewwithRiteshSirID = (Label)row.FindControl("lblWeeklyReviewwithRiteshSirID");
                Label lblWorkonTimeID = (Label)row.FindControl("lblWorkonTimeID");
                Label lblBugfixing = (Label)row.FindControl("lblBugfixing");
                Label lblCoordinationwithQA = (Label)row.FindControl("lblCoordinationwithQA");
                Label lblPunctualityID = (Label)row.FindControl("lblPunctualityID");
                Label lblLeaveManagementID = (Label)row.FindControl("lblLeaveManagementID");
                Label lblReactTraining = (Label)row.FindControl("lblReactTraining");
                Label lblWorkDeviationfromAssignedorPortalID = (Label)row.FindControl("lblWorkDeviationfromAssignedorPortalID");
                Label lblBehaviour = (Label)row.FindControl("lblBehaviour");
                Label lblPortalTaskFilled = (Label)row.FindControl("lblPortalTaskFilled");

                if (lblTechHeadID != null && ddlEmployee.Items.FindByValue(lblTechHeadID.Text) != null)
                {
                    ddlEmployee.ClearSelection();
                    ddlEmployee.Items.FindByValue(lblTechHeadID.Text).Selected = true;
                }
                if (lblDeveloperNameID != null && ddlDeveloperName.Items.FindByValue(lblDeveloperNameID.Text) != null)
                {
                    ddlDeveloperName.ClearSelection();
                    ddlDeveloperName.Items.FindByValue(lblDeveloperNameID.Text).Selected = true;
                }
                if (lblWeeklyReviewwithRiteshSirID != null && ddlWeeklyReviewWithRitesh.Items.FindByValue(lblWeeklyReviewwithRiteshSirID.Text) != null)
                {
                    ddlWeeklyReviewWithRitesh.ClearSelection();
                    ddlWeeklyReviewWithRitesh.Items.FindByValue(lblWeeklyReviewwithRiteshSirID.Text).Selected = true;
                }
                if (lblWorkonTimeID != null && ddlWorkonTime.Items.FindByValue(lblWorkonTimeID.Text) != null)
                {
                    ddlWorkonTime.ClearSelection();
                    ddlWorkonTime.Items.FindByValue(lblWorkonTimeID.Text).Selected = true;
                }
                if (lblPunctualityID != null && ddlPunctuality.Items.FindByValue(lblPunctualityID.Text) != null)
                {
                    ddlPunctuality.ClearSelection();
                    ddlPunctuality.Items.FindByValue(lblPunctualityID.Text).Selected = true;
                }
                if (lblLeaveManagementID != null && ddlLeaveManagement.Items.FindByValue(lblLeaveManagementID.Text) != null)
                {
                    ddlLeaveManagement.ClearSelection();
                    ddlLeaveManagement.Items.FindByValue(lblLeaveManagementID.Text).Selected = true;
                }
                if (lblWorkDeviationfromAssignedorPortalID != null && ddlWorkDeviationfromAssignedorPortal.Items.FindByValue(lblWorkDeviationfromAssignedorPortalID.Text) != null)
                {
                    ddlWorkDeviationfromAssignedorPortal.ClearSelection();
                    ddlWorkDeviationfromAssignedorPortal.Items.FindByValue(lblWorkDeviationfromAssignedorPortalID.Text).Selected = true;
                }
                if (lblCodeQuality != null)
                    txtCodeQuality.Text = lblCodeQuality.Text;

                if (lblCodeReviewbyTechHeads != null)
                    txtCodeReviewByTechHead.Text = lblCodeReviewbyTechHeads.Text;

                if (lblBugfixing != null)
                    txtBugfixing.Text = lblBugfixing.Text;

                if (lblCoordinationwithQA != null)
                    txtCoordinationwithQA.Text = lblCoordinationwithQA.Text;

                if (lblReactTraining != null)
                    txtReactTraining.Text = lblReactTraining.Text;

                if (lblBehaviour != null)
                    txtBehaviour.Text = lblBehaviour.Text;

                if (lblPortalTaskFilled != null)
                    txtPortalTaskFilled.Text = lblPortalTaskFilled.Text;


                Datatable();
                btnSave.Text = "Update";
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
}