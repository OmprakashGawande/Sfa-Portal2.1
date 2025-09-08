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
    public class CommonMethod
    {
        //public static void sendmail(string TO, string CC, string subject, string content)
        //{
        //    try
        //    {
        //        SmtpSection smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
        //        using (MailMessage mm = new MailMessage(smtpSection.From, TO))
        //        {
        //            mm.Subject = subject;
        //            mm.Body = content;
        //            mm.IsBodyHtml = true;
        //            mm.CC.Add(CC);
        //            SmtpClient smtp = new SmtpClient();
        //            smtp.Host = smtpSection.Network.Host;
        //            smtp.EnableSsl = smtpSection.Network.EnableSsl;
        //            NetworkCredential networkCred = new NetworkCredential(smtpSection.Network.UserName, smtpSection.Network.Password);
        //            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        //            smtp.UseDefaultCredentials = smtpSection.Network.DefaultCredentials;
        //            smtp.Credentials = networkCred;
        //            smtp.Port = smtpSection.Network.Port;
        //            smtp.Send(mm);

        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //}
        public static void sendmail(string TO, string CC, string subject, string content, byte[] excelAttachment = null, string excelFileName = null)
        {
            try
            {
                SmtpSection smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                using (MailMessage mm = new MailMessage(smtpSection.From, TO))
                {
                    mm.Subject = subject;
                    mm.Body = content;
                    mm.IsBodyHtml = true;

                    if (!string.IsNullOrEmpty(CC))
                        mm.CC.Add(CC);

                    if (excelAttachment != null && !string.IsNullOrEmpty(excelFileName))
                    {
                        mm.Attachments.Add(new Attachment(new MemoryStream(excelAttachment), excelFileName, "application/vnd.ms-excel"));
                    }

                    using (SmtpClient smtp = new SmtpClient())
                    {
                        smtp.Host = smtpSection.Network.Host;
                        smtp.EnableSsl = smtpSection.Network.EnableSsl;
                        smtp.Credentials = new NetworkCredential(smtpSection.Network.UserName, smtpSection.Network.Password);
                        smtp.Port = smtpSection.Network.Port;
                        smtp.Send(mm);
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMethod.WriteToFile("Send Mail Error: " + ex.Message);
            }
        }

        public static void WriteToFile(string Message)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "\\Logs";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string filepath = AppDomain.CurrentDomain.BaseDirectory + "\\Logs\\DailyReportLog_" + DateTime.Now.Date.ToShortDateString().Replace('/', '_') + ".txt";
            if (!File.Exists(filepath))
            {
                // Create a file to write to.   
                using (StreamWriter sw = File.CreateText(filepath))
                {
                    sw.WriteLine(Message);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(filepath))
                {
                    sw.WriteLine(Message);
                }
            }
            try
            {
                byProcedure("USP_Daily_Task_NoFill_Emp_ByTaskDate_Log", new string[] { "LogMassage" }, new string[] { Message });
            }
            catch (Exception ex)
            {

            }

        }
        public static string ConvertDataTableToHTML(DataTable dt, string groupColumn, string textAlign)
        {
            if (dt == null || dt.Rows.Count == 0)
                return "<p>No Data Found</p>";

            StringBuilder html = new StringBuilder();
            html.Append("<table style='border:1px solid black; border-collapse:collapse; width:90%; margin:1% 5%;'>");

            // Header Row
            html.Append("<tr style='background-color:#6b1216; color:white;'>");
            html.Append("<th style='border:1px solid black;'>S.No.</th>");
            foreach (DataColumn col in dt.Columns)
            {
                html.Append("<th style='border:1px solid black;'>" + col.ColumnName.Replace("_", " ") + "</th>");
            }
            html.Append("</tr>");

            string lastGroup = "";
            int rowCount = 1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                html.Append("<tr>");
                string currentGroup = dt.Rows[i][groupColumn].ToString();
                int groupSpan = dt.Select($"{groupColumn} = '{currentGroup}'").Length;

                // S.No. and group column with rowspan
                if (lastGroup != currentGroup)
                {
                    html.Append($"<td rowspan='{groupSpan}' style='border:1px solid black;text-align:center'>{rowCount}</td>");
                    html.Append($"<td rowspan='{groupSpan}' style='border:1px solid black;text-align:{textAlign}'>{currentGroup}</td>");
                    rowCount++;
                }

                // Remaining columns
                for (int j = 1; j < dt.Columns.Count; j++)
                {
                    html.Append($"<td style='border:1px solid black;text-align:{textAlign}'>{dt.Rows[i][j]}</td>");
                }

                html.Append("</tr>");
                lastGroup = currentGroup;
            }

            html.Append("</table>");
            return html.ToString();
        }
 

        public static string ConvertDataTableToHTMLTaskData(DataTable dt, string textAlign)
        {
            if (dt == null || dt.Rows.Count == 0)
                return "<p>No Task Data Found</p>";

            StringBuilder html = new StringBuilder();
            html.Append("<table style='border:1px solid black; border-collapse:collapse; width:90%; margin:1% 5%;'>");

            // Header Row
            html.Append("<tr style='background-color:#6b1216; color:white;'>");
            html.Append("<th style='border:1px solid black;'>S.No.</th>");
            foreach (DataColumn col in dt.Columns)
            {
                html.Append("<th style='border:1px solid black;'>" + col.ColumnName.Replace("_", " ") + "</th>");
            }
            html.Append("</tr>");

            string lastEmployee = "";
            string lastProject = "";
            int rowCount = 1;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                html.Append("<tr>");

                string employee = dt.Rows[i]["Employee_Name"].ToString();
                string project = dt.Rows[i]["Project_Name"].ToString();

                int employeeSpan = dt.Select($"Employee_Name = '{employee}'").Length;
                int projectSpan = dt.Select($"Employee_Name = '{employee}' AND Project_Name = '{project}'").Length;

                // Employee column with rowspan
                if (lastEmployee != employee)
                {
                    html.Append($"<td rowspan='{employeeSpan}' style='border:1px solid black;text-align:center'>{rowCount}</td>");
                    html.Append($"<td rowspan='{employeeSpan}' style='border:1px solid black;text-align:{textAlign}'>{employee}</td>");
                    rowCount++;
                    lastProject = ""; // reset project grouping for new employee
                }

                // Project column with rowspan
                if (lastProject != project)
                {
                    html.Append($"<td rowspan='{projectSpan}' style='border:1px solid black;text-align:{textAlign}'>{project}</td>");
                }

                // Remaining columns
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ColumnName != "Employee_Name" && col.ColumnName != "Project_Name")
                    {
                        html.Append($"<td style='border:1px solid black;text-align:{textAlign}'>{dt.Rows[i][col.ColumnName]}</td>");
                    }
                }

                html.Append("</tr>");
                lastEmployee = employee;
                lastProject = project;
            }

            html.Append("</table>");
            return html.ToString();
        }

       

        public static DataSet byProcedure(string ProcedureName, string[] Param, string[] ParmValue)
        {
            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(ProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    for (int i = 0; i < Param.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@" + Param[i], ParmValue[i]);
                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(ds);
                    }
                }
            }
            return ds;
        }
    }
}
