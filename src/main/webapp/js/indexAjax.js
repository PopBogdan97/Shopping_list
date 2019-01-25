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
                    $(this).next(".product-list").append('<div><select><option></option></select><div><button><img></button></div></div>');
                    $(this).next(".product-list").children("div").attr({
                        "class": "input-group mb-3"
                    });
                    $(this).next(".product-list").children("div").children("select").attr({
                        "class": "js-example-basic-single custom-select",
                        "name": "state"
                    });
                    $(this).next(".product-list").children("div").children("div").attr({
                        "class": "search-container"
                    });
                    $(this).next(".product-list").children("div").children("div").children("button").attr({
                        "type": "button",
                        "class": "btn btn-outline-primary"
                    })
                    $(this).next(".product-list").children("div").children("div").children("button").children("img").attr({
                        "src": "img/chat.png",
                        "style": "height:22px; width:22px;"
                    })


                    content.style.maxHeight = content.scrollHeight + "px";
                    executeSelect2();

                }

            });
        }
    });
});

 function executeSelect2() {
    $('.js-example-basic-single').select2({
        placeholder: 'Search products...',
        allowClear: true,
        theme: "bootstrap",
        ajax: {
            url: 'http://localhost:8080/ShoppingList/services/product?limit=5',
            type: 'get',
            dataType: 'json',
            delay: 250,
            cache: true
        },
        language: {
            noResults: () =>  {
                if (($(this).data("select2").dropdown.$search.val()).length >= 3) {
                    return "<a  id='tmp-name' data-toggle='modal' data-target='#productModal' href='javascript:void();' onClick='setProductTitle()'>Aggiungi</a>";
                } else {
                    return "No results";
                }
            }
        },
        escapeMarkup: function (markup) {
            return markup;
        }
    });
};

function setProductTitle() {
    nome = $(".select2-search__field").text();

    $('#productModalLabel').text('Edita prodotto: ' + nome);
}
