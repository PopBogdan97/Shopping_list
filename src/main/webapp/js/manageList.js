/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var email;
var shareListId;

$(function () {
    email = $('.retrive-email').attr('id');

    loadList();

});

//load lists
function loadList() {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/user/' + email,
        success: function (data) {
            console.log("success");
            console.log(data);
            if (data.length !== 0) {
                $('#list-start').html("");
                $('#list-start').append("<p></p>");
                $('#list-start').append('<a type="button" class="btn btn-outline-primary back-home" href="index.jsp">Return</a><p></p>');
                if (data.Typology === 'anonymous'){
                    $.each(data.Lists, (i, obj) => {
                    
                    var html = '<div id="' + obj.id + '"style="display: flex">' +
                            '<div class="list-group col-lg-8">' +
                            '<a class="list-group-item list-group-item-dark">' + obj.text + '</a>' +
                            '</div>' +
                            '<button type="button" class="col-lg btn btn-outline-info disabled" style="margin-right: 15px"><img src="img/condividi.png" style="width:35px" /></button>' +
                            '<button type="button" class="col-lg btn btn-danger delete-list"><img src="img/cestino.png"/></button>' +
                            '</div>' +
                            '<p></p>';
                    $('#list-start').append(html);
                    
                });
                }else{
                    
                
                $.each(data.Lists, (i, obj) => {
                    
                    var html = '<div id="' + obj.id + '"style="display: flex">' +
                            '<div class="list-group col-lg-8">' +
                            '<a class="list-group-item list-group-item-dark">' + obj.text + '</a>' +
                            '</div>' +
                            '<button type="button" class="col-lg btn btn-outline-info share-list" style="margin-right: 15px"><img src="img/condividi.png" style="width:35px" /></button>' +
                            '<button type="button" class="col-lg btn btn-danger delete-list"><img src="img/cestino.png"/></button>' +
                            '</div>' +
                            '<p></p>';
                    $('#list-start').append(html);

                });
            }
            }

            $.ajax({
                type: 'GET',
                url: 'http://localhost:8080/ShoppingList/services/collaborator/' + email,
                success: function (data) {
                    console.log("success");
                    console.log(data);
                    if (data.length !== 0) {
                        
                        $.each(data, (i, obj) => {
                            if (obj.DeleteList) {
                                var html = '<div id="' + obj.ListId + '"style="display: flex">' +
                                        '<div class="list-group col-lg-8">' +
                                        '<a class="list-group-item list-group-item-dark">' + obj.ListName + '</a>' +
                                        '</div>' +
                                        '<button type="button" class="col-lg btn btn-outline-info disabled" style="margin-right: 15px"><img src="img/condividi.png" style="width:35px" /></button>' +
                                        '<button type="button" class="col-lg btn btn-danger delete-list"><img src="img/cestino.png"/></button>' +
                                        '</div>' +
                                        '<p></p>';
                                $('#list-start').append(html);
                            }
                        });
                        $('#list-start').append('<button type="button" class="btn btn-outline-success add-list">Add List</button><p></p>');

                    } else {
                        $('#list-start').append("<p></p>");
                        $('#list-start').append('<button type="button" class="btn btn-outline-success add-list">Add List</button><p></p>');
                    }

                    loadScripts();
                },
                error: function () {
                    console.log("error");
                }
            });

        },
        error: function () {
            console.log("error");
        }
    });

}

//make work the buttons
function loadScripts() {
    $('.delete-list').click(function () {
        listId = $(this).parent().attr('id');
        $.ajax({
            type: 'DELETE',
            url: 'http://localhost:8080/ShoppingList/services/list/' + listId,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                loadList();
            },
            error: function () {
                console.log("error");
            }
        });
    });

    $('.add-list').click(function () {
        $('#add-list-modal').modal('show');
    });
    
