<%-- 
    Document   : home
    Created on : 8-ott-2018, 11.07.54
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%=(!(session.getAttribute("email")==null)) ? "Logged as: "+session.getAttribute("email")+" <a href='LogoutServlet'>Logout</a> ": "Not logged <a href='login.jsp'>Login</a>"%>
    </body>
</html>
