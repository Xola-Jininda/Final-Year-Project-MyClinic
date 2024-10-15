using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin
{
    public partial class Orders : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        private void BindGrid()
        {
           
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT [PaymentId], [FullName], [Status] FROM [MyClinic].[dbo].[Payment] WHERE [Status] = 'Processing'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPayments.DataSource = dt;
                gvPayments.DataBind();

                // Set DataKeyNames for accessing the PaymentId
                gvPayments.DataKeyNames = new string[] { "PaymentId" };
            }
        }



        protected void gvPayments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CloseOrder")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int paymentId = Convert.ToInt32(gvPayments.DataKeys[rowIndex]["PaymentId"]);

                // Call your method to close the payment/order
                CloseOrder(paymentId);
                BindGrid();
            }
            else if (e.CommandName == "CancelOrder")
            {
                // Handle CancelOrder logic here
            }
        }

        private void CloseOrder(int paymentId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE [MyClinic].[dbo].[Payment] SET [Status] = 'Closed' WHERE [PaymentId] = @PaymentId AND [Status] = 'Processing'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PaymentId", paymentId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

    }
}