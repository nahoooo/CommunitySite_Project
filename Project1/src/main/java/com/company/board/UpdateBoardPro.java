package com.company.board;

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


@WebServlet("/UpdateBoardPro")
public class UpdateBoardPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/UpdateBoardPro");
	
		
		request.setCharacterEncoding("utf-8");
		int seq=Integer.parseInt(request.getParameter("seq"));
		String boardtype=request.getParameter("boardtype");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String nickname=request.getParameter("nickname");
		
		
		
		System.out.println(seq);
		System.out.println(boardtype);
		System.out.println(title);
		System.out.println(content);
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="update board_ set title=?,content=?,nickname=? where seq=? and boardtype=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setString(3, nickname);
			stmt.setInt(4, seq);
			stmt.setString(5, boardtype);
			
			int cnt=stmt.executeUpdate();
			if(cnt!=0) response.sendRedirect("GetBoardPro?seq="+seq+"&boardtype="+boardtype);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}

}
