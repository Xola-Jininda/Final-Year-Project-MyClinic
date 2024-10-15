<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report1.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Reports.Report1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Info Report</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 -->
    <style>
        /* Style to center the content */
        .center-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh; /* Ensures it takes the full height of the viewport */
            text-align: center;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Style for the button cards */
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
        }

        .card {
            background-color: #4CAF50; /* Slightly muted green */
            color: white;
            padding: 15px;
            font-size: 16px; /* Lighter font */
            font-weight: 500;
            text-align: center;
            border-radius: 8px; /* Softer corners */
            width: 250px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s, background-color 0.2s;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }

        .card:hover {
            transform: translateY(-3px); /* Lighter movement */
            background-color: #45a049; /* Softer hover color */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Softer shadow on hover */
        }

        /* Style for the report viewer */
        .center-container #ReportViewer1 {
            width: 100%; /* Take the full width of the container */
            max-width: 900px; /* Ensure it's not too wide */
            height: 600px; /* Adjust height as needed */
            margin: 0 auto; /* Center it horizontally */
        }

        /* Container to ensure the ReportViewer has spacing */
        .report-viewer-container {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Typography improvement */
        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Button container responsiveness */
        @media (max-width: 768px) {
            .card-container {
                flex-direction: column;
                gap: 15px;
            }

            .card {
                width: 100%; /* Full width for smaller screens */
            }
        }
    </style>
    <script type="text/javascript">
        // Function to show SweetAlert loading message
        function showLoadingAlert() {
            Swal.fire({
                title: 'Loading Report...',
                text: 'Please wait while the report is being loaded',
                icon: 'info',
                allowOutsideClick: false, // Prevent closing by clicking outside
                showConfirmButton: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
        }

        // Function to close the SweetAlert when the report is loaded
        function closeLoadingAlert() {
            Swal.close();
        }

        // Event listener to handle the loading animation when a button is clicked
        function reportButtonClick(buttonId) {
            // Show loading alert when button is clicked
            showLoadingAlert();

            // Simulate report loading for 5 seconds
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
            
            <!-- Button Card Container -->
            <div class="card-container">
                <asp:Button ID="btnRevenueReportt" runat="server" Text="Load Revenue Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="Button1_Click" />
                <asp:Button ID="btnPatientInfoRepor" runat="server" Text="Load Patient Info Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnPatientInfoRepor_Click"/>
                <asp:Button ID="btnEmergencyReport" runat="server" Text="Load Emergency Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnEmergencyReport_Click" />
                <asp:Button ID="btnDoctorReport" runat="server" Text="Load Doctor Report" CssClass="card" OnClientClick="reportButtonClick(this.id)" OnClick="btnDoctorReport_Click" />
                <!-- Back to Dashboard Button -->
                <asp:Button ID="btnBackToDashboard" runat="server" Text="Back to Dashboard" CssClass="card" OnClick="btnBackToDashboard_Click" />
            </div>

            <!-- Report Viewer -->
            <div class="report-viewer-container">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="514px" Width="685px"></rsweb:ReportViewer>
            </div>
            
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        </div>
    </form>
</body>
</html>
