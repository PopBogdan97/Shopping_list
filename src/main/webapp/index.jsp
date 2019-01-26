<%-- 
    Document   : index
    Created on : 18-ott-2018, 14.43.31
    Author     : Marco & Luca
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
        <link rel="stylesheet" type="text/css" href="css/login_registration.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-theme/0.1.0-beta.10/select2-bootstrap.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="css/index.css">


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.full.js"></script>
        <script src="js/indexAjax.js"></script>
        <script type="text/javascript" src="js/login_registration.js"></script>
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
                                + "         <a href=\"profile.jsp\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\"></a>"
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
                                + "         <a href=\"profile.jsp\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\"></a>"
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

        <div class="container">
            <div class="row">
                <div class="col-lg-6 portfolio-item ft-text">
                    <div class="card p-1">
                        <div class="d-flex align-items-center p-2 text-dark-50 border-bottom">
                            <h6 class="mb-0 mx-auto text-dark lh-100">Prodotti</h6>
                        </div>
                        
                        <p></p>                      
                        <div class="input-group mb-3">
                            <img src="img/search.png" style="height:28px; width:28px;">
                            <select class="custom-select all-products"><option></option></select>
                        </div>        
                        <p></p>
                        
                        <c:forEach var="shoppingList" items="${shoppingLists}">
                            <button class="collapsible"><span class="badge badge-primary badge-pill">${shoppingList.counter}</span> ${shoppingList.nome}</button>
                            <ul class="content list-unstyled">
                                <c:forEach var="product" items="${products}">
                                    <c:if test="${product.cat_prodotto == shoppingList.nome}">
                                        <br><li class="portfolio-link" style="cursor:pointer;" data-toggle="modal" href="#${fn:replace(product.nome,' ','')}">${product.nome}</li>
                                        </c:if>
                                    </c:forEach>
                                <br>
                            </ul>
                        </c:forEach>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                    </div>
                </div>
                <div class="col-lg-6 portfolio-item ft-text" style="height: 400px;">

                    <!-- SHOW USER LISTS-->
                    <div class="card p-1" id="show-user-list" >
                        <div class="d-flex align-items-center p-2 text-dark-50 border-bottom">
                            <input type="image" class="mr-3" src="img/annulla.png" onclick="returnBack()" alt="Ok" width="27" height="27"/>
                            <h6 class="mb-0 mx-auto text-dark lh-100">Liste di 
                                <c:if test="${user.getTypology() == 'anonymous'}">
                                    <c:out value="${user.getTypology()}"/>
                                </c:if>
                                <c:if test="${user.getTypology() == 'normal' || user.getTypology() == 'admin'}">
                                    <c:out value="${user.getFirstName()} ${user.getLastName()}"/>
                                </c:if>
                            </h6>
                            <input type="image" class="mr-3" src="img/campana.png" alt="Ok" width="27" height="27"/>
                        </div>
                        <p></p>

                        <c:forEach var="List" items="${user.getLists()}">
                            <button class="collapsible list-button">
                                <span class="badge badge-primary badge-pill" id="product-number-span"></span>
                                <span class="list-span">
                                    ${List}
                                </span>
                            </button>
                            <ul class="content list-unstyled product-list">
                                <br>
                            </ul>
                        </c:forEach>
                        <p></p>
                        <p></p>
                        <p></p>
                        <a data-toggle="modal" data-target="#productModal">utilizza questo</a>
                        <p></p>
                        <p></p>
                        <p></p>
                        <p></p>
                        <nav class="menu" id="menu"> <!--style="visibility:hidden"-->
                            <input type="checkbox" href="#" class="menu-open" name="menu-open" id="menu-open" />
                            <label class="menu-open-button" for="menu-open">
                                <span class="lines line-1"></span>
                                <span class="lines line-2"></span>
                                <span class="lines line-3"></span>
                            </label>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-trash-alt"></i> </a>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-share-alt"></i> </a>
                            <a href="#" class="menu-item lightblue"> <i class="fa fa-comments"></i> </a>
                        </nav>
                        <!--<input type="image" class="mr-3" onclick="showHamburgerMenu()" src="img/more.png" alt="Ok" width="35" height="35"/>-->
                    </div>

                    <!-- ADD PRODUCT MODAL -->
                    <div class="modal fade" id="productModal"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title" id="productModalLabel">Modal title</h3>
                                </div>
                                <div class="modal-body">

                                    <form>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Description</label>
                                            <input type="text" class="form-control" id="formGroupExampleInput" placeholder="E.g. 'Country of origin'">
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="customImage" accept="image/*">
                                            <label class="custom-file-label" for="customImage">Choose Image</label>
                                        </div>
                                        <img id="product-image" src="#" width="125px" alt="Image not set">
                                        <button type="button" id="remove-product-image" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>
                                        
                                        <div class="custom-file" style="margin-top:10px">
                                            <input type="file" class="custom-file-input" id="customLogo" accept="image/*">
                                            <label class="custom-file-label" for="customLogo">Choose Logo</label>
                                        </div>
                                        <img id="product-logo" src="#" width="125px" alt="Logo not set">
                                        <button type="button" id="remove-product-logo" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>

                                        <div class="form-group" style="margin-top:10px">
                                            <label for="formGroupExampleInput2">Product Category</label>
                                            <select class="custom-select product-cat-select" id="product-cat-select"><option></option></select>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button id="closebutton-product" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button id="savebutton-product" type="button" class="btn btn-primary" disabled="disabled">Save changes</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <c:forEach var="product" items="${products}">
            <div class="modal fade" id="${fn:replace(product.nome,' ','')}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="z-index: 10000 !important;">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">${product.nome}</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <img class="img-fluid rounded mx-auto d-block" src="img/02-full.jpg">
                            <br><br>
                            <div>Descrizione: ${product.note}</div>
                            <br><br>

                            <div class="counter">
                                <div class='btn-group'>
                                    <input type="image" class="dec mx-2" src="img/meno.png" alt="Ok" width="30" height="30"/>
                                    <input type="text" class="field px-2" style="width: 70px;" value="1" data-min="1" data-max="1000">
                                    <input type="image" class="inc mx-2" src="img/piu.png" alt="Ok" width="30" height="30"/>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary">Aggiungi prodotto</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

                    <div class="modal fade" id="search-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="z-index: 10000 !important;">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle"></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <img class="img-fluid rounded mx-auto d-block" src="img/02-full.jpg">
                            <br><br>
                            <div>Descrizione: </div>
                            <br><br>

                            <div class="counter">
                                <div class='btn-group'>
                                    <input type="image" class="dec mx-2" src="img/meno.png" alt="Ok" width="30" height="30"/>
                                    <input type="text" class="field px-2" style="width: 70px;" value="1" data-min="1" data-max="1000">
                                    <input type="image" class="inc mx-2" src="img/piu.png" alt="Ok" width="30" height="30"/>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                            <button type="button" class="btn btn-primary">Aggiungi prodotto</button>
                        </div>
                    </div>
                </div>
            </div>
                            
        <script>
            var coll = document.getElementsByClassName("collapsible");
            var i;
            for (i = 0; i < coll.length; i++) {
                coll[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var content = this.nextElementSibling;
                    if (content.style.maxHeight) {
                        content.style.maxHeight = null;
                    } else {
                        content.style.maxHeight = content.scrollHeight + "px";
                    }
                });
            }
        </script>

        <script>
            function showHamburgerMenu() {
                document.getElementById('menu').style.visibility = 'visible';
                document.getElementById('more').style.visibility = 'hidden';
            }
            function returnBack() {
                document.getElementById('menu').style.visibility = 'hidden';
                document.getElementById('more').style.visibility = 'visible';
            }
        </script>

        <script>
            function counter(field) {
                var field = $(field);
                function fieldCount(el) {
                    var min = el.data('min') || false,
                            max = el.data('max') || false,
                            dec = el.prev('.dec'),
                            inc = el.next('.inc');
                    function init(el) {
                        if (!el.attr('disabled')) {
                            dec.on('click', decrement);
                            inc.on('click', increment);
                        }
                        function decrement() {
                            var value = parseInt(el.val());
                            value--;
                            if (!min || value >= min) {
                                el.val(value);
                            }
                        }
                        ;
                        function increment() {
                            var value = parseInt(el.val());
                            value++;
                            if (!max || value <= max) {
                                el.val(value++);
                            }
                        }
                        ;
                    }
                    el.each(function () {
                        init($(this));
                    });
                }
                ;
                if (field.length) {
                    field.each(function () {
                        fieldCount($(this));
                    });
                }
            }
            counter('.field');
        </script>
        
        <script src="js/all_products.js"></script>


        <!--<footer class="py-4 bg-light">
            <div class="container">
                <p class="m-0 text-center text-dark">Copyright © Shopping List 2018</p>
            </div>
        </footer>-->
    </body>
</html>

