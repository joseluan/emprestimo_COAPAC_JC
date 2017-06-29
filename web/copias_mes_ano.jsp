<%@page import="metodos_conexao.Banco"%>
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
        <meta name="description" content="Relatório de cópias">
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
                if (session.getAttribute("isaluno").equals("1")
                        || session.getAttribute("isaluno").equals("2")) {
                    if ((!request.getParameter("mes").equals(""))
                            && (!request.getParameter("ano").equals(""))) {
        %>
        <div class="container">
            <center>
                <div id="page-wrapper">
                    <div class="container-fluid">

                        <div class="row" style="width: 95%;">
                            <img style="margin-top: 25px;" src="imagens/brasao.jpg"/>
                            <h3>Instituto Federal de Educação, Ciência e Tecnologia Rio Grande do Norte, Campus João Câmara</h3>
                            <h3>Direção Geral</h3>
                            <h3>Coordenação de Apoio Acadêmico</h3>

                            <b>
                                <h4>
                                    <%
                                        //verifica se o usuario escolheu a opção todos
                                        if (!request.getParameter("mes").equals("0")) {
                                            String[] meses = {"janeiro", "fevereiro", "março", "abril", "maio", "junho",
                                            "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"};
                                            //verifica se o usuario digitou uma matricula
                                            if (request.getParameter("matricula").equals("")) {
                                                out.println(meses[Integer.parseInt(request.getParameter("mes")) - 1] + " de " + request.getParameter("ano"));
                                            } else {
                                                out.println(meses[Integer.parseInt(request.getParameter("mes")) - 1] + " de " + request.getParameter("ano"));
                                                out.println("<br/>");
                                                out.println("<br/>");
                                                out.println("Cópias feitas para " + b.selectNomeUserOfMatricula(request.getParameter("matricula")));
                                            }
                                        } else {
                                            //verifica se o usuario digitou uma matricula
                                            if (request.getParameter("matricula").equals("")) {
                                                out.println(request.getParameter("ano"));
                                            } else {
                                                out.println(request.getParameter("ano"));
                                                out.println("<br/>");
                                                out.println("<br/>");
                                                out.println("Cópias feitas para " + b.selectNomeUserOfMatricula(request.getParameter("matricula")));
                                            }
                                        }
                                        
                                    %>
                                </h4>
                            </b>

                            <table class="table table-responsive" style="width: 90%;">
                                <thead>
                                    <tr>
                                        <th><h3>Nome</h3></th>
                                        <th><h3>Matricula</h3></th>
                                        <th><h3>Número de cópias</h3></th>
                                        <th><h3>Data</h3></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int qtdcopia = 0;
                                        int regcopia = 0;

                                        ResultSet livros = b.selectAllCopiaofMesAno(request.getParameter("mes"),
                                                request.getParameter("ano"),
                                                request.getParameter("matricula"));
                                        while (livros.next()) {
                                    %>
                                    <tr>
                                        <td><h3><%=livros.getString("nome")%></h3></td>
                                        <td><h3><%=livros.getString("matricula")%></h3></td>
                                        <td><h3><%=livros.getString("c.copia").replace("-", "")%></h3></td>
                                        <td><h3><%=livros.getString("data_copia")%></h3></td>
                                    </tr>   
                                    <%
                                            regcopia++;
                                            qtdcopia += Integer.parseInt(livros.getString("c.copia"));
                                        }
                                        livros.close();
                                    %>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                    </div> 
                </div>
            </center>

            <div class="row">
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <h3>Total de cópias = <%=String.valueOf(qtdcopia).replace("-", "")%> </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-12 col-sm-12">
                    <h3>Número de registros = <%=regcopia%> </h3>
                </div>
            </div>
        </div>
        <%
                        b.conn.close();
                    } else {
                        response.sendRedirect("copias_mes_ano.jsp");
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }%>
    </body>
</html>
