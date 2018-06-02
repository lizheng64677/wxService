package com.suyin.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;

import com.suyin.model.LoginUser;

public class Utils {
	public static String appId,secret,rootUrl,remoteUrl,wxcallBackUrl,cerUrl,mchID,mchKey;
	static {
		appId=SystemPropertiesHolder.get("APP_ID");
		secret=SystemPropertiesHolder.get("APP_SECRET");
		rootUrl=SystemPropertiesHolder.get("ROOT_URL");
		remoteUrl=SystemPropertiesHolder.get("REMOTE_URL");
		wxcallBackUrl=SystemPropertiesHolder.get("CALL_URL");
		cerUrl=SystemPropertiesHolder.get("CER_URL");
		mchID=SystemPropertiesHolder.get("MCHID");
		mchKey=SystemPropertiesHolder.get("MCHKEY");

	}
	

	public static String getOpenId(String code) {
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId+ "&secret="+secret+"&code="+code+"&grant_type=authorization_code";
		JSONObject jsonObject = HttpClientUtils.get(url);
		try {
			return jsonObject.getString("openid");
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 根据code 获取用户信息
	 * @param code
	 * @return
	 */
	public static JSONObject getWecharUserInfo(String code){
		Map<String,Object> baseInfo= Utils.getOpenIdAndToken(code);
		JSONObject jsonObject=Utils.getBaseUserInfo(baseInfo.get("token").toString(), baseInfo.get("openid").toString());
		return jsonObject;
		
	}
	/**
	 * 根据CODE 获取opend token 信息
	 * @param code
	 * @return
	 */
	public static Map<String,Object> getOpenIdAndToken(String code) {
		Map<String,Object>result=new HashMap<String, Object>();
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId+ "&secret="+secret+"&code="+code+"&grant_type=authorization_code";
		JSONObject jsonObject = HttpClientUtils.get(url);
		try {
			result.put("openid", jsonObject.getString("openid"));
			result.put("token", jsonObject.getString("access_token"));
		} catch (Exception e) {
			return null;
		}
		return result;
	}
	/**
	 * 获取微信用户详细信息
	 * @param token
	 * @param openid
	 * @return
	 */
	public static  JSONObject getBaseUserInfo(String token,String openid){
		String url = "https://api.weixin.qq.com/sns/userinfo?access_token="+token+"&openid="+openid+"&lang=zh_CN";
		JSONObject jsonObject = HttpClientUtils.get(url);
		try{
			String isok=jsonObject.getString("errmsg");
		
		}catch(Exception ex){
			
		}
		return jsonObject;
	}
	/**
	 * 
	 * @param request
	 * @return
	 */
	public static String getOpenId(HttpServletRequest request) {
		String obj=(String) request.getSession().getAttribute(Constant.SESSION_OPEN_ID);
		return obj;
	}
	public static String getUserId(HttpServletRequest request){

		LoginUser obj=(LoginUser) request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
		if(null!=obj){
			return obj.getUserid();
		}else{

			return "-1";
		}
	}
	/**
	 * 只获取Openid scope=snsapi_base
	 * 该方法没什么作用，就是组装一下url
	 * @param redirectUrl
	 * @return
	 */
	public static String getRedirectWeiXinUrl(String redirectUrl){
		String requestUrl="";
		try {
			/**强烈要求此处授权链接必须百分百与官方api相符合**/
			requestUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+ URLEncoder.encode(rootUrl+redirectUrl, "UTF-8")+"&response_type=code&scope=snsapi_base&state=2#wechat_redirect";
		} catch (UnsupportedEncodingException e) {
		}
		return requestUrl;
	}

	/**
	 * 
	 * 获取用户的信息  scope=snsapi_userinfo
	 * 该方法没什么作用，就是组装一下url
	 * @param redirectUrl
	 * @return
	 */
	public static String getRedirectUserInfoWeiXinUrl(String redirectUrl){
		String requestUrl="";
		try {
			/**强烈要求此处授权链接必须百分百与官方api相符合**/
			requestUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+ URLEncoder.encode(rootUrl+redirectUrl, "UTF-8")+"&response_type=code&scope=snsapi_userinfo&state=2#wechat_redirect";
		} catch (UnsupportedEncodingException e) {
		}
		return requestUrl;
	}


	/**
	 * 进行http post请求时，需要的是List<NameValuePair> 作为参数，这里转化一下
	 * @param request
	 * @return
	 */
	public static List<NameValuePair> convert(HttpServletRequest request,String moduleName){
		List<NameValuePair> list=new ArrayList<NameValuePair>();
		Enumeration<String> enu= request.getParameterNames();
		String temp=null;
		boolean isOpenIdAdd=false;
		while(enu.hasMoreElements()) {
			temp=enu.nextElement();
			if("openid".equals(temp)) {
				isOpenIdAdd=true;
			}
			list.add(new BasicNameValuePair(temp, request.getParameter(temp)));  
		}
		list.add(new BasicNameValuePair("module", moduleName));
		list.add(new BasicNameValuePair("regtype", "0"));
		list.add(new BasicNameValuePair("version", "1"));
		if(!isOpenIdAdd){
			list.add(new BasicNameValuePair("openid", getOpenId(request)));
			list.add(new BasicNameValuePair("userId", getUserId(request)));
		}
		return list;
	}




	/**
	 * 验证前台发过来的数据是否都存在
	 * @param request
	 * @param args 一个数组，里面是要进行非空验证的parameter的key
	 * @return
	 */
	public static boolean isInvalidParameters(HttpServletRequest request,String... args) {
		for(String arg:args) {
			if(StringUtils.isBlank(request.getParameter(arg)))
				return false;
		}
		return true;
	}


	public static HttpContext getHttpContext(HttpServletRequest request) {
		HttpContext context=(HttpContext) request.getSession().getAttribute(Constant.SESSION_HTTPCONTEXT);
		if(context==null) {
			CookieStore cookieStore = new BasicCookieStore();
			context = new BasicHttpContext();
			context.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
			request.getSession().setAttribute(Constant.SESSION_HTTPCONTEXT, context);
		}
		return context;
	}
	
	/** 
     * 获取用户真实IP地址，不使用request.getRemoteAddr()的原因是有可能用户使用了代理软件方式避免真实IP地址, 
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值 
     *  
     * @return ip
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for"); 
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {  
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("X-Real-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        } 
//        System.out.println("获取客户端ip: " + ip);
        return ip;  
    }
    
	/**
	 * 获取随机字符
	 * @param length
	 * @return
	 */
	public  static String getRandomString(int length){
		StringBuffer buffer=new StringBuffer("0123456789");
		StringBuffer sb=new StringBuffer();
		Random r=new Random();
		int range=buffer.length();
		for(int i=0;i<length;i++){
			sb.append(buffer.charAt(r.nextInt(range)));
		}
		return sb.toString();
	}

}
