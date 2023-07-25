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
    public partial class fanRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void addFan1(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Stadium"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            String fname = name1.Text;
            String fusername = username1.Text;
            String fpassword = password1.Text;
            String fnationalID = NationalID1.Text;
            int fphone = int.Parse(phone1.Text);
            //handle if user entered alphabets in phone instead of int
            if (string.IsNullOrEmpty(DOB1.Text) || string.IsNullOrEmpty(name1.Text) || string.IsNullOrEmpty(username1.Text) || string.IsNullOrEmpty(password1.Text)
                || string.IsNullOrEmpty(phone1.Text))
            {
                Response.Write("<script>alert('There is one or more empty field(s)')</script>");

            }
            else
            {


                DateTime fDOB = DateTime.Parse(DOB1.Text);
                String fAddress = Address1.Text;
                SqlCommand addFan = new SqlCommand("addFan", conn);
                addFan.CommandType = System.Data.CommandType.StoredProcedure;
                addFan.Parameters.Add(new SqlParameter("@name", fname));
                addFan.Parameters.Add(new SqlParameter("@username", fusername));
                addFan.Parameters.Add(new SqlParameter("@password", fpassword));
                addFan.Parameters.Add(new SqlParameter("@nationalID", fnationalID));
                addFan.Parameters.Add(new SqlParameter("@birthdate", fDOB));
                addFan.Parameters.Add(new SqlParameter("@address", fAddress));
                addFan.Parameters.Add(new SqlParameter("@number", fphone));
                SqlParameter success = addFan.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;
                conn.Open();

                addFan.ExecuteNonQuery();


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