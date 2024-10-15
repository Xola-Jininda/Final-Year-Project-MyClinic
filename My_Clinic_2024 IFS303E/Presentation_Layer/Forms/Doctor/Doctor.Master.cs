using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class Doctor : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure the user is logged in and has a valid session
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    LoadDoctorName(userId);
                }
                else
                {
                    Response.Redirect("~/Login.aspx"); // Redirect if no valid session
                }
            }
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath);

            switch (currentPage)
            {
                case "Dashboard.aspx":
                    lnkOverview.CssClass += " active";
                    break;
                case "Appointments.aspx":
                    lnkAppointments.CssClass += " active";
                    break;
                case "Patients.aspx":
                    lnkPatients.CssClass += " active";
                    break;
                case "PastAppointments.aspx":
                    lnkPastAppointments.CssClass += " active";
                    break;
                case "Reports.aspx":
                    lnkReports.CssClass += " active";
                    break;
                case "ProfileSettings.aspx":
                    lnkProfileSettings.CssClass += " active";
                    break;
            }
        }
        private void LoadDoctorName(int userId)
        {
            string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True";
            string query = "SELECT FirstName, LastName FROM Doctors WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName = reader.IsDBNull(0) ? string.Empty : reader.GetString(0);
                            string lastName = reader.IsDBNull(1) ? string.Empty : reader.GetString(1);
                            lblDoctorName.Text = $"Dr. {firstName} {lastName}";
                        }
                        else
                        {
                            lblDoctorName.Text = "Dr. Unknown";
                        }
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}