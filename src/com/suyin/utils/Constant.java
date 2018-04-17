package com.suyin.utils;


public class Constant {
	//SESSION_表示要存到session中的object的key
	//理论上LoginUser中也有openid，就不需要在session中在存了，但是会很麻烦，所以。。。。
	public static final String SESSION_OPEN_ID="SESSION_OPEN_ID";
	
	//session中放置httpcontext，用来使远程连接service时使用同一个session
	public static final String SESSION_HTTPCONTEXT="SESSION_HTTPCONTEXT";
	
	//登录后session中存放user
	public static final String SESSION_LOGIN_USER="SESSIONUSER";
	
	
	//APPLICATION_表示存放在applicationcontext中的object的key
	//全局存放微信的access_token
	public static final String APPLICATION_ACCESS_TOKEN="APPLICATION_ACCESS_TOKEN";
	//全局存放access_token的失效时间，值是从1970-01-01到该时间的毫秒数
	public static final String APPLICATION_TOKEN_TIME="APPLICATION_TOKEN_TIME";
	//全局存放jsp_api
	public static final String 	APPLICATION_JSPAPI_TICKET="APPLICATION_JSPAPI_TICKET";
	//全局存放jsp_api的失效时间，值是从1970-01-01到该时间的毫秒数
	public static final String 	APPLICATION_JSPAPI_TIME="APPLICATION_JSPAPI_TIME";
	
	//电话号码格式
	public static final String PHONE_PATTERN="^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
	
	public static final String REMOTE_GETTOKEN="/client/getToken";
	public static final String REMOTE_RESETTOKEN="/client/resetToken";
	
}
