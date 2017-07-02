<%@page import="metodos_conexao.Banco"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <% Banco b = new Banco(); %>

        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Relatório de empréstimos da COAPAC">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-RELATÓRIO</title>

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
        <div class="container">
            <center>
                <div id="page-wrapper">
                    <div class="row" style="width: 95%;">
                        <img style="margin-top: 25px;" src="imagens/brasao.jpg"/>
                        <h3>Instituto Federal de Educação, Ciência e Tecnologia Rio Grande do Norte, Campus João Câmara</h3>
                        <h3>Direção Geral</h3>
                        <h3>Coordenação de Apoio Acadêmico</h3>

                        <b>
                            <h4>
                                <%
                                    String ano = request.getParameter("ano");
                                    if (!ano.equals("0")) {
                                        out.println(ano);
                                    }
                                    out.println("<br/>");
                                    out.print("Empréstimos feitos para "+b.selectNomeUserOfMatricula(session.getAttribute("login").toString()));
                                    ResultSet livros = b.selectAllEntregaofIdUser(ano, b.selectIdUserOfMatricula(session.getAttribute("login").toString()));
                                %>
                            </h4>
                        </b>
                        <table class="table table-responsive" style="width: 90%;">
                            <thead>
                                <tr>
                                    <th><h3>Nome</h3></th>
                                    <th><h3>Volume</h3></th>
                                    <th><h3>Descrição</h3></th>
                                    <th><h3>Data</h3></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int numemprestimo = 0;
                                    while (livros.next()) {
                                        numemprestimo++;
                                %>
                                <tr>
                                    <td><h3><%=livros.getString("nome_livro")%></h3></td>
                                    <td><h3><%=livros.getString("volume_livro")%></h3></td>
                                    <td><h3><%=livros.getString("descricao_livro")%></h3></td>
                                    <td><h3><%=livros.getString("data_ent")%></h3></td>
                                </tr>   
                                <%  }
                                    livros.close();%>
                            </tbody>
                        </table>
                        <br/>
                    </div>

                </div>
            </center>
            <div class="row">
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <h3>Número de registros = <%=numemprestimo%> </h3>
                </div>
            </div>
        </div> 
        <% 
            b.conn.close();
            } else {
                response.sendRedirect("login.jsp");
            }%>
    </body>
</html>
