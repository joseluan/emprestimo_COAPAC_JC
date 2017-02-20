<%-- 
    Document   : produtos
    Created on : 20/10/2016, 23:29:52
    Author     : luan
--%>

<%-- 
    Document   : adicionar_produto
    Created on : 05/10/2016, 20:07:56
    Author     : luan
--%>
    
<%@page import="java.sql.ResultSet"%>
<%@page import="mysql_bd.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
 
    <% Banco b = new Banco(); 
       boolean ok = false;
    %>
   
    <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Lista de todos os livros e atalhos para excluir e editar livros">
    <meta name="author" content="José Luan Silva do Nascimento">

    <title>Apoio Acadêmico</title>

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
            width: 180px;
            height: 100px;
            font-size: 36pt;
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
                        <a href="livros.jsp">Livros</a>
                    </li>
                    <li>
                        <a href="objetos.jsp">Objetos</a>
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
            <div class="col-lg-12">
                <h1 class="page-header">
                    Lista de produtos
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> Produtos
                    </li>
                </ol>
            </div>
                <center>
                    
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>Livro</th>
                                <th>Volume</th>
                                <th>Editar</th>
                                <th>Excluir</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ResultSet livros = b.selectAllLivro();
                                while(livros.next()){
                            %>
                                <tr>
                                    <td><%=livros.getString("nome")%></td>
                                    <td><%=livros.getString("volume")%></td>
                                    <td>
                                        <form action="editar_l.jsp" method="POST">
                                            <input type="hidden" name="idprodt" value="<%=livros.getString("id")%>">
                                            <input type="submit" id="bteditar" class="btn btn-lg btn-warning" value="Editar">
                                        </form>
                                    </td>
                                    <td>
                                        <form action="excluir_l.jsp" method="POST">
                                            <input type="hidden" name="idprodt" value="<%=livros.getString("id")%>">
                                            <input type="submit" id="btexcluir" class="btn btn-lg btn-danger" value="Excluir">
                                        </form>
                                    </td>
                                </tr>
                            <% 
                                }   
                                livros.close();
                            %>
                        </tbody>
                    </table>   
                </center>
        </div>    
                <!-- /.row -->
        </div>    
    <% b.conn.close(); }else{ response.sendRedirect("login.jsp"); } %>
</body>
</html>