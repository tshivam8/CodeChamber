package com.connections;
import java.sql.*;

public class Connections 
{
    static Connection c;
    static Statement st;
    public static Statement makeConnection()
    {
        try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        c=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306","sahuamit127","y5SRo2N20O#@");
        st=c.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        }catch(Exception e)
        {
            System.out.println("makeConnection : "+e);
        }
        return st;
    }
    public static void closeConnection()
    {
        try{
        st.close();
        c.close();
        }catch(Exception e)
        {
        	System.out.println("closeConnection : "+e);
        }
    }
}
