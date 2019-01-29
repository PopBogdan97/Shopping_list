/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var listid=10;

var email="admin@gmail.com";

var prebuildMessages=["E' ora di fare la spesa. Chi va?", 
    "Lista modificata. Guarda cosa ho aggiunto",
    "Spesa fatta. Ti puoi rilassare",
    "Stò andando a fare la spesa, manca qualcosa?",
    "Vado io a fare la spesa!"];

var lastmessage=0;

    function worker() {
        $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/chat/'+listid+'?last='+lastmessage,
        success: function (data) {
            console.log("success");
            if (JSON.stringify(data)!=='[]') {
                var i=0;
                for (i=0; i<data.length; i++){
                    $("#chatdiv").append("<div>"+data[i].Email+" - "+prebuildMessages[data[i].Message-1]+" - "+data[i].Date+"</div>");
                }
                lastmessage=data[i-1].Id;
                console.log("Lastmessage: "+lastmessage);
            }

        },
        error: function () {
            console.log("error");
        }
    });
      setTimeout(worker, 1000);
  }
  
  
$(function (){
    setTimeout(worker, 0);
    
    $("#send").on("click", function(){
    
     var formData = new FormData();
     formData.append('email', email);
     formData.append('messageid', $("#messages").val());
     
     $.ajax({
        type: 'POST',
        url: 'http://localhost:8080/ShoppingList/services/chat/'+listid,
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
 });
});