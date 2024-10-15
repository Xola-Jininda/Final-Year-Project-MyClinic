<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="BookSummary.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.BookSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/PatientBookSummary.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="summary-container">
        <h2>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyClinicConnectionString2 %>" ProviderName="<%$ ConnectionStrings:MyClinicConnectionString2.ProviderName %>" SelectCommand="SELECT [FirstName] FROM [Admins] WHERE ([FirstName] = @FirstName)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="MessageLabel" DefaultValue="" Name="FirstName" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            Booking Summary</h2>
        <div>
            <label>Date:</label>
            <span class="value"><%= Session["AppointmentDate"] %></span>
        </div>
        <div>
            <label>Time:</label>
            <span class="value"><%= Session["AppointmentTime"] %></span>
        </div>
        <div>
            <label>Patient Name:</label>
            <span class="value"><%= Session["PatientName"] %></span>
        </div>
        <div>
            <label>Gender:</label>
            <span class="value"><%= Session["Gender"] %></span>
        </div>
        <div>
            <label>Contact Number:</label>
            <span class="value"><%= Session["ContactNumber"] %></span>
        </div>
        <div>
            <label>Email:</label>
            <span class="value"><%= Session["Email"] %></span>
        </div>
        

        <div>
            <label>Category:</label>
            <span class="value"><%= Session["Reason"] %></span>
        </div>

        <div>
            <asp:Label ID="MessageLabel" runat="server" Text=""></asp:Label>
        </div>
        <asp:Button class="button" ID="ConfirmButton" runat="server" Text="Submit" OnClick="ConfirmButton_Click" />
    </div>
</asp:Content>
