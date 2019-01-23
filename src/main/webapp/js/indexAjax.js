/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
  $(".list-button").each(function(){
      $.ajax({

        url : 'http://localhost:8080/ShoppingList/services/list/'+ ltrim($(this).text()) +'/products',
        type: 'GET',
        dataType : 'json',
        error : function(that,e) {

            console.log(e);
        },
        success : (data) => {
            $(this).children(".badge").text(data.results.length);
        }
    });

  });
});

function ltrim(str) {
  if(str == null) return str;
  return str.replace(/^\s+/g, '');
}

