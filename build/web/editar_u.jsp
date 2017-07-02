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
        <meta name="description" content="Página para editar um usuário ou administrador">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-EDITAR</title>

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
                font-size: 24pt;
            }
            input#semestre{
                width: 320px;
            }
        </style>
    </head>

    <body>
        <% if (session.getAttribute("login") != null) { %>

        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">
            <!-- Page Heading -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Alterar Produto
                    </h1>
                    <ol class="breadcrumb">
                        <li>
                            <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                        </li>
                        <li class="active">
                            <i class="fa fa-desktop"></i> Editar usuário
                        </li>
                    </ol>
                    <%
                        if (request.getParameter("nome") != null) {
                            String id = request.getParameter("id");
                            String matricula = request.getParameter("matricula");
                            String nome = request.getParameter("nome");
                            String senha = request.getParameter("senha");
                            String email = request.getParameter("email");

                            b.alterarNomeAdminUser(matricula, nome);
                            b.alterarSenhaAdminUser(matricula, senha);
                            b.alterarEmailAdminUser(matricula, email);

                            session.setAttribute("nome", b.selectNomeUserOfId(id));

                            response.sendRedirect("editar_u.jsp");
                    %>
                    <div class="alert alert-success">
                        <h4>Atualizado com sucesso.</h4>
                    </div>
                    <%  }  %>
                </div>
            </div> 
            <center>
                <%
                    ResultSet user = b.selectUsuarioOfMatricula(session.getAttribute("login").toString());
                    while (user.next()) {
                %>
                <form action="editar_u.jsp" method="POST">  
                    <div class="row"> 
                        <div class="col-lg-7 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Nome</label>
                                <input name="nome" type="text" class="form-control editarP" placeholder="Digite o nome" value="<%=user.getString("nome")%>">
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Matricula</label>
                                <input name="matricula" type="text" value="<%=user.getString("matricula")%>" class="form-control editarP" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-lg-7 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>E-mail</label>
                                <input name="email" type="email" value="<%=user.getString("email")%>" class="form-control editarP">
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Senha</label>
                                <input name="senha" min="8" type="text" value="<%=user.getString("senha")%>" class="form-control editarP" placeholder="Insira a senha">
                            </div>
                        </div>
                    </div>
                    <input type="hidden" value="<%=user.getString("id")%>" name="id"/>

                    <br/>

                    <input type="hidden" name="matricula" value="<%=session.getAttribute("login")%>">
                    <input type="submit" value="Editar" class="btn btn-md btn-warning">
                </form>
                <%
                        if (request.getParameter("id2") != null && (!user.getString("isaluno").equals("0"))) {
                            b.excluirAdminUser(request.getParameter("id2"));

                            session.removeAttribute("login");
                            session.removeAttribute("nivel");
                            session.removeAttribute("id");
                            session.removeAttribute("nome");

                            response.sendRedirect("login.jsp");
                %>
                <form action="editar_u.jsp" method="POST">
                    <input type="hidden" name="id2" value="<%=session.getAttribute("login")%>">
                    <input type="submit" value="Excluir" class="btn btn-md btn-danger" style="margin-top: 10px;">
                </form>

                <%
                        }
                    }
                    user.close();
                %>
            </center>

            <%
                    b.conn.close();
                } else {
                    response.sendRedirect("login.jsp");
                }
            %>
    </body>
</html>
