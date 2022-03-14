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

import com.company.board.vo.ReplyBoardVO;
import com.company.common.JDBCConnection;


@WebServlet("/ReplyAjaxGetPro")
public class ReplyAjaxGetPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		// 넘어오는 seq값을 받는다.
		int num=Integer.parseInt(request.getParameter("num"));
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();		
		
			//해당 게시물에 포함되는 답글 리스트를 전송하는 내용을 추가.
		
			
			String sql="select boardseq,seq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from replyboard where boardseq=? order by seq desc";
			
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs=stmt.executeQuery();
			
			ArrayList<ReplyBoardVO> replylist = new ArrayList<ReplyBoardVO>();
			
			while(rs.next()) {
				ReplyBoardVO vo = new ReplyBoardVO();
				vo.setBoardseq(rs.getInt("boardseq"));
				vo.setSeq(rs.getInt("seq"));
				vo.setNickname(rs.getString("nickname"));
				vo.setReply(rs.getString("comments"));
				vo.setRegdate(rs.getString(5));
				
				replylist.add(vo);
			}
			
	

			
			
			request.setAttribute("replylist", replylist);
			
			RequestDispatcher view=request.getRequestDispatcher("getBoard.jsp");
			view.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
		
	}
}
