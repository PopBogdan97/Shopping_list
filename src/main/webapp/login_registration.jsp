<%-- 
    Document   : login_registration
    Created on : 18-ott-2018, 13.00.43
    Author     : Luca
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control","no-store"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Login/Registration</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- including the stylesheet file -->
        <link rel="stylesheet" type="text/css" href="css/login_registration.css">
        
        <!-- including the bootstrap tamplate -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        
        <!-- javascript function for switching from login to registration form and vice versa -->
        <script type="text/javascript" src="js/login_registration.js"></script>
    </head>

    <body>
        
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div style="width: 1150px; margin: 0 auto;">
                    <a class="navbar-brand" href="index.jsp">Shopping List</a>
                    <a href="index.jsp" style="float: right; height: 50px; padding: 15px;"><u>Utilizza piattaforma senza account</u></a>
            </div>
        </nav>
        
        
        <div class="container">
            <div id="pageMessages" <%
                if(request.getParameter("error") != null){
                    if(request.getParameter("error").equals("Login error!")){
                        out.print("style='display: block;'");
                    }
                    else if(request.getParameter("error").equals("Account not verified!")){
                        out.print("style='display: block;'");
                    }
                    else if(request.getParameter("error").equals("regError")){
                        out.print("style='display: block;'");
                    }
                    else{
                        out.print("style='display: none;'");
                    }
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
                        if(request.getParameter("error") != null){
                            if(request.getParameter("error").equals("Login error!")){
                                out.print("Login error!"
                                        + "<br><br>Email or Password incorrect");
                            }
                            else if(request.getParameter("error").equals("Account not verified!")){
                                out.print("Account not verified!");
                            }
                            else if(request.getParameter("error").equals("regError")){
                                out.print("Email address already in use!");
                            }
                            else{
                                out.print("");
                            }
                        }
                        else{
                            out.print("");
                        }
                    %>
                    </p>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 10000 !important;">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Inserisci la tua email per recuperare la password</h5>
                        </div>
                        <div class="modal-body">
                            <form>
                                <input type="email" name="emailrecover" id="emailrecover" tabindex="1" <!--class="form-control"--> placeholder="Email Address" value="" onChange="changeWrongText(this)">
                                <input type="button" class="btn btn-primary" id="reset_btn" value="Send Email">
                            </form>
                            <div>
                                <div id="result"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="justify-content: center;">
                <!--<div class="col-md-6 col-md-offset-3">-->
                    <div class="panel panel-login" style="min-width: 50%;">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-6">
                                    <a href="#" id="login-form-link" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "class=''" : "class='active'" %>>Login</a>
                                </div>
                                <div class="col-xs-6">
                                    <a href="#" id="register-form-link" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "class='active'" : "class=''" %>>Register</a>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    
                                    <!-- LOGIN FORM -->
                                    <form id="login-form" action="LoginServlet" method="POST" role="form" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "style='display: none;'" : "style='display: block;'" %> onSubmit="return controlLoginFields()">
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
                                            <div class="row" style="justify-content: center;">
                                                <!--<div class="col-sm-6 col-sm-offset-3">-->
                                                    <input type="submit" name="login-submit" id="login-submit" tabindex="4" style="border-color: #007bff; color: #007bff; max-width: 50%;" class="form-control btn btn-outline-primary" value="Log In"  onClick="disappearAlert(pageMessages)" onmouseover="style='border-color: #007bff; color: white; max-width: 50%;'" onmouseout="style='border-color: #007bff; color: #007bff; max-width: 50%;'">
                                                <!--</div>-->
                                            </div>
                                        </div>
                                    </form>

                                    <form id="reset-form-login" action=".." method="post" role="form" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "style='display: none;'" : "style='display: block;'" %>>
                                        <div class="form-group">
                                            <div class="row" style="justify-content: center;">
                                                <!--<div class="col-sm-6 col-sm-offset-3">-->
                                                    <input type="reset" name="reset-login" id="reset-login" tabindex="4" style="border-color: #dc3545; color: #dc3545; max-width: 50%;" class="form-control btn btn-outline-danger" value="Return" onClick="javascript:history.back()" onmouseover="style='border-color: #dc3545; color: white; max-width: 50%;'" onmouseout="style='border-color: #dc3545; color: #dc3545; max-width: 50%;'">
                                                <!--</div>-->
                                            </div>
                                        </div>
                                    </form>

                                    <!-- REGISTER FORM -->
                                    <form id="register-form" action="RegistrationServlet" method="POST" role="form" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "style='display: block;'" : "style='display: none;'" %> onSubmit='return controlRegisterFields()'>
                                        <div class="form-group">
                                            <img src="img/username.png" class="form-image">
                                            <input type="text" name="name" id="name" tabindex="1" class="form-control" placeholder="Name" value="" onChange="changeWrongText(this)">
                                        </div>
                                        <div class="form-group">
                                            <img src="img/username.png" class="form-image">
                                            <input type="text" name="surname" id="surname" tabindex="1" class="form-control" placeholder="Surname" value="" onChange="changeWrongText(this)">
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
                                                <label for="acceptPrivacy" class="checkbox-label" onmousedown="checkboxClicked(acceptPrivacy)">Ho letto e acconsento alla <a href="https://eur-lex.europa.eu/legal-content/IT/TXT/PDF/?uri=CELEX:32016R0679&from=IT">normativa sulla privacy</a></label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row" style="justify-content: center;">
                                                <!--<div class="col-sm-6 col-sm-offset-3">-->
                                                    <input type="submit" name="register-submit" id="register-submit" tabindex="4" style="border-color: #28a745; color: #28a745; max-width: 50%;" class="form-control btn btn-outline-success" value="Register Now" onClick="disappearAlert(pageMessages)" onmouseover="style='border-color: #28a745; color: white; max-width: 50%;'" onmouseout="style='border-color: #28a745; color: #28a745; max-width: 50%;'">
                                                <!--</div>-->
                                            </div>
                                        </div>
                                    </form>
                                    <form id="reset-form-register" action=".." method="post" role="form" <%= (request.getParameter("error")!=null && (request.getParameter("error").equals("regError") || request.getParameter("error").equals("registration"))) ? "style='display: block;'" : "style='display: none;'" %>>
                                        <div class="form-group">
                                            <div class="row" style="justify-content: center;">
                                                <!--<div class="col-sm-6 col-sm-offset-3">-->
                                                    <input type="reset" name="reset-register" id="reset-register" tabindex="4" style="border-color: #dc3545; color: #dc3545; max-width: 50%;" class="form-control btn btn-outline-danger" value="Return" onClick="javascript:history.back()" onmouseover="style='border-color: #dc3545; color: white; max-width: 50%;'" onmouseout="style='border-color: #dc3545; color: #dc3545; max-width: 50%;'">
                                                <!--</div>-->
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <!--</div>-->
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
