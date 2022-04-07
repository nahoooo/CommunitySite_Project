package com.company.board.vo;

import java.sql.Date;

public class RestaurantVO {
	private int seq;
	private String title;
	private String nickname;
	private String restaurantname;
	private String restaurantaddr;
	private String onelinereview;
	private String tel;
	private String openinghours;
	private String parking;
	private String closed;
	private String content;
	private String imageurl;
	private String thumbnail;
	private Date regdate;
	private int cnt;
	private int like_cnt;
	private int comment_cnt;
	private String placeLa;
	private String placeLO;
	private int starrating;
	
	
	
	
	

	public int getStarrating() {
		return starrating;
	}
	public void setStarrating(int starrating) {
		this.starrating = starrating;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRestaurantname() {
		return restaurantname;
	}
	public void setRestaurantname(String restaurantname) {
		this.restaurantname = restaurantname;
	}
	public String getRestaurantaddr() {
		return restaurantaddr;
	}
	public void setRestaurantaddr(String restaurantaddr) {
		this.restaurantaddr = restaurantaddr;
	}
	public String getOnelinereview() {
		return onelinereview;
	}
	public void setOnelinereview(String onelinereview) {
		this.onelinereview = onelinereview;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getOpeninghours() {
		return openinghours;
	}
	public void setOpeninghours(String openinghours) {
		this.openinghours = openinghours;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public String getClosed() {
		return closed;
	}
	public void setClosed(String closed) {
		this.closed = closed;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImageurl() {
		return imageurl;
	}
	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getLike_cnt() {
		return like_cnt;
	}
	public void setLike_cnt(int like_cnt) {
		this.like_cnt = like_cnt;
	}
	public int getComment_cnt() {
		return comment_cnt;
	}
	public void setComment_cnt(int comment_cnt) {
		this.comment_cnt = comment_cnt;
	}
	public String getPlaceLa() {
		return placeLa;
	}
	public void setPlaceLa(String placeLa) {
		this.placeLa = placeLa;
	}
	public String getPlaceLO() {
		return placeLO;
	}
	public void setPlaceLO(String placeLO) {
		this.placeLO = placeLO;
	}
	
	
	
}
