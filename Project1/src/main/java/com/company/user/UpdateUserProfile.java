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
import javax.servlet.http.HttpSession;

import com.company.common.JDBCConnection;

@WebServlet("/UpdateUserProfile")
public class UpdateUserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println("/UpdateUserProfile");
	
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		
		HttpSession session=request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		System.out.println(sessionID);
		
		if (sessionID == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}

		System.out.println(nickname);
		System.out.println(email);
		
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "update member set nickname=?, email=? where id=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, nickname);
			stmt.setString(2, email);
			stmt.setString(3, sessionID);


			int cnt = stmt.executeUpdate();
			if (cnt != 0)
				session.removeAttribute("nickname"); 
				session.setAttribute("nickname", nickname);
				response.sendRedirect("UserProfile");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(stmt, conn);
		}
	}
}
