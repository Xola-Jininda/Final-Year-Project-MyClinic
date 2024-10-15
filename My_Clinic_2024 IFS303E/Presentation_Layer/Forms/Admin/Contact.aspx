<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   <style>
       .contact-container {
    width: 800px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.contact-title {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
}

.grid-view {
    width: 100%;
    border-collapse: collapse;
}

.grid-view th {
    background-color: #3CB371;
    color: white;
    padding: 10px;
}

.grid-view td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.grid-view tr:hover {
    background-color: #f1f1f1;
}

   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contact-container">
        <h2 class="contact-title">Review Contact Messages</h2>

        <asp:GridView ID="gvContacts" runat="server" AutoGenerateColumns="false" CssClass="grid-view" GridLines="None">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Message" HeaderText="Message" />
                <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>

        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red" />
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
            <% ViewState["AlertTitle"] = ""; %>
            <% ViewState["AlertText"] = ""; %>
            <% ViewState["AlertType"] = ""; %>
        }
    });
    </script>
</asp:Content>
