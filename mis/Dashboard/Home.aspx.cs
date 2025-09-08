using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Drawing.Charts;
using DocumentFormat.OpenXml.Presentation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class mis_Dashboard_Home : System.Web.UI.Page
{
    APIProcedure objdb = new APIProcedure();
    DataSet ds = new DataSet();
    CultureInfo cult = new CultureInfo("gu-IN", true);
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["Emp_ID"] != null)
            {

                SpCDate.InnerText = DateTime.Now.Date.ToString("dd-MM-yyyy");
                GetRequirementAllocation();
                GetTotalRequirementAssigned();
            }
            else
            {
                Response.Redirect("~/mis/Login.aspx");
            }
        }

        catch (Exception ex)
        {
            //lblMsg.Text = objdb.Alert("fa-ban", "alert-danger", "Sorry!", ex.Message.ToString());
        }
    }

    private void GetRequirementAllocation()
    {
        try
        {
            string CDate = DateTime.Now.Date.ToString("dd-MM-yyyy") != "" ? Convert.ToDateTime(DateTime.Now.Date.ToString("dd-MM-yyyy"), cult).ToString("yyyy/MM/dd") : "";
            ds = objdb.ByProcedure("Usp_GetDashBoardCount", new string[] { "Flag", "Date" }, new string[] { "1", CDate }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                LBAllocatedCount.Text = ds.Tables[0].Rows[0]["AllocatedCount"].ToString();
                LBNotAllocatedCount.Text = ds.Tables[0].Rows[0]["NotAllocatedCount"].ToString();
            }
         
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void GetTotalRequirementAssigned()
    {
        try
        {
            string CDate = DateTime.Now.Date.ToString("dd-MM-yyyy") != "" ? Convert.ToDateTime(DateTime.Now.Date.ToString("dd-MM-yyyy"), cult).ToString("yyyy/MM/dd") : "";
            ds = objdb.ByProcedure("Usp_GetDashBoardCount", new string[] { "Flag", "Date" }, new string[] { "2", CDate }, "dataset");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                LBReqCompleted.Text = ds.Tables[0].Rows[0]["CompleteCount"].ToString();
                LBReqPending.Text = ds.Tables[0].Rows[0]["PendingCount"].ToString();
                LBPartialComplete.Text = ds.Tables[0].Rows[0]["PartialCompleteCount"].ToString();
                LBNotFilledCount.Text = ds.Tables[0].Rows[0]["NotFilledCount"].ToString();
            }
         
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
