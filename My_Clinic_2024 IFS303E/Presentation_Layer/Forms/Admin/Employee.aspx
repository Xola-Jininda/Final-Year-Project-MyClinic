<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Employee.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Center wrapper to vertically and horizontally center the form -->
    <div class="center-wrapper">
        <div class="form-container">
            <h2 class="form-title">Add New Employee</h2>
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" />

            <!-- Radio Buttons -->
            <div class="form-group">
                <label for="EmployeeType">Select Employee Type:</label>
                <div class="radio-group">
                    <asp:RadioButton ID="rbtnAdmin" runat="server" GroupName="EmployeeType" Text="Admin" />
                    <asp:RadioButton ID="rbtnDoctor" runat="server" GroupName="EmployeeType" Text="Doctor" />
                    <asp:RadioButton ID="rbtnParamedic" runat="server" GroupName="EmployeeType" Text="Paramedic" />
                </div>
            </div>


            <!-- Username -->
            <div class="form-group">
                <label for="Username">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-text" placeholder="Enter Username"></asp:TextBox>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="Password">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="input-text" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            </div>

            <!-- Submit Button -->
            <asp:Button ID="btnAddEmployee" runat="server" CssClass="submit-btn" Text="Add Employee" OnClick="btnAddEmployee_Click" />
        </div>
    </div>
</asp:Content>
