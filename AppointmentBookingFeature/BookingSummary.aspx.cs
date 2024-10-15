using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppointmentBookingFeature
{
    public partial class BookingSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Appointment"] != null)
                {
                    var appointment = (Default.Appointment)Session["Appointment"];
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
                    Response.Redirect("Default.aspx");
                }
            }
        }
    }
}