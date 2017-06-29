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
        <meta name="description" content="Lista de todos os usuários e administradores, atalhos para excluir e editar livros">
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
                font-size: 14pt;
                margin-left: 15px;
            }

        </style>
    </head>

    <body>
        <%
            if (session.getAttribute("login") != null) {
                if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) {
        %>

        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">    
            <div class="col-lg-12">
                <h1 class="page-header">
                    Lista de Usuários/Administradores
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> Usuários/Administradores
                    </li>
                </ol>
            </div>

            <!-- Formulários -->
            <form action="usuarios.jsp" method="POST">
                <table>
                    <tr>
                        <td><input type="number" style="margin-right: 5px;font-size: 14pt;width: 200px" class="form-control" placeholder="Digite a matricula" name="matricula"/></td>
                        <td><input type="submit" class="btn btn-success" value="Pesquisar" title="Clique aqui para pesquisar um usuário" /></td>
                    </tr>
                </table>
            </form>
            <%  if (request.getParameter("matricula") != null) { %>
            <center>
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>Nome</th>
                            <th>Matricula</th>
                            <th>E-mail</th>
                            <th>Nivel</th>
                            <th>Cópia</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet useradmin = b.selectUsuarioOfIdLike(request.getParameter("matricula"));
                            while (useradmin.next()) {
                        %>
                        <tr>
                            <td><%=useradmin.getString("nome")%></td>
                            <td><%=useradmin.getString("matricula")%></td>
                            <td><%=useradmin.getString("email")%></td>
                            <td><%=useradmin.getString("isaluno")%></td>
                            <td><td><%=useradmin.getString("copia")%> cópias</td></td>
                            <td>
                                <form action="copia.jsp" method="POST">
                                    <table>
                                        <tr>  
                                            <% if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) {%>
                                            <td><input type="submit" class="btn btn-success" value="Modificar" title="Controle de cópias de alunos" /></td>
                                        <input type="hidden" name="id" value="<%=useradmin.getString("id")%>"/>
                                        <% } %>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                            useradmin.close();

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
                response.sendRedirect("index.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }%>
</body>
</html>