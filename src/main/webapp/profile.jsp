<%-- 
    Document   : profile
    Created on : 21-gen-2019, 17.44.28
    Author     : marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    </head>
    <body class="bg-success">
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
                    else if(session != null && session.getAttribute("email") != null && session.getAttribute("tipo").equals("admin")){
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
                    }
                    else{
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                    + " <ul class=\"navbar-nav ml-auto\">"
                                    + "     <li class=\"nav-item\">"
                                    + "         <a href=\"#\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\"></a>"
                                    + "         <b>"+session.getAttribute("email")+"</b>"
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
                            <img src="img/impostazioni.png" alt="" style="visibility: <%=(session.getAttribute("Tipologia")=="admin") ? "block" : "hidden"%>" width="30" height="30">
                            <a class="btn" href="adminPanel.jsp" style="visibility: <%=(session.getAttribute("Tipologia")=="admin") ? "block" : "hidden"%>" >Gestisci categorie</a>
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
        <img src="img/02-full.jpg" id="myImg" class="rounded-circle mx-auto d-block" width="300" height="300" data-toggle="modal" data-target="#searchModal" >
        <br><br>
        <h1 class="text-center">Gianluca Pirrera</h1>
        <!-- The Modal -->
        <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="z-index: 10000 !important;">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Modifica immagine</h5>
                    </div>
                    <div class="modal-body">
                        <form action="ImageUploadServlet" method="post" enctype="multipart/form-data">
                            <label>Image</label>
                            <input type="hidden" name="email" value=<%=request.getAttribute("email")%>>
                            <input type="file" name="file" />
                        </form>
                        <span style="color:red"><%=(request.getAttribute("error") == null) ? "" : request.getAttribute("error")%></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                        <button type="submit" class="btn btn-primary">Modifica</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
