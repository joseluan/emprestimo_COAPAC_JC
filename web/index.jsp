<%@page import="metodos_conexao.Banco"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <% Banco b = new Banco(); %>

        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Tela inicial e tela de empréstimo de livro">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-EMPRESTIMO</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <link href="css/principal.css" rel="stylesheet">
        <style type="text/css">
            p{
                text-indent: 40px;
                font-size: 14pt;
                text-align: justify;
            }
            ul{
                list-style:none;
            }
            ul li{
                display: inline-block;
            }
            input.btn{
                width: 150px;
                height: 50px;
                font-size: 18pt;
            }
        </style>
    </head>
    <body>
        <%
            if (session.getAttribute("login") != null) {
        %>

        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Empréstimo de Livro 
                </h1>
                <%
                    if (request.getParameter("idlivro") != null) {
                        b.addEntrega(session.getAttribute("id").toString(), request.getParameter("idlivro"));
                %>
                <div class="alert alert-success">Livro emprestado com sucesso!</div>
                <%
                    }
                %>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-desktop"></i> Empréstimo de livro

                    </li>
                </ol>
            </div>

            <!-- Formulários -->
            <form action="index.jsp" method="POST">
                <table>
                    <tr>
                        <td><input type="text" style="margin-right: 5px;font-size: 14pt;width: 200px" class="form-control" placeholder="Nome do livro" name="nome"/></td>
                        <td><input type="submit" class="btn btn-success" value="Pesquisar" title="Clique aqui para pesquisar um livro" /></td>
                    </tr>
                </table>
            </form>
            <% if (request.getParameter("nome") != null) {
                    ResultSet livros = b.selectAllLivroNomePegar(request.getParameter("nome")); %>
            <table class="table table-hover table-striped">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Volume</th>
                        <th>Descrição</th>
                        <th>Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (livros.next()) {
                    %>
                <form method="POST" action="index.jsp">

                    <tr>
                        <td><%=livros.getString("nome")%></td>
                        <td><%=livros.getString("volume")%></td>
                        <td><%=livros.getString("descricao")%></td>
                        <td>
                            <input type="submit" class="btn btn-lg btn-success" value="Pegar" title="Click para pegar um livro emprestado" alt="Click para pegar um livro emprestado">
                            <input name="idlivro" type="hidden" value="<%=livros.getString("id")%>">
                        </td>
                    </tr>

                </form>
                <%
                    }
                    livros.close();
                %>
                </tbody>
            </table>     
            <% } %>
        </div>
        <% b.conn.close();
            } else {
                response.sendRedirect("login.jsp");
            }%>        
    </body>
</html>
