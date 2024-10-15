using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Globalization;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAppointments();
                LoadDoctorCount();
                LoadPatientCount();
                LoadAppointmentCount();
                LoadRevenueSum();
                LoadDeliveryCount();
                LoadActiveCount();
                LoadAmbulaceRequestCount();
            }
        }
        private void BindAppointments()
        {
            // Define the connection string (assuming it's defined elsewhere in your class)
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            // Define the query
            string query = @"SELECT TOP (1000) [AppointmentID], [PatientID], [DoctorID], [AdminID], 
                            [AppointmentDate], [AppointmentTime], [Status], [PatientName], 
                            [PhoneNumber], [Email], [Gender], [Category]
                     FROM [MyClinic].[dbo].[Appointments]
                     WHERE [AppointmentDate] >= CAST(GETDATE() AS DATE)";

            try
            {
                // Initialize connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Open the connection
                    connection.Open();

                    // Initialize SqlCommand
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Initialize SqlDataAdapter
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            // Fill DataTable
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            // Bind DataTable to GridView
                            GridView2.DataSource = dt;
                            GridView2.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                // Example: Console.WriteLine(ex.Message);
                // Consider showing a user-friendly message or logging the error
            }
        }

        private void LoadDoctorCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Doctors";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int doctorCount = (int)cmd.ExecuteScalar();
                lblDoctorCount.Text = doctorCount.ToString();
            }
        }

        private void LoadPatientCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Patients";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int patientCount = (int)cmd.ExecuteScalar();
                lblPatientCount.Text = patientCount.ToString();
            }
        }

        private void LoadAppointmentCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Appointments";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int appointmentCount = (int)cmd.ExecuteScalar();
                lblAppointmentCount.Text = appointmentCount.ToString();
            }
        }
        private void LoadRevenueSum()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT SUM(AmountPaid) FROM [MyClinic].[dbo].[Payment]";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                object result = cmd.ExecuteScalar();

                // Handle null case
                decimal totalRevenue = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
                lblRevenueSum.Text = totalRevenue.ToString("C", new CultureInfo("en-ZA")); 
            }
        }
        private void LoadDeliveryCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM [MyClinic].[dbo].[Payment] WHERE [Status] = 'Closed'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int closedOrderCount = (int)cmd.ExecuteScalar();
                lblDeliveryCount.Text = closedOrderCount.ToString();
            }
        }
        private void LoadActiveCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM [MyClinic].[dbo].[Payment] WHERE [Status] = 'Processing'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int activeOrderCount = (int)cmd.ExecuteScalar();
                lblActiveCount.Text = activeOrderCount.ToString();
            }
        }
        private void LoadAmbulaceRequestCount()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM AmbulanceRequests";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int appointmentCount = (int)cmd.ExecuteScalar();
                lblAmbulanceRequests.Text = appointmentCount.ToString();
            }
        }
    }
}