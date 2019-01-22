/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function() {

        $('#login-form-link').click(function(e) {
                $("#login-form").delay(100).fadeIn(100);
                $("#reset-form-login").delay(100).fadeIn(100);
                $("#register-form").fadeOut(100);
                $("#reset-form-register").fadeOut(100);
                $('#register-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
        });
        $('#register-form-link').click(function(e) {
                $("#register-form").delay(100).fadeIn(100);
                $("#reset-form-register").delay(100).fadeIn(100);
                $("#login-form").fadeOut(100);
                $("#reset-form-login").fadeOut(100);
                $('#login-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
        });

});

		
/* Login and registration fields control */

    /* control registration felds */
    function controlRegisterFields(){
            if(document.getElementById("name").value == ""){
                    setAlert("Field Name not compiled");
                    appearAlert();
                    $("#name").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("surname").value == ""){
                    setAlert("Field Surname not compiled");
                    appearAlert();
                    $("#surname").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("email").value == ""){
                    setAlert("Field Email not compiled");
                    appearAlert();
                    $("#email").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("passwordRegistration").value == ""){
                    setAlert("Field Password not compiled");
                    appearAlert();
                    $("#passwordRegistration").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("confirmPassword").value == ""){
                    setAlert("Field Confirm Password not compiled");
                    appearAlert();
                    $("#confirmPassword").addClass("placeholderwrong");
                    return false;
            }

            if(document.getElementById("passwordRegistration").value != document.getElementById("confirmPassword").value){
                    setAlert("The confirmation password doesn't match!");
                    appearAlert();
                    $("#confirmPassword").val("");
                    $("#confirmPassword").addClass("placeholderwrong");
                    $("#confirmPassword").focus();
                    return false;
            }
            if(document.getElementById("acceptPrivacy").checked == false){
                    setAlert("Is necessary to accept the privacy policy");
                    appearAlert();
                    return false;
            }

            /* control validation email */
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (!reg.test(document.getElementById("email").value)){
                    setAlert("Email format incorrect");
                    appearAlert();
                    return false;
            }
    }

    /* control login fields */
    function controlLoginFields(){
            if(document.getElementById("username").value == ""){
                    setAlert("Field Email not compiled");
                    appearAlert();
                    $("#username").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("passwordLogin").value == ""){
                    setAlert("Field Password not compiled");
                    appearAlert();
                    $("#passwordLogin").addClass("placeholderwrong");
                    return false;
            }
    }


    function changeWrongText(x){
            x.classList.remove("placeholderwrong");
    }
		
/** checkbox changement **/
    function checkboxClicked(x){
        if(x.checked){
                x.style.backgroundColor = '#FFFFFF';
                x.style.borderColor = '#d9d9d9';
        }
        else{
                x.style.backgroundColor = '#28CE7B';
                x.style.borderColor = '#28CE7B';
        }
    }
		
/** Alert **/
    function setAlert(alertText){
        $("#alertParagraph").text(alertText);
    }

    function disappearAlert(){
        $("#pageMessages").css("display","none");
    }

    function appearAlert(){
        $("#pageMessages").css("display","block");
    }
    
/** Display progress bar **/
    
    function displayProgressBar(pass, bar){
        if(pass.value == ""){
            bar.style.display = 'none';
        }
        else{
            bar.style.display = 'block';
        }
    }
    