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
    
    <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Página para a confirmação da entrefa de um produto">
    <meta name="author" content="José Luan Silva do Nascimento">

    <title>Apoio Acadêmico</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    <link href="css/principal.css" rel="stylesheet">
    
    <script type="text/javascript">
        function myFunction() {
            document.getElementById("totalc").value = document.getElementById("quantidade").value*document.getElementById("valor").value;
        }
    </script>
    
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
<body onload="myFunction();">
    <%
        if (session.getAttribute("login") != null) {
    %>
    <% if(session.getAttribute("nivel").equals("1")){ %>
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
                            b.addEntrega(session.getAttribute("id").toString(),request.getParameter("id"));
                    %>
                    <script>
                        alert("Livro emprestado com sucesso!");
                    </script>
                    <%            
                        }
                    %>
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Confirmar a venda do produto
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-desktop"></i> <a href="venda.jsp">vender</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-desktop"></i> Confirmar venda
                            </li>
                        </ol>
                    </div>
                    <%
                        ResultSet produto = b.selectProdutoofId(request.getParameter("idproduto"));
                        while(produto.next()){
                    %>
                    
                    <center>
                        <form action="venda_confirmar.jsp" method="post" oninput="valor();">
                            <input type="hidden" value="<%=produto.getString("quantidade")%>" name="quantidadeest">
                            <input type="hidden" name="id" value="<%=request.getParameter("idproduto")%>">
                            <input type="hidden" name="idproduto" value="<%=request.getParameter("idproduto")%>">
                            <ul class="infor">
                                <li>
                                    <h2>Nome: </h2>
                                    <h2 class="verde"> <%=produto.getString("nome")%></h2>
                                </li>
                                <li>
                                    <h2>Valor: </h2>
                                    <h2 class="verde">R$ <%=produto.getString("valor")%><input type="hidden" name="valorP" id="valor" value="<%=produto.getString("valor")%>"></h2>
                                </li>
                                <li>
                                    <h2>Quantidade no estoque: </h2>
                                    <h2 class="verde"><%=produto.getString("quantidade")%></h2>            
                                </li>
                            </ul>
                            <ul class="infor">
                                <li>
                                    <h2>É doação? </h2>
                                    <div class="radio">
                                        <label class="verde"><input value="1"type="radio" name="doacao">Sim | </label>
                                        <label class="verde"><input value="0" type="radio" name="doacao" checked>Não</label>
                                    </div>
                                </li>
                                <li>
                                    <h2>Quantidade da venda </h2>
                                    <div class="form-group">
                                        <input  oninput="myFunction();" style="width: 30%"  name="quantidade" id="quantidade" class="form-control" type="number" size="10" max="<%=produto.getString("quantidade")%>" min="1" value="1">
                                    </div>
                                </li>
                                <li>
                                   <h2>Total da venda </h2>
                                    <div class="form-group">
                                        <input id="totalc" type="number" style="width: 35%" class="form-control" max="<%=produto.getString("quantidade")%>" disabled>
                                    </div> 
                                </li>
                            </ul>   
                            <input class="btn btn-primary" type="submit" value="Vender">
                            <% } 
                               produto.close();
                            %>
                        </form>
                    </center>            
        </div>   
   <% 
    b.conn.close();
    }else{
        response.sendRedirect("venda.jsp");
    }
    %>
    
    <% }else{ response.sendRedirect("login.jsp"); } %>
</body>
</html>