package com.company.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
import com.company.board.vo.RestaurantVO;
import com.company.common.JDBCConnection;


@WebServlet("/GetRestaurantPro")
public class GetRestaurantPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
   

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("/GetRestaurantPro");
		
		HttpSession session=request.getSession();
		String nickname=(String)session.getAttribute("nickname");
		
		if (nickname == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=JDBCConnection.getConnection();
			// 게시물 조회수 1증가. cnt update
			String sql="update recommend_R set cnt =(select cnt+1 from recommend_R where seq=?) where seq=?";
			stmt=conn.prepareStatement(sql);

			stmt.setInt(1, seq);
			stmt.setInt(2, seq);			
			stmt.executeUpdate();
			stmt.close();
						
			
			//해당 게시물 데이터 가져오기
			sql="select * from recommend_R where seq=?";
			stmt=conn.prepareStatement(sql);		
			stmt.setInt(1, seq);
			
			rs=stmt.executeQuery();
			
			RestaurantVO restaurant=null;
			if(rs.next()) {
				restaurant=new RestaurantVO();
										
				restaurant.setSeq(rs.getInt("seq"));
				restaurant.setNickname(rs.getString("nickname"));
				restaurant.setTitle(rs.getString("title"));
				restaurant.setRestaurantname(rs.getString("restaurantname"));
				restaurant.setRestaurantaddr(rs.getString("restaurantaddr"));
				restaurant.setOnelinereview(rs.getString("onelinereview"));
				restaurant.setTel(rs.getString("tel"));
				restaurant.setOpeninghours(rs.getString("openinghours"));
				restaurant.setParking(rs.getString("parking"));
				restaurant.setClosed(rs.getString("closed"));
				restaurant.setPlaceLa(rs.getString("placeLa"));
				restaurant.setPlaceLO(rs.getString("placeLo"));
				restaurant.setContent(rs.getString("content"));
				restaurant.setImageurl(rs.getString("imageurl"));
				restaurant.setRegdate(rs.getDate("regdate"));
				restaurant.setCnt(rs.getInt("cnt"));
				restaurant.setLike_cnt(rs.getInt("like_cnt"));
				restaurant.setComment_cnt(rs.getInt("comment_cnt"));
				restaurant.setStarrating(rs.getInt("starrating"));
		
			}
			
			request.setAttribute("restaurant", restaurant);
			
			
			//해당 게시물에 포함되는 답글 리스트를 전송하는 내용을 추가.
			stmt.close();
			rs.close();
			
			sql="select boardseq,seq,nickname,starrating,reply,userprofilephto,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from R_replyboard_ where boardseq=? order by seq desc";
			
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			rs=stmt.executeQuery();
			
			ArrayList<ReplyBoardVO> replylist = new ArrayList<ReplyBoardVO>();
			
			int comment_cnt = 0;
			
			while(rs.next()) {
				ReplyBoardVO vo = new ReplyBoardVO();				
				vo.setBoardseq(rs.getInt("boardseq"));
				vo.setSeq(rs.getInt("seq"));
				vo.setNickname(rs.getString("nickname"));
				vo.setStarrating(rs.getInt("starrating"));
				vo.setReply(rs.getString("reply"));
				vo.setUserprofilephto(rs.getString("userprofilephto"));		
				vo.setRegdate(rs.getString(7));				
					
				replylist.add(vo);
				comment_cnt++;
				System.out.println("댓글 리스트 ");
			}		
			request.setAttribute("replylist", replylist);
			
			stmt.close();
			rs.close();
			
			//게시판 게시글 댓글 수 업데이트
			sql="update recommend_R set comment_cnt =? where seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, comment_cnt);
			stmt.setInt(2, seq);			
			stmt.executeUpdate();
			stmt.close();
			
			RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=getRestaurant");
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
