<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/PatientBook.css" rel="stylesheet" />
    <script>
        $(document).ready(function () {
            $('#AppointmentDateTextBox').change(function () {
                $('#SubmitButton').prop('disabled', false);
                $('#MessageLabel').text('');
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2 class="form-title">Book an Appointment</h2>

        <asp:Label ID="MessageLabel" runat="server" CssClass="error"></asp:Label>

        <!-- Appointment Date -->
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Select Date:"></asp:Label>
            <asp:TextBox ID="AppointmentDateTextBox" runat="server" TextMode="Date"></asp:TextBox>
        </div>

        <!-- Appointment Time -->
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Select Time:"></asp:Label>
            <asp:DropDownList ID="AppointmentTimeDropDownList" runat="server"></asp:DropDownList>
        </div>

        <!-- Patient Name -->
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Patient Name:" Visible="False"></asp:Label>
            <asp:TextBox ID="PatientNameTextBox" runat="server" Visible="False"></asp:TextBox>
        </div>

        <!-- Gender -->
        <div class="form-group">
            <asp:Label ID="Label4" runat="server" Text="Gender:" Visible="False"></asp:Label>
            <asp:DropDownList ID="GenderDropDownList" runat="server" Visible="False">
                <asp:ListItem Text="Select Gender" Value="" />
                <asp:ListItem Text="Male" Value="Male" />
                <asp:ListItem Text="Female" Value="Female" />
                <asp:ListItem Text="Other" Value="Other" />
            </asp:DropDownList>
        </div>

        <!-- Contact Number -->
        <div class="form-group">
            <asp:Label ID="Label5" runat="server" Text="Contact Number:" Visible="False"></asp:Label>
            <asp:TextBox ID="ContactNumberTextBox" runat="server" Visible="False"></asp:TextBox>
        </div>

        <!-- Email Address -->
        <div class="form-group">
            <asp:Label ID="Label6" runat="server" Text="Email Address:" Visible="False"></asp:Label>
            <asp:TextBox ID="EmailTextBox" runat="server" ReadOnly="True" Visible="False"></asp:TextBox>
        </div>

        <!-- Clinic -->
        <div class="form-group">
            <asp:Label ID="Label8" runat="server" Text="Clinic:" Visible="false"></asp:Label>
            <asp:DropDownList ID="ClinicDropDownList" runat="server" Visible="false"></asp:DropDownList>
        </div>



        <!-- Category -->
        <div class="form-group">
            <asp:Label ID="Label7" runat="server" Text="Category:"></asp:Label>
            <asp:DropDownList ID="Reason" runat="server"></asp:DropDownList>
        </div>

        <!-- Submit Button -->
        <div>
            <asp:Button ID="SubmitButton" runat="server" Text="Next" OnClick="SubmitButton_Click" CssClass="submit-btn" />
        </div>
    </div>

    <asp:HiddenField ID="HiddenFieldAppointmentID" runat="server" />
</asp:Content>
