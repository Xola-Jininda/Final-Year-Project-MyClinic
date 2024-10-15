using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppointmentBookingFeature
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phoneNumber = txtPhoneNumber.Text;
            string appointmentDate = txtAppointmentDate.Text;
            string appointmentTime = txtAppointmentTime.Text;

            // Process the data (e.g., store in database, send confirmation email)
            // For demonstration, we'll just display a confirmation message
            string confirmationMessage = $"Appointment booked successfully! <br/>" +
                                         $"Name: {name}<br/>" +
                                         $"Email: {email}<br/>" +
                                         $"Phone Number: {phoneNumber}<br/>" +
                                         $"Appointment Date: {appointmentDate}<br/>" +
                                         $"Appointment Time: {appointmentTime}";

            // Display confirmation message
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + confirmationMessage.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'") + "');", true);
        }
    }
}