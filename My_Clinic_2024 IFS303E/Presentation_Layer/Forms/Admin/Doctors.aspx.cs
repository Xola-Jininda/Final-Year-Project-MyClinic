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
    public partial class Doctors : System.Web.UI.Page
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
                string query = "SELECT [DoctorID], [FirstName], [LastName], [Specialty], [Email], [Address] " +
                               "FROM [MyClinic].[dbo].[Doctors]";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Create a new column for Full Name
                dt.Columns.Add("FullName", typeof(string), "FirstName + ' ' + LastName");

                gvDoctors.DataSource = dt;
                gvDoctors.DataBind();
            }
        }

        protected void gvDoctors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteDoctor")
            {
                // Retrieve DoctorID from the CommandArgument
                string doctorId = e.CommandArgument.ToString();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        // Delete the doctor from the Doctors table
                        string deleteDoctorQuery = "DELETE FROM Doctors WHERE DoctorID = @DoctorID";
                        using (SqlCommand cmd = new SqlCommand(deleteDoctorQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DoctorID", doctorId);
                            cmd.ExecuteNonQuery();
                        }

                        // Delete the corresponding user from the User_ table based on the DoctorID
                        string deleteUserQuery = "DELETE FROM User_ WHERE UserId = (SELECT UserId FROM Doctors WHERE DoctorID = @DoctorID)";
                        using (SqlCommand cmd = new SqlCommand(deleteUserQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@DoctorID", doctorId);
                            cmd.ExecuteNonQuery();
                        }

                        // Commit the transaction
                        transaction.Commit();

                        // Re-bind the GridView to reflect the changes
                        BindGrid();

                        // Show success message using SweetAlert
                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert", "Swal.fire('Success', 'Doctor removed successfully!', 'success');", true);
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction on failure
                        transaction.Rollback();
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert", $"Swal.fire('Error', '{ex.Message}', 'error');", true);
                    }
                }
            }
        }


    }
}