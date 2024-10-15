<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Doctors.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Doctors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/Doctors.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <h2>Doctors Management</h2>
        <asp:GridView ID="gvDoctors" runat="server" CssClass="grid-view" AutoGenerateColumns="False" DataKeyNames="DoctorID" OnRowCommand="gvDoctors_RowCommand">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Specialty" HeaderText="Specialty" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <!-- The CommandArgument passes the DoctorID -->
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="DeleteDoctor" CommandArgument='<%# Eval("DoctorID") %>' CssClass="btn-delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
