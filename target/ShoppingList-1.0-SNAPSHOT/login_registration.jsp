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
		
		<!-- including the bootstrap tamplate -->
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		
		
		<!-- javascript function for switching from login to registration form and vice versa -->
		<script type="text/javascript">
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
			
			
			
		</script>
		
		<!-- Login and registration fields control -->
		<script type="text/javascript">
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
		</script>
		
		<!-- checkbox changement -->
		<script type="text/javascript">
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
		</script>
		
		<!-- Alert -->
		<script type="text/javascript">
			function setAlert(elem, alertText){
				$("#alertParagraph").text(alertText);
			}
		
			function disappearAlert(elem){
				elem.style.display = 'none';
			}
			
			function appearAlert(elem){
				elem.style.display = 'block';
			}
		</script>
		
	</head>
	
    <body>
	
		<div class="container">
		
			<div id="pageMessages" style="display: none;">
				<div class="alert animated flipInX alert-danger alert-dismissible">
					<span class="close" data-dismiss="alert">
						<i class="fa fa-times-circle" onClick="disappearAlert(pageMessages)"></i>
					</span>
					<h4>
						<i class="fa ffa fa-exclamation-circle"></i>Opps!
					</h4>
					<strong>Something went wrong</strong>
					<p id="alertParagraph"><!--Here is a bunch of text about some stuff that happened.--></p>
					
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
											<input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username/Email" value="" onChange="changeWrongText(this)">
										</div>
										<div class="form-group">
											<input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="Password" onChange="changeWrongText(this)">
										</div>
										<div class="form-group text-center">
											<div class="remember-div">
												<input type="checkbox" tabindex="3" name="remember" id="remember" class="checkbox-login" onMouseOver="myMouseOver(this)" onMouseOut="myMouseOut(this)" style="outline: none;">
												<label for="remember" class="checkbox-label" onMouseOver="myMouseOver(remember)" onMouseOut="myMouseOut(remember)">Remember Me</label>
											</div>
											<div class="form-group">
											<div class="row">
												<div class="col-lg-12">
													<div class="text-center forgot-div">
														<a href="https://phpoll.com/recover" tabindex="5" class="forgot-password">Forgot Password?</a>
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
													<input type="reset" name="reset-login" id="reset-login" tabindex="4" class="form-control btn resetButton" value="Reset">
												</div>
											</div>
										</div>
									</form>
									
									<!-- REGISTER FORM -->
									<form id="register-form" action="RegistrationServlet" method="POST" role="form" onSubmit='return controlRegisterFields()' style="display: none;">
										<div class="form-group">
											<input type="text" name="nominativo" id="nominativo" tabindex="1" class="form-control" placeholder="Nominativo" value="" onChange="changeWrongText(this)">
										</div>
										<div class="form-group">
											<input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Email Address" value="" onChange="changeWrongText(this)">
										</div>
										<div class="form-group">
											<input type="password" name="passwordRegistration" id="passwordRegistration" tabindex="2" class="form-control" placeholder="Password" onChange="changeWrongText(this)">
											<div class="progress">
												<div id="StrengthProgressBar" class="progress-bar"></div>
											</div>
										</div>
										<div class="form-group">
											<input type="password" name="confirmPassword" id="confirmPassword" tabindex="2" class="form-control" placeholder="Confirm Password" onChange="changeWrongText(this)">
										</div>
										<div class="form-group">
											<div class="accept-div">
													<input type="checkbox" tabindex="3" name="acceptPrivacy" id="acceptPrivacy" class="checkbox-login" onMouseOver="myMouseOver(this)" onMouseOut="myMouseOut(this)" style="outline: none;">
													<label for="acceptPrivacy" class="checkbox-label" onMouseOver="myMouseOver(acceptPrivacy)" onMouseOut="myMouseOut(acceptPrivacy)">Acconsento al trattamento dei miei dati personali secondo la privacy policy ...(link-policy)...</label>
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
													<input type="reset" name="reset-register" id="reset-register" tabindex="4" class="form-control btn resetButton" value="Reset">
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
		
		<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn.min.js"></script>
		<script type="text/javascript" src="js/zxcvbn-bootstrap-strength-meter.js"></script>
		<script type="text/javascript">
		
			$(document).ready(function()
			{
				$("#StrengthProgressBar").zxcvbnProgressBar({ passwordInput: "#passwordRegistration" });
			});
		</script>
		
    </body>
</html>
