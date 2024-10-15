using System;
using System.Configuration;
using System.Data.SqlClient;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms
{
    public partial class Speciality : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddSpeciality_Click(object sender, EventArgs e)
        {
            // Get the selected speciality from the dropdown
            string selectedSpeciality = ddlSpeciality.SelectedItem.Value;

            // Ensure a speciality is selected
            if (string.IsNullOrEmpty(selectedSpeciality))
            {
                lblMessage.Text = "Please select a speciality.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Query to check if the speciality already exists
                string checkQuery = "SELECT COUNT(*) FROM Specialities WHERE SpecialityName = @SpecialityName";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@SpecialityName", selectedSpeciality);

                    try
                    {
                        conn.Open();
                        int specialityCount = (int)checkCmd.ExecuteScalar();

                        if (specialityCount > 0)
                        {
                            lblMessage.Text = "Speciality already exists!";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            // Insert the speciality if it doesn't exist
                            string insertQuery = "INSERT INTO Specialities (SpecialityName) VALUES (@SpecialityName)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@SpecialityName", selectedSpeciality);
                                int rowsAffected = insertCmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    lblMessage.Text = "Speciality added successfully!";
                                    lblMessage.ForeColor = System.Drawing.Color.Green;
                                }
                                else
                                {
                                    lblMessage.Text = "Failed to add speciality.";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Unecpected error occured, please try again later";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}
