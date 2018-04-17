/*
 * 文件名：Discuss.java
 * 版权：Copyright by www.huawei.com
 * 描述：
 * 修改人：Administrator
 * 修改时间：2015年12月17日
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package com.suyin.exp;

public class Discuss {
	private String userPhone;
	private String content;
	private String createTime;
	private String picUrl;
	private String qcdScore;
	
	public String getQcdScore() {
		return qcdScore;
	}
	public void setQcdScore(String qcdScore) {
		this.qcdScore = qcdScore;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	
}
