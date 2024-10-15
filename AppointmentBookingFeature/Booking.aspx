<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="AppointmentBookingFeature.Booking" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Clinic Appointment Booking</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Styles/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Book an Appointment</h2>
            <div class="form-group">
                <label for="Name">Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name" />
            </div>
            <div class="form-group">
                <label for="Email">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email" />
            </div>
            <div class="form-group">
                <label for="PhoneNumber">Phone Number</label>
                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" placeholder="Enter your phone number" />
            </div>
            <div class="form-group">
                <label for="AppointmentDate">Appointment Date</label>
                <asp:TextBox ID="txtAppointmentDate" runat="server" CssClass="form-control" placeholder="Select a date" TextMode="Date" />
            </div>
            <div class="form-group">
                <label for="AppointmentTime">Appointment Time</label>
                <asp:TextBox ID="txtAppointmentTime" runat="server" CssClass="form-control" placeholder="Select a time" TextMode="Time" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Book Appointment" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
    <script src="Js/jquery.min.js"></script>
    <script src="Js/bootstrap.min.js"></script>
</body>

</html>
