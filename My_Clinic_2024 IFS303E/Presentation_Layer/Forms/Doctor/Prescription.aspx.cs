using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class Prescription : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the AppointmentID from the query string
                string appointmentIDStr = Request.QueryString["AppointmentID"];
                if (!string.IsNullOrEmpty(appointmentIDStr) && int.TryParse(appointmentIDStr, out int appointmentID))
                {
                    txtAppointmentID.Value = appointmentIDStr; // Store appointment ID in a hidden field
                    string patientName = GetPatientName(appointmentID); // Retrieve patient name
                    if (!string.IsNullOrEmpty(patientName))
                    {
                        txtPatientName.Text = patientName; // Set patient name in the TextBox
                    }
                }
            }

            if (IsPostBack)
                return;
        }

        protected void SubmitPrescription_Click(object sender, EventArgs e)
        {

            // Optionally show a success message or redirect
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {

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

        protected void btnPrescribe_Click(object sender, EventArgs e)
        {
            // Retrieve values from the form fields
            string patientName = txtPatientName.Text.Trim();
            string medicationName = txtMedicationName.Text.Trim();
            string dosage = txtDosage.SelectedItem?.Text;
            string instructions = txtDuration.SelectedItem?.Text;
            DateTime prescriptionDate = DateTime.Now;
            DateTime collectionDate;

            // Validation checks

            // Check if patient name is provided
            if (string.IsNullOrEmpty(patientName))
            {
                ShowAlert("Error", "Patient name is required.", "error");
                return;
            }

            // Check if medication name is provided
            if (string.IsNullOrEmpty(medicationName))
            {
                ShowAlert("Error", "Medication name is required.", "error");
                return;
            }

            // Check if dosage is selected
            if (txtDosage.SelectedIndex == 0 || string.IsNullOrEmpty(dosage)) // Assuming the first item is a placeholder
            {
                ShowAlert("Error", "Please select a dosage.", "error");
                return;
            }

            // Check if duration/instructions are selected
            if (txtDuration.SelectedIndex == 0 || string.IsNullOrEmpty(instructions)) // Assuming the first item is a placeholder
            {
                ShowAlert("Error", "Please select a duration/instructions.", "error");
                return;
            }

            // Check if collection date is valid
            if (!DateTime.TryParse(txtCollectionDate.Text, out collectionDate))
            {
                ShowAlert("Error", "Invalid collection date.", "error");
                return;
            }

            // Ensure collection date is not in the past
            if (collectionDate.Date < DateTime.Now.Date)
            {
                ShowAlert("Error", "Collection date cannot be in the past.", "error");
                return;
            }

            // Ensure collection date is not a weekend
            if (collectionDate.DayOfWeek == DayOfWeek.Saturday || collectionDate.DayOfWeek == DayOfWeek.Sunday)
            {
                ShowAlert("Error", "Collection date cannot be on a weekend.", "error");
                return;
            }

            // Call the SavePrescription method to insert the data into the database
            bool isSuccess = SavePrescription(patientName, medicationName, dosage, instructions, prescriptionDate, collectionDate);

            // Use SweetAlert to notify the user about the outcome
            if (isSuccess)
            {
                // Show success message and redirect to Dashboard.aspx on OK
                ShowAlert("Success", "Prescription saved successfully!", "success", "Dashboard.aspx");
            }
            else
            {
                // Show error message
                ShowAlert("Error", "Failed to save prescription.", "error");
            }
        }

        private void ShowAlert(string title, string message, string icon, string redirectUrl = null)
        {
            string script = $"Swal.fire({{ title: '{title}', text: '{message}', icon: '{icon}', timer: 3000, showConfirmButton: false }}).then(function() {{ ";

            if (!string.IsNullOrEmpty(redirectUrl))
            {
                script += $"window.location = '{redirectUrl}'; ";
            }

            script += "});";

            ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
        }


        private bool SavePrescription(string patientName, string medicationName, string dosage, string instructions, DateTime prescriptionDate, DateTime collectionDate)
        {
            // Get the connection string from the configuration file
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            // Establish a connection to the database
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Begin a transaction to ensure data integrity
                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    // Define the SQL query to insert data into the dbo_Prescriptions table
                    string query = @"
                INSERT INTO dbo_Prescriptions (PatientFullName, MedicationName, Dosage, Notes, PrescriptionDate, CollectionDate, Status)
                VALUES (@PatientFullName, @MedicationName, @Dosage, @Notes, @PrescriptionDate, @CollectionDate, @Status)";

                    using (SqlCommand cmd = new SqlCommand(query, connection, transaction))
                    {
                        // Add parameters to the SQL command to prevent SQL injection
                        cmd.Parameters.AddWithValue("@PatientFullName", patientName);
                        cmd.Parameters.AddWithValue("@MedicationName", medicationName);
                        cmd.Parameters.AddWithValue("@Dosage", dosage);
                        cmd.Parameters.AddWithValue("@Notes", string.IsNullOrEmpty(instructions) ? DBNull.Value : (object)instructions);
                        cmd.Parameters.AddWithValue("@PrescriptionDate", prescriptionDate);
                        cmd.Parameters.AddWithValue("@CollectionDate", collectionDate);
                        cmd.Parameters.AddWithValue("@Status", "Pending"); // Default status set to 'Pending'

                        try
                        {
                            // Execute the command and commit the transaction if successful
                            int rowsAffected = cmd.ExecuteNonQuery();
                            transaction.Commit();
                            return rowsAffected > 0; // Return true if insertion is successful
                        }
                        catch (Exception ex)
                        {
                            // Roll back the transaction if an error occurs and log the error
                            transaction.Rollback();
                            System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
                            return false;
                        }
                    }
                }
            }
        }

    }
}