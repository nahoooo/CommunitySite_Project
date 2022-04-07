package com.company.user;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.company.common.JDBCConnection;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/UserProfilePhto")
public class UserProfilePhto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("/UserProfilePhto");
		
		request.setCharacterEncoding("utf-8");		
		response.setContentType("text/htm;charset=UTF-8");
		
		
	      String nickname = null;
	      System.out.println(nickname);
	      
		
		
		
	      String realPath = request.getServletContext().getRealPath("userProfile");	      
	      String fileName = null;
	      String contextPath = request.getServletContext().getContextPath();
	      String userProfile = null;
	      

			File targetDir=new File(realPath);//가상경로에 파일이나 폴더를 만들기 위한 객체 생성
			if(!targetDir.exists()) {
				targetDir.mkdirs();//가상경로에 파일이나 폴더가 존재하지 않으면 만들어라.
			}
	      
	
	      Connection conn = null;
	      PreparedStatement stmt = null;
	   
	      
	      
	      try {	    	  
	         MultipartRequest multi = new MultipartRequest(request, realPath, 1024*1024*2, "UTF-8", new DefaultFileRenamePolicy());
	         nickname = multi.getParameter("nickname");
	         System.out.println(nickname);
	         fileName = multi.getFilesystemName("userProfile");
	         System.out.println("fileName : " + fileName);
         
	         userProfile = contextPath + "/userProfile/" + fileName;
	         System.out.println(userProfile);
	         
	         
	         conn=JDBCConnection.getConnection();
	         
	         String sql = "UPDATE MEMBER SET USERPROFILE=? WHERE NICKNAME=?";	         
	         stmt = conn.prepareStatement(sql);
			// 물음표 완성하기
	         stmt.setString(1, userProfile);
			stmt.setString(2, nickname);

			int cnt=stmt.executeUpdate();
			System.out.println(cnt+"개 업데이트 됨.");
	                  
	         
			if (cnt != 0) {
				HttpSession session = request.getSession();
				System.out.println(userProfile);
				session.setAttribute("userProfile", userProfile);
				response.sendRedirect("index.jsp?filePath=home");

			} else {
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			JDBCConnection.close(stmt, conn);
	      }
	}
}




