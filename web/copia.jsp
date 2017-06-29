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
        <meta name="description" content="Página para modificar a quantidade de cópias de um usuário ou administrador">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-CÓPIA</title>

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
                height: 75px;
                font-size: 24pt;
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
                        Alterar Produto
                    </h1>
                </div>
                <%
                    if (request.getParameter("id2") != null) {
                        String id = request.getParameter("id2");
                        String copia = request.getParameter("copia");
                        int copia2 = b.selectCopiaUsuariofdId(id);

                        if ((copia2 + Integer.parseInt(copia)) >= 0) {
                            b.alterarCopiaAdminUser(id, copia);
                %>
                            <div class="alert alert-success">
                                <h4>A quantidade de cópias foi alterada com sucesso!</h4>
                            </div>
                <%
                        } else {
                %>
                            <div class="alert alert-danger">
                                <h4>O valor final da quantidade de cópias é negativo! digite outro valor</h4>
                            </div>
                <%
                        }
                    }
                %>
            </div> 
            <center>
                <form action="copia.jsp" method="POST">

                    <%
                        ResultSet user = b.selectUsuarioOfId(request.getParameter("id"));
                        while (user.next()) {
                    %>
                    <div class="row"> 
                        <div class="col-lg-7 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Nome</label>
                                <input name="nome" type="text" class="form-control editarP" value="<%=user.getString("nome")%>" disabled> 
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Matricula</label>
                                <input name="matricula" type="text" value="<%=user.getString("matricula")%>" class="form-control editarP" disabled>
                            </div>
                        </div>
                        <div class="col-lg-7 col-md-6 col-sm-12">
                            <div class="form-group">
                                <label>Adicionar ou Remover</label>
                                <input name="copia" type="number" placeholder="<%=user.getString("copia")%> cópias" class="form-control editarP">
                            </div>
                        </div>
                    </div>
                    <input type="hidden" value="<%=user.getString("id")%>" name="id2"/>
                    <input type="hidden" value="<%=user.getString("id")%>" name="id"/>
                    <input type="hidden" value="<%=user.getString("copia")%>" name="copia2"/>
                    <br/>
                    <%  }
                        user.close();
                    %>

                    <input type="submit" value="Editar" class="btn btn-md btn-warning">
                </form>
            </center>

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
