/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){    
$('.str-catlist').select2({
    placeholder: 'Categorie di lista',
    allowClear: true,
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/listcat',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    },
    language: {
        noResults: function () {
            if (($(".select2-search--dropdown").find("input").val()).length>=3) {
                return "<a  data-toggle='modal' data-target='#catlistModal' href='javascript:void();' onclick='setcatlisttitle()'>Aggiungi</a>";
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
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/productCat',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    },
    language: {
        noResults: function () {
            if (($(".select2-search--dropdown").find("input").val()).length>=3) {
                return "<a  data-toggle='modal' data-target='#catprodModal' href='javascript:void();' onclick='setcatprodtitle()'>Aggiungi</a>";
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
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/product',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    },
    language: {
        noResults: function () {
            if (($(".select2-search--dropdown").find("input").val()).length>=3) {
                return "<a  data-toggle='modal' data-target='#productModal' href='javascript:void();' onclick='setproducttitle()'>Aggiungi</a>";
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
            url: 'http://localhost:8080/ShoppingList/services/productCat/'+$('.str-catprod option:selected').text(),
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
            type: 'DELETE',
            url: 'http://localhost:8080/ShoppingList/services/product/'+$('.str-product option:selected').attr("value"),
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

$('#modify-catlist').click(function () {

    mode = "modify";
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/listcat/'+$('.str-catlist option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#catlistModalLabel').text('Edit list category: ' + $('.str-catlist :selected').text());
            $('#description-catlist').val(data['Description']);
            $.each(data['Categories'], function (i, item) {
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
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/productCat/'+$('.str-catprod option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#catprodModalLabel').text('Edit product category: ' + $('.str-catprod :selected').text());
            $('#description-catprod').val(data['Description']);
        },
        error: function () {
            console.log("error");
        }
    });

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/productCat/logo/'+$('.str-catprod option:selected').text(),
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
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/'+$('.str-product option:selected').attr("value"),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#productModalLabel').text('Edit product: ' + ($('.str-product option:selected').text()).split("-")[0]);
            $('#description-product').val(data['Description']);

            $('#prodcat-product').append("<option selected='true' value='0'>" + ($('.str-product option:selected').text()).split("-")[1] + "</option>").trigger('change');


            $('#prodcat-product').prop("disabled", true);

        },
        error: function () {
            console.log("error");
        }
    });

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/image/'+$('.str-product option:selected').attr("value"),
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

   $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/logo/'+$('.str-product option:selected').attr("value"),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#logo-product').attr('src', 'data:image/png;base64,' + data);
                $('#removelogo-product').show();
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
    allowClear: true,
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/productCat/',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    }
});

$('#prodcat-product').select2({
    dropdownParent: $('#productModal'),
    placeholder: "Categorie di prodotto",
    allowClear: true,
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/productCat/',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    }
});

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

$('#removelogo-product').click(function () {
    $('#filel-product').val('');
    $('#logo-product').attr('src', "");
    $('#removelogo-product').hide();
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
        formData.append('description', $('#description-catlist').val());

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
        formData.append('description', $('#description-catlist').val());
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
        formData.append('description', $('#description-catprod').val());

        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/productCat/'+$('.str-catprod :selected').text(),
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearcatprod();
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
        formData.append('description', $('#description-catprod').val());

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/productCat/',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearcatprod();
                $('.str-catprod').empty();
                $('.str-catprod').append("<option></option>").trigger('change');
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
            formData.append('fileImage', $('#file-product')[0].files[0]);
        }
        if ($('#removeimage-product').is(':visible')) {
            formData.append('modi', 'false');
        } else {
            formData.append('modi', 'true');

        }
        
        if ($('#filel-product').val()) {
            formData.append('fileLogo', $('#filel-product')[0].files[0]);
        }
        if ($('#removelogo-product').is(':visible')) {
            formData.append('modl', 'false');
        } else {
            formData.append('modl', 'true');

        }
        formData.append('description', $('#description-product').val());
        
        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/product/'+$('.str-product option:selected').attr("value"),
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearproduct();
            },
            error: function () {
                console.log("error");
            }
        });
    } else {
        var formData = new FormData();
        if ($('#file-product').val()) {
            formData.append('fileImage', $('#file-product')[0].files[0]);
        }
        
        if ($('#filel-product').val()) {
            formData.append('fileLogo', $('#filel-product')[0].files[0]);
        }

        formData.append('name', nome);
        formData.append('description', $('#description-product').val());
        formData.append('catName', $("#prodcat-product").select2("data")[0].text);

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/product/',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearproduct();
                $('.str-product').empty();
                $('.str-product').append("<option></option>").trigger('change');
            },
            error: function () {
                console.log("error");
            }
        });
    }
});

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

$("#filel-product").change(function () {
    if (this.files && this.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#logo-product').attr('src', e.target.result);
            $('#removelogo-product').show();
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

});

var mode;

var nome = "";

function setcatlisttitle() {
    nome = $(".select2-search--dropdown").find("input").val();

    $('#catlistModalLabel').text('Edit list category: ' + nome);
}

function setcatprodtitle() {
    nome = $(".select2-search--dropdown").find("input").val();

    $('#catprodModalLabel').text('Edit product category: ' + nome);
}

function setproducttitle() {
    nome = $(".select2-search--dropdown").find("input").val();

    $('#productModalLabel').text('Edit product: ' + nome);
}

function clearcatlist() {
    $('#description-catlist').val('');
    $('#file-catlist').val('');
    $('#img-catlist').attr('src', "");
    $('#removeimage-catlist').hide();
    $('#prodcat-catlist').empty();
    $('#prodcat-catlist').append("<option></option>").trigger('change');
    $("#prodcat-catlist").prop("disabled", false);

}
function clearcatprod() {
    $('#description-catprod').val('');
    $('#file-catprod').val('');
    $('#img-catprod').attr('src', "");
    $('#removeimage-catprod').hide();

}
function clearproduct() {
    $('#description-product').val('');
    $('#file-product').val('');
    $('#img-product').attr('src', "");
    $('#removeimage-product').hide();
    $('#removelogo-product').hide();
    $('#prodcat-product').empty();
    $('#prodcat-product').append("<option></option>").trigger('change');
    $("#prodcat-product").prop("disabled", false);

}
    