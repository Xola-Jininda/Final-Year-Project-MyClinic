using My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyClinicConnectionString"].ConnectionString;
        // Simulated in-memory storage for booked appointments
        private static readonly List<Appointment> BookedAppointments = new List<Appointment>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AppointmentDateTextBox.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                PopulateTimeDropDown();
                LoadCategories();  // Load categories from database
                LoadClinics();     // Load clinics from database
                LoadData();

                if (Request.QueryString["AppointmentID"] != null)
                {
                    int appointmentID = Convert.ToInt32(Request.QueryString["AppointmentID"]);
                    LoadAppointmentDetails(appointmentID);
                    HiddenFieldAppointmentID.Value = appointmentID.ToString(); // Store appointment ID for editing
                }
            }
        }
        private void LoadClinics()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = "SELECT ClinicID, ClinicName FROM Clinic"; // Adjust the table and column names accordingly

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            ClinicDropDownList.DataSource = reader;
                            ClinicDropDownList.DataTextField = "ClinicName";  // Displayed name in the dropdown
                            ClinicDropDownList.DataValueField = "ClinicID";   // Value stored when an option is selected
                            ClinicDropDownList.DataBind();
                        }
                    }

                    // Insert a default option at the top
                    ClinicDropDownList.Items.Insert(0, new ListItem("-- Select Clinic --", ""));
                }
                catch (SqlException ex)
                {
                    // Handle database errors
                    ScriptManager.RegisterStartupScript(this, GetType(), "DatabaseError",
                        $"Swal.fire({{ title: 'Error', text: 'Error loading clinics: {ex.Message}', icon: 'error' }});", true);
                }
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = "SELECT SpecialityID, SpecialityName FROM Specialities";  // Adjust the table and column names accordingly

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            Reason.DataSource = reader;
                            Reason.DataTextField = "SpecialityName";  // Displayed name in the dropdown
                            Reason.DataValueField = "SpecialityID";   // Value stored when an option is selected
                            Reason.DataBind();
                        }
                    }

                    // Insert a default option at the top
                    Reason.Items.Insert(0, new ListItem("-- Select Category --", ""));
                }
                catch (SqlException ex)
                {
                    // Handle database errors
                    ScriptManager.RegisterStartupScript(this, GetType(), "DatabaseError",
                    $"Swal.fire({{ title: 'Error', text: 'Error loading categories: {ex.Message}', icon: 'error' }});", true);
                }
            }
        }


        private void LoadAppointmentDetails(int appointmentID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Appointments WHERE AppointmentID = @AppointmentID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AppointmentID", appointmentID);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            AppointmentDateTextBox.Text = Convert.ToDateTime(reader["AppointmentDate"]).ToString("yyyy-MM-dd");
                            AppointmentTimeDropDownList.SelectedValue = TimeSpan.Parse(reader["AppointmentTime"].ToString()).ToString(@"hh\:mm");
                            PatientNameTextBox.Text = reader["PatientName"].ToString();
                            GenderDropDownList.SelectedValue = reader["Gender"].ToString();
                            ContactNumberTextBox.Text = reader["PhoneNumber"].ToString();
                            EmailTextBox.Text = reader["Email"].ToString();
                            ClinicDropDownList.SelectedValue = reader["ClinicName"].ToString();
                            Reason.SelectedValue = reader["Category"].ToString();  // Use Category or ID depending on how you save it
                        }
                    }
                }
            }
        }


        protected void SubmitButton_Click(object sender, EventArgs e)
        {

            // Get input values
            string dateInput = AppointmentDateTextBox.Text;
            string timeInput = AppointmentTimeDropDownList.SelectedValue;
            string nameInput = PatientNameTextBox.Text;
            string genderInput = GenderDropDownList.SelectedValue;
            string contactInput = ContactNumberTextBox.Text;
            string emailInput = EmailTextBox.Text;
            string reason = Reason.SelectedItem.Text;
            string selectedClinic = ClinicDropDownList.SelectedValue;

            // Calender validation for accuracy and weekends
            DateTime selectedDate;
            TimeSpan selectedTime;
            try
            {
                selectedDate = DateTime.Parse(dateInput);
                selectedTime = TimeSpan.Parse(timeInput);
            }
            catch (FormatException)
            {
                // SweetAlert for invalid date/time format
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidDateTime",
                    "Swal.fire({ title: 'Error', text: 'Invalid date or time format.', icon: 'error' });", true);
                return;
            }

            // Check if the selected date is a weekend
            if (selectedDate.DayOfWeek == DayOfWeek.Saturday || selectedDate.DayOfWeek == DayOfWeek.Sunday)
            {
                // SweetAlert for weekend selection
                ScriptManager.RegisterStartupScript(this, GetType(), "WeekendError",
                    "Swal.fire({ title: 'Error', text: 'Weekends are not available for appointments. Please select a weekday.', icon: 'warning' });", true);
                return;
            }


            // Check if profile fields (name, gender, email, contact) are missing
            if (string.IsNullOrEmpty(nameInput) || string.IsNullOrEmpty(genderInput) || string.IsNullOrEmpty(contactInput) || string.IsNullOrEmpty(emailInput))
            {
                // SweetAlert for missing profile details with redirection
                ScriptManager.RegisterStartupScript(this, GetType(), "IncompleteProfile",
                    @"Swal.fire({
            title: 'Incomplete Profile',
            text: 'Please fill in your profile details.',
            icon: 'warning',
            confirmButtonText: 'Go to profile'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location = 'ProfileSettings.aspx';
            }
        });", true);
                return;
            }


            // Check if appointment details (date, time, reason, clinic) are missing
            if (string.IsNullOrEmpty(dateInput) || string.IsNullOrEmpty(timeInput) || string.IsNullOrEmpty(reason) || reason == "-- Select Category --")
            {
                // SweetAlert for missing appointment details
                ScriptManager.RegisterStartupScript(this, GetType(), "IncompleteDetails",
                    "Swal.fire({ title: 'Error', text: 'Please fill in all appointment details.', icon: 'warning' });", true);
                return;
            }

            
            try
            {
                selectedDate = DateTime.Parse(dateInput);
                selectedTime = TimeSpan.Parse(timeInput);
            }
            catch (FormatException)
            {
                // SweetAlert for invalid date/time format
                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidDateTime",
                    "Swal.fire({ title: 'Error', text: 'Invalid date or time format.', icon: 'error' });", true);
                return;
            }

            // Check if the selected time slot is already booked for the same date and category
            if (BookedAppointments.Any(a => a.Date.Date == selectedDate.Date && a.Time == selectedTime && a.Reason == reason))
            {
                // SweetAlert for booked time slot
                ScriptManager.RegisterStartupScript(this, GetType(), "TimeSlotBooked",
                    "Swal.fire({ title: 'Time Slot Booked', text: 'The selected date and time slot is already booked! Please choose another time.', icon: 'warning' });", true);
                return;
            }

            // If editing an existing appointment
            int appointmentID;
            if (int.TryParse(HiddenFieldAppointmentID.Value, out appointmentID) && appointmentID > 0)
            {
                // Update existing appointment
                UpdateAppointment(appointmentID, selectedDate, selectedTime, nameInput, genderInput, contactInput, emailInput, reason, selectedClinic);
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateSuccess",
                    "Swal.fire({ title: 'Success', text: 'Appointment updated successfully.', icon: 'success' });", true);
            }
            else
            {
                // Add new appointment
                var newAppointment = new Appointment
                {
                    Date = selectedDate,
                    Time = selectedTime,
                    PatientName = nameInput,
                    Gender = genderInput,
                    ContactNumber = contactInput,
                    Email = emailInput,
                    Reason = reason,
                    ClinicID = selectedClinic  // Add ClinicID
                };

                BookedAppointments.Add(newAppointment);

                // Redirect to summary page
                Session["Appointment"] = newAppointment;
                Response.Redirect("~/Presentation_Layer/Forms/Patient/BookSummary.aspx");
            }
        }


        private void PopulateTimeDropDown()
        {
            AppointmentTimeDropDownList.Items.Clear();
            List<TimeSpan> availableTimes = new List<TimeSpan>();

            for (int hour = 8; hour < 17; hour++)
            {
                for (int minute = 0; minute < 60; minute += 15)
                {
                    TimeSpan time = new TimeSpan(hour, minute, 0);
                    availableTimes.Add(time);
                }
            }

            // Remove booked time slots from available times
            DateTime selectedDate;
            if (DateTime.TryParse(AppointmentDateTextBox.Text, out selectedDate))
            {
                var bookedTimes = BookedAppointments
                    .Where(a => a.Date.Date == selectedDate.Date)
                    .Select(a => a.Time)
                    .ToList();

                availableTimes = availableTimes.Except(bookedTimes).ToList();
            }

            // Populate drop-down list with available times
            foreach (var time in availableTimes)
            {
                AppointmentTimeDropDownList.Items.Add(new ListItem(time.ToString(@"hh\:mm"), time.ToString(@"hh\:mm")));
            }

            // If no time slots available, disable the submit button
            if (AppointmentTimeDropDownList.Items.Count == 0)
            {
                MessageLabel.Text = "All time slots are booked for the selected date. Please choose another date.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                SubmitButton.Enabled = false;
            }
            else
            {
                MessageLabel.Text = string.Empty;
                SubmitButton.Enabled = true;
            }
        }

        private void LoadData()
        {
            int userId = (int)Session["UserId"];

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"SELECT p.FirstName, p.LastName, p.Email, p.Mobile, p.Sex
                                 FROM Patients p
                                 INNER JOIN User_ u ON p.UserId = u.UserId
                                 WHERE u.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            string email = reader["Email"].ToString();
                            string phone = reader["Mobile"].ToString();
                            string sex = reader["Sex"].ToString();
                            PatientNameTextBox.Text = $"{firstName} {lastName}";
                            EmailTextBox.Text = email;
                            ContactNumberTextBox.Text = phone;
                            GenderDropDownList.Text = sex;
                        }
                    }
                }
            }
        }

        private void UpdateAppointment(int appointmentID, DateTime date, TimeSpan time, string name, string gender, string contact, string email, string reason, string clinicID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Open the connection at the beginning
                connection.Open();

                // Check if the time slot is available for the same date and category
                string checkQuery = @"SELECT COUNT(*) FROM Appointments 
                      WHERE AppointmentDate = @Date 
                      AND AppointmentTime = @Time 
                      AND Category = @Category
                      AND AppointmentID != @AppointmentID"; // Exclude current appointment

                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@Date", date);
                    checkCommand.Parameters.AddWithValue("@Time", time);
                    checkCommand.Parameters.AddWithValue("@Category", reason); // Ensure this parameter matches
                    checkCommand.Parameters.AddWithValue("@AppointmentID", appointmentID);

                    int count = (int)checkCommand.ExecuteScalar();
                    if (count > 0)
                    {
                        // Notify user that the time slot is booked
                        ScriptManager.RegisterStartupScript(this, GetType(), "TimeSlotBookedAlert",
                            "Swal.fire({ title: 'Time Slot Booked', text: 'The selected date and time slot with this category is already booked! Please choose another time or category.', icon: 'warning' });", true);
                        return;
                    }
                }

                // Update the appointment details in the database
                string query = @"UPDATE Appointments SET 
                     AppointmentDate = @Date, 
                     AppointmentTime = @Time, 
                     PatientName = @Name, 
                     Gender = @Gender, 
                     PhoneNumber = @Contact, 
                     Email = @Email, 
                     Category = @Reason,   
                     ClinicName = @ClinicID  
                     WHERE AppointmentID = @AppointmentID";

                using (SqlCommand updateCommand = new SqlCommand(query, connection))
                {
                    updateCommand.Parameters.AddWithValue("@Date", date);
                    updateCommand.Parameters.AddWithValue("@Time", time);
                    updateCommand.Parameters.AddWithValue("@Name", name);
                    updateCommand.Parameters.AddWithValue("@Gender", gender);
                    updateCommand.Parameters.AddWithValue("@Contact", contact);
                    updateCommand.Parameters.AddWithValue("@Email", email);
                    updateCommand.Parameters.AddWithValue("@Reason", reason); // Ensure this parameter matches
                    updateCommand.Parameters.AddWithValue("@ClinicID", clinicID); // Ensure this parameter matches
                    updateCommand.Parameters.AddWithValue("@AppointmentID", appointmentID);

                    updateCommand.ExecuteNonQuery();
                }

                // Notify user of successful update
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateSuccess",
                    "Swal.fire({ title: 'Success', text: 'Appointment updated successfully.', icon: 'success' });", true);
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
            public string ClinicID { get; set; } 
            public string Clinic { get; set; } 
        }

    }
}
