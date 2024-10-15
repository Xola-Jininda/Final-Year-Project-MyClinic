<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Reports.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <div class="center-container">
        <h1>Select a Report to View</h1>

        <!-- Button Card Container -->
        <div class="card-container">
            <asp:Button ID="btnRevenueReportt" runat="server" Text="Load Revenue Report" CssClass="card"  />
            <asp:Button ID="btnPatientInfoRepor" runat="server" Text="Load Patient Info Report" CssClass="card" />
            <asp:Button ID="btnEmergencyReport" runat="server" Text="Load Emergency Report" CssClass="card"  />
            <asp:Button ID="btnDoctorReport" runat="server" Text="Load Doctor Report" CssClass="card" OnClick="btnDoctorReport_Click" />
        </div>

        <!-- Report Viewer -->
        <div class="report-viewer-container">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="514px" Width="685px"></rsweb:ReportViewer>
        </div>
        
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    </div>
</asp:Content>
