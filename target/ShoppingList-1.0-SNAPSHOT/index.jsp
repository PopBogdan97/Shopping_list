<%-- 
    Document   : index
    Created on : 18-ott-2018, 14.43.31
    Author     : Marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<jsp:useBean id="sum" class="objects.ProdCatBean" scope="page" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Shopping List</title>

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css">
        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
        
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    </head>

    <body class="bg-success">
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Shopping List</a>
                <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse collapse" id="navbarResponsive" style="">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <img src="img/user.png" alt="" width="40" height="40">
                            <a class="btn btn-outline-primary" href="login_registration.jsp">Accedi</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 portfolio-item">
                    <div class="card h-100 p-1">
                        <div class="d-flex align-items-center p-2 text-dark-50 border-bottom">
                            <input type="image" class="mr-3" src="img/search.png" alt="Ok" width="27" height="27"/>
                            <h6 class="mb-0 mx-auto text-dark lh-100">PRODOTTI</h6>
                        </div>
                        <br>
                        <ul class="list-group">
                            <c:forEach var = "i" begin = "1" end = "5">
                                <a href="#" class="list-group-item list-group-item-action list-group-item-info" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <li class="d-flex justify-content-between align-items-center">
                                        Categoria <c:out value = "${i}"/><p>
                                        <span class="badge badge-primary badge-pill">2</span>
                                    </li>
                                </a>
                                <br>
                            </c:forEach>
                            <!--<br>
                            <a href="#" class="list-group-item list-group-item-action list-group-item-info" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <li class="d-flex justify-content-between align-items-center">
                                    Categoria 2
                                    <span class="badge badge-primary badge-pill">2</span>
                                </li>
                            </a>
                            <br>
                            <a href="#" class="list-group-item list-group-item-action list-group-item-info" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <li class="d-flex justify-content-between align-items-center">
                                    Categoria 3
                                    <span class="badge badge-primary badge-pill">2</span>
                                </li>
                            </a>-->
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <a class="dropdown-item" href="#">Something else here</a>
                            </div>
                        </ul>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                    </div>
                </div>
                <div class="col-lg-6 portfolio-item">
                    <div class="card h-100 p-1">
                        <div class="p-2 text-center text-dark-50 border-bottom">
                            <h6 class="mb-0 mt-2 text-dark lh-100">LISTE DI PIPPO</h6>
                        </div>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <input type="image" class="mb-3 float-right" src="img/more.png" alt="Ok" width="30" height="30"/>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <c:forEach var="shoppingList" items="${shoppingLists}">
                ${shoppingList.nome}
            </c:forEach>
        </div>
        <!--<footer class="py-4 bg-light">
            <div class="container">
                <p class="m-0 text-center text-dark">Copyright © Shopping List 2018</p>
            </div>
        </footer>-->
        <script>
            $(document).ready(function() {
                $.ajax({
                    url: 'GetCatProdServlet',
                    type: 'get',
                    dataType: 'json'
                });
            });
        </script>  
    </body>
</html>

