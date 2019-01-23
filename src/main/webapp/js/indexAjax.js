/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function () {
    $(".list-button").each(function () {
        $.ajax({

            url: 'http://localhost:8080/ShoppingList/services/list/' + ltrim($(this).text()) + '/products',
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
            $.ajax({
                url: 'http://localhost:8080/ShoppingList/services/list/' + ltrim($(this).children(".list-span").text()) + '/products',
                type: 'GET',
                dataType: 'json',
                error: function (that, e) {

                    console.log(e);
                },
                success: (data) => {
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


                    content.style.maxHeight = content.scrollHeight + "px";


                }

            });
        }
    });
});

