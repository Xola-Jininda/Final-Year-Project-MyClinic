<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Paramedics/Paramedic.Master" AutoEventWireup="true" CodeBehind="Completed.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Paramedics.Completed" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Style.css" rel="stylesheet" />
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 class="my-4">Completed Ambulance Requests</h2>
        <div class="row">
            <asp:ListView ID="CompletedRequestsListView" runat="server">
                <ItemTemplate>
                    <div class="col-md-6">
                        <div class="request-card border p-3 mb-3 bg-white">
                            <h5 class="request-header">Request ID: <%# Eval("RequestID") %></h5>
                            <p><strong>Emergency Description:</strong> <%# Eval("EmergencyDescription") %></p>
                            <p><strong>Location:</strong> <%# Eval("Location") %></p>
                            <p><strong>Is Conscious:</strong> <%# Eval("IsConscious") %></p>
                            <p><strong>Patient Name:</strong> <%# Eval("PatientName") %></p>
                            <p><strong>Patient Age:</strong> <%# Eval("PatientAge") %></p>
                            <p><strong>Condition Description:</strong> <%# Eval("ConditionDescription") %></p>
                            <p><strong>Request Date:</strong> <%# Eval("RequestDate", "{0:yyyy-MM-dd HH:mm:ss}") %></p>
                            <p><strong>Status:</strong> <%# Eval("Status") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
