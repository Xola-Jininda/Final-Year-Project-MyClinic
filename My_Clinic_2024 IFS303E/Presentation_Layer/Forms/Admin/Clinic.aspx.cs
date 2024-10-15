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
    public partial class Clinic : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAddClinic_Click(object sender, EventArgs e)
        {
            string clinicName = txtClinicName.Text.Trim();
            string address = txtAddress.Text.Trim();
            string city = txtCity.Text.Trim();
            string province = txtProvince.Text.Trim();
            string country = txtCountry.Text.Trim();
            string zipCode = txtZipCode.Text.Trim();

            if (string.IsNullOrEmpty(clinicName) || string.IsNullOrEmpty(address) || string.IsNullOrEmpty(city) ||
                string.IsNullOrEmpty(province) || string.IsNullOrEmpty(country) || string.IsNullOrEmpty(zipCode))
            {
                ViewState["AlertTitle"] = "Error";
                ViewState["AlertText"] = "Please fill in all required fields.";
                ViewState["AlertType"] = "error";
                return;
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Check if clinic name already exists
                    string checkQuery = @"SELECT COUNT(*) FROM Clinic WHERE ClinicName = @ClinicName";
                    using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@ClinicName", clinicName);
                        int count = (int)checkCommand.ExecuteScalar();

                        if (count > 0)
                        {
                            ViewState["AlertTitle"] = "Error";
                            ViewState["AlertText"] = "A clinic with this name already exists.";
                            ViewState["AlertType"] = "error";
                            return;
                        }
                    }

                    // Proceed with inserting the new clinic
                    string insertQuery = @"INSERT INTO Clinic (ClinicName, Address, City, Province, Country, ZipCode)
                                   VALUES (@ClinicName, @Address, @City, @Province, @Country, @ZipCode)";

                    using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                    {
                        insertCommand.Parameters.AddWithValue("@ClinicName", clinicName);
                        insertCommand.Parameters.AddWithValue("@Address", address);
                        insertCommand.Parameters.AddWithValue("@City", city);
                        insertCommand.Parameters.AddWithValue("@Province", province);
                        insertCommand.Parameters.AddWithValue("@Country", country);
                        insertCommand.Parameters.AddWithValue("@ZipCode", zipCode);

                        insertCommand.ExecuteNonQuery();

                        ViewState["AlertTitle"] = "Success";
                        ViewState["AlertText"] = "Clinic added successfully!";
                        ViewState["AlertType"] = "success";

                        // Clear fields after successful addition
                        txtClinicName.Text = "";
                        txtAddress.Text = "";
                        txtCity.Text = "";
                        txtProvince.Text = "";
                        txtCountry.Text = "";
                        txtZipCode.Text = "";
                    }
                }
            }
            catch (SqlException ex)
            {
                ViewState["AlertTitle"] = "Error";
                ViewState["AlertText"] = "Error adding clinic: " + ex.Message;
                ViewState["AlertType"] = "error";
            }
        }


    }
}