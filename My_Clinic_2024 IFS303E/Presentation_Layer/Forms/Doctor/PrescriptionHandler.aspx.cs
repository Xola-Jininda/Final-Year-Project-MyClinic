using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class PrescriptionHandler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                try
                {
                    var jsonString = new System.IO.StreamReader(Request.InputStream).ReadToEnd();
                    System.Diagnostics.Debug.WriteLine("Received JSON: " + jsonString); // Log incoming JSON
                    dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonString);

                    string patientName = data.patientName;
                    int patientID = data.patientID;
                    string medicationName = data.medicationName;
                    string dosage = data.dosage;
                    string instructions = data.instructions;
                    DateTime prescriptionDate = DateTime.Now; // Current date for prescription

                    // Parse collection date from JSON
                    DateTime collectionDate;
                    if (!DateTime.TryParse(data.collectionDate.ToString(), out collectionDate))
                    {
                        throw new ArgumentException("Invalid collection date format.");
                    }

                    bool success = SavePrescription(patientName, medicationName, dosage, instructions, prescriptionDate, collectionDate);

                    Response.ContentType = "application/json";
                    Response.Write("{\"status\":\"" + (success ? "success" : "error") + "\"}");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                    Response.ContentType = "application/json";
                    Response.Write("{\"status\":\"error\",\"message\":\"" + ex.Message + "\",\"stacktrace\":\"" + ex.StackTrace + "\"}");
                }
                finally
                {
                    Response.End();
                }
            }
        }


        private bool SavePrescription(string patientName, string medicationName, string dosage, string instructions, DateTime prescriptionDate, DateTime collectionDate)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    string query = @"INSERT INTO Prescription (PatientName, MedicationName, Dosage, Instructions, PrescriptionDate, CollectionDate, Notes)
                             VALUES (@PatientName, @MedicationName, @Dosage, @Instructions, @PrescriptionDate, @CollectionDate, @Notes)";
                    using (SqlCommand cmd = new SqlCommand(query, connection, transaction))
                    {
                        cmd.Parameters.AddWithValue("@PatientName", patientName);
                        cmd.Parameters.AddWithValue("@MedicationName", medicationName);
                        cmd.Parameters.AddWithValue("@Dosage", dosage);
                        cmd.Parameters.AddWithValue("@Instructions", instructions);
                        cmd.Parameters.AddWithValue("@PrescriptionDate", prescriptionDate);
                        cmd.Parameters.AddWithValue("@CollectionDate", collectionDate);
                        cmd.Parameters.AddWithValue("@Notes", instructions);

                        try
                        {
                            int rowsAffected = cmd.ExecuteNonQuery();
                            transaction.Commit();
                            return rowsAffected > 0;
                        }
                        catch (Exception ex)
                        {
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
