/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elit2.app.control;

import com.elit2.app.model.Alternativa;
import com.elit2.app.model.Questao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Marco Aurélio
 */
public class AlternativaDAO {

    Connection con;
    Statement stmt;
    ResultSet rs;

    public ArrayList<Alternativa> getAlternativas(Questao questao) throws Exception {
        String sql = "SELECT * FROM tb_altern WHERE tb_quest_cd_quest=" + questao.getCd_questao();
        con = new OracleConnector().getConnection();
        stmt = con.createStatement();
        rs = stmt.executeQuery(sql);
        ArrayList<Alternativa> alters = new ArrayList<Alternativa>();
        while (rs.next()) {
            Alternativa alter = new Alternativa(rs.getInt("cd_alternativa"), rs.getString("ds_alternativa"));
            alters.add(alter);
        }
        con.close();
        stmt.close();
        rs.close();
        return alters;
    }

    public int setAlternativa(Questao questao, Alternativa alter) throws Exception {
        con = new OracleConnector().getConnection();
        stmt = con.createStatement();
        int result = stmt.executeUpdate("INSERT INTO tb_altern VALUES (" + alter.getCd_alternativa() + ",'" + alter.getDs_alternativa() + "'," + questao.getCd_questao() + ")");
        return result;
    }

    public int updAlternativa(Alternativa alter) throws Exception {
        con = new OracleConnector().getConnection();
        stmt = con.createStatement();
        int result = stmt.executeUpdate("UPDATE tb_altern SET ds_altern='" + alter.getDs_alternativa() + "' WHERE cd_altern=" + alter.getCd_alternativa());
        return result;
    }

    public int delAlternativa(Alternativa alter) throws Exception {
        con = new OracleConnector().getConnection();
        stmt = con.createStatement();
        int result = stmt.executeUpdate("DELETE FROM tb_altern WHERE cd_altern=" + alter.getCd_alternativa());
        return result;
    }

    public int getAlternativaSequence() throws Exception {
        String sql = "SELECT COUNT(*) FROM tb_altern";
        con = new OracleConnector().getConnection();
        stmt = con.createStatement();
        rs = stmt.executeQuery(sql);
        int contador = 0;
        while (rs.next()) {
            contador = Integer.parseInt(rs.getString("COUNT(*)")) + 1;
        }
        return contador;
    }

}
