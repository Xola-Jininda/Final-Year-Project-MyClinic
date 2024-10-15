<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Speciality.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Speciality" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Speciality.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center-wrapper">
        <div class="form-container">
            <h2 class="form-title">Add New Speciality</h2>

            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" />

            <!-- Speciality Dropdown -->
            <div class="form-group">
                <label for="Speciality">Select Speciality:</label>
                <asp:DropDownList ID="ddlSpeciality" runat="server" CssClass="dropdown">
                    
                    <asp:ListItem Text="-- Select Speciality --" Value="" />
                    <asp:ListItem Text="Dentist" Value="Dentist" />
                    <asp:ListItem Text="General Practitioner" Value="General Practitioner" />
                    <asp:ListItem Text="Cardiologist" Value="Cardiologist" />
                    <asp:ListItem Text="Orthopedic" Value="Orthopedic" />
                    <asp:ListItem Text="Dermatologist" Value="Dermatologist" />
                    
                </asp:DropDownList>
            </div>

            <!-- Submit Button -->
            <asp:Button ID="btnAddSpeciality" runat="server" CssClass="submit-btn" Text="Add Speciality" OnClick="btnAddSpeciality_Click" />
        </div>
    </div>
</asp:Content>
