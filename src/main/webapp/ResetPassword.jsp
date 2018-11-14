<%-- 
    Document   : ResetPassword
    Created on : 19-ott-2018, 11.40.20
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="SetPasswordServlet" method="POST">
                <input type="hidden" name="email" value=<%=request.getAttribute("email")%>>
                <input type="hidden" name="cod" value=<%=request.getAttribute("cod")%>>
                <label>Password</label>
                <input type="password" name="password" id="Password">
			<div class="progress">
                            <div id="StrengthProgressBar" class="progress-bar"></div>
			</div>
                <input type="submit">
            </form>
                <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn.min.js"></script>
		<script type="text/javascript" src="js/zxcvbn-bootstrap-strength-meter.js"></script>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $("#StrengthProgressBar").zxcvbnProgressBar({ passwordInput: "#Password" });
                    });
		</script>
    </body>
</html>
