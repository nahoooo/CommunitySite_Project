package com.company.user;

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
import com.company.board.vo.RestaurantVO;
import com.company.common.JDBCConnection;
import com.company.user.vo.UserVO;


@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
   

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/UserProfile");
		//세션아이디값 가져오기
		HttpSession session=request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		//세션아이디 없으면 로그인
		if (sessionID == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
		//값확인
		System.out.println(sessionID);
		//필요한 것들 생성.
		Connection conn=null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		
		//회원 프로필정보
		try {
			conn=JDBCConnection.getConnection();
			sql = "select * from member where id=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, sessionID);
			
			rs=stmt.executeQuery();
			
			UserVO user = null;
			if(rs.next()) {
				user = new UserVO();
				user.setId(rs.getString("id"));
				user.setNickname(rs.getString("nickname"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setRegist_date(rs.getDate("regist_date"));
				user.setGrade(rs.getString("grade"));
				user.setUserprofile(rs.getString("userprofile"));
			}
			
			request.setAttribute("user", user);
			
			stmt.close();
			rs.close();
		

			
			//회원 일반게시글 정보
			
			sql = "select * from board_ where id=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, sessionID);
			
			rs=stmt.executeQuery();
			ArrayList<BoardVO> boardList=new ArrayList<BoardVO>();			
			BoardVO board = null;
			
			while(rs.next()) {
			board=new BoardVO();
			board.setSeq(rs.getInt("seq"));
			board.setNickname(rs.getString("nickname"));
			board.setBoardtype(rs.getString("boardtype"));
			board.setContent(rs.getString("content"));
			board.setTitle(rs.getString("title"));
			board.setRegdate(rs.getDate("regdate"));
			board.setCnt(rs.getInt("cnt"));
			board.setComment_cnt(rs.getInt("comment_cnt"));
			board.setImageurl(rs.getString("imageurl"));
			
			boardList.add(board);
			}
			request.setAttribute("boardList", boardList);
			
			stmt.close();
			rs.close();
		

			//회원 레스토랑추천 게시글
			
			sql = "select * from recommend_R where id=? ";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, sessionID);
			rs=stmt.executeQuery();
			ArrayList<RestaurantVO> RestaurantList=new ArrayList<RestaurantVO>();
			
			while(rs.next()) {

				RestaurantVO restaurant = new RestaurantVO();
				
				restaurant.setSeq(rs.getInt("seq"));
				restaurant.setNickname(rs.getString("nickname"));
				restaurant.setTitle(rs.getString("title"));
				restaurant.setRestaurantname(rs.getString("restaurantname"));
				restaurant.setRestaurantaddr( rs.getString("restaurantaddr"));
				restaurant.setOnelinereview(rs.getString("onelinereview"));
				restaurant.setTel(rs.getString("tel"));
				restaurant.setOpeninghours(rs.getString("openinghours"));
				restaurant.setParking(rs.getString("parking"));
				restaurant.setClosed(rs.getString("closed"));
				restaurant.setPlaceLa(rs.getString("placeLa"));
				restaurant.setPlaceLO(rs.getString("placeLo"));
				restaurant.setContent(rs.getString("content"));
				restaurant.setImageurl(rs.getString("imageurl"));
				restaurant.setThumbnail(rs.getString("thumbnail"));						
				restaurant.setRegdate(rs.getDate("regdate"));
				restaurant.setCnt(rs.getInt("cnt"));
				restaurant.setLike_cnt(rs.getInt("like_cnt"));
				restaurant.setComment_cnt(rs.getInt("comment_cnt"));
																														
				RestaurantList.add(restaurant);   // 각 줄을 리스트에 담는다.
			}
			request.setAttribute("RestaurantList", RestaurantList);
			
			
			RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=userProfile");
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
