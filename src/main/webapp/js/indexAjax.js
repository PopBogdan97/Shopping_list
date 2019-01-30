/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var productName;
var resultUpdate = 0;
var addProductListId = null;

//set bedge with product quantity on lists
$(function () {
    $(".list-button").each(function () {
        var listId = $(this).children(".list-span").attr('id');
        console.log(listId);
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

    $.ajax({

        url: 'http://localhost:8080/ShoppingList/services/collaborator/' + $('#user-email').text(),
        type: 'GET',
        dataType: 'json',
        error: function (that, e) {

            console.log(e);
        },
        success: function (data) {
            $.each(data, (i, obj) => {
                $(".collab-permission").each(function () {

                    if ($(this).children('.list-span').attr('id') == obj.ListId) {
                        $(this).children('.permission-add-product').attr({"id": obj.AddProduct});
                        $(this).children('.permission-remove-product').attr({"id": obj.DeleteProduct});
                    }

                });

            });


            console.log(data);

        }
    });
});

//replece withe spaces
function ltrim(str) {
    if (str === null)
        return str;
    return str.replace(/^\s+/g, '');
}

function getNum(str) {
    if (str === null)
        return str;
    return str.replace('list-', '');
}

function getNumSearch(str) {
    if (str === null)
        return str;
    return str.replace('search-list-', '');
}

function getIdProd(str) {
    if (str === null)
        return str;
    return str.split('-', )[1];
}

function getIdList(str) {
    if (str === null)
        return str;
    return str.split('-', )[3];
}

function getIdListRemember(str) {
    if (str === null)
        return str;
    return str.split('-', )[4];
}

function getIdProductRemember(str) {
    if (str === null)
        return str;
    return str.split('-', )[2];
}

function getChatListId(str) {
    if (str === null)
        return str;
    return str.replace('chat-list', '');
}

//create dinamically the lists after the button whith the list is clicked
$(function () {
    $(".list-button").click(function () {
        var content = this.nextElementSibling;
        if (content.style.maxHeight) {
            var listId = $(this).children(".list-span").attr('id');
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

                        //this.classList.toggle("active");
                        $(this).next(".product-list").append('<br>').append($('<li>').text(obj.text).attr("id", "product-" + obj.id + "-list-" + listId));
                        if ($(this).hasClass("collab-permission")) {
                            $(this).next(".product-list").children("li").attr({
                                "class": "portfolio-link modify-list-product collab-perm",
                                "style": "cursor:pointer;"
                            });
                        } else {

                            $(this).next(".product-list").children("li").attr({
                                "class": "portfolio-link modify-list-product",
                                "style": "cursor:pointer;"
                            });
                        }
                    });
                    $(this).next(".product-list").append('<br>');
                    $(this).next(".product-list").append('<div><div><button><img></button></div><select><option></option></select><div><button><img></button></div></div>');
                    $(this).next(".product-list").children("div").attr({
                        "class": "input-group mb-3"
                    });
                    $(this).next(".product-list").children("div").children("div").attr({
                        "class": "input-group-prepend my-search-button-div"
                    });
                    $(this).next(".product-list").children("div").children(".my-search-button-div").children("button").attr({
                        "type": "button",
                        "class": "btn btn-outline-secondary my-search-button",
                        "id": "search-list-" + listId
                    });
                    $(this).next(".product-list").children("div").children("div").children("button").children("img").attr({
                        "src": "img/search.png",
                        "style": "height:22px; width:22px;"
                    });
                    //check if can add products
                    if ($(this).children('.permission-add-product').attr("id") == 'false') {
                        $(this).next(".product-list").children("div").children("select").attr({
                            "class": "custom-select my-select2",
                            "id": "list-" + listId
                        });
                        $(this).next(".product-list").children("div").children("select").prop("disabled", true);
                        $(this).next(".product-list").children("div").children(".my-search-button-div").children("button").prop("disabled", true);
                    } else {
                        $(this).next(".product-list").children("div").children("select").attr({
                            "class": "custom-select my-select2",
                            "id": "list-" + listId
                        });
                    }


                    //second button
                    $(this).next(".product-list").children("div").children("select").next("div").attr({
                        "class": "my-chat-button",
                        "style": "margin-left: 5px"
                    });
                    $(this).next(".product-list").children("div").children(".my-chat-button").children("button").prop("disabled", false);

                    if ($('#user-name-typo').text().indexOf("anonymous") > 0) {
                        $(this).next(".product-list").children("div").children(".my-chat-button").children("button").attr({
                            "type": "button",
                            "class": "btn btn-outline-primary chat-button disabled",
                            "style": "display: none",
                            "id": "chat-list" + listId
                        });
                    } else {


                        $(this).next(".product-list").children("div").children(".my-chat-button").children("button").attr({
                            "type": "button",
                            "class": "btn btn-outline-primary chat-button",
                            "id": "chat-list" + listId
                        });
                    }
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


//select2 for searching the product in the right category of the list
function executeSelect2() {
    $('.my-select2').each(function () {
        var listId = getNum($(this).attr('id'));
        $(this).select2({
            placeholder: 'Search products...',
            allowClear: true,
            theme: "bootstrap",
            tags: true,
            ajax: {
                url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/catProducts?limit=5',
                type: 'get',
                dataType: 'json',
                delay: 250,
                cache: true
            }
        });
    });
}
;

//after result handle events
function executeResultEvents() {
    //get data for adding new product in the list
    $('#result-product-modal').children("a").click(function () {
        resultUpdate = 1;
        var productId = getIdProd($(this).attr('id'));
        var listId = getIdList($(this).attr('id'));
        console.log(productId);
        console.log(listId);
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/ShoppingList/services/product/' + productId,
            dataType: 'json',

            success: (data) => {
                console.log(data);
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/image/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-image').attr('src', 'data:image/png;base64,' + data);
                        }
                                                else{
                            $('#modify-list-product-image').attr('src', 'img/sample.jpg');

                        }
                        
                    },
                    error: function () {
                        console.log("error");
                    }
                });
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/logo/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-logo').attr('src', 'data:image/png;base64,' + data);
                        }
                                                else{
                            $('#modify-list-product-logo').attr('src', 'img/logo.png');

                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                });

                $('#product-title-name').text(data.Name);
                $('#modify-list-product-category').text('Product category: ' + data.CatName);
                if (data.Description === '') {
                    $('#modify-list-product-description').text('Description: none');
                } else {
                    $('#modify-list-product-description').text('Description: ' + data.Description);
                }
                $('#remember-product-list').attr("id", "remember-product-" + productId + "-list-" + listId);
                $('#modify-list-product-quantity').val(1);
                $('#remove-product-list').hide();
                $('#resultModal').modal('hide');
                $('#modify-list-product-modal').modal('show');
            },
            error: function () {
                console.log("error");
            }
        });

    });
    
    $('#result-product-modal-category').children("a").click(function () {
        resultUpdate = 1;
        var productId = getIdProd($(this).attr('id'));
        var listId = getIdList($(this).attr('id'));
        console.log(productId);
        console.log(listId);
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/ShoppingList/services/product/' + productId,
            dataType: 'json',

            success: (data) => {
                console.log(data);
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/image/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-image').attr('src', 'data:image/png;base64,' + data);
                        }
                                                else{
                            $('#modify-list-product-image').attr('src', 'img/sample.jpg');

                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                });
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/logo/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-logo').attr('src', 'data:image/png;base64,' + data);
                        }
                                                else{
                            $('#modify-list-product-logo').attr('src', 'img/logo.png');

                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                });

                $('#product-title-name').text(data.Name);
                $('#modify-list-product-category').text('Product category: ' + data.CatName);
                if (data.Description === '') {
                    $('#modify-list-product-description').text('Description: none');
                } else {
                    $('#modify-list-product-description').text('Description: ' + data.Description);
                }
                $('#remember-product-list').attr("id", "remember-product-" + productId + "-list-" + listId);
                $('#modify-list-product-quantity').val(1);
                $('#remove-product-list').hide();
                $('#resultModal').modal('hide');
                $('#modify-list-product-modal').modal('show');
            },
            error: function () {
                console.log("error");
            }
        });

    });

    $('#add-result-product').click(function () {
        $('#resultModal').modal('hide');
        $('#productModal').modal('show');
    });
    
    $('#add-result-product-category').click(function () {
        $('#resultModal').modal('hide');
        $('#productModal').modal('show');
    });
}

