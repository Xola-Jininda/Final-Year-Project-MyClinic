using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppointmentBookingFeature
{
    public partial class Default : System.Web.UI.Page
    {
        // Simulated in-memory storage for booked appointments
        private static readonly List<Appointment> BookedAppointments = new List<Appointment>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AppointmentDateTextBox.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                PopulateTimeDropDown();
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string dateInput = AppointmentDateTextBox.Text;
            string timeInput = AppointmentTimeDropDownList.SelectedValue;
            string nameInput = PatientNameTextBox.Text;
            string genderInput = GenderDropDownList.SelectedValue;
            string contactInput = ContactNumberTextBox.Text;
            string emailInput = EmailTextBox.Text;
            string reasonInput = ReasonTextBox.Text;

            if (string.IsNullOrEmpty(dateInput) || string.IsNullOrEmpty(timeInput) || string.IsNullOrEmpty(nameInput) ||
                string.IsNullOrEmpty(genderInput) || string.IsNullOrEmpty(contactInput) || string.IsNullOrEmpty(emailInput) ||
                string.IsNullOrEmpty(reasonInput))
            {
                MessageLabel.Text = "All fields are required.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                return;
            }

            DateTime selectedDate = DateTime.Parse(dateInput);
            TimeSpan selectedTime = TimeSpan.Parse(timeInput);

            // Check if the selected time slot is already booked
            if (BookedAppointments.Any(a => a.Date.Date == selectedDate.Date && a.Time == selectedTime))
            {
                MessageLabel.Text = "The selected time slot is already booked. Please choose another time.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                // Add the new appointment to the list
                var newAppointment = new Appointment
                {
                    Date = selectedDate,
                    Time = selectedTime,
                    PatientName = nameInput,
                    Gender = genderInput,
                    ContactNumber = contactInput,
                    Email = emailInput,
                    Reason = reasonInput
                };

                BookedAppointments.Add(newAppointment);

                // Redirect to the summary page with the booking details
                Session["Appointment"] = newAppointment;
                Response.Redirect("BookingSummary.aspx");
            }
        }
        private void PopulateTimeDropDown()
        {
            AppointmentTimeDropDownList.Items.Clear();
            for (int hour = 8; hour < 17; hour++)
            {
                for (int minute = 0; minute < 60; minute += 15)
                {
                    TimeSpan time = new TimeSpan(hour, minute, 0);
                    AppointmentTimeDropDownList.Items.Add(new ListItem(time.ToString(@"hh\:mm"), time.ToString(@"hh\:mm")));
                }
            }
        }
        private void PopulateTimeDropDown(DateTime selectedDate)
        {
            

            if (AppointmentTimeDropDownList.Items.Count == 0)
            {
                MessageLabel.Text = "All time slots are booked for the selected date. Please choose another date.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                SubmitButton.Enabled = false;

            }

        }

        public class Appointment
        {
            public DateTime Date { get; set; }
            public TimeSpan Time { get; set; }
            public string PatientName { get; set; }
            public string Gender { get; set; }
            public string ContactNumber { get; set; }
            public string Email { get; set; }
            public string Reason { get; set; }
        }
    }
}