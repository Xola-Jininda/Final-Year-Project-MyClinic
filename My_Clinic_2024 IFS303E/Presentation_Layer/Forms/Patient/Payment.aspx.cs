using System;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class Payment : System.Web.UI.Page
    {
        private string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True"; // Update with your actual connection string

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve session values
                string patientFullName = Session["CurrentPatientFullName"]?.ToString();
                string patientAddress = Session["CurrentPatientAddress"]?.ToString();

                if (!string.IsNullOrEmpty(patientFullName))
                {
                    txtPatientName.Text = patientFullName;
                }

                if (!string.IsNullOrEmpty(patientAddress))
                {
                    txtAddress.Text = patientAddress;
                }
            }
        }

        protected void btnSubmitPayment_Click(object sender, EventArgs e)
        {
            // Get user inputs
            string cardNumber = txtCardNumber.Text.Trim();
            string expiryDate = txtExpiryDate.Text.Trim();
            string cvv = txtCVV.Text.Trim();

            // Retrieve patient details from session
            string fullName = txtPatientName.Text;
            string deliveryAddress = txtAddress.Text;
            string amountPaid = txtAmount.Text;

            // Validate inputs
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(deliveryAddress))
            {
                ShowSweetAlert("Error", "Patient details are missing. Please ensure you have updated your profile.", "error");
                return;
            }

            if (!Regex.IsMatch(cardNumber, @"^\d{16}$"))
            {
                ShowSweetAlert("Error", "Please enter a valid 16-digit card number.", "error");
                return;
            }

            if (!Regex.IsMatch(expiryDate, @"^(0[1-9]|1[0-2])\/\d{2}$"))
            {
                ShowSweetAlert("Error", "Please enter a valid expiry date in MM/YY format.", "error");
                return;
            }

            if (!Regex.IsMatch(cvv, @"^\d{3}$"))
            {
                ShowSweetAlert("Error", "Please enter a valid 3-digit CVV.", "error");
                return;
            }

            // Check if UserId is in session
            if (Session["UserId"] == null)
            {
                ShowSweetAlert("Error", "User not logged in.", "error");
                return;
            }

            int userId = (int)Session["UserId"];

            // Save payment and delivery information to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Include UserId and Status in the insert statement
                string query = @"INSERT INTO Payment (UserId, FullName, CardNumber, AmountPaid, ExpiryDate, CVV, DeliveryAddress, Status)
                         VALUES (@UserId, @FullName, @CardNumber, @AmountPaid, @ExpiryDate, @CVV, @DeliveryAddress, @Status)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);  // Add UserId parameter
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@CardNumber", cardNumber);
                    cmd.Parameters.AddWithValue("@AmountPaid", decimal.Parse(amountPaid));  // Ensure amountPaid is parsed as decimal
                    cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                    cmd.Parameters.AddWithValue("@CVV", cvv);
                    cmd.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);
                    cmd.Parameters.AddWithValue("@Status", "Processing"); // Default status

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        ShowSweetAlert("Success", "Payment has been submitted successfully!", "success");
                    }
                    else
                    {
                        ShowSweetAlert("Error", "There was an error processing your payment.", "error");
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        private void ShowSweetAlert(string title, string message, string icon)
        {
            string script;

            if (icon == "success")
            {
                // Show SweetAlert and redirect after 2 seconds on success
                script = $@"<script type='text/javascript'>
                            swal({{
                                title: '{title}',
                                text: '{message}',
                                icon: '{icon}',
                                button: false,  // Automatically close the alert
                                timer: 2000     // Show for 2 seconds
                            }}).then(() => {{
                                window.location.href = 'Tracking.aspx';  // Redirect to tracking page on success
                            }});
                        </script>";
            }
            else
            {
                // No redirection on error
                script = $@"<script type='text/javascript'>
                            swal({{
                                title: '{title}',
                                text: '{message}',
                                icon: '{icon}',
                                button: 'OK'
                            }});
                        </script>";
            }

            ltlScript.Text = script;
        }
    }
}
