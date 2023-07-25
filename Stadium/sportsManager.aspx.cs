using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Stadium
{
    public partial class sportsManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["users"]);
        }
        protected void addMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand add = new SqlCommand("addNewMatch", conn);
            add.CommandType = System.Data.CommandType.StoredProcedure;
            string hostclub = host.Text;
            string guestclub = guest.Text;
            if (string.IsNullOrEmpty(start.Text) || string.IsNullOrEmpty(end.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else
            {


                DateTime starttime = DateTime.Parse(start.Text);
                DateTime endtime = DateTime.Parse(end.Text);
                add.Parameters.Add(new SqlParameter("@hostName", hostclub));
                add.Parameters.Add(new SqlParameter("@guestName", guestclub));
                add.Parameters.Add(new SqlParameter("@startTime", starttime));
                add.Parameters.Add(new SqlParameter("@endtime", endtime));
                SqlParameter success = add.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;
                conn.Open();

                add.ExecuteNonQuery();


                if (success.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('Match added')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Unable to add match')</script>");
                }
                conn.Close();



            }
        }
        protected void deleteMatch(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand delete = new SqlCommand("deleteMatch", conn);
            delete.CommandType = System.Data.CommandType.StoredProcedure;
            string hostclub = hostD.Text;
            string guestclub = guestD.Text;
            if (string.IsNullOrEmpty(startD.Text) || string.IsNullOrEmpty(endD.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else
            {
                DateTime starttime = DateTime.Parse(startD.Text);
                DateTime endtime = DateTime.Parse(endD.Text);
                delete.Parameters.Add(new SqlParameter("@hostClub", hostclub));
                delete.Parameters.Add(new SqlParameter("@guestClub", guestclub));
                delete.Parameters.Add(new SqlParameter("@startTime", starttime));
                delete.Parameters.Add(new SqlParameter("@endTime", endtime));
                conn.Open();

                var success = delete.ExecuteNonQuery();


                if (success == 1)
                {
                    Response.Write("<script>alert('Match deleted')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Unable to delete match')</script>");
                }


                conn.Close();

            }
        }
        protected void upcomingMatches(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand upMatches = new SqlCommand("SELECT * FROM upcomingMatches", conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(upMatches);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>Upcoming Matches</h1>");
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
        protected void playedMatches(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand playedMatches = new SqlCommand("SELECT * FROM alreadyMatches", conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(playedMatches);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>Already Played Matches</h1>");
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
            Panel2.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();

        }
        protected void clubsneverplayed(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand clubs = new SqlCommand("SELECT * FROM clubsNeverMatched", conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(clubs);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>Clubs never matched </h1>");
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
            Panel3.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();

        }

    }
}