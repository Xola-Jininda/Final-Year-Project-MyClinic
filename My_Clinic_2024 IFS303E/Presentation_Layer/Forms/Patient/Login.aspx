<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AppointmentBookingFeature.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login/Register</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <link href="LogInCSS.css" rel="stylesheet" />
    <style>
        /* Password strength bar */
        .strength-bar {
            height: 10px;
            background-color: #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        .strength-bar div {
            height: 100%;
            width: 0;
            transition: width 0.5s;
        }

        /* Colors for strength levels */
        .weak { background-color: #ff4d4d; }
        .medium { background-color: #ffc107; }
        .strong { background-color: #28a745; }
        .password-requirements li { color: #ff4d4d; }
        .password-requirements .valid { color: #28a745; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <div class="logo-container">
            
                <img src="../../Images/myclinc%20logo.jpg" alt="Clinic Logo" class="logo">
                <h1>My Clinic</h1>
            </div>
            <ul>
                  
    <li><a href="../../../Default.aspx">Home</a></li>
    <li><a href="#about">About</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#team">Our Team</a></li>
    <li><a href="RequestAmbulance.aspx">Emergency</a></li>
    <li><a href="Login.aspx">Sign In/Register</a></li>
</ul>
           
            <div class="hamburger" id="hamburger" onclick="toggleMenu()">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>
        <div class="container">
            <h2 class="text-center">Welcome to My Clinic</h2>
            <div class="text-center mb-3">
                <asp:Button ID="btnShowLogin" runat="server" Text="Login" CssClass="btn btn-custom" OnClick="ShowLogin" />
                <asp:Button ID="btnShowRegister" runat="server" Text="Register" CssClass="btn btn-secondary" OnClick="ShowRegister" />
            </div>
            <div class="form-section" id="loginForm" runat="server" visible="true">
                <h4>Login</h4>
                <div class="form-group">
                    <label for="txtLoginUsername">Username</label>
                    <asp:TextBox ID="txtLoginUsername" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtLoginPassword">Password</label>
                    <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-custom" OnClick="btnLogin_Click" />
                <asp:Button ID="btnCancelLogin" runat="server" Text="Cancel" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
            </div>
           <!-- Register Form -->
            <div class="form-section" id="registerForm" visible="false" runat="server">
                <h4>Register</h4>
                <div class="form-group">
                    <label for="txtRegisterUsername">Username</label>
                    <asp:TextBox ID="txtRegisterUsername" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtRegisterPassword">Password</label>
                    <asp:TextBox ID="txtRegisterPassword" runat="server" CssClass="form-control" TextMode="Password" onkeyup="checkPasswordStrength();" />
                </div>
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtRegisterConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>

                <!-- Password strength bar -->
                <div class="strength-bar">
                    <div id="strength-bar-progress"></div>
                </div>

                <div class="password-requirements">
                    <h6>Password Requirements:</h6>
                    <ul id="password-criteria">
                        <li id="length">At least 8 characters long</li>
                        <li id="lowercase">At least one lowercase letter</li>
                        <li id="uppercase">At least one uppercase letter</li>
                        <li id="number">At least one number</li>
                        <li id="special">At least one special character</li>
                    </ul>
                </div>
                <asp:Button ID="btnRegister" runat="server" Text="Sign Up" CssClass="btn btn-custom" OnClick="btnRegister_Click" />
                <asp:Button ID="btnCancelRegister" runat="server" Text="Cancel" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
            </div>
        </div>
    </form>
     <script>
        function checkPasswordStrength() {
            var password = document.getElementById("txtRegisterPassword").value;
            var progressBar = document.getElementById("strength-bar-progress");

            // Criteria elements
            var lengthCriteria = document.getElementById("length");
            var lowercaseCriteria = document.getElementById("lowercase");
            var uppercaseCriteria = document.getElementById("uppercase");
            var numberCriteria = document.getElementById("number");
            var specialCriteria = document.getElementById("special");

            // Strength level
            var strength = 0;

            // Password length requirement
            if (password.length >= 8) {
                lengthCriteria.classList.add("valid");
                strength++;
            } else {
                lengthCriteria.classList.remove("valid");
            }

            // Lowercase letter
            if (/[a-z]/.test(password)) {
                lowercaseCriteria.classList.add("valid");
                strength++;
            } else {
                lowercaseCriteria.classList.remove("valid");
            }

            // Uppercase letter
            if (/[A-Z]/.test(password)) {
                uppercaseCriteria.classList.add("valid");
                strength++;
            } else {
                uppercaseCriteria.classList.remove("valid");
            }

            // Number
            if (/\d/.test(password)) {
                numberCriteria.classList.add("valid");
                strength++;
            } else {
                numberCriteria.classList.remove("valid");
            }

            // Special character
            if (/[\W_]/.test(password)) {
                specialCriteria.classList.add("valid");
                strength++;
            } else {
                specialCriteria.classList.remove("valid");
            }

            // Update the strength bar based on the number of fulfilled requirements
            var strengthPercentage = (strength / 5) * 100;
            progressBar.style.width = strengthPercentage + "%";

            if (strength <= 2) {
                progressBar.className = "weak";
            } else if (strength <= 4) {
                progressBar.className = "medium";
            } else {
                progressBar.className = "strong";
            }
        }
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</bo
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