//    $('.back-home').click(function () {
//        window.location.href = "http://localhost:8080/ShoppingList/index.jsp";
//    });
    
    $('.share-list').click(function (){
       $('#add-collab-modal').modal('show');
       shareListId = $(this).parent().attr('id');
    });
}

//list adding management
$(document).ready(function () {
    $("#customImage").change(function () {
        if (this.files && this.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#list-image').attr('src', e.target.result);
                $('#remove-list-image').show();
            };

            reader.readAsDataURL(this.files[0]);
        }
    });

    $('#remove-list-image').click(function () {
        $('#customImage').val('');
        $('#list-image').attr('src', "");
        $('#remove-list-image').hide();
    });

    $('#select-cat-list').select2({
        placeholder: 'Search categories...',
        allowClear: true,
        theme: "bootstrap",
        ajax: {
            url: 'http://localhost:8080/ShoppingList/services/listcat?limit=5',
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true
        }
    });

    $('#save-list-button').prop("disabled", true);

    $("#select-cat-list").change(function () {
        if (($('#select-cat-list option:selected').val())) {
            if ($('#input-name-list').val()) {
                $('#save-list-button').prop("disabled", false);
            } else {
                $('#save-list-button').prop("disabled", true);
            }
        } else {
            $('#save-list-button').prop("disabled", true);
        }

    });




    $('#save-list-button').click(function () {
        var formData = new FormData();
        if ($('#customImage').val()) {
            formData.append('file', $('#customImage')[0].files[0]);
        }

        formData.append('name', $('#input-name-list').val());
        formData.append('description', $('#list-description').val());
        formData.append('catName', $('#select-cat-list option:selected').text());
        formData.append('ownerEmail', email);
        formData.append('mod', 1);

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/ShoppingList/services/list',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearListModal();
                $('#close-list-button').click();
                loadList();
            },
            error: function () {
                console.log("error");
            }
        });
    });

    $('#close-list-button').click(function () {

        clearListModal();
    });

    function clearListModal() {
        $('#input-name-list').val('');
        $('#customImage').val('');
        $('#list-image').attr('src', "");
        $('#remove-list-image').hide();
        $('#add-list-modal').modal('hide');
        $('#select-cat-list').empty();
        $('#select-cat-list').append("<option></option>").trigger('change');
    }

});

$(document).ready(function () {
    

    $('#select-collab').select2({
        placeholder: 'Search users...',
        allowClear: true,
        theme: "bootstrap",
        ajax: {
            url: 'http://localhost:8080/ShoppingList/services/user?limit=5',
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true
        }
    });

    $('#save-collab-button').prop("disabled", true);

    $("#select-collab").change(function () {
        if (($('#select-collab option:selected').val())) {
            
                $('#save-collab-button').prop("disabled", false);
            
        } else {
            $('#save-collab-button').prop("disabled", true);
        }

    });




    $('#save-collab-button').click(function () {
        var formData = new FormData();
       

        formData.append('email', $('#select-collab option:selected').text());
        formData.append('listId', shareListId);
        formData.append('listName', $('#'+shareListId).children('a').text());
        formData.append('addProduct', $('#add-product').prop('checked'));
        formData.append('removeProduct', $('#remove-product').prop('checked'));
        formData.append('editList', $('#edit-list').prop('checked'));
        formData.append('deleteList', $('#delete-list').prop('checked'));

        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/collaborator',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                clearCollabModal();
                $('#close-collab-button').click();
                shareListId = null;
            },
            error: function () {
                console.log("error");
            }
        });
    });

    $('#close-collab-button').click(function () {

        clearCollabModal();
    });

    function clearCollabModal() {
       
        $('#add-collab-modal').modal('hide');
        $('#select-collab').empty();
        $('#select-collab').append("<option></option>").trigger('change');
        $('#add-product').prop('checked',true);
        $('#remove-product').prop('checked',true);
        $('#edit-list').prop('checked',true);
        $('#delete-list').prop('checked',true);
    }

});