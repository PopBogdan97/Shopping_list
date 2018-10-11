<%-- 
    Document   : login
    Created on : 5-ott-2018, 19.58.25
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div>
            <form action="LoginServlet" method="POST">
                <label>Email</label>
                <input type="text" name="email">
                <br>
                <label>Password</label>
                <input type="password" name="password">
                <br>
                <input type="submit">
            </form>
            
            <form action="ReSendServlet" method="POST" style="visibility: <%=(request.getAttribute("error") != "Account not verified!") ? "hidden" : "block"%>">
                <label>Re-send email</label>
                <br>
                <input type="hidden" name="email" value=<%=request.getAttribute("email")%>>
                <br>
                <input type="submit">
            </form>
            
                <span style="color:red"><%=(request.getAttribute("error") == null) ? "" : request.getAttribute("error")%></span>                
        
        </div>
    </body>
</html>
