package com.company.user.vo;

import java.sql.Date;

public class UserVO {
	private String id;
	private String nickname;
	private String email;
	private String password;
	private Date regist_date;
	private String grade;
	private String userprofile;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getUserprofile() {
		return userprofile;
	}
	public void setUserprofile(String userprofile) {
		this.userprofile = userprofile;
	}
	
	
}
