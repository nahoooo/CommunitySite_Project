package com.company.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCConnection;
import com.company.user.vo.UserVO;


@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
   

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/UserProfile");
		
		

		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		
		if (nickname == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
		System.out.println(nickname);
		
		Connection conn=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql = "select * from member where nickname=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, nickname);
			
			rs=stmt.executeQuery();
			
			UserVO user = null;
			if(rs.next()) {
				user = new UserVO();
				user.setId(rs.getString("id"));
				user.setNickname(rs.getString("nickname"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setRegist_date(rs.getDate("regist_date"));
				user.setGrade(rs.getString("grade"));
				user.setUserprofile(rs.getString("userprofile"));
			}
			
			request.setAttribute("user", user);
			RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=userProfile");
			view.forward(request, response);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
