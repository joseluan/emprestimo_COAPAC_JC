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
        <meta name="description" content="Página para excluir um objeto ou livro">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-EXCLUIR</title>

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
                width: 500px;
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
            <div class="col-lg-12">
                <h1 class="page-header">
                    Confirmar a exclusão do produto
                </h1>
            </div>
            <center>
                <%
                    ResultSet livro = b.selectObjetoofId(request.getParameter("idprodt"));
                    while (livro.next()) {
                %>

                <h2>Nome do objeto: <%=livro.getString("nome")%></h2><br/>
                <h2>Descrição do objeto: <%=livro.getString("descricao")%></h2><br/>
                <h2>Volume do objeto: <%=livro.getString("volume")%></h2><br/>

                <%  }
                    livro.close();
                %>
                <form action="excluir_l.jsp" method="POST">
                    <hr/>
                    <input type="hidden" name="id" value="<%=request.getParameter("idprodt")%>">
                    <input type="submit" value="Excluir produto" class="btn btn-lg btn-danger">
                    <%
                        if (request.getParameter("id") != null) {
                            b.excluirProduto(request.getParameter("id"));
                            response.sendRedirect("index.jsp");
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
        %>
        <% } else {
                response.sendRedirect("login.jsp");
            }%>
    </body>
</html>