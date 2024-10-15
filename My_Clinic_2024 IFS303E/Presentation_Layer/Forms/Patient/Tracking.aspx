<%@ Page Title="Order Tracking" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="Tracking.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.Tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <style>
        .tracking-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }
        .tracking-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .tracking-header h1 {
            font-size: 24px;
            color: #333333;
        }
        .tracking-details {
            font-size: 16px;
            color: #666666;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .tracking-details p {
            margin: 10px 0;
        }
        .tracking-status {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            background-color: #f0f8ff;
        }
        .tracking-status h3 {
            font-size: 18px;
            color: #333333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="tracking-container">
        <div class="tracking-header">
            <h1>Order Tracking</h1>
        </div>
        <asp:Repeater ID="OrdersRepeater" runat="server">
    <ItemTemplate>
        <div class="tracking-details">
            <p><strong>Order ID:</strong> <%# Eval("PaymentId") %></p>
            <p><strong>Full Name:</strong> <%# Eval("FullName") %></p>
            <p><strong>Amount Paid:</strong> <%# Eval("AmountPaid") %></p>
            <p><strong>Delivery Address:</strong> <%# Eval("DeliveryAddress") %></p>
            <p><strong>Payment Date:</strong> <%# Eval("PaymentDate") %></p>
            <p><strong>Status:</strong> <%# Eval("Status") %></p> 
        </div>
    </ItemTemplate>
</asp:Repeater>
    </div>
</asp:Content>
