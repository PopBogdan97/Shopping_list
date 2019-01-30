/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function (){
$('.all-products').select2({
    placeholder: 'Search for a product',
    allowClear: true,
    theme: 'bootstrap',
    ajax: {
        url: 'http://localhost:8080/ShoppingList/services/product?limit=5',
        type: 'get',
        dataType: 'json',
        delay: 250,
        cache: true
    }
});

$('#search-product-button').click(function(){

clearModal();

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/'+$('.all-products option:selected').attr("value"),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#search-product-title').text(($('.all-products option:selected').text()).split("-")[0]);
           if(data['Description']!==""){ 
            $('#search-product-description').text("Description: "+data['Description']);
        }
        else{
            $('#search-product-description').text("Description: none");
        }
        
            $('#search-product-category').text("Categoria di prodotto: "+data['CatName']);

        console.log("Categoria di prodotto: "+data['CatName']);
        
        product=data["Id"];
        
            $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/productCat/'+data['CatName'],
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            
            var catlists=data['CatLists'];
            
            console.log("Categorie di lista: "+catlists);
            
            $('#search-product-select option').remove();
            $('#search-product-add').prop("disabled", true);

            for (var i = 0; i < $('.list-span').length; i++) {
                      
            $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/list/'+$('.list-span').eq(i).attr('id'),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
                
                for(var j=0; j<catlists.length; j++){
                    console.log("Categoria della lista: "+data["CatName"]);
                    if(data["CatName"]===catlists[j]){
                        if($('.list-button #'+data["Id"]).eq(0).parent().find('.permission-add-product').eq(0).attr("id")!=="false"){
                            $('#search-product-select').append("<option value='"+data["Id"]+"'>"+data["Name"]+"</option>");
                    }
                    }
                }

        },
        error: function () {
            console.log("error");
        }
    });
            }

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

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/image/'+$('.all-products option:selected').attr("value"),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {
                
                $('#search-product-image').attr('src', 'data:image/png;base64,' + data);
            }
                        else{
                            
                $('#search-product-image').attr('src', 'img/sample.jpg');
            }

        },
        error: function () {
            console.log("error");
        }
    });

   $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/logo/'+$('.all-products option:selected').attr("value"),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {
                $('#search-product-logo').attr('src', 'data:image/png;base64,' + data);
            }
                        else{
                            
                $('#search-product-logo').attr('src', 'img/logo.png');
            }

        },
        error: function () {
            console.log("error");
        }
    });
    
});


$('.products').click(function(){

        clearModal();
        
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/'+(this.id).split('-')[1],
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#search-product-title').text(data['Name']);
           if(data['Description']!==""){ 
            $('#search-product-description').text("Description: "+data['Description']);
        }
        else{
            $('#search-product-description').text("Description: none");
        }
        
        $('#search-product-category').text("Categoria di prodotto: "+data['CatName']);
        
        console.log("Categoria di prodotto: "+data['CatName']);
        
        product=data["Id"];
        
            $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/productCat/'+data['CatName'],
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            
            var catlists=data['CatLists'];
            
            console.log("Categorie di lista: "+catlists);
            
            $('#search-product-select option').remove();
            $('#search-product-add').prop("disabled", true);

            for (var i = 0; i < $('.list-span').length; i++) {
                
            $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/list/'+$('.list-span').eq(i).attr('id'),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
                
                for(var j=0; j<catlists.length; j++){
                    console.log("Categoria della lista: "+data["CatName"]);
                    if(data["CatName"]===catlists[j]){
                        if($('.list-button #'+data["Id"]).eq(0).parent().find('.permission-add-product').eq(0).attr("id")!=="false"){
                            $('#search-product-select').append("<option value='"+data["Id"]+"'>"+data["Name"]+"</option>");
                    }
                    }
                }

        },
        error: function () {
            console.log("error");
        }
    });
            }

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

    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/image/'+(this.id).split('-')[1],
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#search-product-image').attr('src', 'data:image/png;base64,' + data);
            }
                        else{
                            
                $('#search-product-image').attr('src', 'img/sample.jpg');
            }

        },
        error: function () {
            console.log("error");
        }
    });

   $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/logo/'+(this.id).split('-')[1],
        success: function (data) {
            console.log("success");
            if (data !== "{}") {

                $('#search-product-logo').attr('src', 'data:image/png;base64,' + data);
            }
                        else{

                $('#search-product-logo').attr('src', 'img/logo.png');
            }

        },
        error: function () {
            console.log("error");
        }
    });
    
});


$("#search-product-add").click(function (){
    console.log("click");
    var lists=$('#search-product-select').val();
    
    for(var i=0; i<lists.length; i++){
        
                    var formData = new FormData();
                    
        formData.append('product', product);
        formData.append('quantity', $('#search-product-quantity').val());
        
        console.log(lists[i]);
        
        $.ajax({
        type: 'PUT',
        url: 'http://localhost:8080/ShoppingList/services/list/'+lists[i]+'/product/add',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
            console.log("success");
            $(".list-button #"+data).click();
            $(".list-button #"+data).click();
        },
        error: function () {
            console.log("error");
        }
    });
    }
    
    clearModal();
});

$(".all-products").change(function () {
    if (($('.all-products option:selected').val())) {
    $('#search-product-button').attr("disabled", false);
    } else {
    $('#search-product-button').attr("disabled", true);
    }

});

$("#search-product-select").change(function () {
    if (($('#search-product-select option:selected').val())) {
        $('#search-product-add').prop("disabled", false);
    } else {
        $('#search-product-add').prop("disabled", true);
    }

});

});

var product="";

function clearModal() {
    $('#search-product-title').val('');
    $('#search-product-image').attr('src', "");
    $('#search-product-logo').attr('src', "");
    $('#search-product-select option').remove();
    $('#search-product-quantity').val('1');
    $('#search-product-description').val('');

}