<%-- 
    Document   : adicionar_produto
    Created on : 05/10/2016, 20:07:56
    Author     : luan
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="mysql_bd.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    
    <% 
        String reqano = request.getParameter("ano");
        Banco b = new Banco(); 
        boolean ok = false;
    %>
    
    <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Adicionando um produto ao sistema">
    <meta name="author" content="José Luan Silva do Nascimento">
    
    <title>Apoio Acadêmico</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $('input#livro').click(function(){
                $('div#divvolume').css('opacity',1);
            });
            $('input#objeto').click(function(){
                $('div#divvolume').css('opacity',0);
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
    %>
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse" id="barra">
                <ul id="menulateral" class="nav navbar-nav side-nav">
                    <li>
                        <a class="navbar-brand" href="index.jsp">Empréstimos do Apoio Acadêmico</a>
                    </li>
                    <li>
                        <a href="index.jsp">Início</a>
                    </li>
                    <li>
                        <a href="meus_emprestimos.jsp">Meus empréstimos</a>
                    </li>
                    <% if(session.getAttribute("isaluno").toString().equals("1")){ %>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#lista">Listas<i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="lista" class="collapse">
                                <li>
                                    <span><a href="livros.jsp"><span>Livros</span></a></span>
                                </li>

                                <li>
                                    <span><a href="objetos.jsp"><span>Objetos</span></a></span>
                                </li>
                                <li>
                                    <span><a href="usuarios.jsp"><span>Usuários</span></a></span>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#demo">Adicionar <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="demo" class="collapse">
                                <li>
                                    <span><a href="adicionar_produto.jsp"><span>Objeto</span></a></span>
                                </li>

                                <li>
                                    <span><a href="adicionar_l_est.jsp"><span>Objeto no Estoque</span></a></span>
                                </li>
                                <li>
                                    <span><a href="cadastrar_admin.jsp"><span>Administrador</span></a></span>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="devolucao.jsp">Devolução</a>
                        </li>
                    <% } %>
                        <li>
                            <a href="pegar_objetos.jsp">Pegar Objetos</a>
                        </li>
                    <li>
                        <form action="login.jsp" method="post">
                            <input style="width: 80px;height: 50px; font-size: 16pt;" type="submit" class="btn btn-xs btn-danger" value="sair">
                            <input type="hidden" value="sair" name="sair">
                        </form>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        
        <div id="conteudo" style="margin-top: 60px;">
                    <% 
                        if (request.getParameter("nome") != null) {
                                String nome = request.getParameter("nome");
                                String descricao = request.getParameter("descricao");
                                String volume = request.getParameter("volume");
                                String isLivro = request.getParameter("isLivro");
                                try{
                                    b.addLivro(nome, descricao, volume,isLivro);
                                    ok = true;
                                }catch(Exception qsle){
                                    ok = false;
                                }     
                        }       
                        if (ok == true) {
                    %>
                        <div class="alert alert-success">
                            <h2>
                                <h3>Sucesso!</h3> Produto salvo com sucesso.
                            </h2>
                        </div>
                    <%  }  %>
                    
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Adicionar produto
                            <small>ao sistema</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-desktop"></i> Adicionar um produto
                            </li>
                        </ol>
                    </div>
                         <center>
                        <form action="adicionar_produto.jsp" method="POST">
                            
                            <div class="form-group">
                                <label>Nome</label>
                                <input style="width: 45%;" type="text" name="nome" class="form-control" placeholder="Digite o nome do seu produto aqui">
                            </div>
                            <div class="form-group">
                                <label>Descrição</label>
                                <textarea style="width: 45%;" min="0" name="descricao" class="form-control" placeholder="Descreva seu livro"></textarea>
                            </div>
                            <br/>
                            <table border="0">
                                <tr>
                                    <td>
                                        <div id="divvolume" class="form-group">
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
                                    </td>
                                    <td> 
                                        <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<h1/>
                                    </td>
                                    <td>
                                        <div class="form-group">
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
                                    </td>
                                </tr>
                            </table>

                            <input id="semestre" type="submit" class="btn btn-lg btn-success" value="Salvar"> 
                            <br/>
                        </form>
                    </center>
        </div>    
    <% b.conn.close(); }else{ response.sendRedirect("login.jsp"); } %>
</body>
</html>