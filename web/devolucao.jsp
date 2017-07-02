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
        <meta name="description" content="Página para devolver um  produto">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-DEVOLUÇÃO</title>

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
            ul#mes li input.btn{
                width: 175px;
                height: 70px;
                font-size: 25pt;
            }
            input.btn{
                width: 150px;
                height: 50px;
                font-size: 18pt;
            }
            input#semestre{
                width: 320px;
            }
        </style>
    </head>

    <body>
        <%
            if (session.getAttribute("login") != null) {
                if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) {%>

        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">
            <!-- Page Heading -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Devolução de Objetos
                    </h1>
                    <ol class="breadcrumb">
                        <li>
                            <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-desktop"></i> Devolução de emprestimos
                        </li>
                    </ol>
                    <%
                        if (request.getParameter("identrega") != null) {
                            b.deleteEntregaOfId(request.getParameter("identrega"), request.getParameter("id_livro"));
                    %>
                    <div class="alert alert-success">Devolvido com sucesso!</div>
                    <%
                        }
                    %>
                </div>
                <form action="devolucao.jsp" method="POST">
                    <table>
                        <tr>
                            <td><input type="number" style="margin-right: 5px;font-size: 14pt;width: 200px" class="form-control" placeholder="Digite a matricula" name="matricula"/></td>
                            <td><input type="submit" class="btn btn-success" value="Pesquisar" title="Clique aqui para pesquisar um empréstimo" /></td>
                        </tr>
                    </table>
                </form>
                <center>
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>Matricula</th>
                                <th>Usuário</th>
                                <th>Objeto</th>
                                <th>Volume</th>
                                <th>Descrição</th>
                                <th>Data</th>
                                <th>Devolução</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (request.getParameter("matricula") != null) {
                                    ResultSet objetos = b.selectAllEntregaofMatriculaUser(request.getParameter("matricula"));
                                    while (objetos.next()) {
                                        String nome = b.selectNomeUserOfId(objetos.getString("id_aluno"));
                            %>
                            <tr>
                                <td><%=objetos.getString("matricula")%></td>
                                <td><%=nome%></td>
                                <td><%=objetos.getString("nome")%></td>
                                <td><%=objetos.getString("volume")%></td>
                                <td><%=objetos.getString("descricao")%></td>
                                <td><%=objetos.getString("data_ent")%></td>
                                <td>
                                    <form action="devolucao.jsp" method="POST">
                                        <input type="hidden" name="identrega" value="<%=objetos.getString("e.id")%>">
                                        <input type="hidden" name="id_livro" value="<%=objetos.getString("id_livro")%>">
                                        <input type="submit" id="btdevolucao" class="btn btn-lg btn-danger" value="Devolver">
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                    objetos.close();
                                }
                            %>
                        </tbody>
                    </table>
                </center>
            </div>    
            <%
                    b.conn.close();
                } else {
                    response.sendRedirect("index.jsp");
                }
            %>

            <% } else {
                    response.sendRedirect("login.jsp");
                }%>
    </body>
</html>