<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Paramedics/Paramedic.Master" AutoEventWireup="true" CodeBehind="Dash.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Paramedics.Dash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Style.css" rel="stylesheet" />
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css">

    <style>
        .request-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            transition: box-shadow 0.3s;
        }

            .request-card:hover {
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }

        .request-header {
            color: #2e7d32;
            font-weight: bold;
        }

        .highlight-emergency {
            background-color: rgba(255, 0, 0, 0.3); /* Light red */
        }

        .normal {
            background-color: white; /* Default background */
        }

        @keyframes blink {
            0%, 100% {
                background-color: rgba(255, 0, 0, 0.3); /* Light red */
            }

            50% {
                background-color: white; /* Default background */
            }
        }

        .blinking {
            animation: blink 1s infinite; /* Blinks every second */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />


            <h2 class="my-4">Ambulance Request Overview</h2>

        <!-- Counters for Request Status -->
        <div class="row mb-4">
            <div class="col-md-4 text-center">
                <div class="counter-box bg-danger text-white p-3">
                    <h5>Requested</h5>
                    <asp:Label ID="lblRequestedCount" runat="server" Text="0" CssClass="counter-value"></asp:Label>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="counter-box bg-warning text-white p-3">
                    <h5>In Progress</h5>
                    <asp:Label ID="lblInProgressCount" runat="server" Text="0" CssClass="counter-value"></asp:Label>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="counter-box bg-success text-white p-3">
                    <h5>Completed</h5>
                    <asp:Label ID="lblCompletedCount" runat="server" Text="0" CssClass="counter-value"></asp:Label>
                </div>
            </div>
        </div>

        <h2 class="my-4">Active Ambulance Requests</h2>
        <div class="row">
            <asp:ListView ID="RequestsListView" runat="server" OnItemCommand="RequestsListView_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-6 mb-3">
                        <div class="request-card border p-3 <%# GetBackgroundClass(Eval("IsLifeThreatening").ToString()) %> <%# Eval("IsLifeThreatening").ToString() == "Yes" ? "blinking" : "" %>">
                            <h5 class="request-header">Request ID: <%# Eval("RequestID") %></h5>
                            <p><strong>Emergency Description:</strong> <%# Eval("EmergencyDescription") %></p>
                            <p><strong>Location:</strong> <%# Eval("Location") %></p>
                            <p><strong>Life Threatening:</strong> <%# Eval("IsLifeThreatening") %></p>
                            <p><strong>Is Conscious:</strong> <%# Eval("IsConscious") %></p>
                            <p><strong>Patient Name:</strong> <%# Eval("PatientName") %></p>
                            <p><strong>Patient Age:</strong> <%# Eval("PatientAge") %></p>
                            <p><strong>Condition Description:</strong> <%# Eval("ConditionDescription") %></p>
                            <p><strong>Request Date:</strong> <%# Eval("RequestDate", "{0:yyyy-MM-dd HH:mm:ss}") %></p>
                            <p><strong>Status:</strong> <%# Eval("Status") %></p>
                            <asp:Button ID="UpdateStatusButton" runat="server" Text="Update Status" CommandName="UpdateStatus" CommandArgument='<%# Eval("RequestID") %>' CssClass="btn btn-primary" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>


