/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mysql_bd;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

/**
 *
 * @author luan
 */
public class Banco {
    private static Statement stmt;
    private static Statement stmt2;
    private ResultSet rs;
    public Connection conn;
    private static final Banco b = new Banco();
    public Banco(){
        String url = "jdbc:mysql://localhost:3306/livrosapoio";
        String usr = "root";
        String pas = "adminadmin";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, usr, pas);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, 
                                        ResultSet.CONCUR_READ_ONLY);
            stmt2 = conn.createStatement();
            System.out.println("Tudo ok, conexão feita!");
          
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Erro: "+e.getMessage());
        }
        
    }
    
    /*adicionando registro*/
    public void addLivro(String nome, String descricao, String volume,String isLivro) throws SQLException{
        String sql = "insert into livro " +
                " (nome,descricao,volume,isLivro) " +
                " values (?,?,?,?)";
        try (PreparedStatement stmtlocal = conn.prepareStatement(sql)) {
            stmtlocal.setString(1, nome);
            stmtlocal.setString(2, descricao);
            stmtlocal.setString(3, volume);
            stmtlocal.setString(4, isLivro);
            
            stmtlocal.execute();
        }
    }
    public void addEntrega(String id_aluno,String id_livro) throws SQLException{
                //venda
                String sql = "insert into entrega (id_aluno,id_livro,data_ent,nome_livro,volume_livro,descricao_livro) "
                           + " values (?,?,?,?,?,?)";
                Calendar c = Calendar.getInstance();
                String data = c.get(Calendar.YEAR)+"-"+(c.get(Calendar.MONTH)+1)+"-"+c.get(Calendar.DAY_OF_MONTH);
                
                PreparedStatement stmtlocal = conn.prepareStatement(sql);
                ResultSet rs = selectLivroOfId(id_livro);
                String nome = "";
                String volume = "";
                String descricao = "";
                while(rs.next()){
                    nome = rs.getString("nome");
                    volume = rs.getString("volume");
                    descricao = rs.getString("descricao");
                }
                stmtlocal.setString(1, id_aluno);
                stmtlocal.setString(2, id_livro);
                stmtlocal.setString(3, data);
                stmtlocal.setString(4, nome);
                stmtlocal.setString(5, volume);
                stmtlocal.setString(6, descricao);

                stmtlocal.execute();
                stmtlocal.close();

                // estoque
                sql = "update estoque "
                    + " set quantidade = quantidade - ?"
                    + " where id_l_est = ?";
                stmtlocal = conn.prepareStatement(sql);
                stmtlocal.setString(1, "1");
                stmtlocal.setString(2, id_livro);
                
                stmtlocal.execute();
                stmtlocal.close();
            
    }
    public void addPEstoque(String id_livro,String quantidade) throws SQLException{
            if (produtoExisteEstoque(id_livro)) {
                ResultSet prodvenda = selectAllProdutoofId(id_livro);
                        String sql = "update estoque "
                                   + " set quantidade = quantidade + ?"
                                   + " where id_l_est = ?";
                        PreparedStatement stmtlocal = conn.prepareStatement(sql);

                        stmtlocal.setString(1, quantidade);
                        stmtlocal.setString(2, id_livro);

                        stmtlocal.execute();
                        stmtlocal.close();
                }else{
                ResultSet prodvenda = selectAllProdutoofId(id_livro);
                        String sql = "insert into estoque (id_l_est,quantidade) values " +
                                       " (?,?)";
                        PreparedStatement stmtlocal = conn.prepareStatement(sql);

                        stmtlocal.setString(1, id_livro);
                        stmtlocal.setString(2, quantidade);

                        stmtlocal.execute();
                        stmtlocal.close();
                }
        }
 
    
    /*Todos os selects*/
    public ResultSet selectAll() throws SQLException{
        String sql = "select * from  livro";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllLivro() throws SQLException{
        String sql = "select * from  livro where isLivro = 1";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllObjeto() throws SQLException{
        String sql = "select * from  livro where isLivro = 0";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllLivroofEstoque() throws SQLException{
        String sql = "select * from livro l inner join estoque est on (l.id = est.id_l_est)"
                + " where isLivro = 1";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllObjetoofEstoque() throws SQLException{
        String sql = "select * from livro l inner join estoque est on (l.id = est.id_l_est)"
                + " where isLivro = 0";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllLivroofEstoqueIdUser(String id_aluno) throws SQLException{
        String sql = "select * from livro l RIGHT outer join entrega e on (l.id=e.id_livro) left outer join usuario u on (e.id_aluno=u.id) " +
                     " where id_aluno = "+id_aluno+
                     " order by data_ent";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectAllofEstoque() throws SQLException{
        String sql = "select * from livro l RIGHT outer join entrega e on (l.id=e.id_livro) left outer join usuario u on (e.id_aluno=u.id) " +
                     " order by data_ent";
        return stmt.executeQuery(sql);
    }
    public ResultSet selectQtdLivroofEstoqueIdUser(String id_aluno) throws SQLException{
        String sql = "select count(id) from entrega "
                   + " id_aluno = "+id_aluno;
        return stmt.executeQuery(sql);
    }
    public ResultSet selectLivroOfId(String id) throws SQLException{
        String sql = "select l.id, l.nome, l.descricao, l.volume, est.quantidade from livro l inner join estoque est " +
                     "on (l.id = est.id_l_est)"
                    +"where l.id = "+id;
        return stmt.executeQuery(sql);
    }
    public ResultSet selectUsuarioOfId(String id) throws SQLException{
        String sql = "select * from usuario "
                    +"where id = "+id;
        return stmt.executeQuery(sql);
    }
    public static ResultSet selectAllProdutoofId(String id) throws SQLException{
        String sql = "select * from livro l"
                    +" where l.id = "+id;
        return stmt.executeQuery(sql);
    }
    public ResultSet selectProdutoofId(String id) throws SQLException{
        String sql = "select * from livro l"
                    +" where l.id = "+id;
        return stmt.executeQuery(sql);
    }
    public int selectqtdProdutos() throws SQLException{
        String sql = "select count(id) qtd from livro";
        ResultSet rs2 = stmt.executeQuery(sql);
        while(rs2.next()){
            return rs2.getInt("qtd");
        }
        return 0;
    }
    public int selectqtdProdutosofEstoque() throws SQLException{
        String sql = "select sum(est.quantidade) soma from livro l inner join estoque est on (l.id = est.id_p_est)";
        ResultSet rs2 = stmt.executeQuery(sql);
        while(rs2.next()){
            return rs2.getInt("soma");
        }
        return 0;
    }
    public int selectqtdEntLivro() throws SQLException{
        String sql = "select count(id) qtd from entrega";
        ResultSet rs2 = stmt2.executeQuery(sql);
        while(rs2.next()){
            return rs2.getInt("qtd");
        }
        return 0;
    }
    public String selectNomeUserOfId(String id) throws SQLException{
        String sql = "select nome from usuario where id = "+id;
        ResultSet rs2 = stmt2.executeQuery(sql);
        while(rs2.next()){
            return rs2.getString("nome");
        }
        return null;
    }
    public ResultSet selectVenda(String id) throws SQLException{
        String sql = "select l.nome, l.volume, e.quantidade, l.descricao, DATE_FORMAT(e.data, '%d/%m/%Y') as data" +
                     " from livro l right outer join entrega e on (l.id = e.id_livro) "
                   + " where e.id_aluno = "+id
                   + " order by e.data";
        return stmt.executeQuery(sql);
    }  
    /*Verificadores de registro*/
    public static boolean produtoExisteEstoque(String id) throws SQLException{
        String sql2 = "select id from estoque "
                    + " where id_l_est = "+id;
        ResultSet estp = stmt.executeQuery(sql2);
        while (estp.next()) {
             return true;
        }
        return false;
    }
    public static boolean produtoExisteVenda(String id) throws SQLException{
        String sql2 = "select id from entrega "
                    + " where id_p_cp = "+id;
        ResultSet estp = stmt.executeQuery(sql2);
        while (estp.next()) {
            return true;
        }
        return false;
    }
    /*Excluindo Registros*/ 
    public void excluirProduto(String id) throws SQLException{
        //excluir venda
        String sql = "DELETE FROM entrega WHERE id_livro = ?";
        PreparedStatement stmtlocal = conn.prepareStatement(sql);

        stmtlocal.setString(1, id);
        stmtlocal.execute();
        stmtlocal.close();
        //excluir estoque
        sql = "DELETE FROM estoque WHERE id_l_est = ?";
        stmtlocal = conn.prepareStatement(sql);

        stmtlocal.setString(1, id);
        stmtlocal.execute();
        stmtlocal.close();
        
        //excluir produto
        sql = "DELETE FROM livro WHERE id = ?";
        stmtlocal = conn.prepareStatement(sql);

        stmtlocal.setString(1, id);
        stmtlocal.execute();
        stmtlocal.close();
    }
    public void deleteEntregaOfId(String id) throws SQLException{
        String sql = "delete from entrega where id = "+id;
        stmt.executeUpdate(sql);
    }
    /*Todos os Alteradores*/
    public void alterarLivro(String id, String nome, String descricao) throws SQLException{
        String sql = "update livro "
                   + " set nome = ?, descricao = ? "
                   + " where id = ?";
        PreparedStatement stmtlocal = conn.prepareStatement(sql);
        stmtlocal = conn.prepareStatement(sql);

        stmtlocal.setString(1, nome);
        stmtlocal.setString(2, descricao);
        stmtlocal.setString(3, id);
        stmtlocal.execute();
        stmtlocal.close();
    }
    /* Cadastros de usuarios e administradores*/
    public void cadastrarUserAdmin(String matricula,String nome,String senha, String isaluno) throws SQLException{
        String sql = "insert into usuario (matricula,nome,senha,isaluno) values " +
                     "(?,?,?,?);";
        PreparedStatement stmtlocal = conn.prepareStatement(sql);
        stmtlocal = conn.prepareStatement(sql);

        stmtlocal.setString(1, matricula);
        stmtlocal.setString(2, nome);
        stmtlocal.setString(3, senha);
        stmtlocal.setString(4, isaluno);
        stmtlocal.execute();
        stmtlocal.close();
    }
}