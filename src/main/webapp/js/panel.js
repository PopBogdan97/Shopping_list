/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('.str-catlist').select2({
    placeholder: 'Categorie di lista',
    allowClear: true,
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/listcat?limit=5',
        type: 'get',
        dataType: 'json',
        delay: 250,
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
        url: 'http://localhost:8080/ShoppingList/services/prodcat?limit=5',
        type: 'get',
        dataType: 'json',
        delay: 250,
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
        url: 'http://localhost:8080/ShoppingList/services/product?limit=5',
        type: 'get',
        dataType: 'json',
        delay: 250,
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


$('#delete-catlist').click(function () {
    if (confirm("Vuoi davvero eliminare la categoria di lista: " + $('.str-catlist option:selected').text() + "?\nI dati relativi ad esso verranno eliminati.")) {

        $.ajax({
            type: 'DELETE',
            url: 'http://localhost:8080/ShoppingList/services/listcat/'+$('.str-catlist option:selected').text(),
            cache: false,
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

        $.ajax({
            type: 'DELETE',
            url: 'http://localhost:8080/ShoppingList/services/prodcat/'+$('.str-catprod option:selected').text(),
            cache: false,
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

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/product/'+$('.str-product option:selected').text(),
            cache: false,
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

var mode;


$('#modify-catlist').click(function () {

    mode = "modify";

    $("#catlistModal").modal("toggle");
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/listcat/'+$('.str-catlist option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#catlistModalLabel').text('Edita categoria di lista: ' + $('.str-catlist :selected').text());
            $('#descrizione-catlist').val(data['description']);
            $.each(data['categories'], function (i, item) {
                $('#prodcat-catlist').append("<option selected='true' value='" + i + "'>" + item + "</option>").trigger('change');
            });

            $('#prodcat-catlist').prop("disabled", true);

        },
        error: function () {
            console.log("error");
        }
    });
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/listcat/image/'+$('.str-catlist option:selected').text(),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#img-catlist').attr('src', 'data:image/png;base64,' + data);
                $('#removeimage-catlist').show();
            }

        },
        error: function () {
            console.log("error");
        }
    });


});

$('#modify-catprod').click(function () {

    mode = "modify";

    $("#catprodModal").modal("toggle");


    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/prodcat/'+$('.str-catprod option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#catprodModalLabel').text('Edita categoria di prodotto: ' + $('.str-catprod :selected').text());
            $('#descrizione-catprod').val(data['description']);
        },
        error: function () {
            console.log("error");
        }
    });

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/prodcat/image/'+$('.str-catprod option:selected').text(),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#img-catprod').attr('src', 'data:image/png;base64,' + data);
                $('#removeimage-catprod').show();
            }

        },
        error: function () {
            console.log("error");
        }
    });


});

$('#modify-product').click(function () {

    mode = "modify";

    $("#productModal").modal("toggle");
    
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/'+$('.str-product option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#productModalLabel').text('Edita prodotto: ' + ($('.str-product option:selected').text()).split("-")[0]);
            $('#descrizione-product').val(data['description']);

            $('#prodcat-product').append("<option selected='true' value='0'>" + ($('.str-product option:selected').text()).split("-")[1] + "</option>").trigger('change');


            $('#prodcat-product').prop("disabled", true);

        },
        error: function () {
            console.log("error");
        }
    });

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/image/'+$('.str-product option:selected').text(),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#img-product').attr('src', 'data:image/png;base64,' + data);
                $('#removeimage-product').show();
            }

        },
        error: function () {
            console.log("error");
        }
    });


});

$('#prodcat-catlist').select2({
    dropdownParent: $('#catlistModal'),
    placeholder: "Categorie di prodotto",
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/prodcat',
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
    allowClear: true,
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/prodcat',
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

    mode = "";
    clearcatlist();
});

$('#closebutton-catprod').click(function () {

    mode = "";
    clearcatprod();
});

$('#closebutton-product').click(function () {

    mode = "";
    clearproduct();
});

$('#removeimage-catlist').click(function () {
    $('#file-catlist').val('');
    $('#img-catlist').attr('src', "");
    $('#removeimage-catlist').hide();
});

$('#removeimage-catprod').click(function () {
    $('#file-catprod').val('');
    $('#img-catprod').attr('src', "");
    $('#removeimage-catprod').hide();
});

$('#removeimage-product').click(function () {
    $('#file-product').val('');
    $('#img-product').attr('src', "");
    $('#removeimage-product').hide();
});

