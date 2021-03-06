package login_conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Login {

    private static Statement stmt;
    public Connection conn;

    public Login() {
        String url = "jdbc:mysql://localhost:3306/livrosapoio";
        String usr = "root";
        String pas = "adminadmin";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, usr, pas);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            System.out.println("Tudo ok, conexão feita!");

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Erro: " + e.getMessage());
        }

    }

    public String efetuarLogin(String login, String senha2) throws SQLException {
        String sql = "select * from usuario  where matricula = '" + login + "' and senha = '" + senha2 + "'";
        ResultSet log = stmt.executeQuery(sql);
        while (log.next()) {
            if (log.getString("matricula") != null || !"".equals(log.getString("login")) || log.getString("senha") != null) {
                return "1";
            }
        }
        stmt.close();
        return "0";
    }

    public String getSenha(String login) throws SQLException {
        String sql = "select senha from usuario where matricula = '" + login + "'";
        ResultSet rslocal = stmt.executeQuery(sql);
        String senha = "";
        while (rslocal.next()) {
            senha = rslocal.getString("senha");
        }
        return senha;
    }

    public String getNivel(String login) throws SQLException {
        String sql = "select isaluno from usuario where matricula = '" + login + "'";
        ResultSet rslocal = stmt.executeQuery(sql);
        String nivel = "";
        while (rslocal.next()) {
            nivel = rslocal.getString("isaluno");
        }
        return nivel;
    }

    public boolean existUser(String matricula) throws SQLException {
        String sql = "select * from usuario where matricula = " + matricula;
        ResultSet rslocal = stmt.executeQuery(sql);
        while (rslocal.next()) {
            return true;
        }
        return false;
    }

    public boolean verificaUser(String matricula, String email) throws SQLException {
        String sql = "select id from usuario where matricula = " + matricula
                + " and email = '" + email + "'";
        ResultSet rslocal = stmt.executeQuery(sql);
        while (rslocal.next()) {
            return true;
        }
        return false;
    }

    public String selectIdOfMatSen(String matricula) throws SQLException {
        String sql = "select id from usuario "
                + " where matricula = " + matricula;
        ResultSet rsId = stmt.executeQuery(sql);
        while (rsId.next()) {
            return rsId.getString("id");
        }
        return null;
    }
}
