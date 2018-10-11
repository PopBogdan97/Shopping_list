<%-- 
    Document   : setimage
    Created on : 5-ott-2018, 20.02.30
    Author     : Emiliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="ImageUploadServlet" method="post" enctype="multipart/form-data">
                                <label>Image</label>
                                <input type="hidden" name="email" value=<%=request.getAttribute("email")%>>
    <input type="file" name="file" />
    <input type="submit" />
</form>
    <span style="color:red"><%=(request.getAttribute("error") == null) ? "" : request.getAttribute("error")%></span>
    <br>
    <a href="login.jsp">Don't set now</a>
    </body>
</html>
