using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor
{
    public partial class ProfileSettings : System.Web.UI.Page
    {
        private string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSpecializations();  // Load specializations into dropdown
                LoadDoctorProfile();    // Load the doctor's profile
            }
        }

        // Load specializations from the database
        private void LoadSpecializations()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT SpecialityID, SpecialityName FROM Specialities";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            SpecializationDropDownList.DataSource = reader;
                            SpecializationDropDownList.DataTextField = "SpecialityName"; // Display name
                            SpecializationDropDownList.DataValueField = "SpecialityName"; // Use the name as value
                            SpecializationDropDownList.DataBind();
                        }
                    }

                    // Add a default "Select Specialization" item at the beginning
                    SpecializationDropDownList.Items.Insert(0, new ListItem("-- Select Specialization --", ""));
                }
                catch (SqlException ex)
                {
                    MessageLabel.Text = "Error loading specializations: " + ex.Message;
                    MessageLabel.CssClass = "error";
                }
            }
        }

        // Load the doctor's profile
        private void LoadDoctorProfile()
        {
            if (Session["UserId"] == null)
            {
                MessageLabel.Text = "User not logged in.";
                MessageLabel.CssClass = "error";
                return;
            }

            int userId = (int)Session["UserId"];

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT d.FirstName, d.LastName, d.Specialty, d.PhoneNumber, d.Email, 
                         d.Address, d.City, d.Province, d.ZipCode, d.Country
                         FROM Doctors d
                         WHERE d.UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                FirstNameTextBox.Text = reader["FirstName"].ToString();
                                LastNameTextBox.Text = reader["LastName"].ToString();

                                // Check if the specialization exists in the dropdown before selecting
                                if (SpecializationDropDownList.Items.FindByValue(reader["Specialty"].ToString()) != null)
                                {
                                    SpecializationDropDownList.SelectedValue = reader["Specialty"].ToString();
                                }

                                PhoneNumberTextBox.Text = reader["PhoneNumber"].ToString();
                                EmailTextBox.Text = reader["Email"].ToString();
                                ClinicAddressTextBox.Text = reader["Address"].ToString();
                                ClinicCityTextBox.Text = reader["City"].ToString();
                                ClinicProvinceTextBox.Text = reader["Province"].ToString();
                                ClinicZipCodeTextBox.Text = reader["ZipCode"].ToString();
                                ClinicCountryTextBox.Text = reader["Country"].ToString();
                            }
                            else
                            {
                                MessageLabel.Text = "Doctor profile not found. Please fill in your details.";
                                MessageLabel.CssClass = "error";
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    MessageLabel.Text = "Error loading profile: " + ex.Message;
                    MessageLabel.CssClass = "error";
                }
            }
        }

        // Save the doctor's profile
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                MessageLabel.Text = "User not logged in.";
                MessageLabel.CssClass = "error";
                return;
            }

            int userId = (int)Session["UserId"];
            string selectedSpecialization = SpecializationDropDownList.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Check if the doctor profile exists
                    string checkQuery = @"SELECT COUNT(*) FROM Doctors WHERE UserId = @UserId";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@UserId", userId);
                        int count = (int)checkCmd.ExecuteScalar();

                        string query;

                        if (count > 0)
                        {
                            // Update existing profile
                            query = @"UPDATE Doctors
                                 SET FirstName = @FirstName, LastName = @LastName, Specialty = @Specialty, 
                                     PhoneNumber = @PhoneNumber, Email = @Email, Address = @Address, 
                                     City = @City, Province = @Province, ZipCode = @ZipCode, 
                                     Country = @Country
                                 WHERE UserId = @UserId";
                        }
                        else
                        {
                            // Insert new profile
                            query = @"INSERT INTO Doctors (UserId, FirstName, LastName, Specialty, PhoneNumber, Email, Address, City, Province, ZipCode, Country)
                                  VALUES (@UserId, @FirstName, @LastName, @Specialty, @PhoneNumber, @Email, @Address, @City, @Province, @ZipCode, @Country)";
                        }

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text);
                            cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text);
                            cmd.Parameters.AddWithValue("@Specialty", selectedSpecialization);  // Use the dropdown value
                            cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumberTextBox.Text);
                            cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text);
                            cmd.Parameters.AddWithValue("@Address", ClinicAddressTextBox.Text);
                            cmd.Parameters.AddWithValue("@City", ClinicCityTextBox.Text);
                            cmd.Parameters.AddWithValue("@Province", ClinicProvinceTextBox.Text);
                            cmd.Parameters.AddWithValue("@ZipCode", ClinicZipCodeTextBox.Text);
                            cmd.Parameters.AddWithValue("@Country", ClinicCountryTextBox.Text);
                            cmd.Parameters.AddWithValue("@UserId", userId);

                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                MessageLabel.Text = "Profile updated successfully.";
                                MessageLabel.CssClass = "success";
                            }
                            else
                            {
                                MessageLabel.Text = "No changes were made.";
                                MessageLabel.CssClass = "error";
                            }
                        }
                    }
                }
                catch (SqlException ex)
                {
                    MessageLabel.Text = "Error saving profile: " + ex.Message;
                    MessageLabel.CssClass = "error";
                }
            }
        }
    }
}
