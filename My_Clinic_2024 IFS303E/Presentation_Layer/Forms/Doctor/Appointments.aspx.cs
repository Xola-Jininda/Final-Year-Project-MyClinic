using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class Appointments : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAppointments();
            }
        }
        private void BindAppointments()
        {
            string specialization = GetDoctorSpecialization();

            if (string.IsNullOrEmpty(specialization))
            {
               // lblAppointmentCount.Text = "Unable to retrieve doctor specialization.";
                GridViewAppointments.DataSource = null;
                GridViewAppointments.DataBind();
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (1000) [AppointmentID], [PatientID], [DoctorID], [AdminID], [AppointmentDate], [AppointmentTime], [Status], 
                                        [PatientName], [PhoneNumber], [Email], [Gender], [Category]
                                 FROM [MyClinic].[dbo].[Appointments]
                                 WHERE [Category] = @Specialization";

                using (SqlCommand cmd = new SqlCommand(query, connection))
                {
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    GridViewAppointments.DataSource = dt;
                    GridViewAppointments.DataBind();

                    string countQuery = @"SELECT COUNT(*) FROM [MyClinic].[dbo].[Appointments] WHERE [Category] = @Specialization";
                    using (SqlCommand countCmd = new SqlCommand(countQuery, connection))
                    {
                        countCmd.Parameters.AddWithValue("@Specialization", specialization);
                        connection.Open();
                        int appointmentCount = (int)countCmd.ExecuteScalar();
                        connection.Close();

                        //lblAppointmentCount.Text = appointmentCount.ToString();
                    }
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