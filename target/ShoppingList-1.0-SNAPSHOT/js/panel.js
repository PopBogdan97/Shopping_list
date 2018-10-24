/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('.str').select2({
    placeholder: 'Categorie di lista',
    ajax: {
        url: 'ListcatServlet',
        type: 'get',
        dataType: 'json',
        delay: 250,
        processResults: function (data) {
            return {
                results: data
            };
        },
        cache: true
    },
    language: {
        noResults: function () {
            if (($(".str").data("select2").dropdown.$search.val()).length >= 3) {
                return "<a  data-toggle='modal' data-target='#catlistModal' href='javascript:void();' onClick='setvalue()'>Aggiungi</a>";
            } else {
                return "No results";
            }
        }
    },
    escapeMarkup: function (markup) {
        return markup;
    }
});



$('.prodcat').select2({
    dropdownParent: $('#catlistModal'),
    placeholder: "Categorie di prodotto",
    ajax: {
        url: 'ProdcatServlet',
        type: 'get',
        dataType: 'json',
        delay: 250,
        processResults: function (data) {
            return {
                results: data
            };
        },
        cache: true
    }
});

var nome="";

$('#closebutton').click(function () {
    clear();
});

$('#savebutton').click(function () {
    
        var formData = new FormData();
        formData.append( 'file', $( '#file' )[0].files[0] );
        formData.append( 'nome', nome);
        formData.append( 'descrizione', $( '#descrizione' ).val());
        var arr = $(".prodcat").select2("data");
for (var i = 0; i < arr.length; i++) {
    formData.append('arr', arr[i].text);
    }
        
        $.ajax({
            type:'POST',
            url: 'NewCatListServlet',
            data:formData,
            cache:false,
            contentType: false,
            processData: false,
            success:function(data){
                console.log("success");
                console.log(data);
            },
            error: function(data){
                console.log("error");
                console.log(data);
            }
        });
    clear();
});

function setvalue() {
    nome=$(".str").data("select2").dropdown.$search.val();

    $('.modal-title').text('Edita categoria di lista: ' + nome);
}

function clear() {
    $('#descrizione').val('');
    $('#file').val('');
    $("#prodcat").val(null).trigger("change");
}
