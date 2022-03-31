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
import com.company.board.vo.RestaurantVO;
import com.company.common.JDBCConnection;


@WebServlet("/TasteMap")
public class TasteMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
System.out.println("/GetBoardPro");
		
		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		
		if (nickname == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
		
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			
		
			
			
			
			//해당 게시물 데이터 가져오기
			String sql="select seq,restaurantname,placeLa,placeLO,title,nickname from recommend_R where placeLa is not null and placeLO is not null";
			stmt=conn.prepareStatement(sql);
			
			
			rs=stmt.executeQuery();
			
			ArrayList<RestaurantVO> restaurantList=new ArrayList<RestaurantVO>();
			
			RestaurantVO restaurant =null;
			while(rs.next()) {
				restaurant=new RestaurantVO();
				restaurant.setSeq(rs.getInt("seq"));		
				restaurant.setRestaurantname(rs.getString("restaurantname"));
				restaurant.setPlaceLa(rs.getString("placeLa"));
				restaurant.setPlaceLO(rs.getString("placeLO"));
				restaurant.setTitle(rs.getString("title"));
				restaurant.setNickname(rs.getString("nickname"));
				restaurantList.add(restaurant);
				System.out.println("등록");
				
				
			}
			
			request.setAttribute("restaurantList", restaurantList);
			
			
			/*
			 * //해당 게시물에 포함되는 답글 리스트를 전송하는 내용을 추가. stmt.close(); rs.close();
			 * 
			 * sql="select boardseq,seq,boardtype,nickname,reply,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from replyboard_ where boardseq=? and boardtype=? order by seq desc"
			 * ;
			 * 
			 * stmt=conn.prepareStatement(sql); stmt.setInt(1, seq); stmt.setString(2,
			 * boardtype); rs=stmt.executeQuery();
			 * 
			 * ArrayList<ReplyBoardVO> replylist = new ArrayList<ReplyBoardVO>();
			 * 
			 * int comment_cnt = 0;
			 * 
			 * while(rs.next()) { ReplyBoardVO vo = new ReplyBoardVO();
			 * vo.setBoardseq(rs.getInt("boardseq")); vo.setSeq(rs.getInt("seq"));
			 * vo.setBoardtype(rs.getString("boardtype"));
			 * vo.setNickname(rs.getString("nickname")); vo.setReply(rs.getString("reply"));
			 * vo.setRegdate(rs.getString(6)); replylist.add(vo); comment_cnt++;
			 * System.out.println("댓글 리스트 "); } request.setAttribute("replylist",
			 * replylist);
			 * 
			 * stmt.close(); rs.close();
			 * 
			 * //게시판 게시글 댓글 수 업데이트
			 * sql="update board_ set comment_cnt =? where boardtype=? and seq=?";
			 * stmt=conn.prepareStatement(sql); stmt.setInt(1, comment_cnt);
			 * stmt.setString(2, boardtype); stmt.setInt(3, seq); stmt.executeUpdate();
			 * stmt.close();
			 */
			
			RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=tasteMap");
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
