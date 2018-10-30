/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('.str-catlist').select2({
    placeholder: 'Categorie di lista',
    allowClear: true,
    ajax: {
        url: 'ListCatServlet',
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
    allowClear: true,
    ajax: {
        url: 'ProdCatServlet',
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
    allowClear: true,
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

$('.str-catlist').on("select2:selecting", function () {
    $('#delete-catlist').show();
});

$('.str-catprod').on("select2:selecting", function () {
    $('#delete-catprod').show();
});

$('.str-product').on("select2:selecting", function () {
    $('#delete-product').show();
});

$('.str-catlist').on("select2:unselecting", function () {

    $('#delete-catlist').hide();
});

$('.str-catprod').on("select2:unselecting", function () {

    $('#delete-catprod').hide();
});

$('.str-product').on("select2:unselecting", function () {

    $('#delete-product').hide();
});

$('#delete-catlist').click(function () {
    if (confirm("Vuoi davvero eliminare la categoria di lista: " + $('.str-catlist option:selected').text() + "?\nI dati relativi ad esso verranno eliminati.")) {

        var formData = new FormData();

        formData.append('action', 'delete');
        formData.append('nome', $('.str-catlist option:selected').text());

        $('#delete-catlist').hide();

        $.ajax({
            type: 'POST',
            url: 'ListCatServlet',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                $('.str-catlist').empty();
                $('.str-catlist').append("<option></option>").trigger('change');
            },
            error: function () {
                console.log("error");
            }
        });
    }
});

$('#delete-catprod').click(function () {
    if (confirm("Vuoi davvero eliminare la categoria di prodotto: " + $('.str-catprod option:selected').text() + "?\nI dati relativi ad esso verranno eliminati.")) {


        var formData = new FormData();

        formData.append('action', 'delete');
        formData.append('nome', $('.str-catprod option:selected').text());

        $('#delete-catprod').hide();

        $.ajax({
            type: 'POST',
            url: 'ProdCatServlet',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                $('.str-catprod').empty();
                $('.str-catprod').append("<option></option>").trigger('change');
            },
            error: function () {
                console.log("error");
            }
        });
    }
});

$('#delete-product').click(function () {
    if (confirm("Vuoi davvero eliminare il prodotto: " + ($('.str-product option:selected').text()).split("-")[0] + "\n" +
            "Della categoria di prodotto: " + ($('.str-product option:selected').text()).split("-")[1] + "?\n" +
            "I dati relativi ad esso verranno eliminati.")) {

        var formData = new FormData();

        formData.append('action', 'delete');
        formData.append('nome', ($('.str-product option:selected').text()).split("-")[0]);
        formData.append('catprod', ($('.str-product option:selected').text()).split("-")[1]);

        $('#delete-product').hide();


        $.ajax({
            type: 'POST',
            url: 'ProductServlet',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                $('.str-product').empty();
                $('.str-product').append("<option></option>").trigger('change');
            },
            error: function () {
                console.log("error");
            }
        });
    }
});

$('#prodcat-catlist').select2({
    dropdownParent: $('#catlistModal'),
    placeholder: "Categorie di prodotto",
    ajax: {
        url: 'ProdCatServlet',
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
        url: 'ProdCatServlet',
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
    clearcatlist();
});

$('#closebutton-catprod').click(function () {
    clearcatprod();
});

$('#closebutton-product').click(function () {
    clearproduct();
});

$('#savebutton-catlist').click(function () {

    var formData = new FormData();
    formData.append('action', 'new');
    if ($('#file-catlist').val()) {
        formData.append('file', $('#file-catlist')[0].files[0]);
        formData.append('ok', 'true');
    } else {
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
        url: 'ListCatServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clearcatlist();
            $('.str-catlist').empty();
            $('.str-catlist').append("<option></option>").trigger('change');
            $('#closebutton-catlist').click();
        },
        error: function () {
            console.log("error");
        }
    });
});

$('#savebutton-catprod').click(function () {

    var formData = new FormData();
    formData.append('action', 'new');
    if ($('#file-catprod').val()) {
        formData.append('file', $('#file-catprod')[0].files[0]);
        formData.append('ok', 'true');
    } else {
        formData.append('ok', 'false');
    }
    formData.append('nome', nome);
    formData.append('descrizione', $('#descrizione-catprod').val());

    $.ajax({
        type: 'POST',
        url: 'ProdCatServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clearcatprod();
            $('.str-catprod').empty();
            $('.str-catprod').append("<option></option>").trigger('change');
            $('#closebutton-catprod').click();
        },
        error: function () {
            console.log("error");
        }
    });
});

$('#savebutton-product').click(function () {

    var formData = new FormData();
    formData.append('action', 'new');
    if ($('#file-product').val()) {
        formData.append('file', $('#file-product')[0].files[0]);
        formData.append('ok', 'true');
    } else {
        formData.append('ok', 'false');
    }
    formData.append('nome', nome);
    formData.append('descrizione', $('#descrizione-product').val());
    formData.append('catprod', $("#prodcat-product").select2("data")[0].text);

    $.ajax({
        type: 'POST',
        url: 'ProductServlet',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
            clearproduct();
            $('.str-product').empty();
            $('.str-product').append("<option></option>").trigger('change');
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

function clearcatlist() {
    $('#descrizione-catlist').val('');
    $('#file-catlist').val('');
    $("#prodcat-catlist").val(null).trigger("change");
}
function clearcatprod() {
    $('#descrizione-catprod').val('');
    $('#file-catprod').val('');
}
function clearproduct() {
    $('#descrizione-product').val('');
    $('#file-product').val('');
    $("#prodcat-product").val(null).trigger("change");
}
