using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAppointments();

                // Get the doctor's specialization from a method, then pass it to CountAllAppointments
                string specialization = GetDoctorSpecialization();
                if (!string.IsNullOrEmpty(specialization))
                {
                    CountAllAppointments(specialization);
                    CountPastAppointments(specialization);
                }
                else
                {
                   // lblTotalAppointmentsCount.Text = "Fill in your profile.";
                }
            }
        }

        private void BindAppointments()
        {
            string specialization = GetDoctorSpecialization();

            if (string.IsNullOrEmpty(specialization))
            {
               
                string script = @"<script type='text/javascript'>
                            Swal.fire({
                                icon: 'warning',
                                title: 'Missing Specialization',
                                text: 'Please complete your profile details!',
                                confirmButtonText: 'OK',
                                allowOutsideClick: false
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location = 'ProfileSettings.aspx';
                                }
                            });
                          </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script);
                GridViewAppointments.DataSource = null;
                GridViewAppointments.DataBind();
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (1000) [AppointmentID], [PatientID], [DoctorID], [AdminID], 
                            [AppointmentDate], [AppointmentTime], [Status], [PatientName], 
                            [PhoneNumber], [Email], [Gender], [Category]
                 FROM [MyClinic].[dbo].[Appointments]
                 WHERE [Category] = @Specialization 
                   AND [AppointmentDate] >= CAST(GETDATE() AS DATE)";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    GridViewAppointments.DataSource = dt;
                    GridViewAppointments.DataBind();

                    string countQuery = @"SELECT COUNT(*) 
                          FROM [MyClinic].[dbo].[Appointments] 
                          WHERE [Category] = @Specialization 
                            AND [AppointmentDate] >= CAST(GETDATE() AS DATE)";
                    using (SqlCommand countCmd = new SqlCommand(countQuery, connection))
                    {
                        countCmd.Parameters.AddWithValue("@Specialization", specialization);
                        connection.Open();
                        int appointmentCount = (int)countCmd.ExecuteScalar();
                        connection.Close();

                        lblAppointmentCount.Text = appointmentCount.ToString();
                    }
                }
            }
        }

        private void CountAllAppointments(string specialization)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Update query to count appointments including today and filtered by specialization
                string query = @"SELECT COUNT(*) 
                         FROM [MyClinic].[dbo].[Appointments]
                         WHERE [Category] = @Specialization";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    
                    cmd.Parameters.AddWithValue("@Specialization", specialization);

                    connection.Open();
                    // Execute the query and get the total appointment count
                    int totalAppointmentCount = (int)cmd.ExecuteScalar();
                    connection.Close();

                    // Display the total count in the label
                    lblTotalAppointmentsCount.Text = totalAppointmentCount.ToString();
                    lblPatients.Text = totalAppointmentCount.ToString();
                }
            }
        }
        private void CountPastAppointments(string specialization)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Update query to count appointments including today and filtered by specialization
                string query = @"SELECT COUNT(*) 
                         FROM [MyClinic].[dbo].[Appointments]
                         WHERE [Category] = @Specialization  
                         AND [AppointmentDate] < CAST(GETDATE() AS DATE)";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {

                    cmd.Parameters.AddWithValue("@Specialization", specialization);

                    connection.Open();
                    // Execute the query and get the total appointment count
                    int pastAppointmentCount = (int)cmd.ExecuteScalar();
                    connection.Close();

                    // Display the total count in the label
                    lblPastAppointments.Text = pastAppointmentCount.ToString();
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

        protected void GridViewAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelAppointment")
            {
                int appointmentID = Convert.ToInt32(e.CommandArgument);

                if (CancelAppointment(appointmentID))
                {
                    BindAppointments();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SweetAlert",
                        "Swal.fire('Success!', 'Appointment has been canceled.', 'success');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SweetAlert",
                        "Swal.fire('Error!', 'Failed to cancel the appointment.', 'error');", true);
                }
            }

            if (e.CommandName == "Prescribe")
            {
                int appointmentID = Convert.ToInt32(e.CommandArgument);
                // Redirect to the booking form with the appointment ID as a query string
                Response.Redirect($"~/Presentation_Layer/Forms/Doctor/Prescription.aspx?AppointmentID={appointmentID}");
            }
        }
        protected void GridViewAppointments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get the AppointmentDate value from the current row
                DateTime appointmentDate = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "AppointmentDate"));

                // Find the prescribe button in the current row
                Button btnPrescribe = (Button)e.Row.FindControl("btnPrescribe");

                // Check if the appointment date is in the future
                if (appointmentDate > DateTime.Today)
                {
                    // Disable the prescribe button and change its appearance
                    btnPrescribe.Enabled = false;
                    btnPrescribe.CssClass += " disabled";
                }
            }
        }

        private int GetDoctorID()
        {
            int doctorID = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            if (Session["UserId"] != null)
            {
                int userID = (int)Session["UserId"];

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT DoctorID FROM Doctors WHERE UserId = @UserID";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        connection.Open();
                        object result = cmd.ExecuteScalar();
                        connection.Close();

                        if (result != null)
                        {
                            doctorID = Convert.ToInt32(result);
                        }
                    }
                }
            }

            return doctorID;
        }


        private int GetPatientID(int appointmentID)
        {
            int patientID = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT PatientID FROM Appointments WHERE AppointmentID = @AppointmentID";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@AppointmentID", appointmentID);
                    connection.Open();
                    object result = cmd.ExecuteScalar();
                    connection.Close();

                    if (result != null)
                    {
                        patientID = Convert.ToInt32(result);
                    }
                }
            }

            return patientID;
        }
        private string GetPatientName(int appointmentID)
        {
            string patientName = "";
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT PatientName FROM Appointments WHERE AppointmentID = @AppointmentID";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@AppointmentID", appointmentID);
                    connection.Open();
                    object result = cmd.ExecuteScalar();
                    connection.Close();

                    if (result != null)
                    {
                        patientName = result.ToString();
                    }
                }
            }

            return patientName;
        }



        private bool CancelAppointment(int appointmentID)
        {
            bool isCanceled = false;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM [MyClinic].[dbo].[Appointments] WHERE [AppointmentID] = @AppointmentID";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@AppointmentID", appointmentID);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        isCanceled = (rowsAffected > 0);
                    }
                }
            }
            catch (SqlException ex)
            {
                // Log the error (ex.Message)
                // Optionally, notify the user of the error via a SweetAlert or other method
            }

            return isCanceled;
        }
    }
}
