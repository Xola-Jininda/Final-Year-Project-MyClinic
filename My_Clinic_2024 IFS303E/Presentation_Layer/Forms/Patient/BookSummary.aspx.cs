using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MimeKit;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class BookSummary : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Appointment"] != null)
                {
                    var appointment = (Dashboard.Appointment)Session["Appointment"];
                    Session["AppointmentDate"] = appointment.Date.ToString("yyyy-MM-dd");
                    Session["AppointmentTime"] = appointment.Time.ToString(@"hh\:mm");
                    Session["PatientName"] = appointment.PatientName;
                    Session["Gender"] = appointment.Gender;
                    Session["ContactNumber"] = appointment.ContactNumber;
                    Session["Email"] = appointment.Email;
                   
                    Session["Reason"] = appointment.Reason;
                }
                else
                {
                    Response.Redirect("~/Presentation_Layer/Forms/Patient/Book.aspx");
                }
            }
        }
        protected void ConfirmButton_Click(object sender, EventArgs e)
        {
            if (Session["AppointmentDate"] != null)
            {
                var appointment = new Dashboard.Appointment
                {
                    Date = DateTime.Parse(Session["AppointmentDate"].ToString()),
                    Time = TimeSpan.Parse(Session["AppointmentTime"].ToString()),
                    PatientName = Session["PatientName"].ToString(),
                    Gender = Session["Gender"].ToString(),
                    ContactNumber = Session["ContactNumber"].ToString(),
                    Email = Session["Email"].ToString(),
                    Reason = Session["Reason"].ToString(),
                   
                };

                int patientId = (int)Session["UserId"];

                // Check if the appointment already exists
                if (IsAppointmentExists(appointment))
                {
                    // Use SweetAlert to notify that the time slot is already booked
                    ScriptManager.RegisterStartupScript(this, GetType(), "TimeSlotBookedAlert",
                    "Swal.fire({ title: 'Time Slot Booked', text: 'The selected date and time slot is already booked! Please choose another time.', icon: 'warning', confirmButtonText: 'OK' }).then((result) => { if (result.isConfirmed) { window.location.href = 'Book.aspx'; } });", true);
                }
                else
                {
                    // Save the appointment to the database
                    SaveAppointmentToDatabase(appointment, patientId);

                    // Send confirmation email to the patient
                    SendEmailWithCode(appointment.Email, appointment);

                }
            }
        }
        private bool IsAppointmentExists(Dashboard.Appointment appointment)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Appointments WHERE AppointmentDate = @AppointmentDate AND AppointmentTime = @AppointmentTime AND Category = @Category";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@AppointmentDate", appointment.Date);
                command.Parameters.AddWithValue("@AppointmentTime", appointment.Time);
                command.Parameters.AddWithValue("@Category", appointment.Reason);

                connection.Open();
                int count = (int)command.ExecuteScalar();

                return count > 0;
            }
        }

        private void SaveAppointmentToDatabase(Dashboard.Appointment appointment, int patientId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Appointments (PatientID, DoctorID, AdminID, AppointmentDate, AppointmentTime, Status, PatientName, PhoneNumber, Email, Gender, Category) " +
                               "VALUES (@PatientID, @DoctorID, @AdminID, @AppointmentDate, @AppointmentTime, @Status, @PatientName, @PhoneNumber, @Email, @Gender, @Category)";
                SqlCommand command = new SqlCommand(query, connection);

                command.Parameters.AddWithValue("@PatientID", patientId);
                command.Parameters.AddWithValue("@DoctorID", DBNull.Value); 
                command.Parameters.AddWithValue("@AdminID", DBNull.Value); 
                command.Parameters.AddWithValue("@AppointmentDate", appointment.Date);
                command.Parameters.AddWithValue("@AppointmentTime", appointment.Time);
                command.Parameters.AddWithValue("@Status", "Scheduled"); // active status
                command.Parameters.AddWithValue("@PatientName", appointment.PatientName);
                command.Parameters.AddWithValue("@PhoneNumber", appointment.ContactNumber);
                command.Parameters.AddWithValue("@Email", appointment.Email);
                command.Parameters.AddWithValue("@Gender", appointment.Gender);
                command.Parameters.AddWithValue("@Category", appointment.Reason);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private void SendEmailWithCode(string emailAddress, Dashboard.Appointment appointment)
        {
            string smtpServer = "mail.cosmartic.co.za";
            int port = 587;
            string fromEmail = "technocrats@cosmartic.co.za";
            string fromPassword = "Technocr@t5";

            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("MyClinic", fromEmail));
            message.To.Add(new MailboxAddress("", emailAddress));
            message.Subject = "Booking Confirmation";
            message.Body = new TextPart("html")
            {
                Text = $@"
            <div style='font-family: Arial, sans-serif; font-size: 14px; color: #333;'>
                <h2 style='color: #4CAF50;'>Appointment Booking Confirmation</h2>
                <p>Dear {appointment.PatientName},</p>

                <p>
                    We are pleased to confirm that your appointment has been successfully booked. 
                    Below are the details of your appointment:
                </p>

                <table style='border-collapse: collapse; width: 100%; margin-top: 20px;'>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Date:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.Date.ToString("dddd, dd MMMM yyyy")}</td>
                    </tr>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Time:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.Time}</td>
                    </tr>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Patient Name:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.PatientName}</td>
                    </tr>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Gender:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.Gender}</td>
                    </tr>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Reason for Visit:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.Reason}</td>
                    </tr>
                    <tr>
                        <td style='padding: 10px; border: 1px solid #ddd;'><strong>Contact Number:</strong></td>
                        <td style='padding: 10px; border: 1px solid #ddd;'>{appointment.ContactNumber}</td>
                    </tr>
                </table>

                <p style='margin-top: 20px;'>If you have any questions or need to reschedule your appointment, feel free to <a href='#' style='color: #4CAF50;'>contact us</a>.</p>

                <p>Thank you for choosing our clinic. We look forward to seeing you.</p>

                <p style='margin-top: 40px;'>Best regards,<br>Clinic Name</p>

                <hr style='border-top: 1px solid #ddd; margin: 40px 0;'>
                <p style='font-size: 12px; color: #999;'>This is an automated email, please do not reply to this message.</p>
            </div>"
            };

            using (var smtpClient = new MailKit.Net.Smtp.SmtpClient())
            {
                try
                {
                    smtpClient.ServerCertificateValidationCallback = (sender, certificate, chain, sslPolicyErrors) => true;
                    smtpClient.CheckCertificateRevocation = false; // Disable revocation check
                    smtpClient.Connect(smtpServer, port, MailKit.Security.SecureSocketOptions.StartTls);
                    smtpClient.Authenticate(fromEmail, fromPassword);
                    smtpClient.Send(message);
                    smtpClient.Disconnect(true);

                    // SweetAlert for success
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert",
                    "Swal.fire({ title: 'Success', text: 'Appointment booked successfully. A confirmation email has been sent to your provided email address.', icon: 'success' });", true);
                }
                catch (MailKit.Net.Smtp.SmtpCommandException)
                {
                    // SweetAlert for SMTP Command Exception
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                    $"Swal.fire({{ title: 'Email Error', text: 'Appointment booked Successfully. There was an error sending the confirmation email', icon: 'error' }});", true);
                }
                catch (MailKit.Net.Smtp.SmtpProtocolException)
                {
                    // SweetAlert for SMTP Protocol Exception
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                    $"Swal.fire({{ title: 'Email Error', text: 'Appointment booked Successfully. There was an error sending the confirmation email', icon: 'error' }});", true);
                }
                catch (Exception)
                {
                    // SweetAlert for General Exception
                    ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                    $"Swal.fire({{ title: 'Error', text: 'Appointment booked Successfully. There was an error sending the confirmation email', icon: 'error' }});", true);
                }
            }
        }


    }
}