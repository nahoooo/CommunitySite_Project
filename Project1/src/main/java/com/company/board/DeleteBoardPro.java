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


@WebServlet("/DeleteBoardPro")
public class DeleteBoardPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("/DeleteBoardPro");
		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		System.out.println(nickname);
		
		if(nickname==null) {
			response.sendRedirect("index.jsp?filePath=login");
			return; //함수의 리턴의 의미는 함수의 값을 반환과 함수의 종료를 의미.
		}
		
		
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="delete from board_ where seq=? and boardno=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			stmt.setInt(2, boardno);
			
			int cnt=stmt.executeUpdate();
			
			if(cnt!=0)
				System.out.println(cnt+"개 삭제");
				
				response.sendRedirect("GetBoardListPro?boardno="+boardno);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	
	}


	
	
	
	
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
