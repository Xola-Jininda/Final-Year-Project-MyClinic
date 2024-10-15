<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AppointmentBookingFeature.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Sign In</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 500px;
            width: 100%;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .nav-tabs {
            justify-content: center;
            margin-bottom: 30px;
        }
        .form-control {
            margin-bottom: 20px;
        }
        .btn-primary {
            width: 100%;
        }
        .custom-link {
            display: block;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
   
         <form id="form1" runat="server">
        <div class="container">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="login-tab" data-toggle="tab" href="#login" role="tab" aria-controls="login" aria-selected="true">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="register-tab" data-toggle="tab" href="#register" role="tab" aria-controls="register" aria-selected="false">Register</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                    <div class="form-group">
                        <asp:TextBox ID="txtLoginUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
        
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password"></asp:TextBox>
                        
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" BackColor="Green" OnClick="btnLogin_Click" />
                    <asp:Label ID="lblLoginMessage" runat="server" ForeColor="Red" CssClass="custom-link"></asp:Label>
                </div>
                <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                    <div class="form-group">
                        <asp:TextBox ID="txtRegisterUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
                       
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtRegisterPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password"></asp:TextBox>
                   
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary" BackColor="green" OnClick="btnRegister_Click"/>
                    <asp:Label ID="lblRegisterMessage" runat="server" ForeColor="Red" CssClass="custom-link"></asp:Label>
                </div>
            </div>
        </div>
    </form>
    

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
</body>
</html>
