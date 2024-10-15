using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Paramedics
{
    public partial class Completed : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCompletedRequests();
            }
        }
        private void LoadCompletedRequests()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT RequestID, EmergencyDescription, Location, IsConscious, PatientName, PatientAge, " +
                               "ConditionDescription, RequestDate, Status " +
                               "FROM AmbulanceRequests WHERE Status = 'Completed'"; // Fetch only completed requests

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                conn.Open();
                adapter.Fill(dt);
                conn.Close();

                CompletedRequestsListView.DataSource = dt;
                CompletedRequestsListView.DataBind();
            }
        }
    }
}