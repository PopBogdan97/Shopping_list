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
        
        <title>ResetPassword</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        
        <style>
            .buttonInvia{
                border-color: #007bff;
                color: #007bff;
                background-color: transparent;
            }
            .buttonInvia:hover{
                color: white;
                background-color: #007bff;
            }
        </style>
        
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top" style="background-color: #f8f9fa!important;">
            <div style="width: 1150px; margin: 0 auto;">
                    <a class="navbar-brand" href="index.jsp" style="color: rgba(0,0,0,.9);">Shopping List</a>
            </div>
        </nav>
        
        <div class="container" style="margin-top: 150px;">
            <h3 style="margin-bottom: 10px;">Inserisci la tua nuova Password</h3>
            <form action="SetPasswordServlet" method="POST">
                <!--type="hidden"--><input name="email" value=<%=request.getAttribute("email")%>>
                <!--type="hidden"--><input name="cod" value=<%=request.getAttribute("cod")%>>
                <input type="password" name="password" id="Password" placeholder="Password" class="form-control" style="max-width: 400px; margin-bottom:5px;" required>
                        <div class="progress" style="max-width: 500px;">
                            <div id="StrengthProgressBar" class="progress-bar"></div>
                        </div>
                <input type="submit" class="btn btn-outline-primary buttonInvia">
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
        </div>
    </body>
</html>
