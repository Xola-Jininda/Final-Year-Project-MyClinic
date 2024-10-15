<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestAmbulance.aspx.cs" Inherits="My_Clinic_2024_IFS303E.Presentation_Layer.Forms.Patient.RequestAmbulance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--Start of Tawk.to Script-->
    <script type="text/javascript">
        var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
        (function () {
            var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/66bfead1146b7af4a43b62b5/1i5eqqhlh';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);

            Tawk_API.onLoad = function () {
                Tawk_API.setAttributes({
                    'name': '',
                    'email': '',
                    'phone': ''
                }, function (error) {
                    if (error) {
                        console.error('Failed to reset chat attributes', error);
                    }
                });

                Tawk_API.maximize();
                Tawk_API.clear();
            };
        })();
    </script>
    <!--End of Tawk.to Script-->
    <title>Request Ambulance</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- External CSS and JS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link href="ambulance.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            let currentQuestion = 0;
            const questions = $(".question");
            const totalQuestions = questions.length;
            const progressBar = $(".progress");

            // Initialize with the first question
            $(questions[currentQuestion]).addClass("active");

            // Update Progress Bar
            function updateProgressBar() {
                let progress = ((currentQuestion + 1) / totalQuestions) * 100;
                progressBar.css("width", progress + "%").text("Progress: " + Math.round(progress) + "%");
            }

            // Next button functionality
            $("#nextButton").click(function () {
                if (validateAnswer(currentQuestion)) {
                    $(questions[currentQuestion]).removeClass("active");
                    currentQuestion++;
                    $(questions[currentQuestion]).addClass("active");
                    updateProgressBar();
                    updateNavigationButtons();
                }
            });

            // Previous button functionality
            $("#prevButton").click(function () {
                $(questions[currentQuestion]).removeClass("active");
                currentQuestion--;
                $(questions[currentQuestion]).addClass("active");
                updateProgressBar();
                updateNavigationButtons();
            });


            // Validate each answer
            function validateAnswer(questionIndex) {
                const currentInput = $(questions[questionIndex]).find("input, textarea, select");

                if (currentInput.is(":radio") && currentInput.filter(":checked").length === 0) {
                    Swal.fire('Warning', 'Please select an answer!', 'warning');
                    return false;
                }

                // Check for required text inputs
                if ((currentInput.is("textarea") || currentInput.is("input[type='text']")) && currentInput.val().trim() === "") {
                    Swal.fire('Warning', 'This field is required!', 'warning');
                    return false;
                }

                // Check for description textboxes
                if (currentInput.is("#EmergencyDescriptionTextBox, #ConditionDescriptionTextBox")) {
                    const description = currentInput.val().trim();
                    const wordCount = description.split(/\s+/).length;

                    // Allow only letters and spaces, and check word count
                    const isTextOnly = /^[A-Za-z\s]*$/.test(description);

                    if (!isTextOnly) {
                        Swal.fire('Warning', 'Only text is allowed!', 'warning');
                        return false;
                    }

                    if (wordCount < 3) {
                        Swal.fire('Warning', 'Please provide at least 3 words!', 'warning');
                        return false;
                    }
                }

                if (currentInput.is("select") && currentInput.val() === "") {
                    Swal.fire('Warning', 'Please select an option!', 'warning');
                    return false;
                }

                return true;
            }


            // Update navigation buttons
            function updateNavigationButtons() {
                $("#prevButton").toggle(currentQuestion > 0);
                $("#nextButton").toggle(currentQuestion < totalQuestions - 1);
                $("#SubmitQuizButton").toggle(currentQuestion === totalQuestions - 1);
            }

            // Initialize Progress Bar and Buttons
            updateProgressBar();
            updateNavigationButtons();

            // Geolocation API: Get current location
            $("#getLocationButton").click(function () {
                if (navigator.geolocation) {
                    // Show SweetAlert indicating the process is ongoing
                    Swal.fire({
                        title: 'Just a sec',
                        text: 'Fetching your current location...',
                        icon: 'info',
                        showConfirmButton: false,
                        timer: 2000 // Auto-close after 2 seconds
                    });

                    navigator.geolocation.getCurrentPosition(showPosition, showError);
                } else {
                    Swal.fire('Error', 'Geolocation is not supported by this browser.', 'error');
                }

            });

            // Show position with reverse geocoding
            function showPosition(position) {
                const lat = position.coords.latitude.toFixed(6);  // Limit to 6 decimal places
                const lon = position.coords.longitude.toFixed(6); // Limit to 6 decimal places

                // Reverse geocoding to get the address
                $.ajax({
                    url: `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}`,
                    method: "GET",
                    success: function (data) {
                        const address = data.display_name; // Extract the display_name from the response

                        // Set the location in the visible text box
                        $("#LocationTextBox").val(address);

                        // Also set the location in the hidden field for persistence
                        $("#hiddenLocation").val(address);
                    },
                    error: function () {
                        Swal.fire('Error', 'Failed to retrieve address from coordinates.', 'error');
                    }
                });
            }



            // Error handler for geolocation
            function showError(error) {
                const errorMessages = {
                    1: 'Permission to access location was denied.',
                    2: 'Location information is unavailable.',
                    3: 'The request to get location timed out.',
                    0: 'An unknown error occurred.'
                };
                Swal.fire('Error', errorMessages[error.code], 'error');
            }

            // Location autocomplete feature
            $("#LocationTextBox").on("input", function () {
                const query = $(this).val();
                if (query.length >= 3) {
                    $.ajax({
                        url: `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`, // Encode the query
                        method: "GET",
                        success: function (data) {
                            let suggestions = "";
                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    suggestions += `<div class="suggestion-item" data-lat="${item.lat}" data-lon="${item.lon}">${item.display_name}</div>`;
                                });
                            } else {
                                suggestions += `<div class="suggestion-item">No results found</div>`;
                            }
                            $(".suggestions").html(suggestions).show();
                        },
                        error: function () {
                            Swal.fire('Error', 'Failed to fetch location data.', 'error');
                        }
                    });
                } else {
                    $(".suggestions").hide();
                }
            });

            // Handle suggestion click
            $(document).on("click", ".suggestion-item", function () {
                const locationName = $(this).text();
                const lat = $(this).data("lat");
                const lon = $(this).data("lon");
                $("#LocationTextBox").val(locationName);
                $(".suggestions").hide();
            });


        });

    </script>

 <style>
    /* Navbar Styling */
    .navbar {
        background-color: #4CAF50; /* Green background */
        overflow: hidden;
        position: sticky;
        top: 0;
        width: 100%;
        z-index: 1000;
    }

    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
        font-size: 17px;
        transition: background-color 0.3s;
    }

    .navbar a:hover {
        background-color: #3CB371; /* Lighter green on hover */
        color: white;
    }

    .navbar .logo {
        font-size: 20px;
        font-weight: bold;
    }

    .navbar .right {
        float: right;
    }

    /* Language Selector Dropdown Styling */
    #languageSelector {
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #4CAF50;
        background-color: white;
        color: #4CAF50;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
    }

    #languageSelector:hover {
        background-color: #3CB371;
        color: white;
    }

    /* Responsive styling */
    @media (max-width: 600px) {
        .navbar a {
            float: none;
            display: block;
            text-align: left;
        }
    }

    /* Location suggestions styling */
    .suggestions {
        border: 1px solid #ddd;
        max-height: 150px;
        overflow-y: auto;
        background-color: #fff;
        position: absolute;
        width: 100%;
    }

    .suggestion-item {
        padding: 10px;
        cursor: pointer;
        border-bottom: 1px solid #ddd;
    }

    .suggestion-item:hover {
        background-color: #f1f1f1;
    }
