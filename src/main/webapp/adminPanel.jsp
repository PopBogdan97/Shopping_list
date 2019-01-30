<%-- 
    Document   : adminPanel
    Created on : 15-ott-2018, 11.43.56
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

       
        <link rel="stylesheet" href="css/panel.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-theme/0.1.0-beta.10/select2-bootstrap.css" rel="stylesheet" />


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.full.js"></script>
 
        <script src="js/panel.js"></script>
        
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Admin Panel</a>
                <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <%
                    
                        out.println("<div class=\"navbar-collapse collapse\" id=\"navbarResponsive\" style=\"\">"
                                + " <ul class=\"navbar-nav ml-auto\">"
                                + "     <li class=\"nav-item\">"
                                + "         <a href=\"profile.jsp\"><img src=\"img/user.png\" alt=\"\" width=\"40\" height=\"40\">"
                                + "         <b id=\"user-email\" style=\"color: black;\">" + session.getAttribute("email") + "</b></a>"
                                + "     </li>"
                                + "     <li class=\"nav-item\">"
                                + "         <a class=\"btn btn-outline-primary\" href=\"index.jsp\" style=\"float: left; margin-top: 10px; margin-left: 10px; margin-right: 10px\">Return to home</a>"
                                + "     </li>"
                                + "     <li class=\"nav-item\">"
                                + "         <a class=\"btn btn-outline-danger\" href=\"LogoutServlet\" style=\"margin-top: 10px;\">Logout</a>"
                                + "     </li>"
                                + " </ul>"
                                + "</div>");
                   
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
                <div class="col portfolio-item ft-text">
                    <h1>Categorie di lista</h1>
                    <select class="str-catlist custom-select" name="str-catlist"><option></option></select>
                    <button class="btn" id="delete-catlist" style="display:none;">Elimina</button>
                    <button class="btn" id="modify-catlist" style="display:none;" data-toggle="modal" data-target="#catlistModal" >Modifica</button>
                </div>
                <div class="col portfolio-item ft-text">
                    <h1>Categorie di prodotto</h1>
                    <select class="str-catprod custom-select" name="str-catprod"><option></option></select>
                    <button class="btn" id="delete-catprod" style="display:none;">Elimina</button>
                    <button class="btn" id="modify-catprod" style="display:none;" data-toggle="modal" data-target="#catprodModal" >Modifica</button>
                </div>
                <div class="col portfolio-item ft-text">
                    <h1>Prodotti</h1>
                    <select class="str-product custom-select" name="str-product"><option></option></select>
                    <button class="btn" id="delete-product" style="display:none;">Elimina</button>
                    <button class="btn" id="modify-product" style="display:none;" data-toggle="modal" data-target="#productModal" >Modifica</button>
                </div>
            </div>
        </div>
        
        <!-- CatList Modal -->
        <div class="modal fade" id="catlistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" style="z-index: 10000 !important;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="catlistModalLabel">Modal title</h3>
                    </div>
                    <div class="modal-body">
                                   <form>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Description</label>
                                            <input type="text" class="form-control" id="description-catlist" placeholder="E.g. 'Country of origin'">
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="file-catlist" accept="image/*">
                                            <label class="custom-file-label" for="customImage">Choose Image</label>
                                        </div>
                                        <img id="img-catlist" src="#" width="125px" alt="Image not set">
                                        <button type="button" id="removeimage-catlist" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>
                                        <div class="form-group" style="margin-top:10px">
                                            <label for="formGroupExampleInput2">Product Category</label>
                                            <select class="custom-select" id="prodcat-catlist" multiple="multiple"><option></option></select>
                                        </div>
                                    </form>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton-catlist" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton-catlist" type="button" class="btn btn-primary" disabled="disabled" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- ProdList Modal -->
        <div class="modal fade" id="catprodModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" style="z-index: 10000 !important;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="catprodModalLabel">Modal title</h3>
                    </div>
                    <div class="modal-body">
                                   <form>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Description</label>
                                            <input type="text" class="form-control" id="description-catprod" placeholder="E.g. 'Country of origin'">
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="file-catprod" accept="image/*">
                                            <label class="custom-file-label" for="customImage">Choose Image</label>
                                        </div>
                                        <img id="img-catprod" src="#" width="125px" alt="Image not set">
                                        <button type="button" id="removeimage-catprod" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>
                                    </form>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton-catprod" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton-catprod" type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
                
        <!-- Product Modal -->        
        <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" style="z-index: 10000 !important;">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h3 class="modal-title" id="productModalLabel">Modal title</h3>
                                </div>
                                <div class="modal-body">

                                    <form>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Description</label>
                                            <input type="text" class="form-control" id="description-product" placeholder="E.g. 'Country of origin'">
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="file-product" accept="image/*">
                                            <label class="custom-file-label" for="customImage">Choose Image</label>
                                        </div>
                                        <img id="img-product" src="#" width="125px" alt="Image not set">
                                        <button type="button" id="removeimage-product" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>

                                        <div class="custom-file" style="margin-top:10px">
                                            <input type="file" class="custom-file-input" id="filel-product" accept="image/*">
                                            <label class="custom-file-label" for="customLogo">Choose Logo</label>
                                        </div>
                                        <img id="logo-product" src="#" width="125px" alt="Logo not set">
                                        <button type="button" id="removelogo-product" class="btn btn-danger" style="display:none;"><img src="img/cestino.png"></button>

                                        <div class="form-group" style="margin-top:10px">
                                            <label for="formGroupExampleInput2">Product Category</label>
                                            <select class="custom-select" id="prodcat-product"><option></option></select>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button id="closebutton-product" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button id="savebutton-product" type="button" class="btn btn-primary" disabled="disabled" data-dismiss="modal">Save changes</button>
                                </div>
                            </div>
                        </div>
        </div>                
    </body>
</html>
