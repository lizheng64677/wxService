package com.suyin.utils;

import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import net.sf.json.JSONObject;

/**
 * 调用微信的一些接口已获得微信的一些授权
 * 目前的作用就是在使用微信jssdk时获取 jsp_api_tiket
 * @author Administrator
 *
 */
public class WxUtils extends Utils {
	private static Logger logger=Logger.getLogger(WxUtils.class);
	/**
	 * 获取微信 jsp api ticket
	 * @param request
	 * @return
	 */
	public synchronized static String getJspApi(HttpServletRequest request) {
		String result=null;
		ServletContext applicationContext= request.getSession().getServletContext();
		if(applicationContext.getAttribute(Constant.APPLICATION_JSPAPI_TIME)==null
				||new Date().getTime()>=Long.parseLong(applicationContext.getAttribute(Constant.APPLICATION_JSPAPI_TIME).toString())) {
			JSONObject jso = getJspApi(getAccessToken(request));
			if("1".equals(jso.getString("error")))
				throw new RuntimeException("获取jspapi时网络错误");
			result=jso.getString("ticket");
			applicationContext.setAttribute(Constant.APPLICATION_JSPAPI_TICKET, result);
			applicationContext.setAttribute(Constant.APPLICATION_JSPAPI_TIME, String.valueOf(new Date().getTime()+jso.getLong("expires_in")*1000));
		}else {
			result=applicationContext.getAttribute(Constant.APPLICATION_JSPAPI_TICKET).toString();
		}
		logger.debug("this jsp api ticket is: "+result);
		return result;
	}
		
	/**
	 * 获取微信access token
	 * @param request
	 * @return
	 */
	private static String getAccessToken(HttpServletRequest request) {
		String result=null;
		ServletContext applicationContext= request.getSession().getServletContext();
		if(applicationContext.getAttribute(Constant.APPLICATION_TOKEN_TIME)==null
				||new Date().getTime()>=Long.parseLong(applicationContext.getAttribute(Constant.APPLICATION_TOKEN_TIME).toString())) {
			JSONObject jso = getAccessToken();
			if("1".equals(jso.getString("error"))) {
				throw new RuntimeException("获取access token时网络出现错误");
			}
			result=jso.getString("access_token");
			applicationContext.setAttribute(Constant.APPLICATION_ACCESS_TOKEN,result);
			applicationContext.setAttribute(Constant.APPLICATION_TOKEN_TIME, String.valueOf(new Date().getTime()+jso.getLong("expires_in")*1000));
		}else {
			result=applicationContext.getAttribute(Constant.APPLICATION_ACCESS_TOKEN).toString();
		}
		logger.debug("this access_token is: "+result);
		return result;
	}

	private static JSONObject getJspApi(String accessToken) {
		if(accessToken==null) {
			JSONObject jso=new JSONObject();
			jso.put("error", "1");
			return jso;
		}
		String url="https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&"
				+ "access_token="+accessToken;
		JSONObject jso=HttpClientUtils.get(url);
		return jso;
		
	}
	

	private static JSONObject getAccessToken() {
		String url="https://api.weixin.qq.com/cgi-bin/token?"
				+ "grant_type=client_credential"
				+ "&appid="+appId
				+ "&secret="+secret;
		JSONObject jso=HttpClientUtils.get(url);
		return jso;
	}
	

	public static void main(String[] args) {
		System.out.println(getJspApi("4mBw56qlpiCfgie1yHZhd1_dT_xnt4QdPmtJFwY_6JA__tWverRaSGyHb0a5I2Rve2_Dg34HpHoEweN9JsUVLWWglkUcpyFvDW76fr4c2Kg"));
	}
}
