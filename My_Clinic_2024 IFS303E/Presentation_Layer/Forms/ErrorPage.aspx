<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.ErrorPage" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error - Something Went Wrong</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Styles/ErrorPage.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="error-container">
            <h1>Oops! Something Went Wrong.</h1>
            <p>We are sorry, but an error has occurred. Please try again later or go back to the previous page.</p>
            <a href="javascript:history.back()" class="btn-go-back">Go Back</a>
        </div>
    </form>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
2024/10/13 15:22:05: MailKit.Security.SslHandshakeException: An error occurred while attempting to establish an SSL or TLS connection.

The server's SSL certificate could not be validated for the following reasons:
• The server certificate has the following errors:
  • The revocation function was unable to check revocation for the certificate.

 ---> System.Security.Authentication.AuthenticationException: The remote certificate is invalid according to the validation procedure.
   at System.Net.Security.SslState.StartSendAuthResetSignal(ProtocolToken message, AsyncProtocolRequest asyncRequest, Exception exception)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ProcessReceivedBlob(Byte[] buffer, Int32 count, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.StartReceiveBlob(Byte[] buffer, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.CheckCompletionBeforeNextReceive(ProtocolToken message, AsyncProtocolRequest asyncRequest)
   at System.Net.Security.SslState.ForceAuthentication(Boolean receiveFirst, Byte[] buffer, AsyncProtocolRequest asyncRequest, Boolean renegotiation)
   at System.Net.Security.SslState.ProcessAuthentication(LazyAsyncResult lazyResult)
   at MailKit.Net.Smtp.SmtpClient.SslHandshake(SslStream ssl, String host, CancellationToken cancellationToken) in D:\src\MailKit\MailKit\Net\Smtp\SmtpClient.cs:line 1313
   at MailKit.Net.Smtp.SmtpClient.PostConnect(Stream stream, String host, Int32 port, SecureSocketOptions options, Boolean starttls, CancellationToken cancellationToken) in D:\src\MailKit\MailKit\Net\Smtp\SmtpClient.cs:line 1359
   --- End of inner exception stack trace ---
   at MailKit.Net.Smtp.SmtpClient.PostConnect(Stream stream, String host, Int32 port, SecureSocketOptions options, Boolean starttls, CancellationToken cancellationToken) in D:\src\MailKit\MailKit\Net\Smtp\SmtpClient.cs:line 1376
   at MailKit.Net.Smtp.SmtpClient.Connect(String host, Int32 port, SecureSocketOptions options, CancellationToken cancellationToken) in D:\src\MailKit\MailKit\Net\Smtp\SmtpClient.cs:line 1507
   at My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.BookSummary.SendEmailWithCode(String emailAddress) in C:\MyClinic_\My_Clinic_2024 IFS303E\Presentation_Layer\Forms\Patient\BookSummary.aspx.cs:line 147
2024/10/13 15:26:38: INFO - Attempting to connect to SMTP server mail.cosmartic.co.za on port 587
2024/10/13 15:26:40: ERROR - General Exception: An error occurred while attempting to establish an SSL or TLS connection.

The server's SSL certificate could not be validated for the following reasons:
• The server certificate has the following errors:
  • The revocation function was unable to check revocation for the certificate.


