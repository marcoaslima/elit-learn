<%-- 
    Document   : erro
    Created on : 01/06/2014, 21:02:24
    Author     : Ivan Aurélio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ELIT - LOGIN</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <script type="text/javascript" src="./js/jquery.min.js"></script>
        <script type="text/javascript" src="./js/bootstrap.min.js"></script>
        <link rel="shortcut icon" href="img/emblem_library.ico" type="image/x-icon" />
    </head>
    <body>
        <%@include  file="_res/menu.jsp" %>
        <br />
        <div>
            <center><img src='img/icone-de-erro.jpg' style="width: 128px; height: 128px; alignment-adjust: central;"/></center>
        </div>
        <div class="alert alert-error">  
            <a class="close" data-dismiss="alert">×</a>  
            <h1 style='text-align: center; color: blue;'><strong>Me desculpa!</strong>&nbsp;Ocorreu um erro com a aplicação. Retorne mais tarde. </h1>
            <%if (request.getParameter("error") != null) {%>
            <p style="text-align: center; color:red;"><b>Descrição do erro: <%=request.getParameter("error")%></b></p>
            <%}%>

        </div> 
        <hr/>
        <div>
            <p style='text-align: center; color:blue;'>Todos os direitos reservados ELIT IT 2014</p>
        </div>
    </body>
</html>
