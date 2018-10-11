<%-- 
    Document   : register
    Created on : 5-ott-2018, 20.00.58
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

    </head>
    <body>
        <div>
            <form action="RegistrationServlet" method="POST">
                <label>Email</label>
                <input type="text" name="email">
                <br>
                <label>Password</label>
                <input type="password" name="password" id="Password">
			<div class="progress">
                            <div id="StrengthProgressBar" class="progress-bar"></div>
			</div>
                <br>
                <label>Nominativo</label>
                <input type="text" name="nominativo">
                <br>           
                <input type="submit">                
            </form>
        </div>
        
		<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn.min.js"></script>
		<script type="text/javascript" src="js/zxcvbn-bootstrap-strength-meter.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function()
			{
				$("#StrengthProgressBar").zxcvbnProgressBar({ passwordInput: "#Password" });
			});
		</script>
    </body>
</html>