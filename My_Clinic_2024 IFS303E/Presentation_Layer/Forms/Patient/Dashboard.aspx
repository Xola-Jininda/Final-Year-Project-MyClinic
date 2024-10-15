<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.DSH" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/PatientDashboard.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <h2>Upcoming Appointments</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:GridView ID="UpcomingAppointmentsGridView" runat="server" CssClass="grid-view" AutoGenerateColumns="False" OnSelectedIndexChanged="UpcomingAppointmentsGridView_SelectedIndexChanged" OnRowCommand="UpcomingAppointmentsGridView_RowCommand">
            <Columns>
                <asp:BoundField DataField="AppointmentDate" HeaderText="Date" SortExpression="AppointmentDate" />
                <asp:BoundField DataField="AppointmentTime" HeaderText="Time" SortExpression="AppointmentTime" />
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" SortExpression="PatientName" Visible="False" />
                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" Visible="False" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                <asp:BoundField DataField="Category" HeaderText="Reason for Visit" SortExpression="Category" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="CancelAppointmentButton" runat="server" Text="Cancel" CommandName="CancelAppointment"
                            CommandArgument='<%# Eval("AppointmentID") %>' CssClass="btn-cancel" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="ManageButton" runat="server" CommandName="Manage" CommandArgument='<%# Eval("AppointmentID") %>' CssClass="btn-manage" Text="Manage"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <h2>Past Appointments</h2>
        <asp:GridView ID="PastAppointmentsGridView" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="AppointmentDate" HeaderText="Date" SortExpression="AppointmentDate" />
                <asp:BoundField DataField="AppointmentTime" HeaderText="Time" SortExpression="AppointmentTime" />
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" SortExpression="PatientName" />
                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                <asp:BoundField DataField="Category" HeaderText="Reason for Visit" SortExpression="Category" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
