<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Clinic.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Clinic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/Clinic.css" rel="stylesheet" />
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2 class="form-title">Add New Clinic Branch</h2>

        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" />

        <!-- Clinic Name -->
        <div class="form-group">
            <label for="ClinicName">Clinic Name:</label>
            <asp:TextBox ID="txtClinicName" runat="server" CssClass="input-text" placeholder="Enter Clinic Name"></asp:TextBox>
        </div>

        <!-- Address -->
        <div class="form-group">
            <label for="Address">Address:</label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="input-text" placeholder="Enter Address"></asp:TextBox>
        </div>

        <!-- City -->
        <div class="form-group">
            <label for="City">City:</label>
            <asp:TextBox ID="txtCity" runat="server" CssClass="input-text" placeholder="Enter City"></asp:TextBox>
        </div>

        <!-- Province -->
        <div class="form-group">
            <label for="Province">Province:</label>
            <asp:TextBox ID="txtProvince" runat="server" CssClass="input-text" placeholder="Enter Province"></asp:TextBox>
        </div>

        <!-- Country -->
        <div class="form-group">
            <label for="Country">Country:</label>
            <asp:TextBox ID="txtCountry" runat="server" CssClass="input-text" placeholder="Enter Country"></asp:TextBox>
        </div>

        <!-- Zip Code -->
        <div class="form-group">
            <label for="ZipCode">Zip Code:</label>
            <asp:TextBox ID="txtZipCode" runat="server" CssClass="input-text" placeholder="Enter Zip Code"></asp:TextBox>
        </div>

        <!-- Submit Button -->
        <asp:Button ID="btnAddClinic" runat="server" CssClass="submit-btn" Text="Add Clinic" OnClick="btnAddClinic_Click" />
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <script>

    function showSweetAlert(title, text, type) {
        Swal.fire({
            title: title,
            text: text,
            icon: type,
            confirmButtonText: 'OK'
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        var alertTitle = '<%= ViewState["AlertTitle"] %>';
        var alertText = '<%= ViewState["AlertText"] %>';
        var alertType = '<%= ViewState["AlertType"] %>';
        
        if (alertTitle && alertText && alertType) {
            showSweetAlert(alertTitle, alertText, alertType);
            // Clear the ViewState after showing the alert
            <% ViewState["AlertTitle"] = ""; %>
            <% ViewState["AlertText"] = ""; %>
            <% ViewState["AlertType"] = ""; %>
        }
    });
    </script>

</asp:Content>
