<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.unobtrusive-ajax/3.2.5/jquery.unobtrusive-ajax.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.3/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate.unobtrusive/3.2.5/jquery.validate.unobtrusive.min.js"></script>

    <!-- Fonts and icons -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">

    <!-- Stylesheet -->
    <link href="../CSS/DashboardStyleSheet.css" rel="stylesheet" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpIkuOsiwFVD0pO5vZSoW7UycFgSYdW+GI1R+Vo9yURy9B6+fzT9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6W8u6vE6kUaa7s2e2c9kiJq8MO+4V5TnSo8mlQepGO0CAY5kMfX" crossorigin="anonymous"></script>

    <title>Welcome to My Clinic</title>
    <link href="Default.css" rel="stylesheet" />
    <style>
        .hero-section .content1 {
            position: absolute;
            top: 35%; /* Move the box slightly up */
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1; /* Keeps text and buttons in front of the video */
            padding: 80px 20px; /* Reduce padding slightly to make the box smaller */
            background-color: rgba(0, 0, 0, 0.7); /* Slightly darker transparent background */
            border-radius: 15px; /* Rounded corners */
            width: 35%; /* Make the box smaller */
        }
        .cursor1 {
            display: inline-block;
            width: 10px; /* Width of the cursor */
            height: 1.5em; /* Height of the cursor */
            background-color: white; /* Cursor color */
            animation: blink 0.8s infinite; /* Blinking effect */
            margin-left: 5px; /* Space between text and cursor */
            vertical-align: middle; /* Align cursor vertically */
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }
    </style>
   

    <!--Start of Tawk.to Script-->
<script type="text/javascript">
    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
    (function () {
        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        s1.async = true;
        s1.src = 'https://embed.tawk.to/66f8d627e5982d6c7bb63126/1i9a8a5s7';
        s1.charset = 'UTF-8';
        s1.setAttribute('crossorigin', '*');
        s0.parentNode.insertBefore(s1, s0);
    })();
