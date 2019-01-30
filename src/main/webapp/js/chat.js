/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var email = "";

var prebuildMessages = ["Stò andando a fare la spesa, manca qualcosa?",
    "Lista modificata. Guarda cosa ho aggiunto",
    "Spesa fatta. Ti puoi rilassare",
    "E' ora di fare la spesa. Chi va?",
    "Vado io a fare la spesa!"
];

var lastmessage = [];

var message = 0;

var listid;

var lastcurrentmessage = 0;

var timer;

function send() {
    var formData = new FormData();
    formData.append('email', email);
    formData.append('messageid', message);

    $.ajax({
        type: 'POST',
        url: 'http://localhost:8080/ShoppingList/services/chat/' + listid,
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function () {
            console.log("success");
        },
        error: function () {
            console.log("error");
        }
    });
}
;

function worker() {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/chat/' + listid + '?last=' + lastcurrentmessage,
        success: function (data) {
            console.log("success");
            if (JSON.stringify(data) !== '[]') {
                var i = 0;
                for (i = 0; i < data.length; i++) {

                    $("#chatPart").append("<div style='background-color:#8cf5ff; border-radius:10px; margin:10px; margin-left:0;'>\n\
<span style='display: block; padding-left: 10px; font-weight: bold; font-size: 1.1em;'>" + data[i].Email + "</span>\n\
<span style='display: block; text-align: center; font-size: 1em;'>" + prebuildMessages[data[i].Message - 1] + "</span>\n\
<span style='display: block; text-align: right; padding-right: 10px; font-size: 0.8em; font-style: italic;'>" + data[i].Date + "</span>\n\
</div>"
                            );
                }
                lastcurrentmessage = data[data.length - 1].Id;
                lastmessage[data[0].List] = data[data.length - 1].Id;
                console.log("Lastmessage: " + lastcurrentmessage);
            }

        },
        error: function () {
            console.log("error");
        }
    });
    timer=setTimeout(worker, 1000);
}


function slowworker() {

    for (var index = 0; index < $('.list-span').length; index++) {
        
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/ShoppingList/services/chat/' + $('.list-span').eq(index).attr('id') + '?last=' + lastmessage[$('.list-span').eq(index).attr('id')],
            success: function (data) {
                console.log("success");
                if (JSON.stringify(data) !== '[]') {
                    lastmessage[data[0].List] = data[data.length - 1].Id;
                    console.log("Lastmessage: " + lastmessage[data[0].List]+ "New messages");
                    $('#notify-span-'+data[0].List).text("New Messages");
                }

            },
            error: function () {
                console.log("error");
            }
        });
    }
    setTimeout(slowworker, 15000);

}


$(function () {

setTimeout(slowworker, 0);

    email = $('#user-email').text();
    console.log(email);

    $("#messageOne").on("click", function () {
        message = 1;
        send();
    });
    $("#messageTwo").on("click", function () {
        message = 2;
        send();
    });
    $("#messageThree").on("click", function () {
        message = 3;
        send();
    });
    $("#messageFour").on("click", function () {
        message = 4;
        send();
    });
    $("#messageFive").on("click", function () {
        message = 5;
        send();
    });

    for (var i = 0; i < $('.list-span').length; i++) {
        lastmessage[$('.list-span').eq(i).attr('id')] = 0;

    }

    $('body').on('click', '.chat-button', function () {
        listid = this.id.split("list")[1];
        console.log(listid);
        timer=setTimeout(worker, 0);
    });

    $('body').on('click', "#closebutton-product", function () {
        console.log("close");
        clearTimeout(timer);
        lastcurrentmessage = 0;
        $('#chatPart').html("");
        $('#notify-span-'+listid).text("");

    });

});