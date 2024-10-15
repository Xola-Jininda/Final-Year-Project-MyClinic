<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Doctor/Doctor.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Doctor.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <link href="../../Styles/DoctorDashboard.css" rel="stylesheet" />

    <style>
        <style>
        /* Styling the overall page layout */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .w3-container {
            padding: 16px;
        }

        /* Dashboard Header */
        header h5 {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        /* Dashboard Cards */
        .w3-container {
            transition: transform 0.3s ease-in-out;
        }

        .w3-container:hover {
            transform: translateY(-5px);
        }

        .w3-green, .w3-green-theme {
            background-color: #3CB371 !important;
            color: white;
        }

        .w3-quarter {
            margin-bottom: 20px;
        }

        .w3-quarter h4 {
            font-size: 18px;
            font-weight: bold;
        }

        .w3-quarter i {
            opacity: 0.7;
        }

        /* GridView */
        .grid-view {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .grid-view th {
            background-color: #3CB371;
            color: white;
            padding: 10px;
            text-align: left;
        }

        .grid-view td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        .grid-view tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .grid-view tr:hover {
            background-color: #e0f7fa;
        }

        /* Buttons */
        .w3-button {
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
            border-radius: 4px;
        }

        .w3-button.w3-red {
            background-color: #f44336;
        }

        .w3-button.w3-red:hover {
            background-color: #d32f2f;
        }

        .w3-button.w3-green {
            background-color: #4CAF50;
        }

        .w3-button.w3-green:hover {
            background-color: #388E3C;
        }

        /* Prescribe Form */
        #prescriptionForm {
            display: none;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        #prescriptionForm input, #prescriptionForm textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        /* SweetAlert Customization */
        .swal2-popup {
            font-size: 1.6rem !important;
        }

    </style>
   
    <script>
        function showPrescriptionForm(appointmentId, patientName, patientId) {
            document.getElementById("txtAppointmentID").value = appointmentId;
            document.getElementById("txtPatientName").value = patientName;
            document.getElementById("txtPatientID").value = patientId;
            document.getElementById("prescriptionForm").style.display = 'block';
        }

        function prescribeMedication() {
            var patientName = document.getElementById("txtPatientName").value;
            var patientID = document.getElementById("txtPatientID").value;
            var medicationName = document.getElementById("txtMedicationName").value;
            var dosage = document.getElementById("txtDosage").value;
            var instructions = document.getElementById("txtInstructions").value;
            var collectionDate = document.getElementById("txtCollectionDate").value; // ISO format date

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "PrescriptionHandler.aspx", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.status === "success") {
                            Swal.fire({
                                title: 'Success!',
                                text: 'Medication has been prescribed.',
                                icon: 'success',
                                allowOutsideClick: false, // Alert won't close on outside click
                                allowEscapeKey: false,    // Alert won't close on escape
                                allowEnterKey: false      // Alert won't close on enter
                            }).then(() => {
                                hidePrescriptionForm();
                            });
                        } else {
                            Swal.fire({
                                title: 'Error!',
                                text: response.message || 'Failed to prescribe medication.',
                                icon: 'error',
                                allowOutsideClick: false,
                                allowEscapeKey: false,
                                allowEnterKey: false
                            });
                        }
                    } else {
                        Swal.fire({
                            title: 'Error!',
                            text: 'Failed to connect to the server.',
                            icon: 'error',
                            allowOutsideClick: false,
                            allowEscapeKey: false,
                            allowEnterKey: false
                        });
                    }
                }
            };


            xhr.send(JSON.stringify({
                patientName: patientName,
                patientID: patientID,
                medicationName: medicationName,
                dosage: dosage,
                instructions: instructions,
                collectionDate: collectionDate // ISO format date
            }));
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <!-- !PAGE CONTENT! -->
    <div class="w3-main" style="margin-left: 300px; margin-top: 43px;">
        <!-- Header -->
        <header class="w3-container" style="padding-top: 22px">
            <h5><b><i class="fa fa-dashboard"></i>MyClinic Dashboard</b></h5>
        </header>

        <div class="w3-row-padding w3-margin-bottom">
            <div class="w3-quarter">
                <div class="w3-container w3-green w3-padding-16" onclick="toggleDetails('appointments')">
                    <div class="w3-left"><i class="fa fa-calendar w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblAppointmentCount" runat="server" Text=""></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Upcoming Appointments</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-green-theme w3-padding-16" onclick="toggleDetails('appointments')">
                    <div class="w3-left"><i class="fa fa-user-md w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblPastAppointments" runat="server" Text=""></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Past Appointments</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-green-theme w3-padding-16" onclick="toggleDetails('records')">
                    <div class="w3-left"><i class="fa fa-file-medical w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblTotalAppointmentsCount" runat="server" Text=""></asp:Label>
                        </h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>All Appointments</h4>
                </div>
            </div>


            <div class="w3-quarter">
                <div class="w3-container w3-green-theme w3-padding-16" onclick="toggleDetails('patients')">
                    <div class="w3-left"><i class="fa fa-file-medicalb w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblPatients" runat="server" Text=""></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>My Patients</h4>
                </div>
            </div>
        </div>

        <div id="appointments" class="w3-container w3-hide">
            <h5>Appointments Details</h5>
            <p>List of appointments goes here...</p>
        </div>
        <div id="patients" class="w3-container w3-hide">
            <h5>Patients Details</h5>
            <p>List of patients goes here...</p>
        </div>
        <div id="records" class="w3-container w3-hide">
            <h5>Records Details</h5>
            <p>List of medical records goes here...</p>
        </div>
        <div id="reports" class="w3-container w3-hide">
            <h5>Reports Details</h5>
            <p>List of reports goes here...</p>
        </div>



        <!-- Appointments GridView -->
        <div class="w3-container">
            <h5>Upcoming Appointments</h5>
            <asp:GridView ID="GridViewAppointments" runat="server" AutoGenerateColumns="False" CssClass="grid-view" OnRowCommand="GridViewAppointments_RowCommand" OnRowDataBound="GridViewAppointments_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="AppointmentID" HeaderText="Appointment ID" Visible="False" />
                    <asp:BoundField DataField="PatientID" HeaderText="Patient ID" Visible="False" />
                    <asp:BoundField DataField="DoctorID" HeaderText="Doctor ID" Visible="False" />
                    <asp:BoundField DataField="AdminID" HeaderText="Admin ID" Visible="False" />
                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                    <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="AppointmentTime" HeaderText="Time" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" Visible="False" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="CancelAppointment" CommandArgument='<%# Eval("AppointmentID") %>' CssClass="w3-button w3-red" />
                            <asp:Button ID="btnPrescribe" runat="server" Text="Prescribe" CommandName="Prescribe" CommandArgument='<%# Eval("AppointmentID") %>' CssClass="w3-button w3-green" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
