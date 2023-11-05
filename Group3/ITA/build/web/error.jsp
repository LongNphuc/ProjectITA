<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error 404 - Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Error 404 - Page Not Found</h1>
        <p>The requested page could not be found on this server.</p>
        <p>Please check the URL you entered or contact the administrator for assistance.</p>
        <a href="${request.getContextPath()}/ITA">Come back to Login</a>
    </div>
</body>
</html>
