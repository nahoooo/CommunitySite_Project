package com.company.board;

import java.io.IOException;
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

@WebServlet("/AddBoardPro")
public class AddBoardPro extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		System.out.println(content);
		int boardno = Integer.parseInt(request.getParameter("boardno"));
		System.out.println(boardno);
	

		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = JDBCConnection.getConnection();
			String sql = "insert into board_(seq,title,nickname,content,boardno) values((select nvl(max(seq),0)+1 from board_ where boardno = ? ),?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, boardno);
			stmt.setString(2, title);
			stmt.setString(3, nickname);
			stmt.setString(4, content);
			stmt.setInt(5, boardno);

			int cnt = stmt.executeUpdate();
			if (cnt != 0)
			
			response.sendRedirect("GetBoardListPro?boardno="+boardno);	
				
			

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCConnection.close(stmt, conn);
		}
	}
}
