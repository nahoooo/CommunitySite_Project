package com.company.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.board.vo.BoardVO;
import com.company.board.vo.ReplyBoardVO;
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
		
		int seq=Integer.parseInt(request.getParameter("seq"));
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
			stmt.setInt(2, seq);
			stmt.setInt(3, boardno);
			stmt.setInt(4, seq);
			stmt.executeUpdate();
			stmt.close();
			
			//해당 게시물 데이터 가져오기
			sql="select * from board_ where boardno=? and seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, boardno);
			stmt.setInt(2, seq);
			
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
			
			//해당 게시물에 포함되는 답글 리스트를 전송하는 내용을 추가.
			stmt.close();
			rs.close();
			
			sql="select boardseq,seq,boardno,nickname,reply,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from replyboard_ where boardseq=? and boardno=? order by seq desc";
			
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			stmt.setInt(2, boardno);
			rs=stmt.executeQuery();
			
			ArrayList<ReplyBoardVO> replylist = new ArrayList<ReplyBoardVO>();
			
			while(rs.next()) {
				ReplyBoardVO vo = new ReplyBoardVO();
				vo.setBoardseq(rs.getInt("boardseq"));
				vo.setSeq(rs.getInt("seq"));
				vo.setBoardno(rs.getInt("boardno"));
				vo.setNickname(rs.getString("nickname"));
				vo.setReply(rs.getString("reply"));
				vo.setRegdate(rs.getString(6));
				
				replylist.add(vo);
				System.out.println("댓글 리스트 ");
			}		
			request.setAttribute("replylist", replylist);
								
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
