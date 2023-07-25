using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Stadium
{
    public partial class SystemAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Session["users"]);
        }
        protected void addClub(object sender, EventArgs e)
        {
            String name1 = name.Text;
            String location1 = location.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand add = new SqlCommand("addClub", conn);
            add.CommandType = System.Data.CommandType.StoredProcedure;
            add.Parameters.Add(new SqlParameter("@clubname", name1));
            add.Parameters.Add(new SqlParameter("@Location", location1));
            conn.Open();


            var success = add.ExecuteNonQuery();


            if (success == 1)
            {
                Response.Write("<script>alert('Club Added')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to add club')</script>");
            }

            conn.Close();
        }
        protected void deleteClub(object sender, EventArgs e)
        {
            String name1 = deletename.Text;
            String location1 = location.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand delete = new SqlCommand("deleteClub", conn);
            delete.CommandType = System.Data.CommandType.StoredProcedure;
            delete.Parameters.Add(new SqlParameter("@clubname", name1));

            conn.Open();


            var success = delete.ExecuteNonQuery();


            if (success == 1)
            {
                Response.Write("<script>alert('Club deleted')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to delete club')</script>");
            }
            conn.Close();


        }
        protected void addStadium(object sender, EventArgs e)
        {
            String name1 = sname.Text;
            String location1 = slocation.Text;
            int capacity1 = int.Parse(scapacity.Text);
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand add = new SqlCommand("addStadium", conn);
            add.CommandType = System.Data.CommandType.StoredProcedure;
            add.Parameters.Add(new SqlParameter("@stadiumname", name1));
            add.Parameters.Add(new SqlParameter("@Location", location1));
            add.Parameters.Add(new SqlParameter("@capacity", capacity1));
            conn.Open();


            var success = add.ExecuteNonQuery();


            if (success == 1)
            {
                Response.Write("<script>alert('Stadium Added')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to add stadium')</script>");
            }

            conn.Close();
        }
        protected void deleteStadium(object sender, EventArgs e)
        {
            String name1 = stadiumname.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand delete = new SqlCommand("deleteStadium", conn);
            delete.CommandType = System.Data.CommandType.StoredProcedure;
            delete.Parameters.Add(new SqlParameter("@Stadiumname", name1));
            SqlParameter success = delete.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            delete.ExecuteNonQuery();

           


            if (success.Value.ToString() == "1")
            {
                Response.Write("<script>alert('Stadium deleted')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to delete stadium')</script>");
            }
            conn.Close();

        }
        protected void block(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand block = new SqlCommand("blockFan", conn);
            block.CommandType = System.Data.CommandType.StoredProcedure;
            String id = fan.Text;
            block.Parameters.Add(new SqlParameter("@FanID", id));
            conn.Open();
           
            var success = block.ExecuteNonQuery();


            if (success == 1)
            {
                Response.Write("<script>alert('Fan blocked')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to block fan')</script>");
            }
            
            
            conn.Close();

        }
        protected void unblock(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand unblock = new SqlCommand("unblockFan", conn);
            unblock.CommandType = System.Data.CommandType.StoredProcedure;
            String id = fan.Text;
            unblock.Parameters.Add(new SqlParameter("@FanID", id));
            conn.Open();
          
            var success = unblock.ExecuteNonQuery();


            if (success == 1)
            {
                Response.Write("<script>alert('Fan unblocked')</script>");
            }
            else
            {
                Response.Write("<script>alert('Unable to unblock fan')</script>");
            }


            conn.Close();

        }



    }
}