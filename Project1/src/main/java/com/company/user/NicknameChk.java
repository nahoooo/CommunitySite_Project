package com.company.user;

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

import com.company.common.JDBCConnection;


@WebServlet("/NicknameChk")
public class NicknameChk extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("euc-kr");
		System.out.println("/NicknameChk");

		String userNickname = request.getParameter("userNickname");
		System.out.println(userNickname);
		PrintWriter out = response.getWriter();

		try {

			int NicknameCheck = checkUserNickname(userNickname);

			if (NicknameCheck == 0) {
				System.out.println("이미 존재하는 닉네임");
			} else if (NicknameCheck == 1) {
				System.out.println("사용 가능한 닉네임");
			}
			out.write(NicknameCheck + "");
		} catch (ClassNotFoundException | SQLException e) {			
			e.printStackTrace();
		}

	}

	public int checkUserNickname(String userNickname) throws ClassNotFoundException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = JDBCConnection.getConnection();
		String sql = "select * from member where nickname=?";
		int result = 0;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, userNickname);

			rs = stmt.executeQuery();

			if (rs.next()) {
				result = 0; // 이미 존재하는 경우, 생성 불가능.
			} else {
				result = 1;
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			JDBCConnection.close(rs, stmt, conn);
		}
		return result;

	}

}
