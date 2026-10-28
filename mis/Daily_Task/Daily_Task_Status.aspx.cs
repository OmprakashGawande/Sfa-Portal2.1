using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Drawing;
using System.IO;
using System.Net;
using Microsoft.Reporting.WebForms;



public partial class mis_Daily_Task_Daily_Task_Status : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds, ds1, ds5, dsC, dsCU, dsphad;
    static DataTable dt = new DataTable();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    IFormatProvider culture = new CultureInfo("en-US", true);
    string[] arr = { "1", "2", "3", "4", "5", "59" };
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;

        if (objdb.createdBy() != null && objdb.Office_ID() != null)
        {
            if (!arr.Contains(Session["Emp_ID"].ToString()))
            {
               // objdb.redirectToHome();
            }

            if (!IsPostBack)
            {
                gridvew1.DataSource = null;
                gridvew1.DataBind();
                lblMsg.Text = "";
                txtDate.Attributes.Add("readonly", "readonly");
                DateTime dd = DateTime.Now;
                txtDate.Text = (Convert.ToDateTime(dd, culture).ToString("dd/MM/yyyy"));
            }
        }
        else
        {
            objdb.redirectToHome();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            fillGrid();
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry", ex.Message.ToString());
        }
    }
    protected void fillGrid()
    {
        try
        {
            gridvew1.DataSource = null;
            gridvew1.DataBind();
            string ddate = Convert.ToDateTime(txtDate.Text.Trim(), cult).ToString("yyyy/MM/dd");
            ds1 = objdb.ByProcedure("USP_Daily_Task_RPT_Emp_Details", new string[] { "Task_date" }, new string[] { ddate }, "dataset");
            if (ds1 != null)
            {
                if (ds1.Tables.Count > 0)
                {
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        gridvew1.DataSource = ds1.Tables[0];
                        gridvew1.DataBind();
                    }

                }

            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry", ex.Message.ToString());
        }

    }
    protected void fillTaskGrid(string TaskId)
    {
        try
        {
            gridEmpTask.DataSource = null;
            gridEmpTask.DataBind();
            ds1 = objdb.ByProcedure("USP_Daliy_Task_Child_GetBy_Task_Id", new string[] { "Task_Id" }, new string[] { TaskId }, "dataset");
            if (ds1 != null)
            {
                if (ds1.Tables.Count > 0)
                {
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        gridEmpTask.DataSource = ds1.Tables[0];
                        gridEmpTask.DataBind();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "$('#ViewDetails').modal('show');", true);
                    }

                }

            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry", ex.Message.ToString());
        }

    }
    protected void gridvew1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            if (e.CommandName == "ViewDetails")
            {
                fillTaskGrid(e.CommandArgument.ToString());
               
            }
            else if (e.CommandName == "DeleteTask")
            {
                ds1 = objdb.ByProcedure("USP_Daily_Task_Delete", new string[] { "Task_Id", "UpdateBy", "UpdatedByIp" }, new string[] { e.CommandArgument.ToString(), objdb.createdBy(), objdb.GetLocalIPAddress() }, "dataset");
                if (ds1 != null)
                {
                    if (ds1.Tables.Count > 0)
                    {
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            if (ds1.Tables[0].Rows[0]["Msg"].ToString() == "Ok")
                            {
                                lblMsg.Text = objdb.Alert("fa-check", "alert-success", "Thank You !", ds1.Tables[0].Rows[0]["ErrorMsg"].ToString());
                                fillGrid();
                            }
                            else
                            {
                                lblMsg.Text = objdb.Alert("fa-ban", "alert-info", "Alert !", ds1.Tables[0].Rows[0]["ErrorMsg"].ToString());
                            }

                        }

                    }

                }

            }
        }

        catch (Exception ex)
        {
            lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry! Error 6 : ", ex.Message.ToString());
        }
    }
    protected void btnprint_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtDate.Text != "")
        {
            string ddate = Convert.ToDateTime(txtDate.Text.Trim(), cult).ToString("yyyy/MM/dd");
            string baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath.TrimEnd('/') + "/";
            string url = baseUrl + "/mis/Daily_Task/Task_Print.aspx?dt=" + objdb.Encrypt(ddate);
            string script = "<script>window.open('" + url + "', '_blank');</script>";
            Response.Write(script);

        }
        }
        catch (Exception)
        {
            
        }
    }
}