<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Doctor/Doctor.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor.Reports" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/DoctorReports.css" rel="stylesheet" />

    <script type="text/javascript">
        // SweetAlert functions remain unchanged
        function showLoadingAlert() {
            Swal.fire({
                title: 'Loading Report...',
                text: 'Please wait while the report is being loaded',
                icon: 'info',
                allowOutsideClick: false,
                showConfirmButton: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
        }

        function closeLoadingAlert() {
            Swal.close();
        }

        function reportButtonClick(buttonId) {
            showLoadingAlert();
            setTimeout(function () {
                closeLoadingAlert();
            }, 5000);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="center-container">
        <h1>Select a Report to View</h1>
        <div class="card-container">
            <asp:Button ID="btnPatientInfoReport" runat="server" Text="Load Patient Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnPatientInfoReport_Click" />
            <asp:Button ID="btnAppointmentsReport" runat="server" Text="Load Appointments Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnAppointmentsReport_Click" />
        </div>
        <!-- Report Viewer -->
        <div class="report-viewer-container">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="600px" Width="900px"></rsweb:ReportViewer>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    </div>
</asp:Content>
