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
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
    </head>
    <body>
        <h1>Admin Panel</h1>
        <div style="width:520px;margin:0px auto;margin-top:30px;height:250px;">
            <h2>Categorie di lista</h2>
            <select class="str-catlist form-control" style="width:500px" name="str-catlist"><option></option></select>
            <button id="delete-catlist" style="display:none;">Elimina</button>
            <button id="modify-catlist" style="display:none;">Modifica</button>
        </div>
        <div style="width:520px;margin:0px auto;margin-top:30px;height:250px;">
            <h2>Categorie di prodotto</h2>
            <select class="str-catprod form-control" style="width:500px" name="str-catprod"><option></option></select>
            <button id="delete-catprod" style="display:none;">Elimina</button>
            <button id="modify-catprod" style="display:none;">Modifica</button>
        </div>
            <div style="width:520px;margin:0px auto;margin-top:30px;height:250px;">
            <h2>Prodotti</h2>
            <select class="str-product form-control" style="width:500px" name="str-product"><option></option></select>
            <button id="delete-product" style="display:none;">Elimina</button>
            <button id="modify-product" style="display:none;">Modifica</button>
        </div>

        <!-- CatList Modal -->
        <div class="modal fade" id="catlistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 10000 !important;" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="catlistModalLabel">Modal title</h3>
                    </div>
                    <div class="modal-body">
                        <label>Descrizione</label>
                        <br>
                        <input type="text" id="descrizione-catlist" style="width:500px"/>
                        <br>
                        <br>
                        <label>Immagine</label>
                        <input type="file" id="file-catlist" accept="image/*"/>
                        <img id="img-catlist" src="#" alt="Immagine non settata" width="200px"/>
                        <button id="removeimage-catlist" style="display:none;">Rimuovi immagine</button>
                        <br>
                        <br>
                        <select class="form-control" style="width:500px" id="prodcat-catlist" name="prodcat-catlist" multiple="multiple"></select>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton-catlist" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton-catlist" type="button" class="btn btn-primary" disabled="disabled">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- ProdList Modal -->
        <div class="modal fade" id="catprodModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 10000 !important;" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="catprodModalLabel">Modal title</h3>
                    </div>
                    <div class="modal-body">
                        <label>Descrizione</label>
                        <br>
                        <input type="text" id="descrizione-catprod" name="descrizione" style="width:500px"/>
                        <br>
                        <br>
                        <label>Immagine</label>
                        <input type="file" id="file-catprod" name="file" accept="image/*"/>
                        <img id="img-catprod" src="#" alt="Immagine non settata" width="200px"/>
                        <button id="removeimage-catprod" style="display:none;">Rimuovi immagine</button>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton-catprod" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton-catprod" type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
                
        <!-- Product Modal -->
        <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 10000 !important;" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="productModalLabel">Modal title</h3>
                    </div>
                    <div class="modal-body">
                        <label>Descrizione</label>
                        <br>
                        <input type="text" id="descrizione-product" style="width:500px"/>
                        <br>
                        <br>
                        <label>Immagine</label>
                        <input type="file" id="file-product" accept="image/*"/>
                        <img id="img-product" src="#" alt="Immagine non settata" width="200px"/>
                        <button id="removeimage-product" style="display:none;">Rimuovi immagine</button>
                        <br>
                        <br>
                        <select class="form-control" style="width:500px" id="prodcat-product" name="prodcat-product"></select>
                    </div>
                    <div class="modal-footer">
                        <button id="closebutton-product" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="savebutton-product" type="button" class="btn btn-primary" disabled="disabled">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
       <script src="js/panel.js"></script>
    </body>
</html>
