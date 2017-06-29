<%-- any content can be specified here e.g.: --%>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="sr-only">Toggle navigation</span> 
            <span class="icon-bar"></span>
            <span class="icon-bar"></span> 
            <span class="icon-bar"></span>
        </button>             
    </div>

    <div class="collapse navbar-collapse"
         id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li class="active"><a href="index.jsp">Sistema COAPAC</a></li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    Pegar <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="index.jsp">Livros</a>
                    </li>
                    <li>
                        <a href="pegar_objetos.jsp">Objetos</a>
                    </li>
                </ul>
            </li>
            <li  class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    Relatórios <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="relatorio_emprestimos.jsp" target="_blank">Empréstimos</a></li>
                        <% if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) { %>
                    <li> <a href="relatorio_copia.jsp">Cópias</a> </li>
                        <% } %>
                </ul>
            </li>
            <li><a href="editar_u.jsp">Editar</a></li>
                <% if (session.getAttribute("isaluno").equals("1") || session.getAttribute("isaluno").equals("2")) { %>
            <li  class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    Listas <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li> <a href="livros.jsp">Livros</a> </li>
                    <li> <a href="objetos.jsp">Objetos</a> </li>
                    <li> <a href="usuarios.jsp">Usuarios</a> </li>
                </ul>
            </li>
            <li  class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    Adicionar <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="adicionar_objeto.jsp">Objeto</a>
                    </li>
                    <li>
                        <a href="adicionar_estoque.jsp">Estoque</a>
                    </li>
                    <li>
                        <a href="cadastrar_admin.jsp" target="_blank">Administrador</a>
                    </li>
                </ul>
            </li>
            <li><a href="devolucao.jsp">Devolver</a></li>
                <% } %>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="relatorio_emprestimos.jsp" target="_blank">
                    <%
                        try {
                            out.print(session.getAttribute("nome").toString().split(" ")[0] + " " + session.getAttribute("nome").toString().split(" ")[1]);
                        } catch (Exception e) {
                            out.print(session.getAttribute("nome").toString().split(" ")[0]);
                        }
                    %>
                </a>
            </li>
            <li>
                <form action="login.jsp" method="post">
                    <input style="width: 80px;height: 50px; font-size: 16pt;" type="submit" class="btn btn-xs" value="sair">
                    <input type="hidden" value="sair" name="sair">
                </form>
            </li>
        </ul>

    </div>
</nav>
