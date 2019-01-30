/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    
    getImage();


$('#modify').click(function () {
    
            $('#first-name').val($('#f-name').text());
            $('#last-name').val($('#l-name').text());

    });
    
$('#modal-button').click(function () {
    
    var formData = new FormData();
        if ($('#file-profile').val()) {
            formData.append('file', $('#file-profile')[0].files[0]);
        }
        
                if ($('#removeimage-profile').is(':visible')) {
            formData.append('mod', 'false');
        } else {
            formData.append('mod', 'true');

        }
        
    fname=$('#first-name').val();
    lname=$('#last-name').val();
        
        formData.append('firstName', fname);
        formData.append('lastName', lname);
        
        $.ajax({
            type: 'PUT',
            url: 'http://localhost:8080/ShoppingList/services/user/'+$('#user-email').val()+'/profile',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function () {
                console.log("success");
                $('#f-name').text(fname);
            $('#l-name').text(lname);
            
            getImage();
            },
            error: function () {
                console.log("error");
            }
        });
        
        });


$('#removeimage-profile').click(function () {
    $('#file-profile').val('');
    $('#img-profile').attr('src', "");
    $('#img').attr('src', "");
    $('#removeimage-profile').hide();
});

$("#file-profile").change(function () {
    if (this.files && this.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#img-profile').attr('src', e.target.result);
            $('#removeimage-profile').show();
        };

        reader.readAsDataURL(this.files[0]);
    }
});


});

var fname="";
var lname="";

function getImage(){
        $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/ShoppingList/services/user/image/'+$('#user-email').val(),
        success: function (data) {
            console.log("success");
            if (data !== "{}") {
                
                $('#img').attr('src', 'data:image/png;base64,' + data);                
                $('#img-profile').attr('src', 'data:image/png;base64,' + data);
                $('#removeimage-profile').show();
            }
            else{
                $('#img').attr('src', 'img/utente.jpg');
            }

        },
        error: function () {
            console.log("error");
        }
    });
    
}