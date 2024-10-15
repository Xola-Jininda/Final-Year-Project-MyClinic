using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppointmentBookingFeature
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True"; // connection string
            string username = txtRegisterUsername.Text;
            string password = txtRegisterPassword.Text;
           

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO User_ (Username, Password) VALUES (@Username, @Password)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                

                try
                {
                    cmd.ExecuteNonQuery();
                    
                }
                catch (Exception ex)
                {
                    lblRegisterMessage.Text = "Error: " + ex.Message;
                }
            }
        }
        
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True"; //connection string
            string username = txtLoginUsername.Text;
            string password = txtLoginPassword.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Role FROM User_ WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    string role = result.ToString();
                    FormsAuthentication.SetAuthCookie(username, false);

                    if (role == "Admin")
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else if (role == "Doctor")
                    {
                        Response.Redirect("DoctorDashboard.aspx");
                    }
                    else if (role =="")
                    {
                        Response.Redirect("PatientDashboard.aspx");
                    }
                }
                else
                {
                    lblLoginMessage.Text = "Invalid username or password.";
                }
            }
        }
    }
}