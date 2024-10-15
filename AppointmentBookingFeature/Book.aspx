<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="AppointmentBookingFeature.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Clinic Appointment Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        form {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        form div {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], select, textarea {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="text"]:focus, input[type="date"]:focus, select:focus, textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        button {
            display: inline-block;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            font-size: 12px;
        }

        .success {
            color: green;
            font-size: 12px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#AppointmentDateTextBox').change(function () {
                $('#SubmitButton').prop('disabled', false);
                $('#MessageLabel').text('');
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Select Date:"></asp:Label>
            <asp:TextBox ID="AppointmentDateTextBox" runat="server" TextMode="Date"></asp:TextBox>

            <asp:Label ID="Label2" runat="server" Text="Select Time:"></asp:Label>
            <asp:DropDownList ID="AppointmentTimeDropDownList" runat="server" Width="768px"></asp:DropDownList>

            <asp:Label ID="Label3" runat="server" Text="Patient Name:"></asp:Label>
            <asp:TextBox ID="PatientNameTextBox" runat="server"></asp:TextBox>

            <asp:Label ID="Label4" runat="server" Text="Gender:"></asp:Label>
            <asp:DropDownList ID="GenderDropDownList" runat="server" Width="768px">
                <asp:ListItem Text="Select Gender" Value="" />
                <asp:ListItem Text="Male" Value="Male" />
                <asp:ListItem Text="Female" Value="Female" />
                <asp:ListItem Text="Other" Value="Other" />
            </asp:DropDownList>

            <asp:Label ID="Label5" runat="server" Text="Contact Number:"></asp:Label>
            <asp:TextBox ID="ContactNumberTextBox" runat="server"></asp:TextBox>

            <asp:Label ID="Label6" runat="server" Text="Email Address:"></asp:Label>
            <asp:TextBox ID="EmailTextBox" runat="server"></asp:TextBox>

            <asp:Label ID="Label7" runat="server" Text="Reason for Visit:"></asp:Label>
            <asp:TextBox ID="ReasonTextBox" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>

            <asp:Button ID="SubmitButton" runat="server" Text="Book Appointment" OnClick="SubmitButton_Click" CssClass="button" />
            <asp:Label ID="MessageLabel" runat="server" CssClass=""></asp:Label>
        </div>
    </form>
</body>
</html>
