<%@page import="java.sql.ResultSet"%>
<%@page import="metodos_conexao.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <% Banco b = new Banco(); %>

        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Lista de todos os livros e atalhos para excluir e editar livros">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-LISTA</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery/mudarcor.js"></script>

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
                    Lista de livros
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> Livros
                    </li>
                </ol>
            </div>
            <!-- Formulários -->
            <form action="livros.jsp" method="POST">
                <table>
                    <tr>
                        <td><input type="text" style="margin-right: 5px;font-size: 14pt;width: 200px" class="form-control" placeholder="nome do objeto" name="nome"/></td>
                        <td><input type="submit" class="btn btn-success" value="Pesquisar" title="Clique aqui para pesquisar um objeto" /></td>
                    </tr>
                </table>
            </form>
            <% if (request.getParameter("nome") != null) { %>
            <center>

                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>Nome</th>
                            <th>Volume</th>
                            <th>Quantidade</th>
                            <th>Editar</th>
                            <th>Excluir</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet livros = b.selectAllLivroNome(request.getParameter("nome"));
                            while (livros.next()) {
                        %>
                        <tr>
                            <td><%=livros.getString("nome")%></td>
                            <td><%=livros.getString("volume")%></td>
                            <td><%=livros.getString("quantidade")%></td>
                            <td>
                                <form action="editar_l.jsp" method="POST">
                                    <input type="hidden" name="idprodt" value="<%=livros.getString("id")%>">
                                    <input type="submit" id="bteditar" class="btn btn-lg btn-warning" value="Editar">
                                </form>
                            </td>
                            <td>
                                <form action="excluir_l.jsp" method="POST">
                                    <input type="hidden" name="idprodt" value="<%=livros.getString("id")%>">
                                    <input type="submit" id="btexcluir" class="btn btn-lg btn-danger" value="Excluir">
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                            livros.close();
                        %>
                    </tbody>
                </table>   
            </center>
            <% } %>
        </div>    
        <!-- /.row -->
    </div>    
    <% b.conn.close();
        } else {
            response.sendRedirect("login.jsp");
        }%>
</body>
</html>