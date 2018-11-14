<%-- 
    Document   : index
    Created on : 18-ott-2018, 14.43.31
    Author     : Marco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

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
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                        <li class="nav-item">
                            <img src="img/user.png" alt="" width="40" height="40">
                            <a class="btn btn-outline-primary" href="login_registration.jsp">Accedi</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 portfolio-item ft-text">
                    <div class="card h-100 p-1">
                        <div class="d-flex align-items-center p-2 text-dark-50 border-bottom">
                            <input type="image" class="mr-3" src="img/search.png" alt="Ok" width="27" height="27"/>
                            <h6 class="mb-0 mx-auto text-dark lh-100">PRODOTTI</h6>
                        </div>
                        <br>
                        <c:forEach var="shoppingList" items="${shoppingLists}">
                            <button class="collapsible"><span class="badge badge-primary badge-pill">${shoppingList.counter}</span> ${shoppingList.nome}</button>
                            <ul class="content list-unstyled">
                                <br>
                                <c:forEach var="product" items="${products}">
                                    <c:if test="${product.cat_prodotto == shoppingList.nome}">
                                        <li class="portfolio-link" data-toggle="modal" href="#exampleModalCenter${product.nome}">${product.nome}</li>
                                    </c:if>
                                </c:forEach>
                                <br>
                            </ul>
                        </c:forEach>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                    </div>
                </div>
                <div class="col-lg-6 portfolio-item ft-text">
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
                        <nav class="menu">
                            <input type="checkbox" href="#" class="menu-open" name="menu-open" id="menu-open" />
                            <label class="menu-open-button" for="menu-open">
                                <span class="lines line-1"></span>
                                <span class="lines line-2"></span>
                                <span class="lines line-3"></span>
                            </label>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-anchor"></i> </a>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-coffee"></i> </a>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-heart"></i> </a>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        
        <c:forEach var="product" items="${products}">
            <div class="modal fade" id="exampleModalCenter${product.nome}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">${product.nome}</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                             ...
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary">Aggiungi prodotto</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <script>
            var coll = document.getElementsByClassName("collapsible");
            var i;

            for (i = 0; i < coll.length; i++) {
                coll[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var content = this.nextElementSibling;
                    if (content.style.maxHeight){
                        content.style.maxHeight = null;
                    } else {
                        content.style.maxHeight = content.scrollHeight + "px";
                    } 
                });
            }
        </script>
        
        <!--<footer class="py-4 bg-light">
            <div class="container">
                <p class="m-0 text-center text-dark">Copyright © Shopping List 2018</p>
            </div>
        </footer>-->
    </body>
</html>

