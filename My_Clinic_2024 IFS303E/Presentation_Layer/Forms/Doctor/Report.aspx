<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor.Report" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Viewer</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="../../Styles/DoctorReport.css" rel="stylesheet" />
    
    <script type="text/javascript">
        // SweetAlert functions
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
            // Simulate report loading delay; replace with actual report loading logic
            setTimeout(function () {
                closeLoadingAlert();
            }, 5000);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="center-container">
            <h1>Select a Report to View</h1>
            <div class="card-container">
                <asp:Button ID="btnPatientInfoReport" runat="server" Text="Load Patient Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnPatientInfoReport_Click" />
                <asp:Button ID="btnAppointmentsReport" runat="server" Text="Load Appointments Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnAppointmentsReport_Click" />
            </div>
            <!-- Back to Dashboard Button -->
            <asp:Button ID="btnBackToDashboard" runat="server" Text="Back to Dashboard" CssClass="card" OnClick="btnBackToDashboard_Click" />
            <!-- Report Viewer -->
            <div class="report-viewer-container">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="514px" Width="774px"></rsweb:ReportViewer>
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        </div>
    </form>
</body>
</html>
