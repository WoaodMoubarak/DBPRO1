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
    public partial class clubrepresentative : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["users"]);
        }

        protected void viewClub(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand getID = new SqlCommand("Select CR.CID FROM ClubRepresentative CR WHERE CR.username = @user ", conn);
            getID.Parameters.Add(new SqlParameter("@user", Session["users"]));

            conn.Open();
            SqlDataReader dr2 = getID.ExecuteReader();
            dr2.Read();
            //
            String x = dr2["CID"] + "";
            conn.Close();
            //Console.WriteLine(x);
            //
            SqlCommand getInfo = new SqlCommand("SELECT * FROM Club C WHERE  @ID=C.ID",conn);
            getInfo.Parameters.Add(new SqlParameter("@ID", x));

            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(getInfo);
            DataTable dt = new DataTable();
            da.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<h1>Club details</h1>");
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
        protected void upcominMatches(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);




            SqlCommand getCID = new SqlCommand("Select C.CID FROM ClubRepresentative C WHERE  @user=C.username  ", conn);
            getCID.Parameters.Add(new SqlParameter("@user", Session["users"]));

            conn.Open();
            SqlDataReader dr2 = getCID.ExecuteReader();
            dr2.Read();
            String x = dr2["CID"] + "";
            dr2.Read();
            conn.Close();

            SqlCommand getName = new SqlCommand("SELECT C.Clubname FROM Club C WHERE C.ID = @ID",conn);
            getName.Parameters.Add(new SqlParameter("@ID",x));
            conn.Open();
            SqlDataReader dr3 = getName.ExecuteReader();
            dr3.Read();
            String y = dr3["Clubname"] + "";
            SqlCommand matches = new SqlCommand("Select * FROM dbo.upcomingMatchesOfClub(@clubname)", conn);

            matches.Parameters.Add(new SqlParameter("@clubname",y ));




            conn.Close();
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(matches);
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
            Panel2.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();




        }
        protected void availableStadiums(object sender, EventArgs e)
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
                SqlCommand Stadiums = new SqlCommand("Select * FROM dbo.viewAvailableStadiumsOn(@Mdate)", conn);
                Stadiums.Parameters.Add(new SqlParameter("@Mdate", date));

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(Stadiums);
                DataTable dt = new DataTable();
                da.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<h1>Available Stadiums</h1>");
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

        protected void sendRequest(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand sending = new SqlCommand("addHostRequest", conn);
            sending.CommandType = System.Data.CommandType.StoredProcedure;
            String SName = StadiumName.Text;
            if (string.IsNullOrEmpty(startTime.Text))
            {
                Response.Write("<script>alert('date field is empty')</script>");

            }
            else
            {


                DateTime date = DateTime.Parse(startTime.Text);
                sending.Parameters.Add(new SqlParameter("@stadium", SName));
                sending.Parameters.Add(new SqlParameter("@startdate", date));
                SqlParameter success = sending.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;



                SqlCommand getCID = new SqlCommand("Select CR.CID FROM ClubRepresentative CR WHERE CR.username = @user ", conn);
                getCID.Parameters.Add(new SqlParameter("@user", Session["users"]));
                SqlCommand getName = new SqlCommand("SELECT C.Clubname FROM Club C WHERE C.ID = @ID", conn);

                conn.Open();
                SqlDataReader dr2 = getCID.ExecuteReader();
                dr2.Read();
                String CRIDS = dr2["CID"] + "";
                int CRID = Int16.Parse(CRIDS);
                getName.Parameters.Add(new SqlParameter("@ID", CRID));
                conn.Close();
                conn.Open();
                SqlDataReader dr3 = getName.ExecuteReader();

                dr3.Read();
                String clubN = dr3["Clubname"] + "";
                sending.Parameters.Add(new SqlParameter("@club", clubN));



                conn.Close();
                conn.Open();
                sending.ExecuteNonQuery();
                // purchaseproc.ExecuteNonQuery();
                if (success.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('Request sent')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Unable to send request')</script>");
                }



                conn.Close();



            }
        }





    }
}