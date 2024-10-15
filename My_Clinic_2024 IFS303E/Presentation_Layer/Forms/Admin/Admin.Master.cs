using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWelcomeMessage();
            }
        }
        private void LoadWelcomeMessage()
        {
            if (Session["UserId"] == null)
            {
                lblAdminName.Text = "Welcome, Admin!";
                return;
            }

            int userId = (int)Session["UserId"];

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"SELECT p.FirstName, p.LastName
                                 FROM Admins p
                                 INNER JOIN User_ u ON p.UserId = u.UserId
                                 WHERE u.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            lblAdminName.Text = $"Welcome, {firstName} {lastName}!";
                        }
                        else
                        {
                            lblAdminName.Text = "Welcome!";
                        }
                    }
                }
            }
        }
    }
}