using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class RequestAmbulance : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        private bool isSpeechEnabled = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string location = Request.Form["hiddenLocation"];
                if (!string.IsNullOrEmpty(location))
                {
                    LocationTextBox.Text = location;
                }
            }
        }

        protected void SubmitQuizButton_Click(object sender, EventArgs e)
        {
            // Retrieve values from the text boxes and radio button lists
            string emergencyDescription = EmergencyDescriptionTextBox.Text.Trim();
            string location = LocationTextBox.Text.Trim();
            string isConscious = ConsciousBreathingList.SelectedValue;
            string patientName = txtName.Text.Trim();
            string patientAge = AgeTextBox.Text.Trim();
            string hasVisibleBleeding = VisibleBleedingList.SelectedValue;
            string allergies = AllergiesDropList.SelectedValue;
            string conditionDescription = ConditionDescriptionTextBox.Text.Trim();
            string isLifeThreatening = UrgencyList.SelectedValue;
            DateTime requestDate = DateTime.Now; // Current date and time

            // Validate required fields
            if (string.IsNullOrEmpty(emergencyDescription) || string.IsNullOrEmpty(location) || string.IsNullOrEmpty(patientName) || string.IsNullOrEmpty(patientAge))
            {
                // Use SweetAlert for validation error
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Error', 'Please fill out all required fields.', 'warning');", true);
                return;
            }

            // Validate numeric input for age
            if (!int.TryParse(patientAge, out int parsedAge))
            {
                // Use SweetAlert for numeric validation error
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Error', 'Please enter a valid numeric age.', 'warning');", true);
                return;
            }

            // Store form data in Session (for later use if needed)
            Session["EmergencyDescription"] = emergencyDescription;
            Session["Location"] = location;
            Session["IsConscious"] = isConscious;
            Session["PatientName"] = patientName;
            Session["PatientAge"] = parsedAge.ToString();
            Session["HasVisibleBleeding"] = hasVisibleBleeding;
            Session["Allergies"] = allergies;
            Session["ConditionDescription"] = conditionDescription;
            Session["IsLifeThreatening"] = isLifeThreatening;
            Session["RequestDate"] = requestDate;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO AmbulanceRequests 
                        (EmergencyDescription, Location, IsConscious, PatientName, PatientAge, HasVisibleBleeding, 
                         Allergies, ConditionDescription, IsLifeThreatening, RequestDate) 
                        VALUES 
                        (@EmergencyDescription, @Location, @IsConscious, @PatientName, @PatientAge, 
                         @HasVisibleBleeding, @Allergies, @ConditionDescription, @IsLifeThreatening, @RequestDate)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmergencyDescription", emergencyDescription);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@IsConscious", isConscious);
                cmd.Parameters.AddWithValue("@PatientName", patientName);
                cmd.Parameters.AddWithValue("@PatientAge", parsedAge);
                cmd.Parameters.AddWithValue("@HasVisibleBleeding", hasVisibleBleeding);
                cmd.Parameters.AddWithValue("@Allergies", allergies);
                cmd.Parameters.AddWithValue("@ConditionDescription", conditionDescription);
                cmd.Parameters.AddWithValue("@IsLifeThreatening", isLifeThreatening);
                cmd.Parameters.AddWithValue("@RequestDate", requestDate);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    // Disable speech synthesis after submission
                    isSpeechEnabled = false;

                    // Display success message using SweetAlert and trigger voice message
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "Swal.fire('Success!', 'Ambulance request submitted successfully. Help is on the way!', 'success').then(() => { " +
                        "if (window.speechSynthesis) { " +
                        "var utterance = new SpeechSynthesisUtterance('Thank you, help is on the way.'); " +
                        "window.speechSynthesis.speak(utterance); " +
                        "} " +
                        "});", true);
                }
                catch (Exception ex)
                {
                    // Display the detailed error message using SweetAlert
                    string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes in the error message
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"Swal.fire('Error!', 'There was an error processing your request: {errorMessage}', 'error');", true);
                }

            }
        }

    }
}
