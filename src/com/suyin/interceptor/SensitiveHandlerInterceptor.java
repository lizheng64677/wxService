package com.suyin.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import net.sf.json.JSONObject;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;

/**
 * 所有敏感操作的拦截器，以保证该用户是注册过的用户;敏感操作都用ajax提交的，那么如果没有注册过就返回{error:2}
 * 另外必须保证提交的参数中一定有openid
 * .（因为VerificationHandlerInterceptor拦截器保证了进入任何一个页面后session中一定会有openid
 * ，那么一定可以保证传回的参数中有openid）
 * 
 * @author Administrator
 *
 */
public class SensitiveHandlerInterceptor extends HandlerInterceptorAdapter {

//        public boolean preHandle(HttpServletRequest request,
//                                 HttpServletResponse response, Object handler) throws Exception {
    
//            String path = request.getServletPath();
//            if(path.startsWith("/shareDowload")){return true;}
//            // 保证该用户是注册过的用户
//            if (request.getSession().getAttribute(Constant.SESSION_LOGIN_USER) == null) {
//                JSONObject jso = HttpClientUtils.getRemote("/nouser/findUserByOpenId?openid="+ request.getParameter("openid"));
//                request.getSession().setAttribute(Constant.SESSION_OPEN_ID, request.getParameter("openid"));
//    
//                if ("success".equals(jso.getString("message"))) {
//                    LoginUser user = new LoginUser()
//                    .setUserid(jso.getString("userid"))
//                    .setOpenid(jso.getString("openid"))
//                    .setState(jso.getString("state"));
//                    request.getSession().setAttribute(Constant.SESSION_LOGIN_USER,
//                        user);
//                    return true;
//                    // 说明该用户没有注册过，返回{error：2}，
//                } else {
//                    response.setContentType("application/json;charset=UTF-8");
//                    PrintWriter pw = response.getWriter();
//                    pw.print("{\"error\":\"10\",\"msg\":\"该用户没有注册或者传参数时没有带openid\"}");
//                    pw.flush();
//                    pw.close();
//                    return false;
//                }
//            }
//            return true;
//        }

    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
//        LoginUser user = new LoginUser()
//        .setUserid("65576");
//        request.getSession().setAttribute(Constant.SESSION_LOGIN_USER,
//            user);
//        request.getSession().setAttribute(Constant.SESSION_OPEN_ID, "oEWBhuH1TWxGFhibxzLM4XYtbDYo");
        return true;
        	
    }
	

}
