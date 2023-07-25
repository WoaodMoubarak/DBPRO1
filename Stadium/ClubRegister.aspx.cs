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
    public partial class ClubRegister : System.Web.UI.Page
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
            String fcname = clubname1.Text;
            String fusername = username1.Text;
            String fpassword = password1.Text;
            if (string.IsNullOrEmpty(name1.Text) || string.IsNullOrEmpty(clubname1.Text) || string.IsNullOrEmpty(username1.Text) || string.IsNullOrEmpty(password1.Text))
            {
                Response.Write("<script>alert('There is one or more empty field(s)')</script>");

            }
            else
            {
                SqlCommand CRexists = new SqlCommand("Select CR.ID FROM ClubRepresentative CR INNER JOIN Club C ON C.ID = CR.ID WHERE C.clubname = @c ", conn);
                CRexists.Parameters.Add(new SqlParameter("@c", fcname));
                conn.Open  ();
                SqlDataReader r = CRexists.ExecuteReader();
                Boolean y = r.Read();
                conn.Close();
                if (y == true)
                {

                    Response.Write("<script>alert('This club already has a representative')</script>");

                }
                else
                {
                    SqlCommand Clubexists = new SqlCommand("Select C.ID FROM Club C  WHERE C.clubname = @c ", conn);
                    Clubexists.Parameters.Add(new SqlParameter("@c", fcname));
                    conn.Open();
                    SqlDataReader t = Clubexists.ExecuteReader();
                    Boolean x = t.Read();
                    conn.Close();
                    if (x == false)
                    {
                        Response.Write("<script>alert('club name does not exist')</script>");
                    }
                    else
                    {
                        SqlCommand addM = new SqlCommand("addRepresentative", conn);
                        addM.CommandType = System.Data.CommandType.StoredProcedure;
                        addM.Parameters.Add(new SqlParameter("@xname", fname));
                        addM.Parameters.Add(new SqlParameter("@clubname", fcname));
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