$('#savebutton-catlist').click(function () {

    if (mode === "modify") {
        var formData = new FormData();
        if ($('#file-catlist').val()) {
            formData.append('file', $('#file-catlist')[0].files[0]);
        }
        if ($('#removeimage-catlist').is(':visible')) {
            formData.append('mod', 'false');
        } else {
            formData.append('mod', 'true');

        }
        formData.append('description', $('#descrizione-catlist').val());

        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/listcat/'+$('.str-catlist :selected').text(),
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearcatlist();
                $('#closebutton-catlist').click();
            },
            error: function () {
                console.log("error");
            }
        });
    } else {
        
        var formData = new FormData();
        if ($('#file-catlist').val()) {
            formData.append('file', $('#file-catlist')[0].files[0]);
        }
        formData.append('name', nome);
        formData.append('description', $('#descrizione-catlist').val());
        var arr = $("#prodcat-catlist").select2("data");
        for (var i = 0; i < arr.length; i++) {
            formData.append('arr', arr[i].text);
        }

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/listcat/',
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
    }
});

$('#savebutton-catprod').click(function () {

    if (mode === "modify") {
        var formData = new FormData();
        if ($('#file-catprod').val()) {
            formData.append('file', $('#file-catprod')[0].files[0]);
        }
        if ($('#removeimage-catprod').is(':visible')) {
            formData.append('mod', 'false');
        } else {
            formData.append('mod', 'true');

        }
        formData.append('description', $('#descrizione-catprod').val());

        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/prodcat/'+$('.str-catprod :selected').text(),
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearcatprod();
                $('#closebutton-catprod').click();
            },
            error: function () {
                console.log("error");
            }
        });
    } else {
        var formData = new FormData();
        if ($('#file-catprod').val()) {
            formData.append('file', $('#file-catprod')[0].files[0]);
        }
        formData.append('name', nome);
        formData.append('description', $('#descrizione-catprod').val());

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/listcat/',
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
    }
});

$('#savebutton-product').click(function () {

    if (mode === "modify") {
        var formData = new FormData();
        if ($('#file-product').val()) {
            formData.append('file', $('#file-product')[0].files[0]);
        }
        if ($('#removeimage-catlist').is(':visible')) {
            formData.append('mod', 'false');
        } else {
            formData.append('mod', 'true');

        }
        formData.append('nome', ($('.str-product option:selected').text()).split("-")[0]);
        formData.append('descrizione', $('#descrizione-product').val());
        formData.append('catprod', ($('.str-product option:selected').text()).split("-")[1]);

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
                $('#closebutton-product').click();
            },
            error: function () {
                console.log("error");
            }
        });
    } else {
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
    }
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
    $('#img-catlist').attr('src', "");
    $('#removeimage-catlist').hide();
    $('#prodcat-catlist').empty();
    $('#prodcat-catlist').append("<option></option>").trigger('change');
    $("#prodcat-catlist").prop("disabled", false);

}
function clearcatprod() {
    $('#descrizione-catprod').val('');
    $('#file-catprod').val('');
    $('#img-catprod').attr('src', "");
    $('#removeimage-catprod').hide();

}
function clearproduct() {
    $('#descrizione-product').val('');
    $('#file-product').val('');
    $('#img-product').attr('src', "");
    $('#removeimage-product').hide();
    $('#prodcat-product').empty();
    $('#prodcat-product').append("<option></option>").trigger('change');
    $("#prodcat-product").prop("disabled", false);

}

$("#file-catlist").change(function () {
    if (this.files && this.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#img-catlist').attr('src', e.target.result);
            $('#removeimage-catlist').show();
        };

        reader.readAsDataURL(this.files[0]);
    }

});

$("#file-catprod").change(function () {
    if (this.files && this.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#img-catprod').attr('src', e.target.result);
            $('#removeimage-catprod').show();
        };

        reader.readAsDataURL(this.files[0]);
    }
});

$("#file-product").change(function () {
    if (this.files && this.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#img-product').attr('src', e.target.result);
            $('#removeimage-product').show();
        };

        reader.readAsDataURL(this.files[0]);
    }
});

$("#prodcat-catlist").change(function () {
    if (($('#prodcat-catlist option:selected').val())) {
        $('#savebutton-catlist').prop("disabled", false);
    } else {
        $('#savebutton-catlist').prop("disabled", true);
    }

});

$("#prodcat-product").change(function () {
    if (($('#prodcat-product option:selected').val())) {
        $('#savebutton-product').prop("disabled", false);
    } else {
        $('#savebutton-product').prop("disabled", true);
    }

});

$(".str-catlist").change(function () {
    if (($('.str-catlist option:selected').val())) {
        $('#delete-catlist').show();
        $('#modify-catlist').show();
    } else {
        $('#delete-catlist').hide();
        $('#modify-catlist').hide();
    }

});

$(".str-catprod").change(function () {
    if (($('.str-catprod option:selected').val())) {
        $('#delete-catprod').show();
        $('#modify-catprod').show();
    } else {
        $('#delete-catprod').hide();
        $('#modify-catprod').hide();
    }

});

$(".str-product").change(function () {
    if (($('.str-product option:selected').val())) {
        $('#delete-product').show();
        $('#modify-product').show();
    } else {
        $('#delete-product').hide();
        $('#modify-product').hide();
    }

});
    