<%-- 
    Document   : checkMail
    Created on : 30-gen-2019, 21.35.54
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">"
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div style="width: 1150px; margin: 0 auto;">
                <a class="navbar-brand" href="index.jsp">Shopping List</a>
            </div>
        </nav>
        <div class="container" style="margin-top: 150px;">
            <center><div>
                    <h3>Check your email: <b><%= request.getParameter("email")%></b></h3>
                </div></center>
            <center><a href='login_registration.jsp' class="btn btn-outline-primary" style="margin-top: 30px;">Return to Login</a></center>
        </div>
    </body>
</html>
