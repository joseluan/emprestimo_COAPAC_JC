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
        <meta name="description" content="Pagina para adicionar um objeto ou livro ao estoque">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC/ESTOQUE</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <link href="css/principal.css" rel="stylesheet">
        <style>
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
                if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) { %>
        %>
        <jsp:include page="jspf/menu_barra.jsp"/>

        <div id="conteudo" style="margin-top: 60px;">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Adicionar objeto
                    <small>ao estoque</small>
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <i class="fa fa-dashboard"></i>  <a href="index.jsp">Início</a>
                    </li>
                    <li class="active">
                        <i class="fa fa-desktop"></i> Adicionar objeto ao estoque
                    </li>
                </ol>
                <%
                    if (request.getParameter("quantidade") != null) {
                        String id = request.getParameter("id");
                        String quantidade = request.getParameter("quantidade");
                        String quantidade_estoque = b.selectQuantidadeEstoqueOfId(id);
                        try {
                            if ((Integer.parseInt(quantidade_estoque)
                                    + Integer.parseInt(quantidade)) >= 0) {

                                b.addOEstoque(id, quantidade);
                %>
                                <div class="alert alert-success">
                                    <h4>A quantidade de Objeto/Livro foi adicionada com sucesso.</h4>
                                </div>
                            <%
                            } else {
                            %>
                                <div class="alert alert-danger">
                                    <h4>O valor final da quantidade de cópias é negativo! digite outro valor</h4>
                                </div>
                <%
                            }
                        } catch (NumberFormatException n) {
                            if (Integer.parseInt(quantidade) >= 0) {
                                b.addOEstoque(id, quantidade);
                            
                %>
                                <div class="alert alert-success">
                                    <h4>A quantidade de Objeto/Livro foi adicionada com sucesso.</h4>
                                </div>
                <%          }else{ %>
                                <div class="alert alert-danger">
                                    <h4>O valor final da quantidade de cópias é negativo! digite outro valor</h4>
                                </div>
                <%
                            }
                        }
                    }
                %>
            </div>
            <center>
                <form action="adicionar_estoque.jsp" method="get">

                    <div class="form-group">
                        <label>Objeto/LIvro</label>
                        <select name="id" class="form-control">
                            <%
                                ResultSet produtos = b.selectAll();
                                while (produtos.next()) {
                            %>
                            <option value="<%=produtos.getString("id")%>">
                            <label><%=produtos.getString("nome")%></label>
                            </option>
                            <%
                                }
                                produtos.close();
                            %>
                        </select>
                    </div>
                    <hr/>

                    <div class="form-group">
                        <label>Quantidade</label>
                        <input type="number" name="quantidade" class="form-control" placeholder="Insira a quantidade de objetos">
                    </div>
                    <br/>
                    <input id="semestre" type="submit" class="btn btn-sm btn-success" value="Adicionar">
                    <br/>

                </form>
            </center> 
        </div>    
        <%
                    b.conn.close();
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }%>
    </body>
</html>