package com.company.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCConnection;

@WebServlet("/LoginPro")
public class LoginPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println("/LoginPro");
		String id = request.getParameter("Id");
		String saveid = request.getParameter("saveid");
		
		Cookie cookie = new Cookie("userId", id);// 일단 쿠키 생성

		System.out.println(saveid);
		
		if (saveid!=null) { // 체크박스 체크여부에 따라 쿠키 저장 확인
			// 체크박스 체크 되었을 때
			// 쿠키 저장
			response.addCookie(cookie);
		} else {
			// 체크박스 체크 해제되었을 때
			// 쿠키 유효시간 0으로 해서 브라우저에서 삭제하게 한다.
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="select nickname,userprofile from member where id=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs=stmt.executeQuery();
			if(rs.next()) {
				String nickname = rs.getString(1);
				String userProfile = rs.getString(2);
				HttpSession session=request.getSession();
				System.out.println(nickname);
				System.out.println(userProfile);
				session.setAttribute("nickname", nickname);
				session.setAttribute("userProfile", userProfile);
				response.sendRedirect("index.jsp");
			}else {
			
				response.sendRedirect("login.jsp");
			}
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} catch (SQLException e) {			
			e.printStackTrace();
		}


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
