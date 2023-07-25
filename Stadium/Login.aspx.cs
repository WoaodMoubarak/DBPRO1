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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            String user = username.Text;
            String pass = Password.Text;

            SqlCommand loginproc = new SqlCommand("userlogin", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@user", user));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);
            SqlParameter block = loginproc.Parameters.Add("@block", SqlDbType.Int);


            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;
            block.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1" && type.Value.ToString() == "0")
            {
                if (block.Value.ToString() == "0")
                {
                    Response.Write("<script>alert('You Are Temporarily Blocked')</script>");
                }
                else
                {


                    Session["Users"] = user;
                    Response.Write("Login successfully");
                    Response.Redirect("fan.aspx");
                }
            }
            else
            {
                if (success.Value.ToString() == "1" && type.Value.ToString() == "2")
                {
                    Session["Users"] = user;
                    Response.Write("Login successfully");
                    Response.Redirect("clubrepresentative.aspx");
                }

                else
                {
                    if (success.Value.ToString() == "1" && type.Value.ToString() == "4")
                    {
                        Session["Users"] = user;
                        Response.Write("Login successfully");
                        Response.Redirect("SystemAdmin.aspx");

                    }
                    else
                    {
                        if (success.Value.ToString() == "1" && type.Value.ToString() == "1")
                        {
                            Session["Users"] = user;
                            Response.Write("Login successfully");
                            Response.Redirect("StadiumManager.aspx");

                        }


                        else
                        {
                            if (success.Value.ToString() == "1" && type.Value.ToString() == "3")
                            {
                                Session["Users"] = user;
                                Response.Write("Login successfully");
                                Response.Redirect("sportsManager.aspx");

                            }
                            else
                            {
                                if(success.Value.ToString() == "0")
                                {
                                    Response.Write("<script>alert('Invalid username or password')</script>");
                                }
                            }
                        }
                    }
                }

            }
        }
        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");

        }
    }
    
}