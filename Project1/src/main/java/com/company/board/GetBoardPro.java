package com.company.board;

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

import com.company.board.vo.BoardVO;
import com.company.common.JDBCConnection;


@WebServlet("/GetBoardPro")
public class GetBoardPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
  
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/GetBoardPro");
		
		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		
		if (nickname == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
		
		int num=Integer.parseInt(request.getParameter("num"));
		int boardno=Integer.parseInt(request.getParameter("boardno"));
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			// 게시물 조회수 1증가. cnt update
			String sql="update board_ set cnt =(select cnt+1 from board_ where boardno=? and seq=?) where boardno=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, boardno);
			stmt.setInt(2, num);
			stmt.setInt(3, boardno);
			stmt.setInt(4, num);
			stmt.executeUpdate();
			stmt.close();
			
			//해당 게시물 데이터 가져오기
			sql="select * from board_ where boardno=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, boardno);
			stmt.setInt(2, num);
			
			rs=stmt.executeQuery();
			
			BoardVO board=null;
			if(rs.next()) {
				board=new BoardVO();
				board.setSeq(rs.getInt("seq"));
				board.setTitle(rs.getString("title"));
				board.setNickname(rs.getString("nickname"));
				board.setContent(rs.getString("content"));				
				board.setRegdate(rs.getDate("regdate"));
				board.setCnt(rs.getInt("cnt"));
			}
			
			request.setAttribute("board", board);
			request.setAttribute("boardno", boardno);
			
						
			
			RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=getBoard");
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
