package com.company.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCConnection;

@WebServlet("/JoinPro")
public class JoinPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn=JDBCConnection.getConnection();
			String sql ="insert into member(id,nickname,email,password) values(?,?,?,?)";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, nickname);
			stmt.setString(3, email);
			stmt.setString(4, password);
			
			int cnt = stmt.executeUpdate();
			System.out.println(cnt+"개 등록되었습니다.");
			
			response.sendRedirect("index.jsp?filePath=login");
			
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
	}

}
