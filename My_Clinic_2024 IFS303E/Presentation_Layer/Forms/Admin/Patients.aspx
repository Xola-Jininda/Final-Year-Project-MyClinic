<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Patients.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Patients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Patients.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <h2>Patients Management</h2>
        <asp:GridView ID="gvPatients" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:BoundField DataField="Sex" HeaderText="Sex" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

