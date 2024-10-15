using My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class DeliveryForm : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EnsurePatientSessionData();
                LoadPrescriptions();
            }

        }

        private void EnsurePatientSessionData()
        {
            // Check if session variables are set
            if (Session["PatientFullName"] == null || Session["PatientAddress"] == null)
            {
                // Assuming UserId is stored in session upon login
                if (Session["UserId"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT p.FirstName, p.LastName, p.Address
                             FROM Patients p
                             WHERE p.UserId = @UserId";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            string fullName = $"{reader["FirstName"]} {reader["LastName"]}";
                            string address = reader["Address"].ToString();

                            // Store retrieved details in session
                            Session["PatientFullName"] = fullName;
                            Session["PatientAddress"] = address;
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        System.Diagnostics.Debug.WriteLine($"Error retrieving session data: {ex.Message}");
                    }
                }
            }
        }
        private void LoadPrescriptions()
        {
            // Get full name from MasterPage
            var masterPage = (Patient)Master;
            string patientFullName = masterPage.GetFullName();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT PrescriptionId, MedicationName, Dosage, Notes, CollectionDate
                         FROM dbo_Prescriptions
                         WHERE PatientFullName = @PatientFullName and Status = 'Pending' ";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@PatientFullName", patientFullName);
                SqlDataAdapter sda = new SqlDataAdapter(command);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                // Clear existing controls
                PrescriptionsPanel.Controls.Clear();

                foreach (DataRow row in dt.Rows)
                {
                    int prescriptionId = (int)row["PrescriptionId"];
                    string medicationName = row["MedicationName"].ToString();
                    string dosage = row["Dosage"].ToString();
                    string duration = row["Notes"].ToString();
                    DateTime collectionDate = (DateTime)row["CollectionDate"];

                    Panel prescriptionCard = new Panel
                    {
                        CssClass = "card mb-3",
                        Style =
                {
                    ["width"] = "18rem",
                    ["margin-right"] = "1rem"
                }
                    };

                    prescriptionCard.Controls.Add(new Literal
                    {
                        Text = $"<div class='card-body'><h5 class='card-title'>{medicationName}</h5><p class='card-text'>Dosage: {dosage}</p><p class='card-text'>Duration: {duration}</p><p class='card-text'>Collection Date: {collectionDate:dd/MM/yyyy}</p>"
                    });

                    Button requestDeliveryButton = new Button
                    {
                        Text = "Request Delivery",
                        CssClass = "btn btn-custom",
                        CommandArgument = prescriptionId.ToString(),
                        OnClientClick = $"requestDelivery({prescriptionId}, '{collectionDate:yyyy-MM-dd}'); return false;"
                    };


                    prescriptionCard.Controls.Add(requestDeliveryButton);
                    prescriptionCard.Controls.Add(new Literal { Text = "</div>" });

                    PrescriptionsPanel.Controls.Add(prescriptionCard);
                }

                // Add empty cards if there are no prescriptions
                if (dt.Rows.Count == 0)
                {
                    for (int i = 0; i < 3; i++)
                    {
                        Panel emptyCard = new Panel
                        {
                            CssClass = "card mb-3",
                            Style =
                    {
                        ["width"] = "18rem",
                        ["margin-right"] = "1rem"
                    }
                        };
                        emptyCard.Controls.Add(new Literal { Text = "<div class='card-body'><p>No prescriptions available for delivery.</p></div>" });
                        PrescriptionsPanel.Controls.Add(emptyCard);
                    }
                }
            }
        }
        [WebMethod]
        public static string StorePatientDetailsInSession(int prescriptionId)
        {
            try
            {
                // Assuming that patientFullName and address are stored in the session during profile loading
                string patientFullName = HttpContext.Current.Session["PatientFullName"]?.ToString();
                string patientAddress = HttpContext.Current.Session["PatientAddress"]?.ToString();

                // Check for null or empty values
                if (string.IsNullOrEmpty(patientFullName))
                {
                    System.Diagnostics.Debug.WriteLine("PatientFullName is not set in the session.");
                    return "Failure: PatientFullName not set";
                }

                if (string.IsNullOrEmpty(patientAddress))
                {
                    System.Diagnostics.Debug.WriteLine("PatientAddress is not set in the session.");
                    return "Failure: PatientAddress not set";
                }

                // Store the details in session (if not already done)
                HttpContext.Current.Session["CurrentPatientFullName"] = patientFullName;
                HttpContext.Current.Session["CurrentPatientAddress"] = patientAddress;

                return "Success";
            }
            catch (Exception ex)
            {
                // Log the error message
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
                return "Error";
            }
        }



        [WebMethod]
        public static string RequestDelivery(int prescriptionId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString))
                {
                    string query = "UPDATE dbo_Prescriptions SET Status = 'Requested' WHERE PrescriptionId = @PrescriptionId";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@PrescriptionId", prescriptionId);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Success" : "Failure";
                }
            }
            catch (Exception ex)
            {
                // Log the error message
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
                return "Error";
            }
        }

    }
}
