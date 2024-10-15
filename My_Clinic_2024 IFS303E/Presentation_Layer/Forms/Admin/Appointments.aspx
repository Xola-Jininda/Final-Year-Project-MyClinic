<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Appointments.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Appointments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Appointments.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <h2>Appointments Management</h2>
        <asp:GridView ID="gvAppointments" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date"  />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" />
             
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
