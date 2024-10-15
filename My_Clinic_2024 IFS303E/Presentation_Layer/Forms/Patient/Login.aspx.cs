using System;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace AppointmentBookingFeature
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtRegisterUsername.Text.Trim();
            string password = txtRegisterPassword.Text.Trim();
            string confirmPassword = txtRegisterConfirmPassword.Text.Trim(); // Added confirm password field

            // Input validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ValidationError",
                    "Swal.fire('Validation Error', 'All fields are required.', 'warning');", true);
                return;
            }

            if (username.Length < 3 || !System.Text.RegularExpressions.Regex.IsMatch(username, @"^[a-zA-Z]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ValidationError",
                    "Swal.fire('Validation Error', 'Username must be at least 3 letters long and contain only letters.', 'warning');", true);
                return;
            }

            // Check if passwords match
            if (password != confirmPassword)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PasswordMismatch",
                    "Swal.fire('Validation Error', 'Passwords do not match.', 'warning');", true);
                return;
            }

            // Password validation
            if (password.Length < 8 || !System.Text.RegularExpressions.Regex.IsMatch(password, @"[a-z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, @"\d") ||
                !System.Text.RegularExpressions.Regex.IsMatch(password, @"[\W_]"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ValidationError",
                    "Swal.fire('Validation Error', 'Password must be at least 8 characters long and include at least one lowercase letter, one uppercase letter, one number, and one special character.', 'warning');", true);
                return;
            }

            string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True";
            bool registrationSuccessful = false;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if username already exists
                string checkUserQuery = "SELECT COUNT(*) FROM User_ WHERE Username = @Username";
                using (SqlCommand checkUserCmd = new SqlCommand(checkUserQuery, conn))
                {
                    checkUserCmd.Parameters.AddWithValue("@Username", username);
                    int userCount = (int)checkUserCmd.ExecuteScalar();

                    if (userCount > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "UserExists",
                            "Swal.fire('Error', 'Username already exists. Please choose a different username.', 'error');", true);
                        return;
                    }
                }

                // Insert new user
                string query = "INSERT INTO User_ (Username, Password_) VALUES (@Username, @Password_)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password_", password);

                    try
                    {
                        cmd.ExecuteNonQuery();
                        registrationSuccessful = true;
                    }
                    catch (Exception ex)
                    {
                        // Show error alert
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Error",
                            $"Swal.fire('Error', '{ex.Message}', 'error');", true);
                    }
                }
            }

            // If registration is successful, show success alert and redirect to login tab
            if (registrationSuccessful)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Success",
                    "Swal.fire({ title: 'Registration Successful!', text: 'You will be redirected to the login page.', icon: 'success'}).then((result) => { $('#register-tab').removeClass('active'); $('#login-tab').addClass('active'); $('#register').removeClass('show active'); $('#login').addClass('show active'); });", true);
            }
        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True";
            string username = txtLoginUsername.Text;
            string password = txtLoginPassword.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT UserId, Role_ FROM User_ WHERE Username = @Username AND Password_ = @Password_";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password_", password);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int userId = reader.IsDBNull(0) ? 0 : reader.GetInt32(0);
                            string role = reader.IsDBNull(1) ? string.Empty : reader.GetString(1);
                            FormsAuthentication.SetAuthCookie(username, false);

                            Session["UserId"] = userId;

                            // Use if statement to choose role and redirect
                            if (role == "Admin")
                            {
                                Response.Redirect("~/Presentation_Layer/Forms/Admin/Dashboard.aspx");
                            }
                            else if (role == "Doctor")
                            {
                                Response.Redirect("~/Presentation_Layer/Forms/Doctor/Dashboard.aspx");
                            }
                            else if(role == "Paramedic")
                            {
                                Response.Redirect("~/Presentation_Layer/Forms/Paramedics/Dash.aspx");
                            }
                            else
                            {
                                Response.Redirect("~/Presentation_Layer/Forms/Patient/Dashboard.aspx");
                            }
                        }
                        else
                        {
                            // Show error alert
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "LoginError",
                                "Swal.fire('Invalid Credentials', 'Username or password is incorrect.', 'error');", true);
                        }
                    }
                }
            }
        }

        protected void ShowLogin(object sender, EventArgs e)
        {
            loginForm.Visible = true;
            registerForm.Visible = false;
        }

        protected void ShowRegister(object sender, EventArgs e)
        {
            loginForm.Visible = false;
            registerForm.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

        }
    }
}
