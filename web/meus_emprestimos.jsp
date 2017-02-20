<%-- 
    Document   : relatorio_anual_final
    Created on : 30/10/2016, 21:58:57
    Author     : luan
--%>

<%@page import="mysql_bd.Banco"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <% Banco b = new Banco(); %>
        
        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Relatório de empréstimos de objetos do Apoio Acadêmico">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>Apoio Acadêmico</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">    

</head>
<body>
    <%
        if (session.getAttribute("login") != null) {
    %>
    <center>
        <div id="page-wrapper">
            <div class="container-fluid">
                
                <div class="row">
                    <img style="margin-top: 25px;" src="imagens/brasao.jpg"/>
                    <h2>Instituto Federal de Educação, Ciência e Tecnologia Rio Grande do Norte, Campus João Câmara</h2>
                    <h3>Direção Geral</h3>
                    <h3>Coordenação de Apoio Acadêmico</h3>
                    <% ResultSet rs = b.selectUsuarioOfId(session.getAttribute("id").toString());
                       String nome = "";
                       while(rs.next()){
                           nome = rs.getString("nome");
                       }
                    %>
                    <b><h3>Empréstimos feitos para o usuário <%=nome%></h3></b>
                    <table class="table" style="width: 90%;">
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
                                double saldo = 0;
                                double venda = 0;
                                double despesa = 0;
                                ResultSet livrosOfId = b.selectAllLivroofEstoqueIdUser(session.getAttribute("id").toString());
                                while(livrosOfId.next()){
                            %>
                                    <tr>
                                        <td><h3><%=livrosOfId.getString("nome")%></h3></td>
                                        <td><h3><%=livrosOfId.getString("volume")%></h3></td>
                                        <td><h3><%=livrosOfId.getString("descricao")%></h3></td>
                                        <td><h3><%=livrosOfId.getString("data_ent")%></h3></td>
                                    </tr>   
                            <% 
                                }
                                livrosOfId.close();
                            %>
                        </tbody>
                    </table>
                    <br/>
                </div>
            </div> 
        </div>
    </center>
    <% b.conn.close(); }else{ response.sendRedirect("login.jsp"); } %>
</body>
</html>
