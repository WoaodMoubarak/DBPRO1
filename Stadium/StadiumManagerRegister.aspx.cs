using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Stadium
{
    public partial class StadiumManagerRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void addManager(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            String fname = name1.Text;
            String fsname = stadiumname1.Text;
            String fusername = username1.Text;
            String fpassword = password1.Text;
            if (string.IsNullOrEmpty(name1.Text) || string.IsNullOrEmpty(stadiumname1.Text) || string.IsNullOrEmpty(username1.Text) || string.IsNullOrEmpty(password1.Text))
            {
                Response.Write("<script>alert('There is one or more empty field(s)')</script>");

            }
            else
            {
                SqlCommand SMexists = new SqlCommand("Select SM.ID FROM StadiumManager SM INNER JOIN Stadium S ON S.ID = SM.stadiumID WHERE S.stadiumname = @s ", conn);
                SMexists.Parameters.Add(new SqlParameter("@s", fsname));
                conn.Open();
                SqlDataReader r = SMexists.ExecuteReader();
                Boolean y = r.Read();
                conn.Close();
                if (y == true)
                {

                    Response.Write("<script>alert('This stadium already has a manager')</script>");

                }
                else
                {
                    SqlCommand Stadiumexists = new SqlCommand("Select S.ID FROM Stadium S  WHERE S.stadiumname = @c ", conn);
                    Stadiumexists.Parameters.Add(new SqlParameter("@c", fsname));
                    conn.Open();
                    SqlDataReader t = Stadiumexists.ExecuteReader();
                    Boolean x = t.Read();
                    conn.Close();
                    if (x == false)
                    {
                        Response.Write("<script>alert('stadium name does not exist')</script>");
                    }

                    else
                    {
                        SqlCommand addM = new SqlCommand("addStadiumManager", conn);
                        addM.CommandType = System.Data.CommandType.StoredProcedure;
                        addM.Parameters.Add(new SqlParameter("@xname", fname));
                        addM.Parameters.Add(new SqlParameter("@stadiumName", fsname));
                        addM.Parameters.Add(new SqlParameter("@username", fusername));
                        addM.Parameters.Add(new SqlParameter("@xpassword", fpassword));
                        SqlParameter success = addM.Parameters.Add("@success", SqlDbType.Int);
                        success.Direction = ParameterDirection.Output;
                        conn.Open();

                        addM.ExecuteNonQuery();


                        if (success.Value.ToString() == "1")
                        {
                            Response.Write("<script>alert('Registeration Successful ')</script>");

                            conn.Close();
                            Response.Redirect("Login.aspx");

                        }
                        else
                        {
                            Response.Write("<script>alert('Username already taken')</script>");

                            conn.Close();
                        }


                    }
                }

            }
        }
    }
}