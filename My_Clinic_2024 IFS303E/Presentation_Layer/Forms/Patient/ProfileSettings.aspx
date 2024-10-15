<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="ProfileSettings.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.ProfileSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/PatientProfileSettings.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Profile Settings</h2>
        <div id="profileForm" runat="server">
            <div class="form-row">
                <div>
                    <asp:Label ID="FirstNameLabel" runat="server" Text="First Name:"></asp:Label>
                    <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="LastNameLabel" runat="server" Text="Last Name:"></asp:Label>
                    <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <asp:Label ID="DateOfBirthLabel" runat="server" Text="Date of Birth:"></asp:Label>
                    <asp:TextBox ID="DateOfBirthTextBox" runat="server" TextMode="Date" CssClass="input-field"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="BloodGroupLabel" runat="server" Text="Do you have any Medical Aid?:"></asp:Label>
                    <asp:DropDownList ID="BloodGroupDropDownList" runat="server" CssClass="input-field">
                        <asp:ListItem Text="---Select Option---" Value="" />
                        <asp:ListItem Text="Yes" Value="Yes" />
                        <asp:ListItem Text="No" Value="No" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <asp:Label ID="EmailLabel" runat="server" Text="Email Address:"></asp:Label>
                    <asp:TextBox ID="EmailTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="MobileLabel" runat="server" Text="Mobile Number:"></asp:Label>
                    <asp:TextBox ID="MobileTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <asp:Label ID="AddressLabel" runat="server" Text="Address:"></asp:Label>
                    <asp:TextBox ID="AddressTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="CityLabel" runat="server" Text="City:"></asp:Label>
                    <asp:TextBox ID="CityTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <asp:Label ID="ProvinceLabel" runat="server" Text="Province:"></asp:Label>
                    <asp:TextBox ID="ProvinceTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="ZipCodeLabel" runat="server" Text="Zip Code:"></asp:Label>
                    <asp:TextBox ID="ZipCodeTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
            </div>
            <div class="form-row">
                <div>
                    <asp:Label ID="CountryLabel" runat="server" Text="Country:"></asp:Label>
                    <asp:TextBox ID="CountryTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                </div>
            </div>
             <div>
                    <asp:Label ID="Label1" runat="server" Text="Sex:"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="input-field">
                        <asp:ListItem Text="---Select Sex---" Value="" />
                        <asp:ListItem Text="Male" Value="Male" />
                        <asp:ListItem Text="Female" Value="Female" />                       
                    </asp:DropDownList>
                </div>
            <div>
                <asp:Button ID="SaveButton" runat="server" Text="Save Changes" OnClick="SaveButton_Click" CssClass="button" />
            </div>
            <div>
                <asp:Label ID="MessageLabel" runat="server" CssClass="message"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
