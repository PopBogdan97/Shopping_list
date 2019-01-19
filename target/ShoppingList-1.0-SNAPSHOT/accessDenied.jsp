<%-- 
    Document   : AccessDenied
    Created on : 17-gen-2019, 16.57.57
    Author     : Luca
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping List</title>

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Shopping List</a>
                <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <%
                    if(session == null || session.getAttribute("email") == null){
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                    + " <ul class=\"navbar-nav ml-auto\">"
                                    + "     <li class=\"nav-item\">"
                                    + "         <img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\">"
                                    + "         <a class=\"btn btn-outline-primary\" href=\"login_registration.jsp\">Accedi</a>"
                                    + "     </li>"
                                    + " </ul>"
                                    + "</div>");
                    }
                %>
            </div>
        </nav>
        
        <center style="margin-top: 100px;">
            <h1>Non hai i permessi per accedere a questa pagina</h1>
            <br>
            <a href="index.jsp"><button class="btn btn-outline-primary">Torna alla home page</button></a>
        </center>
        
    </body>
</html>
