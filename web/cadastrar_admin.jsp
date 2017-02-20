<%-- 
    Document   : cadastrar_usuario
    Created on : 29/01/2017, 20:31:18
    Author     : Luan
--%>
<%@page import="login.autenticacao.Login"%>
<%@page import="mysql_bd.Banco"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="imagens/logoP.png" type="image/x-icon" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Página de cadastro do administrador">
        <meta name="author" content="José Luan Silva do Nascimento">

        <title>Apoio Acadêmico</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <link href="css/principal.css" rel="stylesheet">
        <style type="text/css">
            img{
                margin: 25px;
                margin-top: 50px;
            }
            div.container{
                border: 3px solid #5cb85c;
                border-radius: 10px;
                width: 50%;
                padding: 10px 0px 10px 0px;
                margin-bottom: 15px;
                margin-top: 1%;
                -webkit-box-shadow: 8px 9px 5px -3px rgba(18,38,97,0.38);
                -moz-box-shadow: 8px 9px 5px -3px rgba(18,38,97,0.38);
                box-shadow: 8px 9px 5px -3px rgba(18,38,97,0.38);
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
        <form action="cadastrar_aluno.jsp" method="post" class="login">
          <center>
              <br/>
                <div class="container">
                    <div class="form-group">
                        <label><b><h2>Cadastrar Administrador</h2></b></label>
                    </div>
                    <%
                        if (request.getParameter("nome") != null && request.getParameter("senha") != null && request.getParameter("cfsenha") != null) {
                            String nome = request.getParameter("nome");
                            String senha = request.getParameter("senha");
                            String cfsenha = request.getParameter("cfsenha");
                            String matricula = request.getParameter("matricula");
                            Login lg = new Login();
                            if (!senha.equals(cfsenha)) {
                                out.println("<h4>As senhas não correspondem</h4>");
                                if(lg.existUser(matricula)){
                                    out.println("<h4>Usuário já cadastrado</h4>");
                                }
                            }else{
                                if(lg.existUser(matricula)){
                                    out.println("<h4>Usuário já cadastrado</h4>");
                                }else{
                                    Banco b = new Banco();
                                    b.cadastrarUserAdmin(matricula,nome, senha, "1");
                                    b.conn.close();
                                    response.sendRedirect("login.jsp");
                                }   
                            }
                            lg.conn.close();    
                        }
                    %>
                    <div class="form-group">
                        <label><b>Nome</b></label>
                        <input type="text" style="width: 75%" class="form-control" placeholder="Digite o seu nome" name="nome" required>
                    </div>
                    <div class="form-group">
                        <label><b>Matricula</b></label>
                        <input type="number" style="width: 75%" class="form-control" placeholder="Digite sua matricula" name="matricula" required>
                    </div>
                    <div class="form-group">
                        <label><b>Senha</b></label>
                        <input type="password" style="width: 75%" class="form-control" placeholder="Digite a senha" name="senha" required>
                    </div>
                    <div class="form-group">
                        <label><b>Confirmar senha</b></label>
                        <input type="password" style="width: 75%" class="form-control" placeholder="Confirme a senha" name="cfsenha" required>
                    </div>
                </div>
              <input type="submit" style="width: 35%;" class="btn btn-lg btn-success" value="Cadastrar" title="Clique aqui para entrar no sistema" /> 
          </center>
      </form>
    </body>   
</html>