
package com.elit2.app.control;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class OracleConnector {

    private String servername;
    private String login; 
    private String senha; 
    
    public OracleConnector(){
        this.servername = "valmirsl.no-ip.org";
        this.login = "hr";
        this.senha = "hr";
    }
    
    public OracleConnector(String servername,String login, String senha){
        this.servername = servername;
        this.login = login;
        this.senha = senha;
    }
    
    public Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@" + this.servername + ":1521:XE";
        return DriverManager.getConnection(url, this.login, this.senha);
    }

   
    public int executeStatement(String sql) throws Exception {
        Exception e = null;
        int result = 0;

        Connection con = null;
        Statement stmt = null;

        try {
            con = getConnection();
            stmt = con.createStatement();
            result = stmt.executeUpdate(sql);
        } catch (Exception ex) {
            e = ex;
        } finally {
            try {
                stmt.close();
            } catch (Exception ex2) {
            }
            try {
                con.close();
            } catch (Exception ex2) {
            }
        }
        if (e != null) {
            throw e;
        }
        return result;
    }

    public ArrayList<Object[]> getQuery(String sql) throws Exception {
        Exception e = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<Object[]> result = null;
        try {
            con = getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            result = new ArrayList<Object[]>();
            while (rs.next()) {
                Object[] reg = new Object[rs.getMetaData().getColumnCount()];
                for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
                    reg[i] = rs.getObject(i + 1);
                }
                result.add(reg);
            }
        } catch (Exception ex) {
            e = ex;
        } finally {
            try {
                rs.close();
            } catch (Exception ex2) {
            }
            try {
                stmt.close();
            } catch (Exception ex2) {
            }
            try {
                con.close();
            } catch (Exception ex2) {
            }
        }

        if (e != null) {
            throw e;
        }
        return result;
    }
}
