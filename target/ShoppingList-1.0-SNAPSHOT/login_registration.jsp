<%-- 
    Document   : login_registration
    Created on : 18-ott-2018, 13.00.43
    Author     : Luca
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login/Registration</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- including the stylesheet file -->
        <link rel="stylesheet" type="text/css" href="css/login_registration.css">

        
        
        <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <!-- including the bootstrap tamplate -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- javascript function for switching from login to registration form and vice versa -->
        <script type="text/javascript" src="js/login_registration.js"></script>
    </head>

    <body>
        <div class="container">
            <div id="pageMessages" <%
                if(request.getAttribute("error") == "Login error!"){
                    out.print("style='display: block;'");
                }
                else if(request.getAttribute("error") == "Account not verified!"){
                    out.print("style='display: block;'");
                }
                else{
                    out.print("style='display: none;'");
                }
                %>>
                <div class="alerto animated flipInX alert-danger alert-dismissible">
                    <span class="close" data-dismiss="alert">
                        <i class="fa fa-times-circle" onClick="disappearAlert()"></i>
                    </span>
                    <h4>
                        <i class="fa ffa fa-exclamation-circle"></i> Opps!
                    </h4>
                    <strong>Something went wrong</strong>
                    <p id="alertParagraph">
                    <%
                        if(request.getAttribute("error") == "Login error!"){
                            out.print("Login error!"
                                    + "<br><br>Email or Password incorrect");
                        }
                        else if(request.getAttribute("error") == "Account not verified!"){
                            out.print("Account not verified!");
                        }
                        else{
                            out.print("");
                        }
                    %>
                    </p>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div>
                                    <input type="email" name="emailrecover" id="emailrecover" tabindex="1" class="form-control" placeholder="Email Address" value="" onChange="changeWrongText(this)">
                                    <input type="button" id="reset_btn" value="Send Email">
                                </div>
                            </form>
                            <div>
                                <div id="result"></div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-login">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-6">
                                    <a href="#" class="active" id="login-form-link">Login</a>
                                </div>
                                <div class="col-xs-6">
                                    <a href="#" id="register-form-link">Register</a>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <!-- LOGIN FORM -->
                                    <form id="login-form" action="LoginServlet" method="POST" role="form" style="display: block;" onSubmit="return controlLoginFields()">
                                        <div class="form-group">
                                            <img src="img/email.png" class="form-image">
                                            <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Email" value="" onChange="changeWrongText(this)">
                                        </div>
                                        <div class="form-group">
                                            <img src="img/password.png" class="form-image">
                                            <input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="Password" onChange="changeWrongText(this)">
                                        </div>
                                        <div class="form-group text-center">
                                            <div class="remember-div">
                                                <input type="checkbox" tabindex="3" name="remember" id="remember" class="checkbox-login" onmousedown="checkboxClicked(this)" style="outline: none;">
                                                <label for="remember" class="checkbox-label" onmousedown="checkboxClicked(remember)">Remember Me</label>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="text-center forgot-div">
                                                            <a data-toggle="modal" data-target="#exampleModal" href="#" class="forgot-password" id="reset_link">Forgot Password?</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In"  onClick="disappearAlert(pageMessages)">
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <form id="reset-form-login" action=".." method="post" role="form" style="display: block;">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="reset" name="reset-login" id="reset-login" tabindex="4" class="form-control btn resetButton" value="Return" onClick="javascript:history.back()">
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- REGISTER FORM -->
                                    <form id="register-form" action="RegistrationServlet" method="POST" role="form" onSubmit='return controlRegisterFields()' style="display: none;">
                                        <div class="form-group">
                                            <img src="img/username.png" class="form-image">
                                            <input type="text" name="nominativo" id="nominativo" tabindex="1" class="form-control" placeholder="Nominativo" value="" onChange="changeWrongText(this)">
                                        </div>
                                        <div class="form-group">
                                            <img src="img/email.png" class="form-image">
                                            <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Email Address" value="" onChange="changeWrongText(this)">
                                        </div>
                                        <div class="form-group">
                                            <img src="img/password.png" class="form-image">
                                            <input type="password" name="passwordRegistration" id="passwordRegistration" tabindex="2" class="form-control" placeholder="Password" onChange="changeWrongText(this)" onkeyup="displayProgressBar(this, divProgressBar)">
                                            <div id="divProgressBar" class="progress" style="display: none;">
                                                <div id="StrengthProgressBar" class="progress-bar"></div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <img src="img/password.png" class="form-image">
                                            <input type="password" name="confirmPassword" id="confirmPassword" tabindex="2" class="form-control" placeholder="Confirm Password" onChanged="changeWrongText(this)">
                                        </div>
                                        <div class="form-group">
                                            <div class="accept-div">
                                                <input type="checkbox" tabindex="3" name="acceptPrivacy" id="acceptPrivacy" class="checkbox-login" onmousedown="checkboxClicked(this)" style="outline: none;">
                                                <label for="acceptPrivacy" class="checkbox-label" onmousedown="checkboxClicked(acceptPrivacy)">Acconsento al trattamento dei miei dati personali secondo la privacy policy</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Register Now" onClick="disappearAlert(pageMessages)">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <form id="reset-form-register" action=".." method="post" role="form" style="display: none;">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <input type="reset" name="reset-register" id="reset-register" tabindex="4" class="form-control btn resetButton" value="Return" onClick="javascript:history.back()">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>     
        <script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn.min.js"></script>
        <script type="text/javascript" src="js/zxcvbn-bootstrap-strength-meter.js"></script>
        <script type="text/javascript">
            $(document).ready(function (){
                $("#StrengthProgressBar").zxcvbnProgressBar({passwordInput: "#passwordRegistration"});

                $("#reset_link").click(function(){
                    $("#result").text("");
                });

                $("#reset_btn").click(function(){
                    var email = $("#emailrecover").val();
                    $.ajax({
                        type: "POST",
                        url: "RequestResetServlet",
                        data: "email=" + email,
                        dataType: "html",
                        success: function(msg){
                            $("#result").html(msg);
                        },
                        error: function(){
                            alert("Chiamata fallita, si prega di riprovare...");
                        }
                    });
                });
            });
        </script>
    </body>
</html>
