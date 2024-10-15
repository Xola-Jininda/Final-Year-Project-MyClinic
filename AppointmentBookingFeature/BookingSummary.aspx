<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingSummary.aspx.cs" Inherits="AppointmentBookingFeature.BookingSummary" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Booking Summary</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .summary-container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .summary-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .summary-container div {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        .value {
            display: inline-block;
            margin-left: 10px;
        }

        .button {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            text-align: center;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="summary-container">
        <h2>Booking Summary</h2>
        <div>
            <label>Date:</label>
            <span class="value" id="date"></span>
        </div>
        <div>
            <label>Time:</label>
            <span class="value" id="time"></span>
        </div>
        <div>
            <label>Patient Name:</label>
            <span class="value" id="patientName"></span>
        </div>
        <div>
            <label>Gender:</label>
            <span class="value" id="gender"></span>
        </div>
        <div>
            <label>Contact Number:</label>
            <span class="value" id="contactNumber"></span>
        </div>
        <div>
            <label>Email:</label>
            <span class="value" id="email"></span>
        </div>
        <div>
            <label>Reason for Visit:</label>
            <span class="value" id="reason"></span>
        </div>
        <a href="Default.aspx" class="button">New Booking</a>
    </div>
    <script>
        window.onload = function() {
            document.getElementById('date').innerText = '<%= Session["AppointmentDate"] %>';
            document.getElementById('time').innerText = '<%= Session["AppointmentTime"] %>';
            document.getElementById('patientName').innerText = '<%= Session["PatientName"] %>';
            document.getElementById('gender').innerText = '<%= Session["Gender"] %>';
            document.getElementById('contactNumber').innerText = '<%= Session["ContactNumber"] %>';
            document.getElementById('email').innerText = '<%= Session["Email"] %>';
            document.getElementById('reason').innerText = '<%= Session["Reason"] %>';
        }
    </script>
</body>
</html>
