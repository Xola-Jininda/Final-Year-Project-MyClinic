<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link href="../../Styles/Profile.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper">
        <div class="form-container">
            <h2>Admin Profile Settings</h2>
            <div id="doctorProfileForm" runat="server">
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
                        <asp:Label ID="EmailLabel" runat="server" Text="Email Address:"></asp:Label>
                        <asp:TextBox ID="EmailTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="PhoneNumberLabel" runat="server" Text="Phone Number:"></asp:Label>
                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="input-field" ></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <asp:Label ID="DOB" runat="server" Text="Date of Birth:"></asp:Label>
                        <asp:TextBox ID="DOBTextBox" runat="server" CssClass="input-field"
                            TextMode="Date"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="AddressLabel" runat="server" Text="Address:"></asp:Label>
                        <asp:TextBox ID="AddressTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <asp:Label ID="ProvinceLabel" runat="server" Text="Province:"></asp:Label>
                        <asp:TextBox ID="ProvinceTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="CityLabel" runat="server" Text="City:"></asp:Label>
                        <asp:TextBox ID="CityTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div>
                        <asp:Label ID="CountryLabel" runat="server" Text="Country:"></asp:Label>
                        <asp:TextBox ID="tBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="ZipLabel" runat="server" Text="Zip Code:"></asp:Label>
                        <asp:TextBox ID="ZipCodeTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>

                <div>
                    <asp:Button ID="SubmitPrescription" runat="server" Text="Save Changes" OnClick="SaveButton_Click" CssClass="button" />
                </div>
                <div>
                    <asp:Label ID="MessageLabel" runat="server" CssClass="message"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