//open modify modal
function executeClickButton() {
    $(".my-search-button").click(function () {
        productName = $(this).parent().next("select").find(':selected').text();
        var listId = getNumSearch($(this).attr('id'));
        var selected = $(this).parent().next("select").find(':selected').text();
        $.ajax({
            url: 'http://localhost:8080/ShoppingList/services/list/' + listId
                    + '/catProducts?&q=' + selected,
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true,
            success: function (data) {
                console.log("success");
                console.log(data);
                $('#result-ModalTitle').text('Search: ' + selected);
                if (data.results.length !== 0) {
                    $('#result-product-modal').html("");
                    $.each(data.results, (i, obj) => {
                        $('#result-product-modal').append($('<a>').text(obj.text).attr('id', 'resultproduct-' + obj.id + '-list-' + listId));
                        
                        
                    });
                    $('#result-product-modal').children("a").attr({
                        "class": "list-group-item list-group-item-action",
                        "style": "cursor:pointer"
                    });
                } else {
                    $('#result-product-modal').html("");
                    $('#result-product-modal').append($('<h5>').text('No results'));
                    $('#result-product-modal').append($('<button>').text('Add product').attr({
                        "class": "btn btn-outline-success",
                        "type": "button",
                        "id": "add-result-product"
                    }));
                    addProductListId = listId;
                }
                executeResultEvents();
                $('#resultModal').modal('show');
            },
            error: function () {
                console.log("error");
            }

        });
        
        $.ajax({
            url: 'http://localhost:8080/ShoppingList/services/list/' + listId
                    + '/catProducts/cat?&q=' + selected,
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true,
            success: function (data) {
                console.log("success");
                console.log(data);
                
                if (data.results.length !== 0) {
                    $('#result-product-modal-category').html("");
                    $.each(data.results, (i, obj) => {
                        $('#result-product-modal-category').append($('<a>').text(obj.text).attr('id', 'resultproduct-' + obj.id + '-list-' + listId));
                        
                        
                    });
                    $('#result-product-modal-category').children("a").attr({
                        "class": "list-group-item list-group-item-action",
                        "style": "cursor:pointer"
                    });
                } else {
                    $('#result-product-modal-category').html("");
                    $('#result-product-modal-category').append($('<h5>').text('No results'));
                    $('#result-product-modal-category').append($('<button>').text('Add product').attr({
                        "class": "btn btn-outline-success",
                        "type": "button",
                        "id": "add-result-product-category"
                    }));
                    addProductListId = listId;
                }
                executeResultEvents();
                $('#resultModal').modal('show');
            },
            error: function () {
                console.log("error");
            }

        });
        
        
        
        $('#productModalLabel').text('Edit product: ' + productName);
        $("#resultModal").modal("show");
    });

    $(".chat-button").click(function () {
        var listId = getChatListId($(this).attr('id'));
        $("#chatModalTitle").text("Chat List: " + $('#'+listId+'.list-span').eq(0).text());
        $("#chatModal").modal("show");
    });
    
    $('#name-order').parent().click(function () {
        $('#result-product-modal').show();
        $('#result-product-modal-category').hide();
    });
    
    $('#cat-order').parent().click(function () {
        $('#result-product-modal').hide();
        $('#result-product-modal-category').show();
    });



//create dinamically the modal for updating the products in the list (Product button)
    $('.modify-list-product').click(function () {
        var productId = getIdProd($(this).attr('id'));
        var listId = getIdList($(this).attr('id'));
        var addPerm =
                console.log(productId);
        console.log(listId);
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/product/' + productId,
            dataType: 'json',

            success: (data) => {
                console.log(data);
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/image/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-image').attr('src', 'data:image/png;base64,' + data);
                        }
                        else{
                            $('#modify-list-product-image').attr('src', 'img/sample.jpg');

                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                });
                $.ajax({
                    type: 'GET',
                    url: 'http://localhost:8080/ShoppingList/services/product/logo/' + productId,
                    success: function (data) {
                        console.log("success");
                        if (data !== "{}") {

                            $('#modify-list-product-logo').attr('src', 'data:image/png;base64,' + data);
                        }
                        else{
                            $('#modify-list-product-logo').attr('src', 'img/logo.png');

                        }
                    },
                    error: function () {
                        console.log("error");
                    }
                });

                $('#product-title-name').text(data.Name);
                $('#modify-list-product-category').text('Product category: ' + data.CatName);
                if (data.Description === '') {
                    $('#modify-list-product-description').text('Description: none');
                } else {
                    $('#modify-list-product-description').text('Description: ' + data.Description);
                }
                $('#modify-list-product-quantity').val(data.Quantity);
                if ($(this).parent().prev().children('.permission-add-product').attr('id') == 'false') {
                    $('#plus').hide();
                }
                if ($(this).parent().prev().children('.permission-remove-product').attr('id') == 'false') {
                    $('#minus').hide();
                } else {
                    $('#remove-product-list').show();
                }

                $('#remember-product-list').attr("id", "remember-product-" + productId + "-list-" + listId);

                $('#modify-list-product-modal').modal('show');
            },
            error: function () {
                console.log("error");
            }
        });

    });

}




