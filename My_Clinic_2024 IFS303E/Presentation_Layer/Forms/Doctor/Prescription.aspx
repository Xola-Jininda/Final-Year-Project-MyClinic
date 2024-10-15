<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Doctor/Doctor.Master" AutoEventWireup="true" CodeBehind="Prescription.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor.Prescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SweetAlert CSS and JS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Include jQuery and jQuery UI for DatePicker -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link href="../../Styles/DoctorPrescription.css" rel="stylesheet" />
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="prescription-form-container">
        <h2>Prescribe Medication</h2>
        <asp:HiddenField ID="txtAppointmentID" runat="server" />

        <label for="txtPatientName">Patient Name:</label>
        <asp:TextBox ID="txtPatientName" runat="server" CssClass="w3-input" ReadOnly="true"></asp:TextBox>


        <label for="txtMedicationName">Medication Name:</label>
        <asp:TextBox ID="txtMedicationName" runat="server" CssClass="w3-input"></asp:TextBox>

        <label for="txtDosage">Dosage:</label>
        <asp:DropDownList ID="txtDosage" runat="server" CssClass="w3-input">
            <asp:ListItem Text="Take 1 pill per day" Value="1 pill per day"></asp:ListItem>
            <asp:ListItem Text="Take 2 pills per day" Value="2 pills per day"></asp:ListItem>
            <asp:ListItem Text="Take 3 pills per day" Value="3 pills per day"></asp:ListItem>
            <asp:ListItem Text="Take 1 pill twice a day" Value="1 pill twice a day"></asp:ListItem>
        </asp:DropDownList>

        <label for="txtDuration">Notes:</label>
       
        <asp:DropDownList ID="txtDuration" runat="server" CssClass="w3-input">
            <asp:ListItem>Choose</asp:ListItem>
            <asp:ListItem>Take for 3 days</asp:ListItem>
            <asp:ListItem>Take for 4 days</asp:ListItem>
            <asp:ListItem>Take for 5 days</asp:ListItem>
            <asp:ListItem>Take for 6 days</asp:ListItem>
            <asp:ListItem>Take for 7 days</asp:ListItem>
            <asp:ListItem>Until finished</asp:ListItem>
            <asp:ListItem>Ongoing Medication</asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>

        <label for="txtCollectionDate">Collection Date:</label>
        <asp:TextBox ID="txtCollectionDate" runat="server" CssClass="w3-input" placeholder="Select Collection Date"></asp:TextBox>

        <asp:Button ID="btnPrescribe" runat="server" CssClass="w3-button w3-green" Text="Submit" OnClick="btnPrescribe_Click" />
        <asp:Button ID="btnCancel" runat="server" CssClass="w3-button w3-red" Text="Cancel" />
    </div>

    <script type="text/javascript">
        // JavaScript functions can be used as needed
        function prescribeMedication() {
            // JavaScript code to interact with ASP.NET server-side logic if needed
        }
    </script>

    <script>
        $(function () {
            // Initialize DatePicker with restrictions on past dates and weekends
            $("#<%= txtCollectionDate.ClientID %>").datepicker({
            minDate: 0, // Prevent selecting past dates
            beforeShowDay: function (date) {
                // Disable weekends (Saturday and Sunday)
                var day = date.getDay();
                return [(day != 0 && day != 6), ''];
            },
            dateFormat: 'yy-mm-dd' // Set the format of the date
        });
    });
</script>
</asp:Content>
