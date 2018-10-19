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
            if(document.getElementById("nominativo").value == ""){
                    setAlert(alertParagraph,"Field Nominativo not compiled");
                    appearAlert(pageMessages);
                    $("#nominativo").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("email").value == ""){
                    setAlert(alertParagraph,"Field Email not compiled");
                    appearAlert(pageMessages);
                    $("#email").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("passwordRegistration").value == ""){
                    setAlert(alertParagraph,"Field Password not compiled");
                    appearAlert(pageMessages);
                    $("#passwordRegistration").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("confirmPassword").value == ""){
                    setAlert(alertParagraph,"Field Confirm Password not compiled");
                    appearAlert(pageMessages);
                    $("#confirmPassword").addClass("placeholderwrong");
                    return false;
            }

            if(document.getElementById("passwordRegistration").value != document.getElementById("confirmPassword").value){
                    setAlert(alertParagraph,"The confirmation password doesn't match!");
                    appearAlert(pageMessages);
                    $("#confirmPassword").val("");
                    $("#confirmPassword").addClass("placeholderwrong");
                    $("#confirmPassword").focus();
                    return false;
            }
            if(document.getElementById("acceptPrivacy").checked == false){
                    setAlert(alertParagraph,"Is necessary to accept the privacy policy");
                    appearAlert(pageMessages);
                    return false;
            }

            /* control validation email */
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (!reg.test(document.getElementById("email").value)){
                    setAlert(alertParagraph,"Email format incorrect");
                    appearAlert(pageMessages);
                    return false;
            }
    }

    /* control login fields */
    function controlLoginFields(){
            if(document.getElementById("username").value == ""){
                    setAlert(alertParagraph,"Field Username not compiled");
                    appearAlert(pageMessages);
                    $("#username").addClass("placeholderwrong");
                    return false;
            }
            if(document.getElementById("passwordLogin").value == ""){
                    setAlert(alertParagraph,"Field Password not compiled");
                    appearAlert(pageMessages);
                    $("#passwordLogin").addClass("placeholderwrong");
                    return false;
            }
    }


    function changeWrongText(x){
            x.classList.remove("placeholderwrong");
    }
		
/** checkbox changement **/
    function myMouseOver(x){
            if(x.checked){
                    x.style.backgroundColor = '#FFFFFF';
                    x.style.borderColor = '#d9d9d9';
            }
            else{
                    x.style.backgroundColor = '#28CE7B';
                    x.style.borderColor = '#28CE7B';
            }
    }

    function myMouseOut(x){
            if(x.checked){
                    x.style.backgroundColor = '#28CE7B';
                    x.style.borderColor = '#28CE7B';
            }
            else{
                    x.style.backgroundColor = '#FFFFFF';
                    x.style.borderColor = '#d9d9d9';
            }
    }
		
/** Alert **/
    function setAlert(elem, alertText){
            $("#alertParagraph").text(alertText);
    }

    function disappearAlert(elem){
            elem.style.display = 'none';
    }

    function appearAlert(elem){
            elem.style.display = 'block';
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
    