<%-- 
    Document   : adicionar_p_est
    Created on : 03/11/2016, 00:16:28
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
    <meta name="description" content="Pagina para adicionar um produto ao estoque">
    <meta name="author" content="José Luan Silva do Nascimento">
    
    <title>Apoio Acadêmico</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    <link href="css/principal.css" rel="stylesheet">

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
            <% 
                        if (request.getParameter("quantidade") != null) {
                            String produto = request.getParameter("produto");
                            String quantidade = request.getParameter("quantidade");
                            b.addPEstoque(produto, quantidade);
                            ok = true;
                        }
                        if (ok == true) {
                    %>
                            <div class="alert alert-success">
                                <h2>
                                    <h3>Sucesso!</h3> Produto adicionado com sucesso.
                                </h2>
                            </div>
                    <%  }  %>
                    
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Adicionar produto
                            <small>ao estoque</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-desktop"></i> Adicionar produto ao estoque
                            </li>
                        </ol>
                    </div>
                    <center>
                        <form action="adicionar_l_est.jsp" method="POST">
                            
                            <div class="form-group">
                                <label>Produto</label>
                                <select name="produto" class="form-control">
                                    <% 
                                        ResultSet produtos = b.selectAll();
                                        while(produtos.next()){
                                    %>
                                        <option value="<%=produtos.getString("id")%>">
                                            <label><%=produtos.getString("nome")%></label>
                                        </option>
                                    <% }
                                        produtos.close();
                                    %>
                                </select>
                            </div>
                            <hr/>
                            
                            <div class="form-group">
                                <label>Quantidade</label>
                                <input type="number" min="1" name="quantidade" class="form-control" placeholder="Insira a quantidade de produtos">
                            </div>
                            <br/>
                            <input id="semestre" type="submit" class="btn btn-lg btn-success" value="Adicionar">
                            <br/>
                            
                        </form>
                    </center> 
        </div>    
    <% b.conn.close(); }else{ response.sendRedirect("index.jsp"); } %>
</body>
</html>