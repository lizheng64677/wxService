package com.suyin.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

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
    public static String appId,secret,rootUrl,remoteUrl;
    static {
        appId=SystemPropertiesHolder.get("APP_ID");
        secret=SystemPropertiesHolder.get("APP_SECRET");
        rootUrl=SystemPropertiesHolder.get("ROOT_URL");
        remoteUrl=SystemPropertiesHolder.get("REMOTE_URL");
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

}
