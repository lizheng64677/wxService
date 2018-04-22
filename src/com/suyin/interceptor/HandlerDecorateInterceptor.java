package com.suyin.interceptor;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

/**
 * 营销活动 
 * 二维码海报+分享
 * 拦截所有.html 请求
 * @author lz
 *
 */
public class HandlerDecorateInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath()+"?"+request.getQueryString();
		//这里保证session中一定有open_id
		if(request.getSession().getAttribute(Constant.SESSION_OPEN_ID)==null) {
			if(request.getParameter("code")==null) {
				response.sendRedirect(Utils.getRedirectUserInfoWeiXinUrl(path));
				return false;
			}else {    
				JSONObject jso=Utils.getWecharUserInfo(request.getParameter("code"));
				LoginUser user=this.setForm(request,jso);
				//查询数据库中是否存在，不存在则进行保存          
				createUserInfo(user);

			}
		} else{
			LoginUser user=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
			if(null!=user){
				createUserInfo(user);
			}
		}

		//测试时放开
		//    	LoginUser user=testFormData(request);

		return true;
	}



	private void createUserInfo(LoginUser user){

		//保存新用户信息
		List<NameValuePair> list=new ArrayList<NameValuePair>();
		list.add(new BasicNameValuePair("openid", user.getOpenid()));	
		list.add(new BasicNameValuePair("headImg", user.getHeadimg()));	
		list.add(new BasicNameValuePair("nickName", user.getNickname()));	
		HttpClientUtils.postRemote("/expdecorateuser/initSaveDecorateUser",list,null);


	}
	/**
	 * 组织授权信息数据
	 * @param request
	 * @param jso
	 */
	private LoginUser setForm(HttpServletRequest request,JSONObject jso){
		LoginUser user = new LoginUser();
		user.setNickname(jso.getString("nickname"));
		user.setHeadimg(jso.getString("headimgurl"));
		user.setOpenid(jso.getString("openid"));
		request.getSession().setAttribute(Constant.SESSION_LOGIN_USER,user);
		request.getSession().setAttribute(Constant.SESSION_OPEN_ID,user.getOpenid());	
		return user;
	}

	/**
	 * 测试时用下
	 * @param request
	 * @param jso
	 */
	private LoginUser testFormData(HttpServletRequest request){
		LoginUser user = new LoginUser();
		user.setNickname("四季");
		user.setHeadimg("http://thirdwx.qlogo.cn/mmopen/vi_32/x39icrW2tia0Go4hxjic4tAsGhDYs8IuENhuKmA5edkvH7OvVc0BYibE6HY5UziarwiaeGraLGFMOzde7uAKFD3zexmw/132");
		user.setOpenid("oEWBhuH1TWxGFhibxzLM4XYtbDYo");
		request.getSession().setAttribute(Constant.SESSION_LOGIN_USER,user);
		request.getSession().setAttribute(Constant.SESSION_OPEN_ID,user.getOpenid());	
		return user;
	}
}
