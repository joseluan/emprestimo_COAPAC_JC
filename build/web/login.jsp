<%@page import="metodos_conexao.Banco"%>
<%@page import="login_conexao.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="imagens/logoP.jpg" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Tela de login">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-LOGIN</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <link href="css/autenticacao.css" rel="stylesheet">
        <style type="text/css">
            @media screen and (max-width: 992px){
                img#logo{
                    width: 100%;
                }
            }
            @media screen and (min-width: 992px){
                div.container{
                    width: 40%;
                }
            }
            label{
                color: #5cb85c;
            }
            h3{
                float: left;
                margin-left: 50px; 
            }
            h4{
                color: #d9534f;
            }
            input#botao{
                margin-bottom: 3%;
                width: 150px;
                height: 75px;
                margin: 0px;
                margin-bottom: 5%;
                font-size: 18pt;
            }
            b:hover{
                color: #3a963a;
            }
        </style>
    </head>
    <body>
        <%
            if (request.getParameter("sair") != null) {
                session.removeAttribute("login");
                session.removeAttribute("nivel");
                session.removeAttribute("id");
                session.removeAttribute("nome");
            }
            if (session.getAttribute("login") == null) {
        %>

        <div class="container">
            <form action="login.jsp" method="POST" class="login">
                <center>  
                    <img id="logo" src="imagens/logo.png" title="Logo do Instituto Federal de Educação, Ciência e Tecnologia Rio Grande do Norte, Campus João Câmara">
                    <br/>
                    <label><b>COAPAC - Login</b></label>
                    <div class="row">
                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                            <label><b>Matricula</b></label>
                            <input type="number" style="width: 95%" class="form-control" placeholder="Digite sua matricula" name="login" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-lg-12 col-md-12 col-sm-12">
                            <label><b>Senha</b></label>
                            <input type="password" min="8" style="width: 95%" class="form-control" placeholder="Digite a senha" name="senha" required>
                        </div>
                    </div>
                    <%
                        String login = request.getParameter("login");
                        String senha = request.getParameter("senha");
                        if (login != null && senha != null) {
                            Login lg = new Login();
                            Banco b = new Banco();
                            String vfsenha = lg.getSenha(login);

                            if (senha.equals(vfsenha)) {
                                String nivel = lg.getNivel(login);

                                session.setAttribute("login", login);
                                session.setAttribute("isaluno", nivel);
                                session.setAttribute("id", lg.selectIdOfMatSen(login));
                                session.setAttribute("nome", b.selectNomeUserOfId(lg.selectIdOfMatSen(login)));
                                session.setMaxInactiveInterval(300);

                                response.sendRedirect("index.jsp");
                            } else {
                                out.println("<h4>Senha ou Login incorretos !</h4>");
                            }
                            lg.conn.close();
                            b.conn.close();
                        }
                    %>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <h3>
                                <b>
                                    <a style="color: #3a963a;" 
                                       href="cadastrar_aluno.jsp" 
                                       target="_blank" 
                                       title="Clique aqui para cadastrar um usuário">
                                        Cadastrar um usuário
                                    </a>
                                </b>
                            </h3>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <h3>
                                <b>
                                    <a style="color: #3a963a;"
                                       href="recuperar_senha.jsp"
                                       target="_blank"
                                       title="Clique aqui para recuperar sua senha">
                                        Esqueceu a senha?
                                    </a>
                                </b>
                            </h3>
                        </div>
                    </div>    
                     
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <input type="submit" id="botao" class="btn btn-md btn-success" value="Entrar" title="Clique aqui para entrar no sistema" /> 
                        </div>
                    </div>
                </center>
            </form>
        </div>
        <%
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>   
</html>