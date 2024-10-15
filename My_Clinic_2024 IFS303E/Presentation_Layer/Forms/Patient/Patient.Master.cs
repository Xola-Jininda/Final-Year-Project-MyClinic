using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class Patient : System.Web.UI.MasterPage
    {

        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWelcomeMessage();
            }

            string currentPage = System.IO.Path.GetFileName(Request.Path);

            switch (currentPage)
            {
                case "Dashboard.aspx":
                    DashLink.Attributes.Add("class", "selected");
                    break;
                case "Book.aspx":
                    BookLink.Attributes.Add("class", "selected");
                    break;
                case "DeliveryForm.aspx":
                    DeliveryLink.Attributes.Add("class", "selected");
                    break;
                case "Tracking.aspx":
                    TrackingLink.Attributes.Add("class", "selected");
                    break;
                case "RequestAmbulance.aspx":
                    AmbulanceLink.Attributes.Add("class", "selected");
                    break;
                case "ProfileSettings.aspx":
                    ProfileLink.Attributes.Add("class", "selected");
                    break;
                default:
                    break;
            }
        }

        private void LoadWelcomeMessage()
        {
            if (Session["UserId"] == null)
            {
                WelcomeMessage.Text = "Welcome, Guest!";
                return;
            }

            int userId = (int)Session["UserId"];

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"SELECT p.FirstName, p.LastName
                                 FROM Patients p
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
                            WelcomeMessage.Text = $"Welcome, {firstName} {lastName}!";
                        }
                        else
                        {
                            WelcomeMessage.Text = "Welcome!";
                        }
                    }
                }
            }
        }
        public string GetFullName()
        {
            if (Session["UserId"] == null)
                return "Guest";

            int userId = (int)Session["UserId"];
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"SELECT p.FirstName, p.LastName
                             FROM Patients p
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
                            return $"{firstName} {lastName}";
                        }
                    }
                }
            }
            return "Guest";
        }
    }
}