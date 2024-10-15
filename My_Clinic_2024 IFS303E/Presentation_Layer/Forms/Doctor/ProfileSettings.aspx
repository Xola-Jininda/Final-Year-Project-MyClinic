<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Doctor/Doctor.Master" AutoEventWireup="true" CodeBehind="ProfileSettings.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor.ProfileSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <link href="../../Styles/DoctorProfileSettings.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-wrapper">
        <div class="form-container">
            <h2>Doctor Profile Settings</h2>
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
                        <asp:Label ID="SpecializationLabel" runat="server" Text="Specialization:"></asp:Label>
                        <asp:DropDownList ID="SpecializationDropDownList" runat="server" CssClass="input-field">
                            <asp:ListItem Text="-- Select Specialization --" Value="" />
                        </asp:DropDownList>
                    </div>
                    <div>
                        <asp:Label ID="LicenseNumberLabel" runat="server" Text="Phone Number:"></asp:Label>
                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <asp:Label ID="EmailLabel" runat="server" Text="Email Address:"></asp:Label>
                        <asp:TextBox ID="EmailTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="MobileLabel" runat="server" Text="Clinic Address:"></asp:Label>
                        <asp:TextBox ID="ClinicAddressTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <asp:Label ID="ClinicAddressLabel" runat="server" Text="Clinic City:"></asp:Label>
                        <asp:TextBox ID="ClinicCityTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="ClinicCityLabel" runat="server" Text="Clinic Province:"></asp:Label>
                        <asp:TextBox ID="ClinicProvinceTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <asp:Label ID="ClinicProvinceLabel" runat="server" Text="Clinic Zip Code:"></asp:Label>
                        <asp:TextBox ID="ClinicZipCodeTextBox" runat="server" CssClass="input-field"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label ID="ClinicZipCodeLabel" runat="server" Text="Country:"></asp:Label>
                        <asp:TextBox ID="ClinicCountryTextBox" runat="server" CssClass="input-field"></asp:TextBox>
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
