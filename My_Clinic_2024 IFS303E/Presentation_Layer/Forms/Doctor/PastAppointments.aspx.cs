using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class PastAppointments : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPastAppointments();
            }
        }

        private void BindPastAppointments()
        {
            string specialization = GetDoctorSpecialization();

            if (string.IsNullOrEmpty(specialization))
            {
                // Display a message if the specialization is not found
                // lblAppointmentCount.Text = "Unable to retrieve doctor specialization.";
                GridViewAppointments.DataSource = null;
                GridViewAppointments.DataBind();
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Adjust the query to select only past appointments
                string query = @"SELECT [AppointmentID], [PatientID], [DoctorID], [AdminID], [AppointmentDate], [AppointmentTime], [Status], 
                                        [PatientName], [PhoneNumber], [Email], [Gender], [Category]
                                 FROM [MyClinic].[dbo].[Appointments]
                                 WHERE [Category] = @Specialization
                                   AND [AppointmentDate] < CAST(GETDATE() AS DATE)";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    GridViewAppointments.DataSource = dt;
                    GridViewAppointments.DataBind();

                    // Update the appointment count label
                    //lblAppointmentCount.Text = $"Total Past Appointments: {dt.Rows.Count}";
                }
            }
        }

        private string GetDoctorSpecialization()
        {
            string specialization = string.Empty;

            if (Session["UserId"] != null)
            {
                int doctorId = (int)Session["UserId"];

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT [Specialty] FROM [MyClinic].[dbo].[Doctors] WHERE [UserId] = @DoctorID";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@DoctorID", doctorId);
                        connection.Open();
                        object result = cmd.ExecuteScalar();
                        connection.Close();

                        if (result != null)
                        {
                            specialization = result.ToString();
                        }
                    }
                }
            }

            return specialization;
        }
    }
}
