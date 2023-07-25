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
    public partial class StadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["users"]);

        }
        protected void viewStadium(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand getID = new SqlCommand("Select SM.StadiumID FROM StadiumManager SM WHERE SM.username = @user ", conn);
            getID.Parameters.Add(new SqlParameter("@user", Session["Users"]));

            conn.Open();
            SqlDataReader dr2 = getID.ExecuteReader();
            dr2.Read();
            String x = dr2["StadiumID"] + "";
            int SMID = Int16.Parse(x);
            conn.Close();


            SqlCommand getInfo = new SqlCommand("SELECT * FROM Stadium S WHERE S.ID = @ID", conn);
            getInfo.Parameters.Add(new SqlParameter("@ID", SMID));

            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(getInfo);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>Stadium Information</h1>");
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
        protected void viewRequests(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand getID = new SqlCommand("Select SM.ID FROM StadiumManager SM WHERE SM.username = @user ", conn);
            getID.Parameters.Add(new SqlParameter("@user", Session["users"]));

            conn.Open();
            SqlDataReader dr2 = getID.ExecuteReader();
            dr2.Read();
            String x = dr2["ID"] + "";
            int SMID = Int16.Parse(x);
            conn.Close();


            SqlCommand getInfo = new SqlCommand("SELECT CR.Cname ,C1.Clubname AS 'Host Club',C2.Clubname AS 'Guest Club' ,M.StartTime,M.EndTime, R.RequestStatus FROM HostRequest R INNER JOIN Matches M ON M.ID = R.Match_ID INNER JOIN Club C1 ON M.ClubIDhost = C1.ID INNER JOIN Club C2 ON M.ClubIDguest = C2.ID INNER JOIN ClubRepresentative CR ON R.ClubRID = CR.ID WHERE R.StadiumMID = @ID", conn);
            getInfo.Parameters.Add(new SqlParameter("@ID", SMID));

            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(getInfo);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>All Requests</h1>");
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
        protected void acceptRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Arequest = new SqlCommand("acceptRequest", conn);
            Arequest.CommandType = System.Data.CommandType.StoredProcedure;
            String host = hostClub.Text;
            String guest = guestClub.Text;
            if (string.IsNullOrEmpty(startTime.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else { 
            Arequest.Parameters.Add(new SqlParameter("@username", Session["users"]));
            Arequest.Parameters.Add(new SqlParameter("@hostclub", host));
            Arequest.Parameters.Add(new SqlParameter("@guestclub", guest));
            Arequest.Parameters.Add(new SqlParameter("@starttime", DateTime.Parse(startTime.Text)));
            SqlParameter success = Arequest.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            Arequest.ExecuteNonQuery();


            if (success.Value.ToString() == "1")
            {
                Response.Write("<script>alert('Request is Accepted')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to accept the request')</script>");
            }
           
            
            conn.Close();
        }}
        protected void rejectRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Rrequest = new SqlCommand("rejectRequest", conn);
            Rrequest.CommandType = System.Data.CommandType.StoredProcedure;
            String host = hostClub.Text;
            String guest = guestClub.Text;
            DateTime date = DateTime.Parse(startTime.Text);
            Rrequest.Parameters.Add(new SqlParameter("@username", Session["users"]));
            Rrequest.Parameters.Add(new SqlParameter("@hostclub", host));
            Rrequest.Parameters.Add(new SqlParameter("@guestclub", guest));
            Rrequest.Parameters.Add(new SqlParameter("@starttime", date));
            SqlParameter success = Rrequest.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            Rrequest.ExecuteNonQuery();
            Rrequest.ExecuteNonQuery();


            if (success.Value.ToString() == "1")
            {
                Response.Write("<script>alert('Request is Rejected')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to reject the request')</script>");
            }

            
            conn.Close();
        }
    }
}