//product update modal management
$(document).ready(function () {

    $('#moidfy-list-product-close').click(function () {
        $(this).parent().attr('id', 'remember-product-list');

        clearProductUpdateModal();
    });

    $('#moidfy-list-product-update').click(function () {

        var formData = new FormData();
        var listId = getIdListRemember($(this).parent().attr('id'));
        var productId = getIdProductRemember($(this).parent().attr('id'));

        console.log(listId + " remember");
        console.log(productId + " remember");

        formData.append('product', productId);
        formData.append('quantity', $('#modify-list-product-quantity').val());

        console.log($('#modify-list-product-quantity').val());
        if (resultUpdate === 1) {
            $.ajax({
                type: 'POST',
                url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/product',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function () {
                    console.log("success");
                    clearProductUpdateModal();
                    $('#moidfy-list-product-close').parent().attr('id', 'remember-product-list');
                    $('#moidfy-list-product-close').click();
                    $('#' + listId).parent().click();
                    $('#' + listId).parent().click();
                },
                error: function () {
                    console.log("error");
                }
            });
            resultUpdate = 0;
        } else {
            $.ajax({
                type: 'PUT',
                url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/product',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function () {
                    console.log("success");
                    clearProductUpdateModal();
                    $('#moidfy-list-product-close').parent().attr('id', 'remember-product-list');
                    $('#moidfy-list-product-close').click();
                },
                error: function () {
                    console.log("error");
                }
            });
        }


    });

    $("#modify-list-product-modal").on("hidden.bs.modal", function () {
        clearProductUpdateModal();
    });

});

