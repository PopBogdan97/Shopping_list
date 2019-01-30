<%-- 
    Document   : manageList
    Created on : 29-gen-2019, 23.39.09
    Author     : bogdan
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-theme/0.1.0-beta.10/select2-bootstrap.css" rel="stylesheet" />



        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.full.js"></script>
        <script src="js/manageList.js"></script>

    </head>

    <body class="bg-success">

        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Shopping List</a>
                <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <%
                    if (session == null || session.getAttribute("email") == null) {
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <a class=\"btn btn-outline-primary\" href=\"login_registration.jsp\">Accedi</a>"
                                + "     </li>"
                                + " </ul>"
                                + "</div>");
                    } else if (session != null && session.getAttribute("email") != null && session.getAttribute("tipo").equals("admin")) {
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <a href=\"profile.jsp\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\">"
                                + "         <b>" + session.getAttribute("email") + "</b></a>"
                                + "     </li>"
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
                                + "         <a href=\"profile.jsp\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\">"
                                + "         <b id=\"user-email\">" + session.getAttribute("email") + "</b></a>"
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

        <div id="${user.getEmail()}" class="container retrive-email">
            <div class="row justify-content-md-center">
                <div class="col-lg-8 portfolio-item ft-text">
                    <div id="list-start" class="card p-1" style="padding-left: 15px !important; padding-right: 15px !important">
                        <p></p>

                        <p></p>
                    </div>
                </div>

            </div>
        </div>

        <!-- ADD LIST MODAL -->
        <div class="modal fade" id="add-list-modal"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="list-modal-title">Add new list</h3>
                    </div>
                    <div class="modal-body">

                        <form>
                            <div class="form-group">
                                <label for="input-name-list">Name</label>
                                <input type="text" class="form-control" id="input-name-list" placeholder="Your list's Name">
                            </div>

                            <div class="form-group" style="margin-top:10px">
                                <label for="formGroupExampleInput2">List Category</label>
                                <select class="custom-select" id="select-cat-list"><option></option></select>
                            </div>

                            <div class="form-group">
                                <label for="formGroupExampleInput">Description</label>
                                <input type="text" class="form-control" id="list-description" placeholder="E.g. 'Bathroom objects'">
                            </div>
                            <p></p>

                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="customImage" accept="image/*">
                                <label class="custom-file-label" for="customImage">Choose Image</label>
                            </div>
                            <img id="list-image" src="#" width="125px" alt="Image not set">
                            <button type="button" id="remove-list-image" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="close-list-button" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="save-list-button" type="button" class="btn btn-success">Add List</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ADD COLLABORATOR MODAL -->
        <div class="modal fade" id="add-collab-modal"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="collab-modal-title">Add new collaborator</h3>
                    </div>
                    <div class="modal-body">

                        <form>

                            <div class="form-group" style="margin-top:10px">
                                <label for="select-collab">Collaborator</label>
                                <select class="custom-select" id="select-collab"><option></option></select>
                            </div>
                            
                            <h5>Permissions: </h5>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="exampleRadios" id="add-product" value="option1" checked>
                                <label class="form-check-label" for="add-product">
                                    Add Product
                                </label>
                            </div>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="exampleRadios" id="remove-product" value="option1" checked>
                                <label class="form-check-label" for="remove-product">
                                    Remove Product
                                </label>
                            </div>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="exampleRadios" id="edit-list" value="option1" checked>
                                <label class="form-check-label" for="edit-list">
                                    Edit List
                                </label>
                            </div>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="exampleRadios" id="delete-list" value="option1" checked>
                                <label class="form-check-label" for="delete-list">
                                    Delete List
                                </label>
                            </div>


                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="close-collab-button" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="save-collab-button" type="button" class="btn btn-success">Add Collaborator</button>
                    </div>
                </div>
            </div>
        </div>




    </body>
</html>

