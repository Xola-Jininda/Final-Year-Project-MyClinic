<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation_Layer/Forms/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Styles/Dashboard.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w3-main" style="margin-left: 300px; margin-top: 43px;">

        <header class="w3-container" style="padding-top: 22px">
            <h5><b><i class="fa fa-dashboard"></i>My Dashboard</b></h5>
        </header>

        <!-- First Row -->
        <div class="w3-row-padding w3-margin-bottom">
            <div class="w3-quarter">
                <div class="w3-container w3-green w3-padding-16">
                    <div class="w3-left"><i class="fa fa-user-md w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblDoctorCount" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Doctors</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-blue w3-padding-16">
                    <div class="w3-left"><i class="fa fa-procedures w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblPatientCount" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Patients</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-green w3-padding-16">
                    <div class="w3-left"><i class="fa fa-calendar-check w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblAppointmentCount" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Appointments</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-orange w3-text-white w3-padding-16">
                    <div class="w3-left"><i class="fa fa-dollar-sign w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblRevenueSum" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Revenue</h4>
                </div>
            </div>
        </div>

        <!-- Second Row -->
        <div class="w3-row-padding w3-margin-bottom" style="margin-top: 20px;">
            <div class="w3-quarter">
                <div class="w3-container w3-purple w3-padding-16">
                    <div class="w3-left"><i class="fa fa-clinic-medical w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblActiveCount" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Active Orders</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-green w3-padding-16">
                    <div class="w3-left"><i class="fa fa-baby w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblDeliveryCount" runat="server" FontSize="Large"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Closed Orders</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-yellow w3-padding-16">
                    <div class="w3-left"><i class="fa fa-calendar-times w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>
                            <asp:Label ID="lblAmbulanceRequests" runat="server" FontSize="Large" Text="0"></asp:Label></h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Ambulance Requests</h4>
                </div>
            </div>
            <div class="w3-quarter">
                <div class="w3-container w3-green w3-text-white w3-padding-16">
                    <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
                    <div class="w3-right">
                        <h3>0</h3>
                    </div>
                    <div class="w3-clear"></div>
                    <h4>Active Users</h4>
                </div>
            </div>
        </div>

        <!-- GridViews Side by Side -->
        <div class="w3-container grid-container">
            <div class="grid-item">
                <h5>Doctors List</h5>
                <asp:GridView ID="GridViewAppointments" runat="server" AutoGenerateColumns="False" CssClass="grid-view" AllowPaging="True" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                        <asp:BoundField DataField="Specialty" HeaderText="Specialty" SortExpression="Specialty" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:MyClinicConnectionString2 %>"
                    SelectCommand="SELECT TOP 2 [FirstName], [LastName], [Specialty], [PhoneNumber] FROM [Doctors]"></asp:SqlDataSource>
            </div>
            <div class="grid-item">
                <h5>Patients List</h5>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view" AllowPaging="True" DataSourceID="SqlDataSource2">
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                        <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" SortExpression="DateOfBirth" />
                        <asp:BoundField DataField="Sex" HeaderText="Sex" SortExpression="Sex" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:MyClinicConnectionString2 %>"
                    SelectCommand="SELECT TOP 2 [FirstName], [LastName], [DateOfBirth], [Sex], [Mobile] FROM [Patients]"></asp:SqlDataSource>
            </div>
        </div>


        <!-- Appointments GridView Below the Two GridViews -->
        <div class="w3-container full-width-grid">
            <h5>Upcoming Appointments</h5>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
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
                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
