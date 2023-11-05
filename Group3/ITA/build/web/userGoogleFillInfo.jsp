<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <title>
            Fill Info 
        </title>
        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
        <!-- Nucleo Icons -->
        <link href="assets/css/nucleo-icons.css" rel="stylesheet" />
        <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
        <!-- CSS Files -->
        <link id="pagestyle" href="assets/css/material-dashboard.css?v=3.0.5" rel="stylesheet" />
        <!-- Nepcha Analytics (nepcha.com) -->
        <!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
        <script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
    </head>

    <body class="">
        <%@include file="component/header.jsp" %>
        <main class="main-content  mt-0">
            <section>
                <div class="page-header min-vh-100">
                    <div class="container">
                        <div class="row">
                            <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
                                <div class="position-relative bg-gradient-primary h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('assets/img/illustrations/illustration-signup.jpg'); background-size: cover;">
                                </div>
                            </div>
                            <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
                                <div class="card card-plain" id="div01">
                                    <div class="card-header">
                                        <h4 class="font-weight-bolder">Sign Up</h4>
                                        <p class="mb-0">Enter infor to register</p>
                                    </div>
                                    <div class="card-body">
                                        <div class="input-group input-group-outline mb-3">
                                            <input id="email" type="email" value="${userGoogle.email}" class="form-control" placeholder="Email" readonly>
                                        </div>
                                        <div class="input-group input-group-outline mb-3">
                                            Your name:<input id="accountName" type="text" value="${userGoogle.given_name}" class="form-control" placeholder="Account Name" required>
                                        </div>
                                        <div class="input-group input-group-outline mb-3">
                                            Password:<input id="password" type="password" placeholder="password" class="form-control" placeholder="Email" required>
                                        </div>
                                        <div class="input-group input-group-outline mb-3">
                                            You are:
                                            <input type="radio" id="teacherRadio" name="role" value="${Role.ROLE_TEACHER}" checked>Teacher<br>
                                            <input type="radio" id="studentRadio" name="role" value="${Role.ROLE_STUDENT}">Student
                                        </div>
                                        <div id="error" style="color: red"></div>
                                        <div class="text-center">
                                            <input type="button" value="OKAY" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0" onClick="register()">
                                        </div>                    
                                    </div>
                                </div>
                                <div class="card card-plain" id="div02" style="display: none">
                                    <div class="card-header">
                                        <h4 class="font-weight-bolder">Sign Up</h4>
                                        <p class="mb-0">Enter OTP</p>                     
                                    </div>
                                    <div class="card-body">
                                        <div class="input-group input-group-outline mb-3">
                                            <input id="otp" type="text" class="form-control" placeholder="OTP" required>
                                        </div>
                                        <div id="error02" style="color: red"></div>
                                        <div class="text-center">
                                            <input type="button" value="CONFIRM OTP" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0" onClick="checkOTP()">
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <!--   Core JS Files   -->
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>
        <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
        <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
        <script>
                                                var win = navigator.platform.indexOf('Win') > -1;
                                                if (win && document.querySelector('#sidenav-scrollbar')) {
                                                    var options = {
                                                        damping: '0.5'
                                                    };
                                                    Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
                                                }
        </script>
        <!-- Github buttons -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
        <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
        <script src="assets/js/material-dashboard.min.js?v=3.0.5"></script>

        <script>
                                                function getSelectedRole() {
                                                    var teacherRadio = document.getElementById('teacherRadio');
                                                    var studentRadio = document.getElementById('studentRadio');

                                                    if (teacherRadio.checked) {
                                                        return teacherRadio.value; 
                                                    } else if (studentRadio.checked) {
                                                        return studentRadio.value; 
                                                    } else {
                                                        return null; 
                                                    }
                                                }
                                                ;
                                                var OTP;
                                                function sendOTP() {
                                                    var email = document.getElementById('email').value;
                                                    console.log(email);
                                                    $.get("sourceServiceApi", {
                                                        source: "sendOTPByEmail",
                                                        email: email
                                                    }, function (result) {
                                                        OTP = JSON.parse(result);
                                                        console.log(OTP);
                                                        
                                                    });
                                                };
                                                
                                                function checkOTP(){
                                                    var email = document.getElementById('email').value;
                                                    var accountName = document.getElementById('accountName').value.trim();
                                                    var password = document.getElementById('password').value.trim();
                                                    var roleIdinput = getSelectedRole();
                                                    if (OTP.toString() === document.getElementById('otp').value.toString()) {
                                                            var userData = {
                                                                email: email,
                                                                accountName: accountName,
                                                                roleId: roleIdinput,
                                                                password: password,
                                                                oauthId: "${requestScope.userGoogle.id}",
                                                                image: "${requestScope.userGoogle.picture}",
                                                                fullName: "${requestScope.userGoogle.name}"
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
                                                        } else {
                                                            document.getElementById('error02').textContent = "OTP not true! Again";
                                                        }
                                                }


                                                function register() {
                                                    var email = document.getElementById('email').value;
                                                    var accountName = document.getElementById('accountName').value.trim();
                                                    var password = document.getElementById('password').value.trim();
                                                    var roleIdinput = getSelectedRole();
                                                    if (accountName === "" || password === "") {
                                                        document.getElementById('error').textContent = "Infor not valid! Again";
                                                    } else {
                                                        document.getElementById('div01').style.display = 'none';
                                                        document.getElementById('div02').style.display = 'block';
                                                        sendOTP();
                                                    }
                                                }
                                                ;
        </script>
    </body>

</html>