function clearProductUpdateModal() {
    $('#product-title-name').val('');
    $('#modify-list-product-logo').attr('src', "");
    $('#modify-list-product-image').attr('src', "");
    $('#modify-list-product-modal').modal('hide');
    $('#modify-list-product-category').val('');
    $('#modify-list-product-description').val('');
    $('#plus').show();
    $('#minus').show();
}


//Product modal management
$(document).ready(function () {
    $('#remove-product-list').click(function () {
        var idPar = $('#moidfy-list-product-update').parent().attr('id');
        var listId = getIdListRemember(idPar);
        var productId = getIdProductRemember(idPar);


        $.ajax({
            type: 'DELETE',
            url: 'http://localhost:8080/ShoppingList/services/list/' + listId + '/product/' + productId,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearProductUpdateModal();
                $('#moidfy-list-product-close').parent().attr('id', 'remember-product-list');
                $('#moidfy-list-product-close').click();
                $('#' + listId).parent().click();
                $('#' + listId).parent().click();
            },
            error: function () {
                console.log("error");
            }
        });
    });

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

    $(".product-cat-select").prop("disabled", true);

    $("#product-cat-select").change(function () {
        if (($('#product-cat-select option:selected').val())) {
            $('#savebutton-product').prop("disabled", false);
        } else {
            $('#savebutton-product').prop("disabled", true);
        }

    });

    $('#savebutton-product').click(function () {

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
            url: 'http://localhost:8080/ShoppingList/services/product/list/' + addProductListId,
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearProductModal();
                $('#closebutton-product').click();
                $('#' + addProductListId).parent().click();
                $('#' + addProductListId).parent().click();
                addProductListId = null;
            },
            error: function () {
                console.log("error");
            }
        });


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
        $('#productModal').modal('hide');
    }
});


