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
        <meta name="description" content="Tabela de escolha do mês, ano e matricula do relatório de cópias">
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
                    Relatório de cópias
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> relatório de cópias
                    </li>
                </ol>
            </div>

            <!-- Formulários -->
            <center>
                <form action="copias_mes_ano.jsp" method="POST" target="_blank">
                    <div class="row" title="Mês do relatório">
                        <!-- mês -->
                        <div class="form-group col-lg-6 col-md-8 col-sm-12">
                            <label>Mês: </label>
                            <select name="mes" class="form-control">
                                <option value="0" selected>Todos</option>
                                <option value="01">Janeiro</option>
                                <option value="02">Fevereiro</option>
                                <option value="03">Março</option>
                                <option value="04">Abril</option>
                                <option value="05">Maio</option>
                                <option value="06">Junho</option>
                                <option value="07">Julho</option>
                                <option value="08">Agosto</option>
                                <option value="09">Setembro</option>
                                <option value="10">Outubro</option>
                                <option value="11">Novembro</option>
                                <option value="12">Dezembro</option>
                            </select>
                        </div>

                        <!-- ano -->
                        <div class="form-group col-lg-6 col-md-8 col-sm-12">
                            <label>Ano: </label>
                            <select name="ano" class="form-control" title="Ano do relatório">
                                <% for (int i = 2017; i <= 2050; i++) {%>
                                <option value="<%=i%>"><%=i%></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <!-- matricula -->
                        <div class="form-group col-lg-6 col-md-8 col-sm-12">
                             <label>Matricula: </label>
                            <input type="number" class="form-control" placeholder="digite aqui a matricula do aluno" name="matricula" title="Matricula do aluno"/>
                        </div>    
                    </div>
                    <div class="row">
                        <!-- botao submit -->
                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                            <input type="submit" class="btn btn-success" value="Gerar Relatório"
                                   title="Clique aqui para gerar um relatório de cópias" />
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
