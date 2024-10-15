using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class ProfileSettings : System.Web.UI.Page
    {
        private string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
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
                conn.Open();

                string query = @"SELECT p.FirstName, p.LastName, p.DateOfBirth, p.BloodGroup, p.Email, p.Mobile, 
                         p.Address, p.City, p.Province, p.ZipCode, p.Sex, p.Country
                         FROM Patients p
                         INNER JOIN User_ u ON p.UserId = u.UserId
                         WHERE u.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            FirstNameTextBox.Text = reader["FirstName"].ToString();
                            LastNameTextBox.Text = reader["LastName"].ToString();
                            DateOfBirthTextBox.Text = Convert.ToDateTime(reader["DateOfBirth"]).ToString("yyyy-MM-dd");
                            BloodGroupDropDownList.SelectedValue = reader["BloodGroup"].ToString();
                            EmailTextBox.Text = reader["Email"].ToString();
                            MobileTextBox.Text = reader["Mobile"].ToString();
                            AddressTextBox.Text = reader["Address"].ToString();
                            CityTextBox.Text = reader["City"].ToString();
                            ProvinceTextBox.Text = reader["Province"].ToString();
                            ZipCodeTextBox.Text = reader["ZipCode"].ToString();
                            CountryTextBox.Text = reader["Country"].ToString();
                            DropDownList1.SelectedValue = reader["Sex"].ToString();

                            // Set full name and address in session
                            string fullName = $"{reader["FirstName"]} {reader["LastName"]}";
                            Session["PatientFullName"] = fullName;
                            Session["PatientAddress"] = reader["Address"].ToString();
                        }
                        else
                        {
                            MessageLabel.Text = "User profile not found. Please fill in your details.";
                            MessageLabel.CssClass = "error";
                        }
                    }
                }
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["UserId"] == null)
            {
                // SweetAlert for user not logged in
                ScriptManager.RegisterStartupScript(this, GetType(), "NotLoggedIn",
                    "Swal.fire({ title: 'Error', text: 'User not logged in.', icon: 'error' });", true);
                return;
            }

            int userId = (int)Session["UserId"];

            // Validate required fields
            if (string.IsNullOrEmpty(FirstNameTextBox.Text) || string.IsNullOrEmpty(LastNameTextBox.Text) ||
                string.IsNullOrEmpty(DateOfBirthTextBox.Text) || string.IsNullOrEmpty(BloodGroupDropDownList.SelectedValue) ||
                string.IsNullOrEmpty(DropDownList1.SelectedValue) || string.IsNullOrEmpty(EmailTextBox.Text) ||
                string.IsNullOrEmpty(MobileTextBox.Text) || string.IsNullOrEmpty(AddressTextBox.Text) ||
                string.IsNullOrEmpty(CityTextBox.Text) || string.IsNullOrEmpty(ProvinceTextBox.Text) ||
                string.IsNullOrEmpty(ZipCodeTextBox.Text) || string.IsNullOrEmpty(CountryTextBox.Text))
            {
                // SweetAlert for missing fields
                ScriptManager.RegisterStartupScript(this, GetType(), "MissingFields",
                    "Swal.fire({ title: 'Incomplete Data', text: 'Please fill in all required fields.', icon: 'warning' });", true);
                return;
            }

            // Additional validations for specific fields
            // Validate Email
            if (!IsValidEmail(EmailTextBox.Text))
            {
                // SweetAlert for invalid email
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidEmail",
                    "Swal.fire({ title: 'Invalid Email', text: 'Please enter a valid email address.', icon: 'error' });", true);
                return;
            }

            // Validate Date of Birth
            DateTime dateOfBirth;
            if (!DateTime.TryParseExact(DateOfBirthTextBox.Text, "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out dateOfBirth))
            {
                // SweetAlert for invalid date format
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidDate",
                    "Swal.fire({ title: 'Invalid Date', text: 'Please enter a valid date (yyyy-MM-dd).', icon: 'error' });", true);
                return;
            }
            // Parse date of birth from TextBox
            DateTime dob;
            if (!DateTime.TryParse(DateOfBirthTextBox.Text, out dob))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidDOB",
                    "Swal.fire({ title: 'Error', text: 'Invalid date format for Date of Birth.', icon: 'error' });", true);
                return;
            }

            // Calculate age
            int age = DateTime.Now.Year - dob.Year;
            if (dob > DateTime.Now.AddYears(-age)) age--;

            // Check if age is below the 18
            if (age < 18)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "TooYoung",
                    "Swal.fire({ title: 'Age Restriction', text: 'You must be at least 18 years to book appointment.', icon: 'warning' });", true);
                return;
            }
            // Validate Mobile number
            if (!long.TryParse(MobileTextBox.Text, out _) || MobileTextBox.Text.Length < 10)
            {
                // SweetAlert for invalid mobile number
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidMobile",
                    "Swal.fire({ title: 'Invalid Mobile Number', text: 'Please enter a valid mobile number.', icon: 'error' });", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string checkQuery = @"SELECT COUNT(*) FROM Patients WHERE UserId = @UserId";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@UserId", userId);
                    int count = (int)checkCmd.ExecuteScalar();

                    string query;

                    if (count > 0)
                    {
                        // Update existing profile
                        query = @"UPDATE Patients
                          SET FirstName = @FirstName, LastName = @LastName, DateOfBirth = @DateOfBirth, 
                              BloodGroup = @BloodGroup, Email = @Email, Mobile = @Mobile, 
                              Address = @Address, City = @City, Sex = @Sex, Province = @Province, 
                              ZipCode = @ZipCode, Country = @Country
                          WHERE UserId = @UserId";
                    }
                    else
                    {
                        // Insert new profile
                        query = @"INSERT INTO Patients (UserId, FirstName, LastName, DateOfBirth, BloodGroup, Email, Mobile, 
                            Address, City, Province, ZipCode, Sex, Country)
                          VALUES (@UserId, @FirstName, @LastName, @DateOfBirth, @BloodGroup, @Email, @Mobile, 
                                  @Address, @City, @Province, @ZipCode, @Sex, @Country)";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text);
                        cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text);
                        cmd.Parameters.AddWithValue("@DateOfBirth", DateOfBirthTextBox.Text);
                        cmd.Parameters.AddWithValue("@BloodGroup", BloodGroupDropDownList.SelectedValue);
                        cmd.Parameters.AddWithValue("@Sex", DropDownList1.SelectedValue);
                        cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text);
                        cmd.Parameters.AddWithValue("@Mobile", MobileTextBox.Text);
                        cmd.Parameters.AddWithValue("@Address", AddressTextBox.Text);
                        cmd.Parameters.AddWithValue("@City", CityTextBox.Text);
                        cmd.Parameters.AddWithValue("@Province", ProvinceTextBox.Text);
                        cmd.Parameters.AddWithValue("@ZipCode", ZipCodeTextBox.Text);
                        cmd.Parameters.AddWithValue("@Country", CountryTextBox.Text);
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            // Update session values
                            string fullName = $"{FirstNameTextBox.Text} {LastNameTextBox.Text}";
                            Session["PatientFullName"] = fullName;
                            Session["PatientAddress"] = AddressTextBox.Text;

                            // SweetAlert for successful update
                            ScriptManager.RegisterStartupScript(this, GetType(), "ProfileUpdated",
                                "Swal.fire({ title: 'Success', text: 'Profile updated successfully.', icon: 'success' });", true);
                        }
                        else
                        {
                            // SweetAlert for no changes made
                            ScriptManager.RegisterStartupScript(this, GetType(), "NoChanges",
                                "Swal.fire({ title: 'No Changes', text: 'No changes were made to the profile.', icon: 'info' });", true);
                        }
                    }
                }
            }
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
