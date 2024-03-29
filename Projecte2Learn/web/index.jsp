<%-- 
    Document   : index
    Created on : 31/05/2014, 09:32:08
    Author     : Marco Aurélio
--%>
<%@page import="com.elit2.app.control.AlunoDAO"%>
<%@page import="com.elit2.app.control.ProfessorDAO"%>
<%@page import="com.elit2.app.model.Professor"%>
<%@page import="com.elit2.app.control.LoginDAO"%>
<%@page import="com.elit2.app.model.Login"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.elit2.app.control.OracleConnector"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //request.getSession().setAttribute("professor", new Professor(1, "marco@live.com", 1, 1));
    if (session.getAttribute("professor") != null || session.getAttribute("aluno") != null) {
        response.sendRedirect("dashboard.jsp?action=redirect");
    }
%>

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
        <%
            if (request.getParameter("nm_email") != null && request.getParameter("nm_senha") != null) {
                LoginDAO logDao = new LoginDAO();
                ArrayList<Login> logins = null;
                try {
                    logins = logDao.getLogin(request.getParameter("nm_email"), request.getParameter("nm_senha"));

                    if (logins.size() > 0) {

                        if (logins.get(0).getTp_login() == 1) {
                            ProfessorDAO profDao = new ProfessorDAO();
                            Professor prof = profDao.getProfessorPorLogin(logins.get(0).getCd_login());
                            session.setAttribute("professor", prof);
                            response.sendRedirect("dashboard.jsp?page=conteudos");
                        } else if (logins.get(0).getTp_login() == 0) {
                            AlunoDAO aluDAO = new AlunoDAO();
                            Aluno aluno = aluDAO.getAlunoPorLogin(logins.get(0).getCd_login());
                            session.setAttribute("aluno", aluno);
                            response.sendRedirect("dashboard.jsp?tp=pes&con=true");
                        } else {
                            response.sendRedirect("index.jsp?action=idusernotfound");
                        }
                    } else {
                        response.sendRedirect("index.jsp?action=loginerror");
                    }

                } catch (Exception ex) {
                    response.sendRedirect("erro.jsp?errorcode=" + ex.getMessage());
                }
            }
        %>

        <!-- div da navbar - fim -->
        <div class="container" style="width: 80%;">
            <div class="row">
                <div class="col-md-12">
                    <ul class="breadcrumb">
                    </ul>
                </div>
            </div>
            <div class="row">

            </div>
            <div id="corpo">
                <div class="row">
                    <div class="col-md-4 text-left">
                        <br>
                        <img src="img/logo.png" class="img-responsive img-rounded">
                    </div>
                    <div class="col-md-4">
                        <p></p>
                    </div>


                    <div class="col-md-4">
                        <%if (request.getParameter("action") != null) {%>
                        <div class="alert alert-danger" style="text-align: center;">Combinação e-mail/senha inválidos.</div>
                        <%}%>
                        <form role="form" action="index.jsp" method="POST">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Endereço de E-mail:</label>
                                <input class="form-control" name="nm_email" id="exampleInputEmail1" placeholder="Enter email" type="email">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Senha:</label>
                                <input class="form-control" name="nm_senha" id="exampleInputPassword1" placeholder="Password" type="password">
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm" style="float:right;">ENTRAR</button>                            
                        </form>
                    </div>

                </div>
                <br>

            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="img/img_banner.png.jpg">
                                <div class="carousel-caption">
                                    <h2></h2>
                                    <p></p>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

            </div>
            <br>
            <%@include  file="_res/rodape.jsp"%>
        </div>

    </body>

</html>
