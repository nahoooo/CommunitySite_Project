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
import com.company.board.vo.RestaurantVO;
import com.company.common.JDBCConnection;


@WebServlet("/GetRestaurantListPro")
public class GetRestaurantListPro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
System.out.println("/GetBoardListPro");

	request.setCharacterEncoding("utf-8");
		
		int page;
		if(request.getParameter("page")==null)
			page=1;
		else 
			page=Integer.parseInt(request.getParameter("page"));
		
		String boardtype = request.getParameter("boardtype");
		
		HttpSession session=request.getSession();
		String nickname2=(String)session.getAttribute("nickname");
		
		if (nickname2 == null) {
			response.sendRedirect("index.jsp?filePath=login");
			return;
		}
	
		//DB접속
				Connection conn=null;
				PreparedStatement stmt=null;
				ResultSet rs=null;
				
				try {
					conn=JDBCConnection.getConnection();
//					String sql="select * from board order by seq desc";
					
					String sql="select * from (select rownum as rnum,B.* from (select * from recommend_R order by seq desc) B) where rnum between ? and ?";
					// page 1: 1-10
					// page 2: 11-20
					// page 3: 21-30
					stmt=conn.prepareStatement(sql);
					
					// page를 이용하여 각 페이지에 담기는 레코드의 rownum값을 환산				
					stmt.setInt(1, page*10-9);
					stmt.setInt(2, page*10);
					
					rs=stmt.executeQuery();
					ArrayList<RestaurantVO> RestaurantList=new ArrayList<RestaurantVO>();
					
					while(rs.next()) {
																																		
						int seq=rs.getInt("seq");
						String nickname=rs.getString("nickname");
						String title=rs.getString("title");
						String restaurantname = rs.getString("restaurantname");
						String restaurantaddr = rs.getString("restaurantaddr");
						String onelinereview = rs.getString("onelinereview");
						String tel = rs.getString("tel");
						String openinghours = rs.getString("openinghours");
						String parking = rs.getString("parking");
						String closed = rs.getString("closed");
						String placeLa = rs.getString("placeLa");
						String placeLo = rs.getString("placeLo");
						String content = rs.getString("content");										
						String imageurl=rs.getString("imageurl");
						Date regdate=rs.getDate("regdate");
						int cnt=rs.getInt("cnt");
						int like_cnt=rs.getInt("like_cnt");
						int comment_cnt=rs.getInt("comment_cnt");
					
						RestaurantVO restaurant = new RestaurantVO();
						restaurant.setSeq(seq);
						restaurant.setNickname(nickname);
						restaurant.setTitle(title);
						restaurant.setRestaurantname(restaurantname);
						restaurant.setRestaurantaddr(restaurantaddr);
						restaurant.setOnelinereview(onelinereview);
						restaurant.setTel(tel);
						restaurant.setOpeninghours(openinghours);
						restaurant.setParking(parking);
						restaurant.setClosed(closed);
						restaurant.setPlaceLa(placeLa);
						restaurant.setPlaceLO(placeLo);
						restaurant.setContent(content);
						restaurant.setImageurl(imageurl);
						restaurant.setRegdate(regdate);
						restaurant.setCnt(cnt);
						restaurant.setLike_cnt(like_cnt);
						restaurant.setComment_cnt(comment_cnt);
						
																												
						RestaurantList.add(restaurant);   // 각 줄을 리스트에 담는다.
					}
					
					// PrepareStatmement와 Resultset을 재활용하기 위해 자원을 닫고 다시 사용.
					stmt.close();
					rs.close();
					
					sql="select max(seq) from recommend_R";
					stmt=conn.prepareStatement(sql);					
					rs=stmt.executeQuery();
					
					int totalCount=0; //전체 게시글 수 담는 변수
					if(rs.next()) {
						totalCount=rs.getInt(1);
					}
					System.out.println(totalCount);
					
					
					
					// 1. 전달할 데이터를 request에 담는다.
					request.setAttribute("RestaurantList", RestaurantList);
					request.setAttribute("totalRows", totalCount);					
					
					// 2. 지금 사용하는 request와 response를 지정한 페이지로 전달해서
					// 동일한 request와 response를 사용하도록 지정
					RequestDispatcher view=request.getRequestDispatcher("index.jsp?filePath=getRestaurantList");
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
