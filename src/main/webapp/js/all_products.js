/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$('.all-products').select2({
    placeholder: 'Search for a product',
    allowClear: true,
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