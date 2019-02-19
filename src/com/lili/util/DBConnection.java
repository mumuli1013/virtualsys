package com.lili.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lili
 *2019年1月31日
 * JAVABEAN连接
 */
public class DBConnection {
	public Connection conn;
	public Statement st;
	public ResultSet rs;
	public Connection getConn() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vcdb", "root", "961013");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
     
    public String getUsername(Integer userId){
        String sql = "select username from User where id="+userId;
        conn = getConn();
        String username = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()){
                username = rs.getString("username");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return username;
    }
    
    public String getGameName(Integer gameId)
    {
    	String sql = "select name from game_info where id="+gameId;
        conn = getConn();
        String gamename = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()){
            	gamename = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return gamename;
    }
    public String getGameUserName(Integer gameUserId)
    {
    	String sql = "select name from game_user where id="+gameUserId;
        conn = getConn();
        String gusername = null;
        try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()){
                gusername = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return gusername;
    }
    
    public String getGameClass(Integer gcId)
    {
    	String sql = "select game_cname from game_class where id="+gcId;
    	conn = getConn();
    	String gameCname = null;
    	try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()){
            	gameCname = rs.getString("game_cname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	return gameCname;
    }
    public int findGUCountByGId(int gameId) {
    	String sql = "select count(*) GuserNum from game_user where game_id="+gameId;
    	conn = getConn();
    	int GuserNum = 0;
    	try {
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()){
            	GuserNum = rs.getInt("GuserNum");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	return GuserNum;
    }
}
