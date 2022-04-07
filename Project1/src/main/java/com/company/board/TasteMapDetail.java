package com.company.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.company.board.vo.RestaurantVO;
import com.company.common.JDBCConnection;


@WebServlet("/TasteMapDetail")
public class TasteMapDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("/TasteMapDetail");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		System.out.println(seq);
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
	
		try {
			conn=JDBCConnection.getConnection();
			
			//해당 게시물 데이터 가져오기
			String	sql="select * from recommend_R where seq=?";
			stmt=conn.prepareStatement(sql);		
			stmt.setInt(1, seq);
			
			rs=stmt.executeQuery();
			
			
			JSONArray jsonArray = new JSONArray ();
			JSONObject json = null;
			
			RestaurantVO restaurant=null;
			if(rs.next()) {			
				json = new JSONObject();				
				json.put("seq", rs.getInt("seq"));
				json.put("restaurantname",rs.getString("restaurantname"));
				json.put("nickname", rs.getString("nickname"));
				json.put("onelinereview", rs.getString("onelinereview"));
				json.put("restaurantaddr", rs.getString("restaurantaddr"));
				json.put("imageurl", rs.getString("imageurl"));
				json.put("parking", rs.getString("parking"));
				json.put("tel", rs.getString("tel"));
				json.put("thumbnail", rs.getString("thumbnail"));
				json.put("starrating", rs.getInt("starrating"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				json.put("seq", rs.getInt("seq"));
//				
//				
//				
//				
//				
//				
//				restaurant.setNickname(rs.getString("nickname"));
//				restaurant.setTitle();
//				restaurant.setRestaurantname(rs.getString("restaurantname"));
//				restaurant.setRestaurantaddr(rs.getString("restaurantaddr"));
//				restaurant.setOnelinereview(rs.getString("onelinereview"));
//				restaurant.setTel(rs.getString("tel"));
//				restaurant.setOpeninghours(rs.getString("openinghours"));
//				restaurant.setParking(rs.getString("parking"));
//				restaurant.setClosed(rs.getString("closed"));
//				restaurant.setPlaceLa(rs.getString("placeLa"));
//				restaurant.setPlaceLO(rs.getString("placeLo"));
//				restaurant.setContent(rs.getString("content"));
//				restaurant.setImageurl(rs.getString("imageurl"));
//				restaurant.setThumbnail(rs.getString("thumbnail"));
//				restaurant.setRegdate(rs.getDate("regdate"));
//				restaurant.setCnt(rs.getInt("cnt"));
//				restaurant.setLike_cnt(rs.getInt("like_cnt"));
//				restaurant.setComment_cnt(rs.getInt("comment_cnt"));
				jsonArray.add(json);
			}


			PrintWriter out = response.getWriter();

			out.print(json.toString());

			out.flush();

			out.close();
	
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCConnection.close(rs, stmt, conn);
		}
		
	}
}
