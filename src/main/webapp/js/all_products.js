/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function (){
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

$('.all-products').on("select2:selecting", function(e) {
    
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/'+$('.all-products option:selected').text(),
        datatype: 'json',
        cache: false,
        success: function (data) {
            console.log("success");
            $('#search-product-title').text($('.all-products :selected').text());
            $('#search-product-description').val(data['description']);

        },
        error: function () {
            console.log("error");
        }
    });
    
        $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/product/image/'+$('.all-products option:selected').text(),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {
                $('#search-product-image').attr('src', 'data:image/png;base64,' + data);
            }

        },
        error: function () {
            console.log("error");
        }
    });
});

$(".all-products").change(function () {
    if (($('.all-products option:selected').val())) {
    $('#search-product-button').attr("disabled", false);
    } else {
    $('#search-product-button').attr("disabled", true);
    }

});

});