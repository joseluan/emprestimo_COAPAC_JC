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
        <meta name="description" content="Página para editar um objeto ou livro">
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
                width: 220px;
                height: 100px;
                font-size: 36pt;
            }
            input#semestre{
                width: 320px;
            }
        </style>
    </head>

    <body>
        <%
            if (session.getAttribute("login") != null) {
                if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) { %>

        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">
            <!-- Page Heading -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">
                        Alterar Produto
                    </h1>
                </div>
                <center>
                    <form action="editar_l.jsp" method="POST">

                        <%
                            ResultSet produto = b.selectAllObjetoofId(request.getParameter("idprodt"));
                            while (produto.next()) {
                        %>
                        <div class="form-group">
                            <label>Nome</label>
                            <input name="nome" type="text" class="form-control editarP" placeholder="Digite o nome do seu produto aqui" value="<%=produto.getString("nome")%>">
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label>Descrição</label>
                            <textarea name="descricao" type="number" class="form-control editarP" placeholder="Insira a descrição do seu produto"><%=produto.getString("descricao")%></textarea>
                        </div>
                        <br/>
                        <%  }
                            produto.close();
                        %>

                        <hr/>
                        <input type="hidden" name="id" value="<%=request.getParameter("idprodt")%>">
                        <input type="submit" value="Editar" class="btn btn-lg btn-warning">
                        <%
                            if (request.getParameter("id") != null) {
                                b.alterarLivro(request.getParameter("id"), request.getParameter("nome"), request.getParameter("descricao"));
                                response.sendRedirect("objetos.jsp");
                            }
                        %>
                    </form>
                </center>
            </div>    
            <%
                        b.conn.close();
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp");
                }
            %>
    </body>
</html>