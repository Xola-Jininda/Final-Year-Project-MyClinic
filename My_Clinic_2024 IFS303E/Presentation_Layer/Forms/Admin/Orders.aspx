<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include SweetAlert CSS and JS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link href="../../Styles/Orders.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="dashboard-container">
        <h2>Orders Management</h2>
        <asp:GridView ID="gvPayments" runat="server" CssClass="grid-view" AutoGenerateColumns="False" OnRowCommand="gvPayments_RowCommand" DataKeyNames="PaymentId">
    <Columns>
        <asp:BoundField DataField="PaymentId" HeaderText="#Order No" />
        <asp:BoundField DataField="FullName" HeaderText="Full Name" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:LinkButton ID="ManageButton" runat="server" CommandName="CloseOrder" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn-manage" Text="Close Order"></asp:LinkButton>
                <asp:LinkButton ID="CancelButton" runat="server" CssClass="btn-cancel" CommandName="CancelOrder" CommandArgument="<%# Container.DataItemIndex %>" Text="Cancel"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

        <asp:HiddenField ID="hfMessage" runat="server" />

    </div>

    <script type="text/javascript">
    window.onload = function() {
        var message = document.getElementById('<%= hfMessage.ClientID %>').value;
        if (message) {
            swal("Success", message, "success");
        }
    };
    </script>

</asp:Content>
