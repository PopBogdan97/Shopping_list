/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('.str-catlist').select2({
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
            if (($(".str-catlist").data("select2").dropdown.$search.val()).length >= 3) {
                return "<a  data-toggle='modal' data-target='#catlistModal' href='javascript:void();' onClick='setcatlisttitle()'>Aggiungi</a>";
            } else {
                return "No results";
            }
        }
    },
    escapeMarkup: function (markup) {
        return markup;
    }
});

$('.str-catprod').select2({
    placeholder: 'Categorie di prodotto',
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
    },
    language: {
        noResults: function () {
            if (($(".str-catprod").data("select2").dropdown.$search.val()).length >= 3) {
                return "<a  data-toggle='modal' data-target='#catprodModal' href='javascript:void();' onClick='setcatprodtitle()'>Aggiungi</a>";
            } else {
                return "No results";
            }
        }
    },
    escapeMarkup: function (markup) {
        return markup;
    }
});

$('.str-product').select2({
    placeholder: 'Prodotti',
    ajax: {
        url: 'ProductServlet',
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
            if (($(".str-product").data("select2").dropdown.$search.val()).length >= 3) {
                return "<a  data-toggle='modal' data-target='#productModal' href='javascript:void();' onClick='setproducttitle()'>Aggiungi</a>";
            } else {
                return "No results";
            }
        }
    },
    escapeMarkup: function (markup) {
        return markup;
    }
});



$('#prodcat-catlist').select2({
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

$('#prodcat-product').select2({
    dropdownParent: $('#productModal'),
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

var nome = "";

$('#closebutton-catlist').click(function () {
    clear();
});

$('#closebutton-catprod').click(function () {
    clear();
});

$('#closebutton-product').click(function () {
    clear();
});

$('#savebutton-catlist').click(function () {

    var formData = new FormData();
    if ($('#file-catlist').val()) {
        formData.append('file', $('#file-catlist')[0].files[0]);
        formData.append('ok', 'true');
    }
    else{
        formData.append('ok', 'false');
    }
    formData.append('nome', nome);
    formData.append('descrizione', $('#descrizione-catlist').val());
    var arr = $("#prodcat-catlist").select2("data");
    for (var i = 0; i < arr.length; i++) {
        formData.append('arr', arr[i].text);
    }

    $.ajax({
        type: 'POST',
        url: 'NewCatListServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clear();
            $('#closebutton-catlist').click();
        },
        error: function () {
            console.log("error");
        }
    });
});

$('#savebutton-catprod').click(function () {

    var formData = new FormData();
    if ($('#file-catprod').val()) {
        formData.append('file', $('#file-catprod')[0].files[0]);
        formData.append('ok', 'true');
    }
    else{
        formData.append('ok', 'false');
    }
    formData.append('nome', nome);
    formData.append('descrizione', $('#descrizione-catprod').val());

    $.ajax({
        type: 'POST',
        url: 'NewCatProdServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clear();
            $('#closebutton-catprod').click();
        },
        error: function () {
            console.log("error");
        }
    });
});

$('#savebutton-product').click(function () {

    var formData = new FormData();
    if ($('#file-product').val()) {
        formData.append('file', $('#file-product')[0].files[0]);
        formData.append('ok', 'true');
    }
    else{
        formData.append('ok', 'false');
    }
    formData.append('nome', nome);
    formData.append('descrizione', $('#descrizione-product').val());
    formData.append('catprod', $("#prodcat-product").select2("data")[0].text);

    $.ajax({
        type: 'POST',
        url: 'NewProductServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clear();
            $('#closebutton-product').click();
        },
        error: function () {
            console.log("error");
        }
    });
});

function setcatlisttitle() {
    nome = $(".str-catlist").data("select2").dropdown.$search.val();

    $('#catlistModalLabel').text('Edita categoria di lista: ' + nome);
}

function setcatprodtitle() {
    nome = $(".str-catprod").data("select2").dropdown.$search.val();

    $('#catprodModalLabel').text('Edita categoria di prodotto: ' + nome);
}

function setproducttitle() {
    nome = $(".str-product").data("select2").dropdown.$search.val();

    $('#productModalLabel').text('Edita prodotto: ' + nome);
}

function clear() {
    $('#descrizione-catlist').val('');
    $('#file-catlist').val('');
    $("#prodcat-catlist").val(null).trigger("change");
    $('#descrizione-catprod').val('');
    $('#file-catprod').val('');
    $('#descrizione-product').val('');
    $('#file-product').val('');
    $("#prodcat-product").val(null).trigger("change");
}
