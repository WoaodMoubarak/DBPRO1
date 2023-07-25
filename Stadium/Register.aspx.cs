using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;


namespace Stadium
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Fan(object sender, EventArgs e)
        {
           
            Response.Redirect("fanRegister.aspx");




        }
        protected void StadiumManager(object sender, EventArgs e)
        {

            Response.Redirect("StadiumManagerRegister.aspx");




        }
        protected void ClubR(object sender, EventArgs e)
        {

            Response.Redirect("ClubRegister.aspx");




        }
        protected void SportsM(object sender, EventArgs e)
        {

            Response.Redirect("SportsRegister.aspx");




        }


    }
}