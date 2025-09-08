using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace sfaDailyTask
{
    class Program
    {
        static void Main(string[] args)
        {
            DataSet ds = new DataSet();
            try
            {
                // Call the new stored procedure

                string Date = DateTime.Now.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                ds = CommonMethod.byProcedure("USP_DailyTask_NotFilled", new string[] { "Date" }, new string[] { Date });
                string Latedate = DateTime.Now.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
               

                StringBuilder sb = new StringBuilder();
                if (ds != null && ds.Tables.Count > 0)
                {
                    sb.Append("<div style='text-align:center;color:black;'>");
                    sb.Append("<h2 style=' margin: 0; padding:0'>SFA Technologies Pvt. Ltd. </h2>");
                    //sb.Append("<h4 style=' margin: 0; padding:0'>Date : " + Latedate + "</h4>");
                    sb.Append("</div>");
                    sb.Append("<div>");



                    // 1. Employees Not Filled 
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        sb.Append("<hr/>");
                        sb.Append("<div style='text-align:center;color:black;margin-bottom:10px;'>");
                        sb.Append("<h3 style='margin: 5px 0; padding:0;font-size: 1.5rem;color: #891b0f;'>Employee Task Not Filled Report (" + Latedate + ")</h3>");
                        sb.Append("</div>");

                        sb.Append("<table style='border:1px solid black; border-collapse:collapse; width:95%; margin:0 auto; font-family:Arial, sans-serif;'>");

                        // Header
                        sb.Append("<thead>");
                        sb.Append("<tr style='background-color:#1d5b79; color:white;'>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:3%; text-align:center;'>S.No.</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:15%; text-align:center;'>Employee Name</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:15%; text-align:center;'>Project Name</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:15%; text-align:center;'>Requirement Point</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:20%; text-align:center;'>Description</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:5%; text-align:center;'>Priority</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:15%; text-align:center;'>Assigned By</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:7%; text-align:center;'>Allocation Date</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:7%; text-align:center;'>Allocation Time</th>");
                        sb.Append("<th style='border:1px solid black; padding:5px; width:7%; text-align:center;'>Fill Status</th>");
                        sb.Append("</tr>");
                        sb.Append("</thead>");

                        // Body
                        sb.Append("<tbody>");
                        int serial = 1;
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            sb.Append("<tr style='background-color:" + (i % 2 == 0 ? "#f9f9f9" : "#ffffff") + ";'>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + serial + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[0].Rows[i]["EmployeeName"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[0].Rows[i]["ProjectNames"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[0].Rows[i]["TaskNames"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[0].Rows[i]["TaskDescriptions"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + ds.Tables[0].Rows[i]["Priorities"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[0].Rows[i]["AssignedBys"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + ds.Tables[0].Rows[i]["AllocationDates"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + ds.Tables[0].Rows[i]["AllocationTimes"] + "</td>");
                            sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + ds.Tables[0].Rows[i]["FillStatus"] + "</td>");
                            sb.Append("</tr>");
                            serial++;
                        }
                        sb.Append("</tbody>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                 

                        // 🚨 NOTE 
                        sb.Append("<div style='margin:0 auto; font-family:Arial, sans-serif; color:red; font-weight:bold;font-size: 1.1rem;'>");
                        sb.Append("**NOTE :- Daily Report Portal is interlinked with Payroll. So kindly ensure your daily report for smooth and timely generation of your salary.");
                        sb.Append("</div>");

                        // 2. Employees On Leave
                        if (ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0)
                        {
                            sb.Append("<hr/>");
                            sb.Append("<div style='text-align:center;color:black;margin-bottom:10px;'>");
                            sb.Append("<h3 style='margin: 5px 0; padding:0;font-size: 1.5rem;color: #891b0f;'>Employee On Leave</h3>");
                            sb.Append("</div>");

                            sb.Append("<table style='border:1px solid black; border-collapse:collapse; width:50%; margin:0 auto; font-family:Arial, sans-serif;'>");

                            // Header
                            sb.Append("<thead>");
                            sb.Append("<tr style='background-color:#1d5b79; color:white;'>");
                            sb.Append("<th style='border:1px solid black; padding:5px; width:10%; text-align:center;'>S.No.</th>");
                            sb.Append("<th style='border:1px solid black; padding:5px; width:90%; text-align:center;'>Employee Name</th>");
                            sb.Append("</tr>");
                            sb.Append("</thead>");

                            // Body
                            sb.Append("<tbody>");
                            for (int i = 0; i < ds.Tables[3].Rows.Count; i++)
                            {
                                sb.Append("<tr style='background-color:" + (i % 2 == 0 ? "#f9f9f9" : "#ffffff") + ";'>");
                                sb.Append("<td style='border:1px solid black; padding:5px; text-align:center;'>" + (i + 1) + "</td>");
                                sb.Append("<td style='border:1px solid black; padding:5px; text-align:left;'>" + ds.Tables[3].Rows[i]["EmployeeName"] + "</td>");
                                sb.Append("</tr>");
                            }
                            sb.Append("</tbody>");
                            sb.Append("</table>");
                            sb.Append("<br/>");
                        }
                    }

                    else
                    {
                        CommonMethod.WriteToFile("Employee Task Not Filled Or Leave Report Record Not Found Tables[1] :" + DateTime.Now);
                    }

                    // 4. Prepare TO email list
                    string toEmails = "";
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                        {
                            if (ds.Tables[1].Rows[i]["TOEmp_Email"].ToString() != "")
                                toEmails += ds.Tables[1].Rows[i]["TOEmp_Email"].ToString() + ",";
                        }
                    }

                    // 5. Prepare Email CC list
                    string empEmail = "";
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        int count = ds.Tables[2].Rows.Count;
                        for (int i = 0; i < count; i++)
                        {
                            if (ds.Tables[2].Rows[i]["CCEmp_Email"].ToString() != "")
                            {
                                empEmail += ds.Tables[2].Rows[i]["CCEmp_Email"].ToString() + ",";
                            }
                        }
                    }
                    //if (empEmail != "")
                    //{
                    //    string empMail = ConfigurationSettings.AppSettings["IsDevelopment"].ToLower() == "false"
                    //        ? empEmail.TrimEnd(',')
                    //        : ConfigurationSettings.AppSettings["IsDevelopmentCcMailId"];
                    //    string adminMail = ConfigurationSettings.AppSettings["IsDevelopment"].ToLower() == "false"
                    //        ? ConfigurationSettings.AppSettings["adminMailId"]
                    //        : ConfigurationSettings.AppSettings["IsDevelopmentToMailId"];

                    //    CommonMethod.sendmail(adminMail, empMail, Latedate + " Todays Employee Status List", sb.ToString());
                    //    CommonMethod.WriteToFile("Email has been successfully sent :" + DateTime.Now);
                    //}
                    //else
                    //{
                    //    CommonMethod.WriteToFile("Employee Email Not Found Tables[3] :" + DateTime.Now);
                    //}
                    if (empEmail != "")
                    {
                        string empMail = ConfigurationSettings.AppSettings["IsDevelopment"].ToLower() == "false"
                            ? empEmail.TrimEnd(',')
                            : ConfigurationSettings.AppSettings["IsDevelopmentCcMailId"];

                        string adminMail = ConfigurationSettings.AppSettings["IsDevelopment"].ToLower() == "false"
                            ? toEmails.TrimEnd(',')
                            //? ConfigurationSettings.AppSettings["adminMailId"]
                            : ConfigurationSettings.AppSettings["IsDevelopmentToMailId"];

                        // Create Excel from HTML (same content as email body)
                        //byte[] excelBytes = ConvertHtmlToExcelBytes(sb.ToString());

                        // Generate file name with date-time
                       // string excelFileName = $"EmployeeStatusReport_{DateTime.Now:dd_MM_yyyy_hh_mm_tt}.xls";


                        // Send email with HTML body and Excel attachment
                        CommonMethod.sendmail(adminMail, empMail,
                            Latedate + " Todays Employee Status List",
                            sb.ToString());

                        CommonMethod.WriteToFile("Email with HTML body and Excel attachment sent: " + DateTime.Now);
                    }

                }
                else
                {
                    CommonMethod.WriteToFile("No Record Found :" + DateTime.Now);
                }
            }
            catch (Exception ex)
            {
                CommonMethod.WriteToFile(ex.Message.ToString() + " Exception :" + DateTime.Now);
            }
        }
        //public static byte[] converthtmltoexcelbytes(string htmlcontent)
        //{
        //    using (memorystream ms = new memorystream())
        //    {
        //        streamwriter writer = new streamwriter(ms, encoding.utf8);
        //        writer.write(htmlcontent);
        //        writer.flush();
        //        ms.position = 0;
        //        return ms.toarray();
        //    }
        //}


    }
}


