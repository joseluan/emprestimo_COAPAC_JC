<%-- 
    Document   : comprar
    Created on : 15/10/2016, 21:37:11
    Author     : luan
--%>

<%@page import="mysql_bd.Banco"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    
    <% 
        String reqano = request.getParameter("ano");
        Banco b = new Banco(); 
    %>
    
    <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Tabela para a escolha do empréstimo de um objeto">
    <meta name="author" content="José Luan Silva do Nascimento">

    <title>Apoio Acadêmico</title>

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
            <div class="col-lg-12">
                        <h1 class="page-header">
                            Empréstimo de Objetos
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-desktop"></i> Empréstimo
                            </li>
                        </ol>
                    </div>
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Volume</th>
                                <th>Descrição</th>
                                <th>Empréstimo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (request.getParameter("idproduto") != null) {
                                    b.addEntrega(session.getAttribute("id").toString(),request.getParameter("idproduto"));          
                                }
                            %>
                            <%
                                ResultSet objeto = b.selectAllObjetoofEstoque();
                                while(objeto.next()){
                            %>
                        <form method="post" action="index.jsp">
                       
                            <tr>
                                <td><%=objeto.getString("nome")%></td>
                                <td><%=objeto.getString("volume")%></td>
                                <td><%=objeto.getString("descricao")%></td>
                                <td>
                                    <% 
                                        if(objeto.getString("quantidade") == "" || objeto.getString("quantidade") == "0" || objeto.getString("quantidade") == null || Integer.parseInt(objeto.getString("quantidade")) <= 0){
                                    %>
                                        
                                    <input type="submit" class="btn btn-lg btn-danger" value="Pegar" title="Adicione mais livro no estoque"  alt="Adicione mais livro no estoque" disabled>
                                                                                
                                    <% } else{ %>
                                        <input type="submit" class="btn btn-lg btn-success" value="Pegar" title="Click para pegar um livro emprestado" alt="Click para pegar um livro emprestado">
                                        <input name="idproduto" type="hidden" value="<%=objeto.getString("id")%>">
                                    <% } %>
                                </td>
                            </tr>
                            
                         </form>
                            <% 
                                }
                                objeto.close();
                            %>
                        </tbody>
                    </table>      
        </div>
    <% b.conn.close(); }else{ response.sendRedirect("login.jsp"); } %>        
</body>
</html>
