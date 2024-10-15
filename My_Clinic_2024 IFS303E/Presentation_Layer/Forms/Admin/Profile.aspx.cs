using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin
{
    public partial class Profile : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdminProfile();
            }
        }
        private void LoadAdminProfile()
        {
            if (Session["UserId"] == null)  // Changed from AdminId to UserId as UserId links both tables
            {
                MessageLabel.Text = "Admin not logged in.";
                MessageLabel.CssClass = "error";
                return;
            }

            int userId = (int)Session["UserId"]; // Changed from AdminId to UserId

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Query to pull data from both Admins and User_ tables using UserId
                string query = @"SELECT a.FirstName, a.LastName, a.Email, a.PhoneNumber, a.DOB, a.Address, a.City, a.Province, a.County, a.ZipCode, u.Username, u.Role_ 
                                 FROM Admins a
                                 JOIN User_ u ON a.UserId = u.UserId
                                 WHERE a.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);  // Use UserId in the query

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            FirstNameTextBox.Text = reader["FirstName"].ToString();
                            LastNameTextBox.Text = reader["LastName"].ToString();
                            EmailTextBox.Text = reader["Email"].ToString();
                            PhoneNumberTextBox.Text = reader["PhoneNumber"].ToString(); // Changed to PhoneNumber

                            DOBTextBox.Text = reader["DOB"].ToString();
                            AddressTextBox.Text = reader["Address"].ToString();
                            CityTextBox.Text = reader["City"].ToString();
                            ProvinceTextBox.Text = reader["Province"].ToString();
                            tBox.Text = reader["County"].ToString();
                            ZipCodeTextBox.Text = reader["ZipCode"].ToString();
                            //UsernameTextBox.Text = reader["Username"].ToString();  // Added Username from User_ table
                            //RoleTextBox.Text = reader["Role_"].ToString(); // Role comes from User_ table

                            // Set full name in session
                            string fullName = $"{reader["FirstName"]} {reader["LastName"]}";
                            Session["AdminFullName"] = fullName;
                        }
                        else
                        {
                            MessageLabel.Text = "Admin profile not found.";
                            MessageLabel.CssClass = "error";
                        }
                    }
                }
            }
        }


        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "NotLoggedIn",
                    "Swal.fire({ title: 'Error', text: 'Admin not logged in.', icon: 'error' });", true);
                return;
            }

            int userId = (int)Session["UserId"];

            // Check if the user is 10 years or older
            if (!IsValidDOB(DOBTextBox.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Underage",
                    "Swal.fire({ title: 'Underage', text: 'You must be 18 years or older.', icon: 'error' });", true);
                return;
            }
            // Validate required fields
            if (string.IsNullOrEmpty(FirstNameTextBox.Text) || string.IsNullOrEmpty(LastNameTextBox.Text) ||
                string.IsNullOrEmpty(EmailTextBox.Text) || string.IsNullOrEmpty(PhoneNumberTextBox.Text) )
                //string.IsNullOrEmpty(RoleTextBox.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "MissingFields",
                    "Swal.fire({ title: 'Incomplete Data', text: 'Please fill in all required fields.', icon: 'warning' });", true);
                return;
            }

            // Additional validations, e.g., email, mobile, etc.
            if (!IsValidEmail(EmailTextBox.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidEmail",
                    "Swal.fire({ title: 'Invalid Email', text: 'Please enter a valid email address.', icon: 'error' });", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if the admin profile exists in the Admins table
                string checkQuery = @"SELECT COUNT(*) FROM Admins WHERE UserId = @UserId";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@UserId", userId);
                    int count = (int)checkCmd.ExecuteScalar();

                    string query;

                    if (count > 0)
                    {
                        // Update the Admin profile
                        query = @"UPDATE Admins
                                  SET FirstName = @FirstName, LastName = @LastName, Email = @Email, 
                                      PhoneNumber = @PhoneNumber, DOB = @DOB, Address = @Address, City = @City, Province = @Province, County = @Country, ZipCode = @ZipCode
                                  WHERE UserId = @UserId";
                    }
                    else
                    {
                        // Insert a new Admin profile
                        query = @"INSERT INTO Admins (UserId, FirstName, LastName, Email, PhoneNumber, DOB, Address, City, Province, County, ZipCode)
                                  VALUES (@UserId, @FirstName, @LastName, @Email, @PhoneNumber, @DOB, @Address, @City, @Province, @Country, @ZipCode)";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text);
                        cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text);
                        cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text);
                        cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumberTextBox.Text); // Changed to PhoneNumber
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@DOB", DOBTextBox.Text);
                        cmd.Parameters.AddWithValue("@Address", AddressTextBox.Text);
                        cmd.Parameters.AddWithValue("@City", CityTextBox.Text);
                        cmd.Parameters.AddWithValue("@Province", ProvinceTextBox.Text);
                        cmd.Parameters.AddWithValue("@Country", tBox.Text);
                        cmd.Parameters.AddWithValue("@ZipCode", ZipCodeTextBox.Text);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            string fullName = $"{FirstNameTextBox.Text} {LastNameTextBox.Text}";
                            Session["AdminFullName"] = fullName;

                            ScriptManager.RegisterStartupScript(this, GetType(), "ProfileUpdated",
                                "Swal.fire({ title: 'Success', text: 'Profile updated successfully.', icon: 'success' });", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "NoChanges",
                                "Swal.fire({ title: 'No Changes', text: 'No changes were made to the profile.', icon: 'info' });", true);
                        }
                    }
                }
            }
        }
        private bool IsValidDOB(string dob)
        {
            if (DateTime.TryParse(dob, out DateTime dateOfBirth))
            {
                int age = DateTime.Today.Year - dateOfBirth.Year;
                if (dateOfBirth > DateTime.Today.AddYears(-age)) age--; // Adjust for leap years

                return age >= 18;
            }
            return false; // Invalid date format
        }

        // Helper function to validate email format
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}