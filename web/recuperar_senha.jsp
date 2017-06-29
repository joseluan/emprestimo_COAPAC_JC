<%@page import="login_conexao.Login"%>
<%@page import="metodos_conexao.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Página para recuperar a senha do usuário">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>COAPAC-RECUPERAR</title>

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
            label{
                color: #5cb85c;
            }
            h4{
                color: #d9534f;
            }
            b:hover{
                color: #3a963a;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form action="recuperar_senha.jsp" method="POST" class="login">
                <center>
                    <img id="logo" src="imagens/logo.png" title="Logo do Instituto Federal de Educação, Ciência e Tecnologia Rio Grande do Norte, Campus João Câmara">
                    <div class="form-group">
                        <label><b><h2>Recuperar senha</h2></b></label>
                    </div>
                    <%
                        if (request.getParameter("email") != null && request.getParameter("matricula") != null && request.getParameter("cfsenha") != null) {
                            String senha = request.getParameter("senha");
                            String cfsenha = request.getParameter("cfsenha");
                            String matricula = request.getParameter("matricula");
                            String email = request.getParameter("email");
                            Login lg = new Login();
                            if (!senha.equals(cfsenha)) {
                                out.println("<h4>As senhas não correspondem</h4>");
                                if (!lg.verificaUser(matricula, email)) {
                                    out.println("<h4>Usuário não cadastrado</h4>");
                                }
                            } else {
                                if (lg.verificaUser(matricula, email)) {
                                    Banco b = new Banco();
                                    b.alterarSenhaAdminUser(matricula, senha);
                                    b.conn.close();
                                    response.sendRedirect("login.jsp");
                                } else {
                                    out.println("<h4>Usuário não cadastrado</h4>");
                                }
                            }
                            lg.conn.close();
                        }
                    %>
                    <div class="row">
                        <div class="form-group col-lg-6 col-md-6 col-sm-12">
                            <label><b>Matricula</b></label>
                            <input type="number" class="form-control" placeholder="Digite sua matricula" name="matricula" required>
                        </div>
                        <div class="form-group col-lg-6 col-md-6 col-sm-1">
                            <label><b>E-mail</b></label>
                            <input type="email" class="form-control" placeholder="Digite seu e-mail" name="email" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-lg-6 col-md-6 col-sm-1">
                            <label><b>Nova Senha</b></label>
                            <input type="password" min="8" class="form-control" placeholder="Digite a senha" name="senha" required>
                        </div>
                        <div class="form-group col-lg-6 col-md-6 col-sm-1">
                            <label><b>Confirmar senha</b></label>
                            <input type="password" min="8" class="form-control" placeholder="confirme a senha" name="cfsenha" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <input type="submit" id="botao" class="btn btn-lg btn-success" value="Atualizar" title="Clique aqui para atualizar a sua senha" /> 
                        </div>
                    </div>
                </center>
            </form>
        </div> 
    </body>   
</html>