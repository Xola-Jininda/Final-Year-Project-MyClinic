using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Paramedics
{
    public partial class Dash : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRequests();
                LoadRequestCounters(); // Load counters for the statuses
            }
        }
        // Method to load the counters for different statuses
        private void LoadRequestCounters()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Count for 'Requested' status
                string requestedQuery = "SELECT COUNT(*) FROM AmbulanceRequests WHERE Status = 'Requested'";
                SqlCommand requestedCmd = new SqlCommand(requestedQuery, conn);
                int requestedCount = (int)requestedCmd.ExecuteScalar();
                lblRequestedCount.Text = requestedCount.ToString();

                // Count for 'In Progress' status
                string inProgressQuery = "SELECT COUNT(*) FROM AmbulanceRequests WHERE Status = 'In Progress'";
                SqlCommand inProgressCmd = new SqlCommand(inProgressQuery, conn);
                int inProgressCount = (int)inProgressCmd.ExecuteScalar();
                lblInProgressCount.Text = inProgressCount.ToString();

                // Count for 'Completed' status
                string completedQuery = "SELECT COUNT(*) FROM AmbulanceRequests WHERE Status = 'Completed'";
                SqlCommand completedCmd = new SqlCommand(completedQuery, conn);
                int completedCount = (int)completedCmd.ExecuteScalar();
                lblCompletedCount.Text = completedCount.ToString();

                conn.Close();
            }
        }


        private void LoadRequests()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT RequestID, EmergencyDescription, Location, IsConscious, PatientName, PatientAge, " +
                               "ConditionDescription, RequestDate, Status, IsLifeThreatening " +
                               "FROM AmbulanceRequests WHERE Status IN ('Requested', 'In Progress')"; // Fetch requested and in-progress requests

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                conn.Open();
                adapter.Fill(dt);
                conn.Close();

                RequestsListView.DataSource = dt;
                RequestsListView.DataBind();
            }
        }

        protected void RequestsListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int requestId = Convert.ToInt32(e.CommandArgument);
                string currentStatus = GetCurrentStatus(requestId);

                // Determine the new status
                string newStatus = currentStatus == "Requested" ? "In Progress" : "Completed";

                // Update the status in the database
                UpdateStatus(requestId, newStatus);

                // Show SweetAlert notification after postback
                string alertMessage = newStatus == "Completed" ? "Emergency status has been completed!" : "Emergency status has been updated!";
                string script = $"swal('Success!', '{alertMessage}', 'success');";

                // Use ScriptManager to register the script block
                ScriptManager.RegisterStartupScript(this, this.GetType(), "UpdateStatus", script, true);

                // Reload requests and counters to reflect the new status
                LoadRequests();
                LoadRequestCounters();
            }
        }




        private string GetCurrentStatus(int requestId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Status FROM AmbulanceRequests WHERE RequestID = @RequestID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@RequestID", requestId);

                conn.Open();
                string status = cmd.ExecuteScalar()?.ToString();
                conn.Close();

                return status;
            }
        }

        private void UpdateStatus(int requestId, string newStatus)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE AmbulanceRequests SET Status = @Status WHERE RequestID = @RequestID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@RequestID", requestId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        protected string GetBackgroundClass(string isLifeThreatening)
        {
            return isLifeThreatening.Equals("Yes", StringComparison.OrdinalIgnoreCase) ? "highlight-emergency" : "normal";
        }


    }
}
