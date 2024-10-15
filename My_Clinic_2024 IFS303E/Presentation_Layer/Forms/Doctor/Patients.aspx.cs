using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class Patients : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPatients();
            }
        }
        protected void GridViewAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelAppointment")
            {
                int appointmentId = Convert.ToInt32(e.CommandArgument);
                bool success = CancelAppointment(appointmentId);
                ShowAlert(success);
            }
        }

        private bool CancelAppointment(int appointmentId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM [MyClinic].[dbo].[Appointments] WHERE [AppointmentID] = @AppointmentID";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@AppointmentID", appointmentId);
                    connection.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    connection.Close();

                    return rowsAffected > 0; // Return true if deletion was successful
                }
            }
        }

        private void ShowAlert(bool success)
        {
            // Register the SweetAlert script to display success or failure message
            string message = success ? "Appointment cancelled successfully!" : "Failed to cancel appointment. Please try again.";
            string script = $"<script>swal('{(success ? "Success!" : "Error!")}', '{message}', '{(success ? "success" : "error")}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, false);
        }
        private void BindPatients()
        {
            string specialization = GetDoctorSpecialization();

            if (string.IsNullOrEmpty(specialization))
            {
                GridViewAppointments.DataSource = null;
                GridViewAppointments.DataBind();
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Adjust the query to select only past appointments and group by patient details
                string query = @"
                    SELECT 
                        [PatientID], 
                        LTRIM(RTRIM([PatientName])) AS PatientName, 
                        LTRIM(RTRIM([PhoneNumber])) AS PhoneNumber, 
                        LTRIM(RTRIM([Email])) AS Email, 
                        [Gender], 
                        COUNT([AppointmentID]) AS AppointmentCount
                    FROM 
                        [MyClinic].[dbo].[Appointments]
                    WHERE 
                        [Category] = @Specialization
                        AND [AppointmentDate] < CAST(GETDATE() AS DATE)
                    GROUP BY 
                        [PatientID], 
                        LTRIM(RTRIM([PatientName])), 
                        LTRIM(RTRIM([PhoneNumber])), 
                        LTRIM(RTRIM([Email])), 
                        [Gender]";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    GridViewAppointments.DataSource = dt;
                    GridViewAppointments.DataBind();
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
