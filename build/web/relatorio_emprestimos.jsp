<%@page import="metodos_conexao.Banco"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <% Banco b = new Banco(); %>

        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Tabela de escolha do mês, ano e matricula do relatório de empréstimos">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-RELATÓRIO</title>

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
                width: 250px;
                height: 75px;
                font-size: 24pt;
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
                    Relatório de empréstimos
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> relatório de empréstimos
                    </li>
                </ol>
            </div>

            <!-- Formulários -->
            <center>
                <form action="emprestimo_mes_ano.jsp" method="POST" target="_blank">
                    <div class="row">
                        <!-- ano -->
                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                            <label>Ano: </label>
                            <select style="font-size: 30pt; width: 200px; height: 80px;" name="ano" class="form-control" title="Ano do relatório">
                                <option value="0" selected>Todos</option>
                                <% for (int i = 2017; i <= 2050; i++) {%>
                                    <option value="<%=i%>"><%=i%></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <!-- botao submit -->
                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                            <input type="submit" class="btn btn-success" value="Gerar Relatório"
                                   title="Clique aqui para gerar um relatório de empréstimo" />
                        </div>
                    </div>
                </form>
            </center>
        </div>
        <% b.conn.close();
            } else {
                response.sendRedirect("login.jsp");
            }%>        
    </body>
</html>
