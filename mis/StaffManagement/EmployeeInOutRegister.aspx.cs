using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class mis_StaffManagement_EmployeeInOutRegister : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    DataSet ds = new DataSet();
    private static string InOutRegisterId = string.Empty;
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

    private DataSet USP_EmployeeInOutReg(string[] columns, string[] values)
    {
        ds = objdb.ByProcedure("USP_EmployeeInOutRegister", columns, values, "ds");
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

    private void Initials()
    {
        try
        {
            ViewState["Emp_ID"] = Session["Emp_ID"].ToString();

            FillEmployee();
            FillGridDetails();
            //fill breadcrumb.
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

            ds = objdb.ByProcedure("USP_TaskAllocation", new string[] { "Flag" }, new string[] { "1" }, "ds");
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                lblMsg.Text = string.Empty;
                string ErrorMsg = string.Empty;

                DateTime dtOut = DateTime.Parse(txtTimeOut.Text); // "01:45 PM"
                DateTime dtIn = DateTime.Parse(txtTimeIn.Text);

                TimeSpan timeOut = dtOut.TimeOfDay;
                TimeSpan timeIn = dtIn.TimeOfDay;

                if (timeIn <= timeOut)
                {
                    ErrorMsg = "Time In must be greater than Time Out!";
                }

                if (!string.IsNullOrEmpty(ErrorMsg))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alertMessage", "alert(' \\n " + ErrorMsg + "')", true);
                }
                else
                {
                    string Date = txtDate.Text != "" ? Convert.ToDateTime(txtDate.Text, cult).ToString("yyyy/MM/dd") : "";
                    string flag = string.Empty;
                    if (btnSave.Text.Equals("Save"))
                    {
                        InOutRegisterId = string.Empty;
                        flag = "1";
                    }
                    else if (btnSave.Text.Equals("Update"))
                    {
                        flag = "6";
                    }
                    if (string.IsNullOrEmpty(flag))
                    {
                        WarningMsg("Something went wrong, Please try after sometime.");
                        return;
                    }

                    ds = USP_EmployeeInOutReg(
                          new string[]
                          {
                              "Flag",
                              "InOutRegisterId",
                              "EntryDate",
                              "Employee_Id",
                              "Place",
                              "OrderBy",
                              "TimeOut",
                              "TimeIn",
                              "CreatedBy",
                              "CreatedByIp"
                          },
                          new string[]
                          {
                              flag,
                              InOutRegisterId,
                              Convert.ToString(Date),
                              ddlEmployee.SelectedValue,
                              txtPlace.Text.Trim(),
                              txtOrderBy.Text.Trim(),
                              txtTimeOut.Text.Trim(),
                              txtTimeIn.Text.Trim(),
                              Convert.ToString(ViewState["Emp_ID"]),
                              objdb.GetLocalIPAddress()
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

    private void FillGridDetails()
    {
        try
        {
            gvInOutRegisterReport.DataSource = null;
            gvInOutRegisterReport.DataBind();

            ds = USP_EmployeeInOutReg(new string[] { "Flag" }, new string[] { "2" });
            if (IsNullDataSet(ds))
            {
                gvInOutRegisterReport.DataSource = ds.Tables[0];
                gvInOutRegisterReport.DataBind();
                Datatable();
            }
        }
        catch (Exception ex)
        {
            ErrorMsg(ex);
        }
    }
    private void Clear()
    {
        txtDate.Text = string.Empty;
        ddlEmployee.ClearSelection();
        txtPlace.Text = string.Empty;
        txtOrderBy.Text = string.Empty;
        txtTimeOut.Text = string.Empty;
        txtTimeIn.Text = string.Empty;

    }
    protected void Datatable()
    {
        if (gvInOutRegisterReport.Rows.Count > 0)
        {
            gvInOutRegisterReport.HeaderRow.TableSection = TableRowSection.TableHeader;
            gvInOutRegisterReport.UseAccessibleHeader = true;
        }
    }
}