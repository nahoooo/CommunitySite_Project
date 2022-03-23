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

@WebServlet("/ReplyDeleteAjaxPro")
public class ReplyDeleteAjaxPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/ReplyUpdateAjaxPro");

		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		int seq = Integer.parseInt(request.getParameter("seq"));
		String boardtype = request.getParameter("boardtype");
		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
	

		System.out.println(seq);
		System.out.println(boardtype);
		System.out.println(boardseq);


		Connection conn = null;
		PreparedStatement stmt = null;

		int result = 0;
		try {
			conn = JDBCConnection.getConnection();
			String sql = "delete from replyboard_ where seq=? and boardtype=? and boardseq=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, seq);
			stmt.setString(2, boardtype);
			stmt.setInt(3, boardseq);

			int cnt = stmt.executeUpdate();

			if (cnt != 0) {
				result = 1; // 댓글 삭제완료.
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
