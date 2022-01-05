package cdac.in.suchana;

import java.util.*;
import java.io.*;
import java.sql.*;

class DbConnect{
	
	String dbURL = null;
	String dbUname = null;
	String dbPassword = null;
	static Connection connection = null;

	DbConnect(){
		try{
			Properties prop = new Properties();
			prop.load(getClass().getResourceAsStream("config.properties"));

			dbURL = prop.getProperty("dburl").trim();
			dbUname = prop.getProperty("dbuname").trim();
			dbPassword = prop.getProperty("dbpasswd").trim();

			//System.err.println( dbURL+", "+dbUname+", "+dbPassword);


		}catch(Exception e){
			e.printStackTrace();
		}

	}

	Connection getConnection(){


		try{
			if( connection == null ){	
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(dbURL, dbUname, dbPassword);
			}
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		return connection;
	}

	void close(){

		try{
			if( connection != null ){
				connection.close();
			}

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connection = null;
		}
	}

	public static void main(String[] args){
		DbConnect dbc = new DbConnect();
		Connection conn = dbc.getConnection();
		System.out.println( conn );
		dbc.close();
	}
}
