using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Text;

namespace Stadium
{
    
public partial class fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["users"]);
        }
        protected void purchaseTicket(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand getID = new SqlCommand("Select F.NationalID FROM Fan F  WHERE F.username = @user ", conn);
            getID.Parameters.Add(new SqlParameter("@user", Session["users"]));

            conn.Open();
            SqlDataReader dr2 = getID.ExecuteReader();
            dr2.Read();
            //
            String x = dr2["NationalID"] + "";
            conn.Close();
            SqlCommand purchaseproc = new SqlCommand("purchaseTicket", conn);
            purchaseproc.CommandType = System.Data.CommandType.StoredProcedure;
            //String NationalID = nationalID.Text;
            String host = hostClub.Text;
            String guest = guestClub.Text;
            if (string.IsNullOrEmpty(StartTime.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else
            {


                DateTime date = DateTime.Parse(StartTime.Text);
                purchaseproc.Parameters.Add(new SqlParameter("@nationalID", x));
                purchaseproc.Parameters.Add(new SqlParameter("@hostname", host));
                purchaseproc.Parameters.Add(new SqlParameter("@guestname", guest));
                purchaseproc.Parameters.Add(new SqlParameter("@startTime", date));
                conn.Open();
                var success = purchaseproc.ExecuteNonQuery();

                // purchaseproc.ExecuteNonQuery();
                if (success == 1)
                {
                    Response.Write("<script>alert('Ticket Purchased')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Ticket unavailable')</script>");
                }
                conn.Close();
                // Response.Redirect("fan.aspx");
            }
        }
        protected void FetchData(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            if (string.IsNullOrEmpty(Date.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else
            {
                DateTime date = DateTime.Parse(Date.Text);
                SqlCommand fan = new SqlCommand("Select * FROM dbo.availableMatchesToAttend(@Mdate)", conn);
                SqlParameter param = new SqlParameter();
                param.ParameterName = "@Mdate";
                param.Value = date;
                fan.Parameters.Add(param);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(fan);
                DataTable dt = new DataTable();
                da.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<h1>Available Matches</h1>");
                sb.Append("<hr/>");
                sb.Append("<table border=1>");
                sb.Append("<tr>");
                sb.Append("</tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    sb.Append("<th>");
                    sb.Append(dc.ColumnName.ToUpper());
                    sb.Append("</th>");
                }
                foreach (DataRow dr in dt.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn dc in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(dr[dc.ColumnName].ToString());
                        sb.Append("</th>");
                    }
                    sb.Append("</tr>");
                }
                sb.Append("</table>");
                sb.Append("</center>");
                Panel1.Controls.Add(new Label { Text = sb.ToString() });
                conn.Close();
            }
        }

       



        
    }
}