using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E
{
    public partial class Default : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Presentation_Layer/Forms/Patient/Login.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Presentation_Layer/Forms/Patient/RequestAmbulance.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Clear the validation label
            lblValidation.Text = string.Empty;

            // Retrieve user input
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            // Simple hardcoded validation using if statements
            if (string.IsNullOrEmpty(name))
            {
                lblValidation.Text = "Please enter your name.";
                return;
            }

            if (string.IsNullOrEmpty(email))
            {
                lblValidation.Text = "Please enter your email.";
                return;
            }

            // Basic email validation
            if (!email.Contains("@") || !email.Contains("."))
            {
                lblValidation.Text = "Please enter a valid email address.";
                return;
            }

            if (string.IsNullOrEmpty(message))
            {
                lblValidation.Text = "Please enter your message.";
                return;
            }

            // If all validations pass, proceed to process the form submission (e.g., insert into the database)
            try
            {
                // Example method to handle form submission
                SubmitContactForm(name, email, message);

                // Success message
                lblValidation.ForeColor = System.Drawing.Color.Green;
                lblValidation.Text = "Your message has been submitted successfully.";

                // Clear the form fields
                txtName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtMessage.Text = string.Empty;
            }
            catch (Exception ex)
            {
                // Handle any errors during form submission
                lblValidation.ForeColor = System.Drawing.Color.Red;
                lblValidation.Text = "An error occurred: " + ex.Message;
            }
        }
        private void SubmitContactForm(string name, string email, string message)
        {
           

            // SQL query to insert the contact form data into the ContactMessages table
            string query = "INSERT INTO UserContacts (Name, Email, Message, DateSubmitted) VALUES (@Name, @Email, @Message, GETDATE())";

            // Create and open a connection to the database
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a SqlCommand to execute the query
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add the parameters to the query
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Message", message);

                    // Open the connection
                    connection.Open();

                    // Execute the query (INSERT)
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}