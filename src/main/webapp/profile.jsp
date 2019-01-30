<%-- 
    Document   : profile
    Created on : 21-gen-2019, 17.44.28
    Author     : marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Expires" content="0" />

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Shopping List</title>

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/profile.js"></script>
    </head>
    <body class="bg-success">
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">Shopping List</a>
                <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <%
                    if (session == null || session.getAttribute("email") == null) {
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\">"
                                + "         <a class=\"btn btn-outline-primary\" href=\"login_registration.jsp\">Accedi</a>"
                                + "     </li>"
                                + " </ul>"
                                + "</div>");
                    } else if (session != null && session.getAttribute("email") != null && session.getAttribute("tipo").equals("admin")) {
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <img src=\"img/impostazioni.png\" alt=\"\" style=\"float: left;\" width=\"30\" height=\"30\">"
                                + "         <a class=\"btn btn-outline-primary\" href=\"adminPanel.jsp\" style=\"float: left; margin-left: 10px;\">Pannello amministratore</a>"
                                + "     </li>"
                                + "     <li class=\"nav-item\">"
                                + "         <a class=\"btn btn-outline-danger\" href=\"LogoutServlet\">Logout</a>"
                                + "     </li>"
                                + " </ul>"
                                + "</div>");
                    } else {
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <a href=\"#\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\"></a>"
                                + "         <b>" + session.getAttribute("email") + "</b>"
                                + "     </li>"
                                + "     <li class=\"nav-item\">"
                                + "         <a class=\"btn btn-outline-danger\" href=\"LogoutServlet\">Logout</a>"
                                + "     </li>"
                                + " </ul>"
                                + "</div>");
                    }
                %>
                <!--
                    <div class="navbar-collapse collapse" id="navbarResponsive" style="">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item">
                                <img src="img/impostazioni.png" alt="" style="visibility: <%=(session.getAttribute("Tipologia") == "admin") ? "block" : "hidden"%>" width="30" height="30">
                                <a class="btn" href="adminPanel.jsp" style="visibility: <%=(session.getAttribute("Tipologia") == "admin") ? "block" : "hidden"%>" >Gestisci categorie</a>
                            </li>
                            <li class="nav-item">
                                <img src="img/user.png" alt="" width="40" height="40">
                                <a class="btn btn-outline-primary" href="login_registration.jsp">Accedi</a>
                            </li>
                        </ul>
                    </div>
                -->

            </div>
        </nav>     
        <br><br><br><br>
        <img id="img" src="#" class="rounded-circle mx-auto d-block" width="300" height="300" >
        <br><br>
        <h1 class="text-center" id="f-name"><c:out value="${user.getFirstName()}"/></h1>
        <h1 class="text-center" id="l-name"><c:out value="${user.getLastName()}"/></h1>
        <br><br><br>
        <div style="text-align:center">
        <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#searchModal" id="modify">Modify profile</button>
        </div>
        <!-- The Modal -->
        <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Modify profile</h5>
                    </div>
                    <div class="modal-body">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="file-profile" accept="image/*">
                            <label class="custom-file-label" for="customImage">Choose Image</label>
                        </div>
                        <img id="img-profile" src="#" width="125px" alt="Image not set">
                        <button type="button" id="removeimage-profile" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>
                        <input type="hidden" name="email" id="user-email" value="${user.getEmail()}">
                        <br><br>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">First and last name</span>
                            </div>
                            <input type="text" aria-label="First name" class="form-control" id="first-name">
                            <input type="text" aria-label="Last name" class="form-control" id="last-name">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                        <button type="submit" class="btn btn-primary" data-dismiss="modal" id="modal-button">Modifica</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
