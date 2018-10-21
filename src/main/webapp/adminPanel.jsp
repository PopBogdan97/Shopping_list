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
<div class="modal fade" id="catlistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 100000 !important;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                  <form action="ImageUploadServlet" method="post" enctype="multipart/form-data">
                                <label>Image</label>
                                <input type="file" name="file" />
    <input type="submit" />
</form>
          <select class="prodcat form-control" style="width:500px" name="prodcat"></select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>




        <script type="text/javascript">
            $('.str').select2({
            placeholder: 'Inserisci un nome',
                minimumInputLength: 2,
                    ajax: {
                    url: 'ListcatServlet',
                    type:'get',
                            dataType: 'json',
                            delay: 100,
                            processResults: function (data) {
                            return {
                            results: data
                            };
                            },
                            cache: true
                    },
   language: {
       noResults: function(){

return "<a  data-toggle='modal' data-target='#catlistModal' href='javascript:void();' onClick='setvalue()'>Aggiungi</a>";
       }
   },
              escapeMarkup: function (markup) {
        return markup;
    }
            });
            
            
            
    $('.prodcat').select2({
        dropdownParent: $('#catlistModal'),
                    placeholder: 'Inserisci categorie di prodotto',
                    ajax: {
                    url: 'ListcatServlet',
                    type:'get',
                            dataType: 'json',
                            delay: 100,
                            processResults: function (data) {
                            return {
                            results: data
                            };
                            },
                            cache: true
                        }
    });
    
    function setvalue(){$('.modal-title').text('Edita categoria di lista: '+$(".str").data("select2").dropdown.$search.val());}



        </script>
    </body>
</html>
