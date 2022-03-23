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

import com.company.common.JDBCConnection;


@WebServlet("/ReplyUpdateAjaxPro")
public class ReplyUpdateAjaxPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/ReplyUpdateAjaxPro");
	
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");	
		int seq=Integer.parseInt(request.getParameter("seq"));
		String boardtype = request.getParameter("boardtype");
		int boardseq=Integer.parseInt(request.getParameter("boardseq"));		
		String reply=request.getParameter("replytext");
		
		
				
		

		System.out.println(seq);
		System.out.println(boardtype);		
		System.out.println(boardseq);
		System.out.println(reply);
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		
		int result = 0;
		try {
			conn=JDBCConnection.getConnection();
			String sql="update replyboard_ set reply=? where seq=? and boardtype=? and boardseq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, reply);
			stmt.setInt(2, seq);
			stmt.setString(3, boardtype);
			stmt.setInt(4, boardseq);
			
			int cnt=stmt.executeUpdate();
			
			if (cnt != 0) {
				result = 1; // 댓글 입력완료.
			} else {
				result = 0;// 실패
			}
			out.write(result + "");
			
						
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(stmt, conn);
		}
	}
		
	

}
