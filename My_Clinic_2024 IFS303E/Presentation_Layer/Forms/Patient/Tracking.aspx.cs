using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class Tracking : System.Web.UI.Page
    {
        private string connectionString = "Data Source=LAPTOP-FMQLGT3P\\SQLEXPRESS;Initial Catalog=MyClinic;Integrated Security=True"; // Update with your actual connection string

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the user ID from session (ensure this value is set when the user logs in)
                string userId = Session["UserId"]?.ToString();

                if (!string.IsNullOrEmpty(userId))
                {
                    // Fetch order details using the unique user identifier
                    FetchOrderDetails(userId);
                }
                else
                {
                    // Handle the case where no user ID is available in the session
                    ShowError("No order details available. Please log in to view your orders.");
                }
            }
        }

        private void FetchOrderDetails(string userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
            SELECT 
                PaymentId, FullName, AmountPaid, DeliveryAddress, PaymentDate, Status
            FROM 
                Payment 
            WHERE 
                UserId = @UserId 
            ORDER BY 
                PaymentDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            OrdersRepeater.DataSource = dt;
                            OrdersRepeater.DataBind();
                        }
                        else
                        {
                            // Handle the case where no data is found
                            ShowError("No order details found.");
                        }
                    }
                }
            }
        }


        private void ShowError(string message)
        {
            // Display an error message in a suitable place
            Label lblError = new Label();
            lblError.Text = message;
            OrdersRepeater.Controls.Add(lblError);
        }
    }
}
