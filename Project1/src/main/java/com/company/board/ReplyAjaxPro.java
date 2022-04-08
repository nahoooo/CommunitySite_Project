package com.company.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.company.common.JDBCConnection;

@WebServlet("/ReplyAjaxPro")
public class ReplyAjaxPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/ReplyAjaxPro");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String nickname = request.getParameter("nickname");
		String comment = request.getParameter("comment");
		int seq = Integer.parseInt(request.getParameter("seq"));
		String boardtype = request.getParameter("boardtype");
		String userProfilephto = request.getParameter("userProfilephto");

		// 값이 오는지 확인하기
		System.out.println(nickname);
		System.out.println(comment);
		System.out.println(seq);
		System.out.println(boardtype); 	
		System.out.println(userProfilephto); 	
		
		Connection conn = null;
		PreparedStatement stmt = null;

		int result = 0;
		try {
			conn = JDBCConnection.getConnection();
						
				String sql = "insert into replyboard_(boardseq,boardtype,seq,nickname,reply,userProfilephto) values(?,?,(select nvl(max(seq),0)+1 from replyboard_ where boardseq =? and boardtype = ?),?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, seq);
				stmt.setString(2, boardtype);
				stmt.setInt(3, seq);
				stmt.setString(4, boardtype);
				stmt.setString(5, nickname);
				stmt.setString(6, comment);
				stmt.setString(7, userProfilephto);
				
			int cnt = stmt.executeUpdate();

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
