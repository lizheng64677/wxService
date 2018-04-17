package com.suyin.model;

import java.util.Date;

public class LoginUser {

	private String userid;
	private String userPhone;
	private String openid;
	private String state;
	private Date lastModifyTime;  //上一次修改属性的时间，因为有一个月只能修改一次的限制,所有登录时就应该获得这个值
	private String token;
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public Date getLastModifyTime() {
		return lastModifyTime;
	}
	public void setLastModifyTime(Date lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public LoginUser setUserPhone(String userPhone) {
		this.userPhone = userPhone;
		return this;
	}
	public String getOpenid() {
		return openid;
	}
	public LoginUser setOpenid(String openid) {
		this.openid = openid;
		return this;
	}
	
	public String getUserid() {
		return userid;
	}
	public LoginUser setUserid(String userid) {
		this.userid = userid;
		return this;
	}
	
	public String getState() {
		return state;
	}
	public LoginUser setState(String state) {
		this.state = state;
		return this;
	}
	@Override
	public String toString() {
		return "LoginUser [userid=" + userid + ", userPhone=" + userPhone
				+ ", openid=" + openid + ", state=" + state + "]";
	}

	
}
