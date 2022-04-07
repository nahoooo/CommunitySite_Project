package com.company.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCConnection;

@WebServlet("/R_ReplyAjaxPro")
public class R_ReplyAjaxPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/R_ReplyAjaxPro");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String nickname = request.getParameter("nickname");
		String comment = request.getParameter("comment");
		int seq = Integer.parseInt(request.getParameter("seq"));
		int starrating = Integer.parseInt(request.getParameter("starrating"));


		// 값이 오는지 확인하기
		System.out.println(nickname);
		System.out.println(comment);
		System.out.println(seq);
		System.out.println(starrating);


		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = null;
		int result = 0;
		try {
			conn = JDBCConnection.getConnection();

			sql = "insert into R_replyboard_(boardseq,seq,nickname,reply,starrating) values(?,(select nvl(max(seq),0)+1 from R_replyboard_ where boardseq =?),?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, seq);	
			stmt.setInt(2, seq);
			stmt.setString(3, nickname);
			stmt.setString(4, comment);
			stmt.setInt(5, starrating);
			
			stmt.executeUpdate();								
			stmt.close();

			
			sql="update recommend_R a set(starrating)=(select avg(b.starrating) from R_replyboard_ b  where b.seq=a.seq) where a.seq=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, seq);

			int cnt = stmt.executeUpdate();
			stmt.close();
			
			
		
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
		} finally {
			JDBCConnection.close(stmt, conn);
		}

	}
}