</style>

</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="#" class="logo">My Clinic</a>
        <asp:HyperLink CssClass="a" ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        <div class="right">
            <asp:HyperLink CssClass="a" ID="HyperLink2" runat="server" NavigateUrl="~/Default.aspx">Contact Us</asp:HyperLink>
        </div>
    </div>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <select id="languageSelector">
            <option>-Select Language-</option>
            <option value="af">Afrikaans</option>
            <option value="am">Amharic</option>
            <option value="ar">Arabic</option>
            <option value="es">Spanish</option>
            <option value="fr">French</option>
            <option value="ha">Hausa</option>
            <option value="xh">IsiXhosa</option>
            <option value="zu">IsiZulu</option>
            <option value="st">IsiSotho</option>
            <option value="sw">Swahili</option>
            <option value="tn">Tunisian Arabic</option>
            <option value="yo">Yoruba</option>
            <option value="en">English</option>
            <!-- Add more languages as needed -->
        </select>


        <div class="container">
            <div class="container background-image">
                <h1>Act Now: Answer Emergency Questions </h1>
                <h2>Swift Response Begins Here </h2>

                <!-- Progress Bar -->
                <div class="progress-bar">
                    <div class="progress">0%</div>
                </div>

                <!-- Questions -->
                <div class="question active">
                    <label for="EmergencyDescriptionTextBox">
                        <i class="fas fa-exclamation-circle"></i>
                        1. What is your emergency?
                    </label>
                    <asp:TextBox ID="EmergencyDescriptionTextBox" runat="server" CssClass="text-box" />
                </div>

                <input type="hidden" id="hiddenLocation" name="hiddenLocation" />

                <div class="question">
                    <label for="LocationTextBox">
                        <i class="fas fa-map-marker-alt"></i>
                        2. Where are you located?
                    </label>
                    <asp:TextBox ID="LocationTextBox" runat="server" CssClass="text-box" ReadOnly="true" placeholder="Click 'Get Current Location'" EnableViewState="true" />

                    <button type="button" id="getLocationButton">Get Current Location</button>
                </div>

                <div class="question">
                    <label for="ConsciousBreathingList">
                        <i class="fas fa-heartbeat"></i>
                        3. Is the patient conscious?
                    </label>
                    <asp:RadioButtonList ID="ConsciousBreathingList" runat="server" CssClass="radio-button-list">
                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="question">
                    <label for="AgeTextBox">
                        <i class="fas fa-user"></i>
                        4. Patient details (Name and Age):
                    </label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="text-box" placeholder="Patient Full Name*" />
                    <asp:TextBox ID="AgeTextBox" runat="server" CssClass="text-box" placeholder="Enter Age*" />
                </div>

                <div class="question">
                    <label for="VisibleBleedingList">
                        <i class="fas fa-tint"></i>
                        5. Is there any visible bleeding or injury?
                    </label>
                    <asp:RadioButtonList ID="VisibleBleedingList" runat="server" CssClass="radio-button-list">
                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="question">
                    <label for="AllergiesTextBox">
                        <i class="fas fa-allergies"></i>
                        6. Is the patient allergic to any medications?
                    </label>
                    <asp:RadioButtonList ID="AllergiesDropList" runat="server" CssClass="radio-button-list">
                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="question">
                    <label for="ConditionDescriptionTextBox">
                        <i class="fas fa-info-circle"></i>
                        7. Can you describe the patient's condition?
                    </label>
                    <asp:TextBox ID="ConditionDescriptionTextBox" runat="server" CssClass="text-box" />
                </div>

                <div class="question">
                    <label for="UrgencyList">
                        <i class="fas fa-clock"></i>
                        8. Is this a life-threatening emergency?
                    </label>
                    <asp:RadioButtonList ID="UrgencyList" runat="server" CssClass="radio-button-list">
                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <!-- Navigation Buttons -->
                <div class="navigation-buttons">
                    <button type="button" id="prevButton">Previous</button>
                    <button type="button" id="nextButton">Next</button>
                    <asp:Button ID="SubmitQuizButton" runat="server" CssClass="submit-button" Text="Submit" OnClick="SubmitQuizButton_Click" />
                </div>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {
            let currentQuestionIndex = 0;
            const questions = $(".question");

            window.onload = function () {
                // Check if the browser supports speech synthesis
                if ('speechSynthesis' in window) {
                    const speech = new SpeechSynthesisUtterance(welcomeMessage);
                    speech.lang = 'en-US'; // Set language, adjust as needed
                    window.speechSynthesis.speak(speech);
                } else {
                    console.log("Speech synthesis not supported in this browser.");
                }
            };


            // Default language
            let currentLanguage = "en";
            
            const translations = {
                en: {
                    headings: {
                        h1: "Act Now: Answer Emergency Questions",
                        h2: "Swift Response Begins Here"
                    },
                    questions: [
                        "What is your emergency?",
                        "Where are you located?",
                        "Is the patient conscious?",
                        "Patient details (Name and Age)",
                        "Is there any visible bleeding or injury?",
                        "Is the patient allergic to any medications?",
                        "Can you describe the patient's condition?",
                        "Is this a life-threatening emergency?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Yes", no: "No" }
                },
                es: {
                    headings: {
                        h1: "Actúa Ahora: Responde Preguntas de Emergencia",
                        h2: "La Respuesta Rápida Comienza Aquí"
                    },
                    questions: [
                        "¿Cuál es tu emergencia?",
                        "¿Dónde te encuentras?",
                        "¿Está consciente el paciente?",
                        "Detalles del paciente (Nombre y Edad)",
                        "¿Hay alguna hemorragia o lesión visible?",
                        "¿Es alérgico el paciente a algún medicamento?",
                        "¿Puedes describir la condición del paciente?",
                        "¿Es esta una emergencia que pone en peligro la vida?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Sí", no: "No" },
                },
                fr: {
                    headings: {
                        h1: "Agissez Maintenant: Répondez aux Questions d'Urgence",
                        h2: "La Réponse Rapide Commence Ici"
                    },
                    questions: [
                        "Quelle est votre urgence ?",
                        "Où êtes-vous situé ?",
                        "Le patient est-il conscient ?",
                        "Détails du patient (Nom et Âge)",
                        "Y a-t-il des saignements ou des blessures visibles ?",
                        "Le patient est-il allergique à des médicaments ?",
                        "Pouvez-vous décrire l'état du patient ?",
                        "S'agit-il d'une urgence mettant la vie en danger ?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Oui", no: "Non" },
                },
                xh: {
                    headings: {
                        h1: "Thatha Amanyathelo Ngoku: Phendula Imibuzo Engxamisekileyo",
                        h2: "Impendulo Ekhawulezayo Iqala Apha"
                    },
                    questions: [
                        "Yintoni ingxaki yakho?",
                        "Uphi na?",
                        "Ngaba umguli uyaziva?",
                        "Iinkcukacha zomguli (Igama noMnyaka)",
                        "Ngaba kukho ukuvuvukala okanye ukulimala okubonakalayo?",
                        "Ngaba umguli uyaphendula kumagqabantshintshi?",
                        "Ungachaza njani isimo somguli?",
                        "Ngaba le ngxaki iyingozi empilweni?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Ewe", no: "Hayi" }
                },
                af: {
                    headings: {
                        h1: "Tree Nou: Beantwoord Noodvrae",
                        h2: "Vinnige Reaksie Begin Hier"
                    },
                    questions: [
                        "Wat is jou noodsituasie?",
                        "Waar is jy geleë?",
                        "Is die pasiënt bewus?",
                        "Pasiëntbesonderhede (Naam en Leeftijd)",
                        "Is daar enige sigbare bloeding of besering?",
                        "Is die pasiënt allergies vir enige medikasie?",
                        "Kan jy die pasiënt se toestand beskryf?",
                        "Is dit 'n lewensbedreigende noodsituasie?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Ja", no: "Nee" }
                },
                sw: {
                    headings: {
                        h1: "Fanya Sasa: Jibu Maswali ya Dharura",
                        h2: "Majibu ya Haraka Yanaanza Hapa"
                    },
                    questions: [
                        "Nini dharura yako?",
                        "Upo wapi?",
                        "Je, mgonjwa ana ufahamu?",
                        "Maelezo ya mgonjwa (Jina na Umri)",
                        "Je, kuna damu inayonekana au majeraha?",
                        "Je, mgonjwa ana mzio wowote wa dawa?",
                        "Je, unaweza kuelezea hali ya mgonjwa?",
                        "Je, hii ni dharura inayohatarisha maisha?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Ndiyo", no: "Hapana" }
                },
                ha: {
                    headings: {
                        h1: "Yi Yanzu: Amsa Tambayoyin Gaggawa",
                        h2: "Amsa Da Sauri Yana Farawa Anan"
                    },
                    questions: [
                        "Menene gaggawa?",
                        "Ina kake?",
                        "Shin majinyaci yana da hankali?",
                        "Bayanai game da majinyaci (Suna da Shekaru)",
                        "Shin akwai jini ko rauni mai bayyana?",
                        "Shin majinyaci yana da alergi ga wasu magunguna?",
                        "Za ka iya bayyana halin majinyaci?",
                        "Shin wannan gaggawa ce mai barazana ga rayuwa?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "I", no: "A'a" }
                },
                ar: {
                    headings: {
                        h1: "الآن: أجب على أسئلة الطوارئ الصحية",
                        h2: "ابدأ بالإجابة السريعة هنا"
                    },
                    questions: [
                        "ما هي حالة الطوارئ الخاصة بك؟",
                        "أين أنت؟",
                        "هل يعرف المريض؟",
                        "معلومات المريض (الاسم والعمر)",
                        "هل هناك نزيف أو إصابة؟",
                        "هل لدى المريض حساسية من أي أدوية؟",
                        "هل يمكنك وصف حالة المريض؟",
                        "هل هذه حالة طوارئ تهدد الحياة؟",
                        // أضف المزيد من الأسئلة هنا
                    ],
                    radioOptions: { yes: "نعم", no: "لا" }
                },

                am: {
                    headings: {
                        h1: "አሁን እንቅስቃሴ: አስቸኳይ ጥያቄዎችን መልስ",
                        h2: "ፈጣን እርምጃ እዚህ ይጀምራል"
                    },
                    questions: [
                        "እንዴት ነው እንዴት ነው?",
                        "የት ነው?",
                        "ታክ ነው ይንቁ?",
                        "ዝርዝር የታንቀስ ነው (ስም እና አመት)",
                        "ከእንግዲህ ቀይ ይሞክሩ?",
                        "ይህ ነጻ ይሞክሩ?",
                        "ምን ይመለከታሉ?",
                        "ይህ ድምፅ ይሞክሩ?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "አዎ", no: "አይ" }
                },
                yo: {
                    headings: {
                        h1: "Ṣe Nísinsinyí: Dahun Ìbéèrè Àìsàn Pajawiri",
                        h2: "Idahun Ìyára Bẹ̀rẹ̀ Níhìn"
                    },
                    questions: [
                        "Kini pajawiri rẹ?",
                        "Nibo ni o wa?",
                        "Njẹ alaisan naa mọ?",
                        "Alaye alaisan (Orukọ ati Ọmọ ọdun)",
                        "Njẹ ẹjẹ tabi ipalara wo ni o han?",
                        "Njẹ alaisan naa ni iwa ikolu si awọn oogun eyikeyi?",
                        "Ṣe o le ṣe apejuwe ipo alaisan naa?",
                        "Njẹ eyi jẹ pajawiri ti o n ṣe eewu si igbesi aye?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Bẹẹni", no: "Rara" }
                },
                tn: {
                    headings: {
                        h1: "تحرك الآن: أجب على الأسئلة الطارئة",
                        h2: "الاستجابة السريعة تبدأ من هنا"
                    },
                    questions: [
                        "ما هي حالتك الطارئة؟",
                        "أين تقع؟",
                        "هل المريض واعٍ؟",
                        "تفاصيل المريض (الاسم والعمر)",
                        "هل هناك أي نزيف أو إصابة ظاهرة؟",
                        "هل المريض لديه حساسية تجاه أي أدوية؟",
                        "هل يمكنك وصف حالة المريض؟",
                        "هل هذه حالة طارئة تهدد الحياة؟",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "نعم", no: "لا" }
                },
                st: {
                    headings: {
                        h1: "Etsa Hona Joale: Araba Lipotso tsa Tlhokomelo ea Pele",
                        h2: "Karabelo e Potlakileng e Qala Mona"
                    },
                    questions: [
                        "Ke eng bothata ba hao?",
                        "U fumaneha kae?",
                        "Na moriana o hlakile?",
                        "Lintlha tsa moriana (Lebitso le Letšoao)",
                        "Na ho na le ho hlaka ho uena kapa ho ameha?",
                        "Na moriana o na le allergi ho litlhare life kapa life?",
                        "Na u ka hlalosa boemo ba moriana?",
                        "Na ena ke bothata bo kotsi bophelong?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "E", no: "Che" }
                },
                zu: {
                    headings: {
                        h1: "Sebenza Manje: Phendula Imibuzo Ephuthumayo",
                        h2: "Impendulo Esheshayo Iqala Lapha"
                    },
                    questions: [
                        "Yini ingozi yakho?",
                        "Uphi na?",
                        "Ngabe umguli uyazi?",
                        "Imininingwane yomguli (Igama noMnyaka)",
                        "Ngabe kukhona ukuvuvukala noma ukulimala okuboniwe?",
                        "Ngabe umguli unayo imikhuhlane nganoma imaphi imithi?",
                        "Ungachaza kanjani isimo somguli?",
                        "Ingabe lokhu kuyingozi empilweni?",
                        // Add more questions here
                    ],
                    radioOptions: { yes: "Yebo", no: "Cha" }
                }
            };

            // Function to update questions based on selected language
            function updateQuestions() {
                const selectedLanguage = $('#languageSelector').val();
                currentLanguage = selectedLanguage;

                // Update the headings
                $('h1').text(translations[currentLanguage].headings.h1);
                $('h2').text(translations[currentLanguage].headings.h2);

                // Update the question labels
                questions.each(function (index) {
                    $(this).find("label").text(translations[currentLanguage].questions[index]);
                });

                // Define the list of radio button IDs to update
                const radioButtonLists = [
                    '#ConsciousBreathingList',
                    '#VisibleBleedingList',
                    '#AllergiesDropList',
                    '#UrgencyList'
                ];

                // Loop through each radio button list and update the text for "Yes" and "No"
                radioButtonLists.forEach(function (listId) {
                    const radioList = $(listId);
                    radioList.find("input[type=radio]").eq(0).next().text(translations[currentLanguage].radioOptions.yes);
                    radioList.find("input[type=radio]").eq(1).next().text(translations[currentLanguage].radioOptions.no);
                });

              
            }


            $("#languageSelector").change(updateQuestions);

            // Automatically read the welcome message and then the first question
            speakWelcomeMessage();

            // Listen for the 'Next' button click to move to the next question
            $("#nextButton").click(function () {
                window.speechSynthesis.cancel();

                if (currentQuestionIndex < questions.length - 1) {
                    currentQuestionIndex++;
                    speakCurrentQuestion();
                }
            });

            // Listen for the 'Previous' button click to move to the previous question
            $("#prevButton").click(function () {
                window.speechSynthesis.cancel();

                if (currentQuestionIndex > 0) {
                    currentQuestionIndex--;
                    speakCurrentQuestion();
                }
            });

          

            // Function to speak the current question
            

        });
    </script>


</body>
</html>
