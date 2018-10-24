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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />

        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
    </head>
    <body>
        <h1>Admin Panel</h1>



        <div style="width:520px;margin:0px auto;margin-top:30px;height:500px;">

            <h2>Categorie di lista</h2>

            <select class="str form-control" style="width:500px" name="str"></select>

        </div>


        <!-- Modal -->
        <div class="modal fade" id="catlistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 10000 !important;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="exampleModalLabel">Modal title</h3>
                        
                    </div>
                    <div class="modal-body">
                        
                        <label>Descrizione</label>
                        <br>
                        <input type="text" id="descrizione" name="descrizione" style="width:500px"/>
                        <br>
                        <br>
                        <label>Immagine</label>
                        <input type="file" id="file" name="file"/>
                        <br>
                        <br>
                        <select class="prodcat form-control" style="width:500px" id="prodcat" name="prodcat" multiple="multiple"></select>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton" type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="js/panel.js"></script>
    </body>
</html>
