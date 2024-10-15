<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.Payment" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Styles/PatientPayment.css" rel="stylesheet" />

    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css" />
</head>
<body>
    <form id="form1" runat="server" class="payment-container">
        <div class="payment-panel">
            <div class="form-group">
               
                <asp:TextBox ID="txtPatientName" runat="server" ReadOnly="true" Visible="false" CssClass="input" />
            </div>
            <div class="form-group">
                
                <asp:TextBox ID="txtAddress" runat="server" ReadOnly="true" Visible="false" CssClass="input" />
            </div>
            <div class="form-group">
                <label for="txtAmount" class="label">Delivery Fee:</label>
                <asp:TextBox ID="txtAmount" runat="server" ReadOnly="true" Text="87" CssClass="input" />
            </div>
            <div class="form-group">
                <label for="txtCardNumber" class="label">Card Number:</label>
                <asp:TextBox ID="txtCardNumber" MaxLength="16" runat="server" CssClass="input" />
            </div>
            <div class="form-group">
                <label for="txtExpiryDate" class="label">Expiry Date:</label>
                <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="input" />
            </div>
            <div class="form-group">
                <label for="txtCVV" class="label">CVV:</label>
                <asp:TextBox ID="txtCVV" runat="server" MaxLength="3" CssClass="input" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmitPayment" runat="server" Text="Submit Payment" CssClass="btn-submit" OnClick="btnSubmitPayment_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" OnClick="btnCancel_Click" />
            </div>
            <asp:Literal ID="Literal1" runat="server" />
        </div>
    </form>

    <!-- SweetAlert and other scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

    <!-- SweetAlert script to be rendered here from code-behind -->
    <asp:Literal ID="ltlScript" runat="server"></asp:Literal>
</body>
</html>
