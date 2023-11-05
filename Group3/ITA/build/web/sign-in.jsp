

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/caube.css">
        <script src="https://kit.fontawesome.com/c9f5871d83.js" crossorigin="anonymous"></script>

        <title>Sign-in</title>
    </head>
    <body>
        <div class="container">
            <header class="header">
                <nav class="nav">
                    <div class="nav-left">
                        <a href="#"><i class="fa-solid fa-paper-plane"></i>IMS</a>
                    </div>
                    <div class="nav-right">
                        <ul>
                            <a href="http://localhost:9999/ITA/"><li class="active">Home</li></a>
                        </ul>
                    </div>
                </nav>
            </header>
            <div class="login">
                <div class="left">
                    <form action="LoginController" method="get">
                        <div class="top">
                            <h2>Welcome to IMS</h2>
                            <h4>Sign-in</h4>
                        </div>
                        <div class="input">
                            <input type="text" name="account" placeholder="Email" required>
                            <i class="fa-solid fa-envelope"></i>
                        </div>
                        <div class="input">
                            <input type="password" name="password" placeholder="Password" required>
                            <i class="fa-solid fa-eye"></i>
                        </div>
                        <% String errorMessage = (String) request.getAttribute("mess"); %>
                        <% if (errorMessage != null) { %>
                        <div style="color: red"><%= errorMessage %></div>
                        <% } %>
                        <div class="btn">
                            <button>Login</button>
                            <a href="${loginGoogleURL}"             
                               class="btn btn-danger w-100 mb-1 text-start">
                                <i class="fa-brands fa-google me-3" style="color: #ffffff;"></i>
                                Login with <b>Google</b>
                            </a>
                        </div>
                        <br>
<!--                        <div class="forget">
                            <a href="#">Forget password? Click here!</a>
                        </div>-->
                        <div class="icon">           
                            <a href="sign-up?signup=true"><i class="fa-brands"></i> Don't have account.Sign-up</a>                        
                        </div>
                    </form>
                </div>
                <div class="right">
                    <img src="https://khoinguonsangtao.vn/wp-content/uploads/2021/10/hinh-anh-chill.jpg">
                </div>
            </div>
        </div>
    </body>
</html>