</script>
<!--End of Tawk.to Script-->
</head>
<body>
    <form id="form2" runat="server">
        <div class="navbar">
            <div class="logo-container">
                <img src="Presentation_Layer/Images/myclinc%20logo.jpg" alt="Clinic Logo" class="logo">
                <h1>My Clinic</h1>
            </div>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#team">Our Team</a></li>
                <li><a href="Presentation_Layer/Forms/Patient/RequestAmbulance.aspx">Emergency</a></li>
                <li><a href="Presentation_Layer/Forms/Patient/Login.aspx">Sign In/Register</a></li>
            </ul>
            <div class="hamburger" id="hamburger" onclick="toggleMenu()">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>


        <div class="hero-section" id="home">
            <video id="video1" autoplay muted loop class="slide-video">
                <source src="Presentation_Layer/Images/emergency.mp4" type="video/mp4">
                Your browser does not support HTML5 video.
   
            </video>

            <div class="content1">
                <h1>Welcome to My Clinic</h1>
                <p id="typing-paragraph"><span class="cursor1" id="cursor1"></span></p>
                
                <a href="Presentation_Layer/Forms/Patient/Login.aspx" class="btn-get-started">Get Started</a>
                
               
            </div>
        </div>

        <!-- Quick Links -->
        <div class="quick-links">
            <div class="quick-link-card">
                <i class="fas fa-calendar-check quick-link-icon"></i>
                <div class="quick-link-title">Book Appointment</div>
                <div class="quick-link-description">Schedule your visit easily.</div>
            </div>
            <div class="quick-link-card">
                <i class="fas fa-medkit quick-link-icon"></i>
                <div class="quick-link-title">View Medications</div>
                <div class="quick-link-description">Check your prescribed medications.</div>
            </div>
            <div class="quick-link-card">
                <i class="fas fa-user-md quick-link-icon"></i>
                <div class="quick-link-title">Contact Doctor</div>
                <div class="quick-link-description">Reach out to your healthcare provider.</div>
            </div>
        </div>


        <!-- About Us Section -->
        <div class="section-about-custom" id="about">
            <h2 class="about-heading">About Us</h2>
            <div class="about-content-custom">
                <img src="Presentation_Layer/Images/about1.jpg" alt="About Us" class="about-image-custom">
                <div class="about-text">
                    <p>At My Clinic, we are dedicated to providing the best healthcare services to our patients. Our team of qualified professionals is committed to ensuring your health and well-being. We believe in a patient-centered approach, where your needs and preferences are at the forefront of our care.</p>
                    <p>Our facility is equipped with state-of-the-art technology and a comfortable environment to ensure a pleasant experience for our patients. We continually strive to improve our services through ongoing education and staying current with the latest healthcare advancements.</p>
                </div>
            </div>
        </div>


        <!-- Our Services Section -->
        <div class="section-services-custom" id="services">
            <h2 class="services-heading">Our Services</h2>
            <div class="services-content-custom">
                <!-- Service 1: Appointment Scheduling -->
                <div class="service-item-custom">
                    <div class="service-card">
                        <img src="Presentation_Layer/Images/appointment.jpg" alt="Appointment Scheduling" class="service-icon-custom">
                        <h3 class="service-title">Appointment Scheduling</h3>
                        <p class="service-description">Easily schedule your appointments online for convenience and quick access to care.</p>
                    </div>
                </div>
                <!-- Service 2: Ambulance Request -->
                <div class="service-item-custom">
                    <div class="service-card">
                        <img src="Presentation_Layer/Images/ambulance.jpg" alt="Ambulance Request" class="service-icon-custom">
                        <h3 class="service-title">Ambulance Request</h3>
                        <p class="service-description">Request an ambulance for emergencies with a simple click through our platform.</p>
                    </div>
                </div>
                <!-- Service 3: Medical Delivery -->
                <div class="service-item-custom">
                    <div class="service-card">
                        <img src="Presentation_Layer/Images/delivery.jpg" alt="Medical Delivery" class="service-icon-custom">
                        <h3 class="service-title">Medical Delivery</h3>
                        <p class="service-description">Have your prescriptions delivered directly to your doorstep with our reliable service.</p>
                    </div>
                </div>

                <!-- Service 5: Telemedicine Consultations -->
                <div class="service-item-custom">
                    <div class="service-card">
                        <img src="Presentation_Layer/Images/telemedicine.jpg" alt="Telemedicine Consultations" class="service-icon-custom">
                        <h3 class="service-title">Telemedicine Consultations</h3>
                        <p class="service-description">Consult with doctors remotely via secure video calls from the comfort of your home.</p>
                    </div>
                </div>
            </div>
        </div>



        <!-- Our Team Section -->
        <div class="section-team-custom" id="team">
            <h2 class="team-heading">Our Team</h2>
            <div class="team-content-custom">
                <!-- Team Member 1 -->
                <div class="team-member-custom">
                    <img src="Presentation_Layer/Images/enkosi.jpg" alt="Team Member 1" class="team-image-custom">
                    <h3 class="team-member-name">Dr. Enkosi Madikizela</h3>
                    <p class="team-member-title">General Practitioner</p>
                </div>
                <!-- Team Member 2 -->
                <div class="team-member-custom">
                    <img src="Presentation_Layer/Images/ame.jpg" alt="Team Member 2" class="team-image-custom">
                    <h3 class="team-member-name">Dr. Ame Mayawana</h3>
                    <p class="team-member-title">Dentist</p>
                </div>
                <!-- Team Member 3 -->
                <div class="team-member-custom">
                    <img src="Presentation_Layer/Images/tumeka.jpg" alt="Team Member 3" class="team-image-custom">
                    <h3 class="team-member-name">Dr. Tumeka Tali</h3>
                    <p class="team-member-title">Pediatrician</p>
                </div>
                <!-- Team Member 4 -->
                <div class="team-member-custom">
                    <img src="Presentation_Layer/Images/lona.jpg" alt="Team Member 4" class="team-image-custom">
                    <h3 class="team-member-name">Nurse Lona Gquka</h3>
                    <p class="team-member-title">Head Nurse</p>
                </div>
                <!-- Team Member 5 -->
                <div class="team-member-custom">
                    <img src="Presentation_Layer/Images/xola.jpg" alt="Team Member 5" class="team-image-custom">
                    <h3 class="team-member-name">Dr. Xola Jininda</h3>
                    <p class="team-member-title">Pharmacist</p>
                </div>
            </div>
        </div>

        <!-- Contact Us Section -->
        <div class="section-contact-custom" id="contact">
            <h2 class="contact-heading">Contact Us</h2>
            <div class="contact-content-custom">
                <!-- Left Side: Contact Information -->
                <div class="contact-info">
                    <img src="Presentation_Layer/Images/about1.jpg" alt="Contact Us" class="contact-image-custom">
                    <div>
                        <p>We value your feedback and are here to assist you! Get in touch with us at <a href="mailto:contact@myclinic.com">contact@myclinic.com</a> or call us at (123) 456-7890.</p>
                        <p>Visit us at:</p>
                        <address>
                            123 St Marks Str.<br>
                            East London, 5201<br>
                            <strong>Office Hours:</strong><br>
                            Monday - Friday: 8:00 AM - 5:00 PM<br>
                            Saturday: Closed<br>
                            Sunday: Closed
                        </address>
                    </div>
                </div>

                <!-- Right Side: Contact Form -->
                <div class="contact-form">
    <asp:Panel runat="server" CssClass="contact-form-panel">
        <!-- Label for displaying validation messages -->
        <asp:Label runat="server" ID="lblValidation" CssClass="contact-form-validation" ForeColor="Red" />

        <asp:Label runat="server" CssClass="contact-form-label" AssociatedControlID="txtName" Text="Name:"></asp:Label>
        <asp:TextBox runat="server" ID="txtName" CssClass="contact-form-input" placeholder="Your Full Name"></asp:TextBox>

        <asp:Label runat="server" CssClass="contact-form-label" AssociatedControlID="txtEmail" Text="Email:"></asp:Label>
        <asp:TextBox runat="server" ID="txtEmail" CssClass="contact-form-input" placeholder="Your Email"></asp:TextBox>

        <asp:Label runat="server" CssClass="contact-form-label" AssociatedControlID="txtMessage" Text="Message:"></asp:Label>
        <asp:TextBox runat="server" ID="txtMessage" CssClass="contact-form-textarea" TextMode="MultiLine" placeholder="Your Message"></asp:TextBox>

        <asp:Button runat="server" ID="btnSubmit" CssClass="contact-form-button" Text="Submit" OnClick="btnSubmit_Click" />
    </asp:Panel>
