<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <%@include file="component/header.jsp" %>
        <%
    session.setAttribute("checkExist", true);
        %>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="index.html" class="">
                                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>IMS</h3>
                            </a>
                            <h3>Sign-Up</h3>
                        </div>
                        <div id="sender" class="form-floating mb-3">
                            <input type="text" class="form-control" id="number" placeholder="#113" required>
                            <label for="floatingText">Mobile</label>
                            <div id="recaptcha-container"></div>
                            <button class="btn btn-primary py-3 w-100 mb-4" onClick="checkMobile()">Send Captcha</button>
                            <div id='error' style="color: red"></div>
                            <a href="${loginGoogleURL}"             
                               class="btn btn-danger w-100 mb-1 text-start">
                                <i class="fa-brands fa-google me-3" style="color: #ffffff;"></i>
                                Login with <b>Google</b>
                            </a>
                            <p class="text-center mb-0">Already have an Account? <a href="LoginController?signin=true">Sign In</a></p>
                        </div>
                        <div id="verifier" style="display: none">
                            <input type="text" id="verificationcode" placeholder="OTP Code">
                            <input type="button" id="verify" value="Verify" onClick="codeverify()">
                            <div class="p-conf" style="display: none">Number Verified</div>
                            <div class="n-conf" style="display: none">OTP ERROR</div>
                        </div>
                        <div id="fillinfor" class="form-floating mb-3" style="display: none">
                            Your name:<input type="text" id="accountName" required><br>
                            <div id='errorName' style="color: red"></div>
                            You are:
                            <input type="radio" id="teacherRadio" name="role" value="${Role.ROLE_TEACHER}" checked>Teacher<br>
                            <input type="radio" id="studentRadio" name="role" value="${Role.ROLE_STUDENT}">Student<br>
                            Password:<input type="password" id="pass1" required><br>
                            Confirm password:<input type="password" id="pass2" required>
                            <div id='errorPassword' style="color: red"></div>
                            <input type="button" value="Register" class="btn btn-primary py-3 w-100 mb-4" onClick="register()">
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.12.1/firebase-auth-compat.js"></script>

    <script>
                                function displayAlert() {
                                    var message = "${sessionScope.mess}";
                                    if (message !== "") {
                                        alert(message);
                                        var xhr = new XMLHttpRequest();
                                        xhr.open("GET", "sourceServiceApi?source=removeSession&name=checkExist", true);
                                        xhr.send();
                                    }
                                }
                                displayAlert();
    </script>
    <script>

        const firebaseConfig = {
            apiKey: "AIzaSyC-inrRSFkrUDlVql7fmFwbGUnK-ZPcDL8",
            authDomain: "ita301.firebaseapp.com",
            projectId: "ita301",
            storageBucket: "ita301.appspot.com",
            messagingSenderId: "294131505979",
            appId: "1:294131505979:web:fbf8938901cf6d29e9351e",
            measurementId: "G-PZ8H0XR4X3"
        };

        firebase.initializeApp(firebaseConfig);
        render();
        function render() {
            window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier('recaptcha-container');
            recaptchaVerifier.verify();
        }
        ;

        function phoneAuth() {
            var number = document.getElementById('number').value.trim();
            if (number.charAt(0) === '0') {
                number = '+84' + number.substr(1);
            }
            firebase.auth().signInWithPhoneNumber(number, window.recaptchaVerifier).then(function (confirmationResult) {
                window.confirmationResult = confirmationResult;
                coderesult = confirmationResult;
                document.getElementById('sender').style.display = 'none';
                document.getElementById('verifier').style.display = 'block';
            }).catch(function (error) {
                alert(error.message);
            });
        }
        ;
        // function for code verify
        function codeverify() {
            var code = document.getElementById('verificationcode').value;
            coderesult.confirm(code).then(function () {
//                                        document.getElementsByClassName('p-conf')[0].style.display = 'block';
                document.getElementById('verifier').style.display = 'none';
                document.getElementById('fillinfor').style.display = 'block';
            }).catch(function () {
                document.getElementsByClassName('p-conf')[0].style.display = 'none';
                document.getElementsByClassName('n-conf')[0].style.display = 'block';
            });
        }
        ;

        function checkMobile() {
            var number = document.getElementById('number').value.trim();
            var flag = false;
            const request = new XMLHttpRequest();
            request.open("get", "sourceServiceApi?source=listMobile", true);
            if (number !== "") {
                request.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        const mobileList = JSON.parse(this.responseText);
                        console.log(mobileList);
                        console.log('mobile cua tao: ' + number);
                        mobileList.forEach(mobile => {
                            if (mobile === number) {
                                flag = true;
                            }
                        });
                        if (flag) {
                            document.getElementById('error').textContent = "Mobile had been exist!Again";
                        } else {
                            phoneAuth();
                        }
                    }
                };
                request.send();
            } else {
                document.getElementById('error').textContent = "Please input mobile!";
            }
        }
        ;

        function getSelectedRole() {
            var teacherRadio = document.getElementById('teacherRadio');
            var studentRadio = document.getElementById('studentRadio');

            if (teacherRadio.checked) {
                return teacherRadio.value; // Nếu Teacher đã được chọn, trả về giá trị "0"
            } else if (studentRadio.checked) {
                return studentRadio.value; // Nếu Student đã được chọn, trả về giá trị "1"
            } else {
                return null; // Nếu không có radio nào được chọn, có thể trả về giá trị mặc định hoặc null.
            }
        }

        function register() {
            if (document.getElementById('pass1').value !== document.getElementById('pass2').value) {
                document.getElementById('errorPassword').textContent = "Password not confirm! Again";
            } else if (document.getElementById('accountName').value === '') {
                document.getElementById('errorName').textContent = "Name not valid! Again";
            } else {
                var roleIdinput = getSelectedRole();

                var mobileInput = document.getElementById('number').value.trim();
                console.log(mobileInput);
                console.log(roleIdinput);
                var userData = {
                    mobile: mobileInput,
                    accountName: document.getElementById('accountName').value.trim(),
                    roleId: roleIdinput,
                    password: document.getElementById('pass1').value
                };
                fetch('sign-up', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(userData)
                }).then(response => {
                    alert("Register success! Now you will be redirected to your page!");
                    window.location.href = '${request.getContextPath()}';
                }).catch(error => {
                    console.error('Error:', error);
                });
            }
        }
        ;
    </script>
    <%@include file="component/footer.jsp" %>
</body>
</html>
