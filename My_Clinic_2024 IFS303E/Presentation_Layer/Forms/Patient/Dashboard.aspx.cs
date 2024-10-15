using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Graph;
using Microsoft.Graph.Models;
using Microsoft.Identity.Client;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class DSH : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Presentation_Layer/Forms/Patient/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAppointments();
            }
        }

        private void LoadAppointments()
        {
            int userId = (int)Session["UserId"];
            DateTime today = DateTime.Now.Date;

            DataTable upcomingAppointments = GetAppointments(userId, today, isUpcoming: true);
            UpcomingAppointmentsGridView.DataSource = upcomingAppointments;
            UpcomingAppointmentsGridView.DataBind();

            DataTable pastAppointments = GetAppointments(userId, today, isUpcoming: false);
            PastAppointmentsGridView.DataSource = pastAppointments;
            PastAppointmentsGridView.DataBind();
        }

        private DataTable GetAppointments(int userId, DateTime date, bool isUpcoming)
        {
            DataTable dataTable = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = isUpcoming ?
                    "SELECT * FROM Appointments WHERE PatientId = @PatientId AND AppointmentDate >= @Date ORDER BY AppointmentDate, AppointmentTime" :
                    "SELECT * FROM Appointments WHERE PatientId = @PatientId AND AppointmentDate < @Date ORDER BY AppointmentDate DESC, AppointmentTime DESC";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@PatientId", userId);
                command.Parameters.AddWithValue("@Date", date);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                dataAdapter.Fill(dataTable);
            }

            return dataTable;
        }

        protected void UpcomingAppointmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Manage")
            {
                int appointmentID = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"~/Presentation_Layer/Forms/Patient/Book.aspx?AppointmentID={appointmentID}");
            }
            else if (e.CommandName == "CancelAppointment")
            {
                int appointmentID = Convert.ToInt32(e.CommandArgument);
                bool isCancelled = CancelAppointment(appointmentID);
                LoadAppointments();

                string message = isCancelled ? "Appointment has been canceled." : "Failed to cancel the appointment.";
                string alertType = isCancelled ? "success" : "error";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "SweetAlert",
                    $"Swal.fire('Success!', '{message}', '{alertType}');", true);
            }
            //else if (e.CommandName == "JoinVirtualMeeting")
            //{
            //    //int appointmentID = Convert.ToInt32(e.CommandArgument);
            //    //string meetingUrl = await CreateTeamsMeeting(appointmentID);

            //    //if (!string.IsNullOrEmpty(meetingUrl))
            //    //{
            //    //    ScriptManager.RegisterStartupScript(this, GetType(), "MeetingAlert",
            //    //        $"Swal.fire({{ title: 'Meeting Created!', text: 'Join your meeting now?', icon: 'success', showCancelButton: true, confirmButtonText: 'Join', cancelButtonText: 'Cancel' }}).then((result) => {{ if (result.isConfirmed) {{ window.open('{meetingUrl}', '_blank'); }} }});", true);
            //    //}
            //    //else
            //    //{
            //    //    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
            //    //        "Swal.fire('Error!', 'Unable to create the meeting. Please try again later.', 'error');", true);
            //    //}
            //    if (e.CommandName == "JoinVirtualMeeting")
            //    {
            //        int appointmentID = Convert.ToInt32(e.CommandArgument);

            //        // Use a pre-generated or manually created meeting link
            //        string meetingUrl = "https://teams.microsoft.com"; // Replace with actual URL

            //        ScriptManager.RegisterStartupScript(this, GetType(), "MeetingAlert",
            //            $"Swal.fire({{ title: 'Meeting Ready!', text: 'Join your meeting now?', icon: 'success', showCancelButton: true, confirmButtonText: 'Join', cancelButtonText: 'Cancel' }}).then((result) => {{ if (result.isConfirmed) {{ window.open('{meetingUrl}', '_blank'); }} }});", true);
            //    }
            //}
        }


        // Method to create the Teams meeting via Microsoft Graph API

        private async Task<string> CreateTeamsMeeting(int appointmentID)
        {
            var tenantId = ConfigurationManager.AppSettings["TenantId"];
            var clientId = ConfigurationManager.AppSettings["ClientId"];
            var clientSecret = ConfigurationManager.AppSettings["ClientSecret"];

            try
            {
                var confidentialClient = ConfidentialClientApplicationBuilder
                    .Create(clientId)
                    .WithClientSecret(clientSecret)
                    .WithAuthority(new Uri($"https://login.microsoftonline.com/{tenantId}/v2.0"))
                    .Build();

                var authResult = await confidentialClient
                    .AcquireTokenForClient(new[] { "https://graph.microsoft.com/.default" })
                    .ExecuteAsync();

                var accessToken = authResult.AccessToken;

                using (var httpClient = new HttpClient())
                {
                    httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                    httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    var onlineMeeting = new
                    {
                        startDateTime = DateTimeOffset.UtcNow.AddMinutes(5).ToString("o"),
                        endDateTime = DateTimeOffset.UtcNow.AddHours(1).ToString("o"),
                        subject = "Doctor Appointment"
                    };

                    var content = new StringContent(JsonConvert.SerializeObject(onlineMeeting), Encoding.UTF8, "application/json");

                    var response = await httpClient.PostAsync("https://graph.microsoft.com/v1.0/me/onlineMeetings", content);

                    if (!response.IsSuccessStatusCode)
                    {
                        var errorContent = await response.Content.ReadAsStringAsync();
                        System.Diagnostics.Debug.WriteLine($"Error response from API: {errorContent}");
                        return string.Empty;
                    }

                    var responseBody = await response.Content.ReadAsStringAsync();
                    dynamic result = JsonConvert.DeserializeObject(responseBody);

                    return result?.joinWebUrl?.ToString() ?? string.Empty;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Exception creating Teams meeting: {ex.Message}");
                return string.Empty;
            }
        }

        private bool CancelAppointment(int appointmentID)
        {
            bool isCanceled = false;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Appointments WHERE AppointmentID = @AppointmentID";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@AppointmentID", appointmentID);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        // If rowsAffected is 1, the appointment was successfully canceled.
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

        protected void UpcomingAppointmentsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
