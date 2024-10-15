<!DOCTYPE html>
<html lang="en">
<head>
<title>myClinic - Clinic Booking System</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {font-family: "Lato", sans-serif}
.mySlides {display: none}
.w3-bar, .w3-green, .w3-button.w3-green {background-color: #4CAF50 !important; opacity:0.6}
.w3-button.w3-green:hover {background-color: #45a049 !important;}
.carousel-container {position: relative; width: 100%; max-width: 1000px; margin: auto;}
.carousel-slide {display: none;}
.carousel-slide img {width: 100%; height: auto;}
.carousel-prev, .carousel-next {cursor: pointer; position: absolute; top: 50%; width: auto; padding: 16px; margin-top: -22px; color: white; font-weight: bold; font-size: 18px; transition: 0.6s ease; border-radius: 0 3px 3px 0; user-select: none;}
.carousel-next {right: 0; border-radius: 3px 0 0 3px;}
.carousel-prev:hover, .carousel-next:hover {background-color: rgba(0,0,0,0.8);}
.w3-button.red {background-color: #f44336; color: white; border: none; padding: 10px 20px; cursor: pointer; margin-left: 10px;}
.w3-button.red:hover {background-color: #c62828;}
.w3-logo {width: 50px; height: auto; vertical-align: middle; margin-right: 20px;}
.w3-bar-item.logo-container {display: flex; align-items: center; padding: 0 15px; height: 100%;}
.w3-bar-item.logo-container img {margin-right: 10px;}
.w3-icon {font-size: 50px; color: #4CAF50; margin-right: 20px;}
.service-box {display: flex; align-items: center; padding: 20px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 8px;}
.service-box img, .service-box .w3-icon {margin-right: 20px;}

</style>
</head>
<body>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-green w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    
    <!-- Logo and HOME link -->
    <a href="#" class="w3-bar-item w3-button w3-padding-large logo-container">
      <img src="Images/logo%20clinic.jpg" alt="Logo" class="w3-logo" />
      
    </a>
      <a href="#services" class="w3-bar-item w3-button w3-padding-large w3-hide-small">HOME</a>
    <a href="#services" class="w3-bar-item w3-button w3-padding-large w3-hide-small">SERVICES</a>
    <a href="#appointments" class="w3-bar-item w3-button w3-padding-large w3-hide-small">APPOINTMENTS</a>
    <a href="#contact" class="w3-bar-item w3-button w3-padding-large w3-hide-small">CONTACT</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">MORE <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="#" class="w3-bar-item w3-button">FAQ</a>
        <a href="#" class="w3-bar-item w3-button">Policies</a>
      </div>
    </div>
    <!-- Red Button Next to More -->
      <asp:Button ID="Button1" runat="server" class="w3-button red w3-hide-small" Text="Button" />
    
    <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>

<!-- Navbar on small screens -->
<div id="navDemo" class="w3-bar-block w3-green w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#services" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">SERVICES</a>
  <a href="#appointments" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">APPOINTMENTS</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">FAQ</a>
</div>

<!-- Page content -->
<div class="w3-content" style="max-width:2000px;margin-top:46px">

  <!-- Automatic Slideshow Images -->
  <div class="mySlides w3-display-container w3-center">
      <img src="Images/doctors-3.jpg" />
    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
      <h3>Welcome to myClinic</h3>
      <p style="color:black"><b>Your health is our priority!</b></p>   
    </div>
  </div>
  <div class="mySlides w3-display-container w3-center">
      <img src="Images/team-of-medical-workers-in-blue-uniforms-with-an-ambulance-van-carrying-a-first-aid-kit-isolated-on-white-background-2CJNYM4.jpg" />
    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
      <h3>Professional Care</h3>
      <p style="color:black"><b>Experienced medical professionals at your service.</b></p>    
    </div>
  </div>
  <div class="mySlides w3-display-container w3-center">
      <img src="Images/healthcare-career-1.jpg" />
      
    <div class="w3-display-bottommiddle w3-container w3-text-white w3-padding-32 w3-hide-small">
      <h3 style="color:black">Convenient Appointments</h3>
      <p style="color:black"><b>Book your appointments easily online.</b></p>    
    </div>
  </div>

  <!-- The Services Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="services">
    <h2 class="w3-wide">OUR SERVICES</h2>
    <p class="w3-opacity"><i>We provide a range of medical services</i></p>
    <p class="w3-justify">We offer comprehensive medical services to cater to your needs. Whether it’s general check-ups, specialized consultations, or emergency care, our team of professionals is here to ensure you receive the best care possible. Feel free to browse our services and book an appointment online.</p>
    <div class="w3-row w3-padding-32">
      <div class="w3-third">
        <p>General Check-Up</p>
        <img src="/w3images/checkup.jpg" class="w3-round w3-margin-bottom" alt="Check-Up" style="width:100%">
      </div>
      <div class="w3-third">
        <p>Specialized Consultation</p>
        <img src="/w3images/consultation.jpg" class="w3-round w3-margin-bottom" alt="Consultation" style="width:100%">
      </div>
      <div class="w3-third">
        <p>Emergency Care</p>
        <img src="/w3images/emergency.jpg" class="w3-round" alt="Emergency Care" style="width:100%">
      </div>
    </div>
  </div>

  <!-- The Appointments Section -->
  <div class="w3-green" id="appointments">
    <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
      <h2 class="w3-wide w3-center">BOOK AN APPOINTMENT</h2>
      <p class="w3-opacity w3-center"><i>Conveniently schedule your visit</i></p><br>

      <form action="/book_appointment" method="post">
        <label for="name">Name:</label>
        <input class="w3-input w3-border" type="text" id="name" name="name" required>
        <label for="email">Email:</label>
        <input class="w3-input w3-border" type="email" id="email" name="email" required>
        <label for="date">Preferred Date:</label>
        <input class="w3-input w3-border" type="date" id="date" name="date" required>
        <button class="w3-button w3-green w3-margin-top" type="submit">Submit</button>
      </form>
    </div>
  </div>
  
  <!-- The Contact Section -->
  <div class="w3-container w3-content w3-padding-64" style="max-width:800px" id="contact">
    <h2 class="w3-wide w3-center">CONTACT</h2>
    <p class="w3-opacity w3-center"><i>Patient? Drop a note!</i></p>
    <div class="w3-row w3-padding-32">
      <div class="w3-col m6 w3-large w3-margin-bottom">
        <i class="fa fa-map-marker" style="width:30px"></i> East London, SA<br>
        <i class="fa fa-phone" style="width:30px"></i> Phone: +00 151515<br>
        <i class="fa fa-envelope" style="width:30px"> </i> Email: myClinic@mail.com<br>
      </div>
      <div class="w3-col m6">
        <form action="/action_page.php" target="_blank">
          <div class="w3-row-padding" style="margin:0 -16px 8px -16px">
            <div class="w3-half">
              <input class="w3-input w3-border" type="text" placeholder="Name" required name="Name">
            </div>
            <div class="w3-half">
              <input class="w3-input w3-border" type="text" placeholder="Email" required name="Email">
            </div>
          </div>
          <input class="w3-input w3-border" type="text" placeholder="Message" required name="Message">
          <button class="w3-button w3-black w3-section w3-right" type="submit">SEND</button>
        </form>
      </div>
    </div>
  </div>

    <div class="w3-container w3-content w3-padding-64" style="max-width:1200px" id="information">
    <h2 class="w3-wide w3-center">OUR COMMITMENT</h2>
    <p class="w3-opacity w3-center"><i>We always put our patients first</i></p>
    <p class="w3-justify">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing eli.</p>
    
    <div class="w3-row">
      <div class="w3-col l3 m6 s12">
        <div class="service-box">
          <i class="fa fa-stethoscope w3-icon"></i>
          <div>
            <h3>The Best Doctors</h3>
            <p>Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
          </div>
        </div>
      </div>
      <div class="w3-col l3 m6 s12">
        <div class="service-box">
          <i class="fa fa-baby w3-icon"></i>
          <div>
            <h3>Baby Nursery</h3>
            <p>Dolor sit amet, consecte tuer elit, sed diam nonummy nibh euismod tincidunt ut ldolore magna.</p>
          </div>
        </div>
      </div>
      <div class="w3-col l3 m6 s12">
        <div class="service-box">
          <i class="fa fa-flask w3-icon"></i>
          <div>
            <h3>Laboratory</h3>
            <p>Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
          </div>
        </div>
      </div>
      <div class="w3-col l3 m6 s12">
        <div class="service-box">
          <i class="fa fa-plus w3-icon"></i>
          <div>
            <h3>Emergency Room</h3>
            <p>Dolor sit amet, consecte tuer elit, sed. Baby nursery, the best doctors, Laboratory and emergency rooms must have their own icons.</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
    <footer class="w3-container w3-padding-64 w3-center w3-opacity" style="background-color: #4CAF50; color: white;">
  <p>For Emergency Calls</p>
  <p>+27 63-9660</p>
  <p>East London</p>
  <p>0080 673 729 766</p>
  <p>contact@business.com</p>
  <p>50 St Marks Str, no 59</p>
  <p>41770 Southernwood</p>
  <footer class="w3-center w3-padding-32 w3-light-grey">
    <p>Powered by <a href="#" class="w3-hover-text-green">myClinic</a></p>
  </footer>

<!-- End page content -->
</div>

<script>
    // Slideshow 
    var slideIndex = 0;
    showSlides();

    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) { slideIndex = 1 }
        slides[slideIndex - 1].style.display = "block";
        setTimeout(showSlides, 2000); // Change image every 2 seconds
    }

    // Carousel
    var slideIndex = 1;
    showSlidesCarousel(slideIndex);

    function plusSlides(n) {
        showSlidesCarousel(slideIndex += n);
    }

    function showSlidesCarousel(n) {
        var i;
        var slides = document.getElementsByClassName("carousel-slide");
        if (n > slides.length) { slideIndex = 1 }
        if (n < 1) { slideIndex = slides.length }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";
    }
</script>

</body>
</html>