</div>

            </div>
        </div>



        <footer>
            <p>&copy; 2024 My Clinic. All rights reserved.</p>
        </footer>
    </form>

    <!-- <script>
        const videos = document.querySelectorAll('.slide-video');
        let currentVideo = 0;

        function showNextVideo() {
            // Hide current video
            videos[currentVideo].style.display = 'none';

            // Move to the next video
            currentVideo = (currentVideo + 1) % videos.length;

            // Show the next video
            videos[currentVideo].style.display = 'block';
        }

        // Start the video slideshow every 5 seconds (5000 milliseconds)
        setInterval(showNextVideo, 5000);
    </script>-->

    <script>
        function toggleMenu() {
            const menu = document.querySelector('.navbar ul');
            menu.classList.toggle('active');
        }

        // Close menu when clicking outside
        window.onclick = function (event) {
            if (!event.target.matches('.hamburger') && !event.target.matches('.navbar ul')) {
                const menu = document.querySelector('.navbar ul');
                if (menu.classList.contains('active')) {
                    menu.classList.remove('active');
                }
            }
        }
    </script>

   <script>
       const sentences = [
           "Providing Quality Healthcare.",
           "Your Health is Our Priority.",
           "Experience Compassionate Care."
       ];

       let currentSentenceIndex = 0;
       let currentCharIndex = 0;
       const typingSpeed = 100; // Speed of typing in milliseconds
       const deletingSpeed = 50; // Speed of deleting in milliseconds
       const pauseDuration = 1000; // Pause duration after completing a sentence

       const typingParagraph = document.getElementById("typing-paragraph");

       function type() {
           if (currentCharIndex < sentences[currentSentenceIndex].length) {
               typingParagraph.textContent += sentences[currentSentenceIndex].charAt(currentCharIndex);
               currentCharIndex++;
               setTimeout(type, typingSpeed);
           } else {
               setTimeout(deleteText, pauseDuration);
           }
       }

       function deleteText() {
           if (currentCharIndex > 0) {
               typingParagraph.textContent = sentences[currentSentenceIndex].substring(0, currentCharIndex - 1);
               currentCharIndex--;
               setTimeout(deleteText, deletingSpeed);
           } else {
               currentSentenceIndex = (currentSentenceIndex + 1) % sentences.length; // Move to the next sentence
               setTimeout(type, typingSpeed);
           }
       }

       // Start the typing effect when the page loads
       window.onload = () => {
           type();
       };
</script>
</body>
</html>

