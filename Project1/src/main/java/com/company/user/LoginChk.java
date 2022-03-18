package com.company.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCConnection;


@WebServlet("/LoginChk")
public class LoginChk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("/LoginChk");
		
	String Id =	request.getParameter("Id");
	String Password = request.getParameter("Password");
		
	System.out.println(Id);
	System.out.println(Password);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	PrintWriter out = response.getWriter();
	
	int  result = 0;
	try {
		conn=JDBCConnection.getConnection();
		String sql = "select * from member where id=? and password=?";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, Id);
		stmt.setString(2, Password);
		rs=stmt.executeQuery();
		
		if(rs.next()) {
			result = 1;// 가입된 아이디/비번 일치하는 경우
		}else {
			result = 0;//일치하는게 없는경우
		}
		System.out.println(result);
		out.write(result + "");
	} catch (ClassNotFoundException e) {
		
		e.printStackTrace();
	} catch (SQLException e) {
	
		e.printStackTrace();
	}finally {
		JDBCConnection.close(rs, stmt, conn);
	}
	
	}

}
