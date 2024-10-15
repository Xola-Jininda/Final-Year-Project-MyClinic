<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Patient/Patient.Master" AutoEventWireup="true" CodeBehind="DeliveryForm.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.DeliveryForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

     <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="../../Styles/DeliveryForm.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 <script>
     document.addEventListener("DOMContentLoaded", function () {
         // Check if the user is authenticated and address is verified
         var addressVerified = '<%= Session["PatientAddressVerified"] %>'; // Replace this with your actual check

    if (!addressVerified) {
        Swal.fire({
            title: 'Address Verification Required',
            text: 'Have you verified your address in Profile Settings?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Yes, I have verified',
            cancelButtonText: 'No, take me to Profile Settings'
        }).then((result) => {
            if (result.isDismissed || result.isDenied) {
                // Redirect to Profile Settings if the user hasn't verified their address
                window.location.href = '<%= ResolveUrl("~/Presentation_Layer/Forms/Patient/ProfileSettings.aspx") %>';
            } else {
                // If they confirmed they have verified their address, close the alert and do nothing
                Swal.close();
            }
        });
         }
     });

     function requestDelivery(prescriptionId, collectionDate) {
         var currentDate = new Date();
         var collectionDateObj = new Date(collectionDate);

         // Check if the current date is before the collection date
         if (currentDate < collectionDateObj) {
             Swal.fire({
                 title: 'Not Allowed',
                 text: 'The collection date has not arrived yet. Please wait until ' + collectionDateObj.toLocaleDateString() + '.',
                 icon: 'warning'
             });
             return; // Stop the function execution
         }

         // If the collection date has arrived or passed, proceed with the request
         $.ajax({
             type: "POST",
             url: "DeliveryForm.aspx/StorePatientDetailsInSession",
             data: JSON.stringify({ prescriptionId: prescriptionId }),
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: function (response) {
                 if (response.d === "Success") {
                     $.ajax({
                         type: "POST",
                         url: "DeliveryForm.aspx/RequestDelivery",
                         data: JSON.stringify({ prescriptionId: prescriptionId }),
                         contentType: "application/json; charset=utf-8",
                         dataType: "json",
                         success: function (response) {
                             if (response.d === "Success") {
                                 window.location.href = 'Payment.aspx?PrescriptionId=' + prescriptionId;
                             } else {
                                 Swal.fire({
                                     title: 'Error',
                                     text: 'Failed to request delivery. Please try again.',
                                     icon: 'error'
                                 });
                             }
                         },
                         error: function (xhr, status, error) {
                             console.error("Error:", status, error);
                             Swal.fire({
                                 title: 'Error',
                                 text: 'An error occurred. Please try again later.',
                                 icon: 'error'
                             });
                         }
                     });
                 } else {
                     Swal.fire({
                         title: 'Error',
                         text: 'Failed to store patient details. Please try again.',
                         icon: 'error'
                     });
                 }
             },
             error: function (xhr, status, error) {
                 console.error("Error:", status, error);
                 Swal.fire({
                     title: 'Error',
                     text: 'An error occurred. Please try again later.',
                     icon: 'error'
                 });
             }
         });
     }
 </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <div class="container mt-4">
            <div class="page-header text-center">
                <h1>Medication Delivery Requests</h1>
                <p>Manage and request your medication deliveries easily.</p>
            </div>
            <asp:Panel ID="PrescriptionsPanel" runat="server" CssClass="row">
                <!-- Medication cards will be dynamically added here -->
            </asp:Panel>
        </div>
    </div>

    <asp:HiddenField ID="hdnPrescriptionId" runat="server" />

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

</asp:Content>
