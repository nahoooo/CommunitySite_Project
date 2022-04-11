package com.company.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCConnection;

@WebServlet("/AddRestaurantPro")
public class AddRestaurantPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println("/AddRestaurantPro");

		String nickname = request.getParameter("nickname"); // 작성자 닉네임
		String id = request.getParameter("id"); // 작성자 닉네임
		String title = request.getParameter("title"); // 제목
		String restaurantname = request.getParameter("restaurantname"); // 식당이름
		String restaurantaddr = request.getParameter("restaurantaddr"); // 식당주소
		String onelinereview = request.getParameter("onelinereview"); // 한줄평
		String tel = request.getParameter("tel"); // 식당 전화번호
		String openinghours = request.getParameter("openinghours"); // 식당 영업시간
		String parking = request.getParameter("parking"); // 주차가능 여부
		String closed = request.getParameter("closed"); // 휴무일
		String placeLa = request.getParameter("placeLa"); // 위도
		String placeLo = request.getParameter("placeLo"); // 경도
		String content = request.getParameter("content"); // 내용

		// 이미지 url 추출. String으로 한번에 저장되기 때문에 다시 사용할 때 파싱 필요.
		String imageurl="";
		
		ArrayList<String> s = new ArrayList<String>();
		
		Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); // img 태그 src 추출 정규표현식
		Matcher matcher = pattern.matcher(content);

		
		while (matcher.find()) {	
			imageurl+=matcher.group(1);
			s.add((String)matcher.group(1));
		}
		String thumbnail =s.get(0).trim();
		System.out.println(imageurl);
		System.out.println("----------------");
		System.out.println(s.get(0).trim());
		System.out.println(s.get(1).trim());
		System.out.println("----------------");		
		System.out.println(thumbnail);
		System.out.println("입력시작");
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into recommend_R(seq,nickname,title,restaurantname,restaurantaddr,onelinereview,tel,openinghours,parking,closed,placeLa,placeLo,content,imageurl,thumbnail,id) values((select nvl(max(seq),0)+1 from recommend_R),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, nickname);
			stmt.setString(2, title);
			stmt.setString(3, restaurantname);
			stmt.setString(4, restaurantaddr);
			stmt.setString(5, onelinereview);
			stmt.setString(6, tel);
			stmt.setString(7, openinghours);
			stmt.setString(8, parking);
			stmt.setString(9, closed);
			stmt.setString(10, placeLa);
			stmt.setString(11, placeLo);
			stmt.setString(12, content);
			stmt.setString(13, imageurl);
			stmt.setString(14, thumbnail);
			stmt.setString(15, id);
		

			int cnt = stmt.executeUpdate();
			if (cnt != 0)
				System.out.println("입력완료");

				response.sendRedirect("GetRestaurantListPro");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(stmt, conn);
		}
	}
}
