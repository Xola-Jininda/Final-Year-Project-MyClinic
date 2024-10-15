using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin
{
    public partial class Employee : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            // Get form values
            string employeeType = rbtnAdmin.Checked ? "Admin" :
                                  rbtnDoctor.Checked ? "Doctor" :
                                  rbtnParamedic.Checked ? "Paramedic" : null;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate form inputs
            if (string.IsNullOrEmpty(employeeType) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please fill in all fields.";
                return;
            }

            // Insert employee details into the User_ table
            bool success = AddEmployeeToDatabase(employeeType, username, password);

            // Display success or failure message
            if (success)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = $"{employeeType} added successfully!";
                ClearForm();
            }
            else
            {
                lblMessage.Text = "Failed to add employee. Please try again.";
            }
        }

        private bool AddEmployeeToDatabase(string role, string username, string password)
        {
            // Database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

            // SQL Insert Query
            string query = "INSERT INTO User_ (Username, Password_, Role_) VALUES (@Username, @Password, @Role)";

            // Use try-catch to handle any potential database errors
            try
            {
                // Create a SQL connection using the connection string
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Open the connection
                    conn.Open();

                    // Create a SQL command to execute the query
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Role", role);

                        // Execute the query and check if it inserted at least one row
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0; // Return true if insertion was successful
                    }
                }
            }
            catch (Exception ex)
            {
                // Log or display the error message (in production, you might log the error instead)
                lblMessage.Text = "An error occurred: " + ex.Message;
                return false; // Return false if insertion failed
            }
        }

        // Clear form fields after successful insertion
        private void ClearForm()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            rbtnAdmin.Checked = false;
            rbtnDoctor.Checked = false;
            rbtnParamedic.Checked = false;
        }
    }
}