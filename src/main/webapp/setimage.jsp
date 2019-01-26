<%-- 
    Document   : setimage
    Created on : 5-ott-2018, 20.02.30
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <body>
        <br><br>
        <img src="img/utente.jpg" id="myImg" class="rounded-circle mx-auto d-block" width="300" height="300" data-toggle="modal" data-target="#searchModal" >
        <br><br>
        <h1 class="text-center">Ciao <b><%=request.getAttribute("email")%></b></h1>
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
                            <input type="submit" class="btn btn-primary" />
                        </form>
                        <span style="color:red"><%=(request.getAttribute("error") == null) ? "" : request.getAttribute("error")%></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    </div>
                </div>
            </div>
        </div>
        <!--<form action="ImageUploadServlet" method="post" enctype="multipart/form-data">
            <label>Image</label>
            <input type="hidden" name="email" value=<%=request.getAttribute("email")%>>
            <input type="file" name="file" />
            <input type="submit" />
        </form>
        <span style="color:red"><%=(request.getAttribute("error") == null) ? "" : request.getAttribute("error")%></span>-->
        <br>
        <p class="text-center">Clicca sull'immagine per poterla cambiare oppure <a href="login_registration.jsp">clicca qui</a> per continuare senza un'immagine profilo</p>
    </body>
</html>
