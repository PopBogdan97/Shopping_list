/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var productName;

$(function () {
    $(".list-button").each(function () {
        var listId= $(this).children(".list-span").id;
        $.ajax({

            url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/products',
            type: 'GET',
            dataType: 'json',
            error: function (that, e) {

                console.log(e);
            },
            success: (data) => {
                $(this).children(".badge").text(data.results.length);
            }
        });

    });
});

function ltrim(str) {
    if (str == null)
        return str;
    return str.replace(/^\s+/g, '');
}

$(function () {
    $(".list-button").click(function () {
        var content = this.nextElementSibling;
        if (content.style.maxHeight) {
            var listId= $(this).children(".list-span").id;
            $.ajax({
                url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/products',
                type: 'GET',
                dataType: 'json',
                error: function (that, e) {

                    console.log(e);
                },
                success: (data) => {
                    console.log(data);
                    $(this).children(".badge").text(data.results.length);
                    $(this).next(".product-list").html('');
                    $.each(data.results, (i, obj) => {

                        this.classList.toggle("active");
                        $(this).next(".product-list").append('<br><li>' + obj.text + '</li>');
                        $(this).next(".product-list").children("li").attr({
                            "class": "portfolio-link",
                            "style": "cursor:pointer;",
                            "data-toggle": "modal",
                            "href": "#Latte"
                        });
                    });
                    $(this).next(".product-list").append('<br>');
                    $(this).next(".product-list").append('<div><div><button><img></button></div><select><option></option></select><div><button><img></button></div></div>');
                    $(this).next(".product-list").children("div").attr({
                        "class": "input-group mb-3"
                    });
                    $(this).next(".product-list").children("div").children("div").attr({
                        "class": "input-group-prepend"
                    });
                    $(this).next(".product-list").children("div").children("div").children("button").attr({
                        "type": "button",
                        "class": "btn btn-outline-secondary my-search-button",
                        "data-toggle": "modal",
                        "data-target": "#resultModal"
                    });
                    $(this).next(".product-list").children("div").children("div").children("button").children("img").attr({
                        "src": "img/search.png",
                        "style": "height:22px; width:22px;"
                    });

                    $(this).next(".product-list").children("div").children("select").attr({
                        "class": "custom-select my-select2"
                    });
                    //second button
                    $(this).next(".product-list").children("div").children("select").next("div").attr({
                        "class": "my-chat-button",
                        "style": "margin-left: 5px"
                    });
                    $(this).next(".product-list").children("div").children(".my-chat-button").children("button").attr({
                        "type": "button",
                        "class": "btn btn-outline-primary"
                    });
                    $(this).next(".product-list").children("div").children(".my-chat-button").children("button").children("img").attr({
                        "src": "img/chat.png",
                        "style": "height:22px; width:22px;"
                    });

                    content.style.maxHeight = content.scrollHeight + "px";
                    executeSelect2();
                    executeClickButton();

                }

            });
        }
    });
});

function executeSelect2() {
    $('.my-select2').select2({
        placeholder: 'Search products...',
        allowClear: true,
        theme: "bootstrap",
        tags: true,
        ajax: {
            url: 'http://localhost:8080/ShoppingList/services/product?limit=5',
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true
        }
    });
}
;
function executeClickButton() {
    $(".my-search-button").click(function () {
        productName = $(this).parent().next("select").find(':selected').val();
        $('#productModalLabel').text('Edit product: ' + productName);
    });
}



        //Product modal management
$(document).ready(function () {
    $("#customImage").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#product-image').attr('src', e.target.result);
                $('#remove-product-image').show();
            };

            reader.readAsDataURL(this.files[0]);
        }
    });


    $('#remove-product-image').click(function () {
        $('#customImage').val('');
        $('#product-image').attr('src', "");
        $('#remove-product-image').hide();
    });

    $("#customLogo").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#product-logo').attr('src', e.target.result);
                $('#remove-product-logo').show();
            };

            reader.readAsDataURL(this.files[0]);
        }
    });

    $('#remove-product-logo').click(function () {
        $('#customLogo').val('');
        $('#product-logo').attr('src', "");
        $('#remove-product-logo').hide();
    });

    $('.product-cat-select').select2({
        placeholder: 'Search products...',
        allowClear: true,
        theme: "bootstrap",
        ajax: {
            url: 'http://localhost:8080/ShoppingList/services/productCat?limit=5',
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true
        }
    });

    $("#product-cat-select").change(function () {
        if (($('#product-cat-select option:selected').val())) {
            $('#savebutton-product').prop("disabled", false);
        } else {
            $('#savebutton-product').prop("disabled", true);
        }

    });

    $('#savebutton-product').click(function () {
        //bisogna mettere apposto
        var mode = "new";
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
                url: 'http://localhost:8080/ShoppingList/services/listcat/' + $('.str-catlist :selected').text(),
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
            if ($('#customImage').val()) {
                formData.append('fileImage', $('#customImage')[0].files[0]);
            }
            if ($('#customLogo').val()) {
                formData.append('fileLogo', $('#customLogo')[0].files[0]);
            }
            formData.append('name', productName);
            formData.append('description', $('#formGroupExampleInput').val());
            formData.append('catName', $('#product-cat-select option:selected').text());

            $.ajax({
                type: 'POST',
                url: 'http://localhost:8080/ShoppingList/services/product/',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function () {
                    console.log("success");
                    clearProductModal();
                    $('#closebutton-product').click();
                },
                error: function () {
                    console.log("error");
                }
            });
        }
    });
    
    $('#closebutton-product').click(function () {

    mode = "";
    clearProductModal();
});
    
    function clearProductModal() {
    $('#formGroupExampleInput').val('');
    $('#customImage').val('');
    $('#customLogo').val('');
    $('#product-image').attr('src', "");
    $('#product-logo').attr('src', "");
    $('#remove-product-image').hide();
    $('#remove-product-logo').hide();
    $('#productModal').modal('hide')
    $('#product-cat-select').empty();
    $('#product-cat-select').append("<option></option>").trigger('change');
    $("#product-cat-select").prop("disabled", false);

}
});


