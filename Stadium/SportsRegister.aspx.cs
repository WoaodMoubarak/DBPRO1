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
    public partial class SportsRegister : System.Web.UI.Page
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
            String fusername = username1.Text;
            String fpassword = password1.Text;
            SqlCommand addM = new SqlCommand("addAssociationManager", conn);
            addM.CommandType = System.Data.CommandType.StoredProcedure;
            addM.Parameters.Add(new SqlParameter("@xname", fname));
            addM.Parameters.Add(new SqlParameter("@username", fusername));
            addM.Parameters.Add(new SqlParameter("@xpassword", fpassword));
            SqlParameter success = addM.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            
            addM.ExecuteNonQuery();

            if (string.IsNullOrEmpty(name1.Text) || string.IsNullOrEmpty(username1.Text) || string.IsNullOrEmpty(password1.Text))
            {
                Response.Write("<script>alert('There is one or more empty field(s)')</script>");

            }
            else
            {


                if (success.Value.ToString() == "1")
                {
                    Response.Write("<script>alert('Registeration Successful ')</script>");
                    conn.Close();

                    Response.Redirect("Login.aspx");

                }
                else
                {
                    Response.Write("<script>alert('Username already taken')</script>");


                }


            }
        }
    }
}