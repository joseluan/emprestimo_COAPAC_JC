<%@page import="java.sql.SQLException"%>
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
        <meta name="description" content="Adicionando um objeto ou livro ao sistema">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-ADICIONAR</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('input#livro').click(function () {
                    $('div#divvolume').css('opacity', 1);
                });
                $('input#objeto').click(function () {
                    $('div#divvolume').css('opacity', 0);
                });

            });
        </script>
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
                height: 50px;
                font-size: 18pt;
            }
            input#semestre{
                width: 120px;
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
                    Adicionar objeto
                    <small>ao sistema</small>
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> Adicionar um objeto
                    </li>
                </ol>
                <%
                    if (request.getParameter("nome") != null) {
                        String nome = request.getParameter("nome");
                        String descricao = request.getParameter("descricao");
                        String volume = request.getParameter("volume");
                        String isLivro = request.getParameter("isLivro");

                        b.addLivro(nome, descricao, volume, isLivro);

                %>
                <div class="alert alert-success">
                    <h4>Objeto salvo com sucesso.</h4>
                </div>
                <% } %>
            </div>
            <center>
                <form action="adicionar_objeto.jsp" method="POST">
                    <div class="row"> 
                        <div class="form-group col-lg-6 col-md-6 col-sm-12">
                            <label>Nome</label>
                            <input type="text" name="nome" class="form-control" placeholder="Digite o nome do seu produto aqui">
                        </div>
                        <div class="form-group col-lg-6 col-md-6 col-sm-12">
                            <label>Descrição</label>
                            <textarea min="0" name="descricao" class="form-control" placeholder="Descreva seu objeto"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div id="divvolume" class="form-group col-lg-6 col-md-6 col-sm-12">
                            <label>Volume</label>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="volume" id="options1" value="unico" checked>Único
                                </label>
                                <label>
                                    <input type="radio" name="volume" id="options2" value="1">1°
                                </label>
                                <label>
                                    <input type="radio" name="volume" id="options3" value="1">2°
                                </label>
                                <label>
                                    <input type="radio" name="volume" id="options4" value="1">3°
                                </label>
                            </div>
                        </div>


                        <div class="form-group col-lg-6 col-md-6 col-sm-12">
                            <label>É um livro?</label>
                            <div class="radio">
                                <label>
                                    <input onchange="isLivro()" type="radio" name="isLivro" id="livro" value="1" checked>Sim
                                </label>
                                <label>
                                    <input type="radio" name="isLivro" id="objeto" value="0">Não
                                </label>
                            </div>
                        </div>

                    </div>
                    <input id="semestre" type="submit" class="btn btn-lg btn-success" value="Salvar"> 
                </form>
            </center>
        </div>    
        <% b.conn.close();
            } else {
                response.sendRedirect("login.jsp");
            }%>
    </body>
</html>