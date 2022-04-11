package com.company.board;

import java.io.IOException;
import java.io.PrintWriter;
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
       
    
  

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("/DeleteBoardPro");
		PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		System.out.println(nickname);
	
		
		if(nickname==null) {
			response.sendRedirect("index.jsp?filePath=login");
			return; //함수의 리턴의 의미는 함수의 값을 반환과 함수의 종료를 의미.
		}
		
		
		String boardtype = request.getParameter("boardtype");
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		System.out.println(boardtype);
		System.out.println(seq);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		
		try {
			conn=JDBCConnection.getConnection();
			String sql="delete from board_ where seq=? and boardtype=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			stmt.setString(2, boardtype);
			
			int result = 0;
			
			int cnt=stmt.executeUpdate();
			
			if (cnt != 0) {
				System.out.println(cnt+"개 삭제완료");
				result = 1; // 댓글 입력완료.
			} else {
				result = 0;// 실패
			}
			out.write(result + "");
				
//				response.sendRedirect("GetBoardListPro?boardtype="+boardtype);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	
	}
	

}
