package com.suyin.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

/**
 * 
 * 所有的进入某个页面的请求，都经过这个拦截器，就要求这些请求都是 /xx/toxx格式
 * 不过敏感操作的不在这里搞，登录注册的不要搞
 * 这个拦截器主要作用是保证session中一定有openid和user（如果注册过的话）
 * 另外进入页面最好用get方式，要不然参数会丢失的可能性
 * @author Administrator
 */
public class VerificationHandlerInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        String path = request.getServletPath();

        //敏感操作的不在这里搞
        if(path.startsWith("/sen")) return true;
        //登录注册的不要搞
        if(path.startsWith("/userlr")) return true;
        //静态资源请求不要搞
        if(path.indexOf("resources")>0) return true;

        if(path.startsWith("/about")) return true;

        if(path.startsWith("/userProblem")) return true;

        if(path.startsWith("/userPrototype")) return true;

        if(path.startsWith("/user/toMyInfo")) return true;

        if(path.startsWith("/shareDowload")){return true;}
        
        if(path.startsWith("/wxPay")){return true;}

        //这里保证session中一定有open_id
//        if(request.getSession().getAttribute(Constant.SESSION_OPEN_ID)==null) {
//            if(request.getParameter("code")==null) {
//                response.sendRedirect(Utils.getRedirectWeiXinUrl(path));
//                return false;
//            }else {
//                request.getSession().setAttribute(Constant.SESSION_OPEN_ID,Utils.getOpenId(request.getParameter("code")));
//            }
//        }
        //测试
//        request.getSession().setAttribute(Constant.SESSION_OPEN_ID, "oEWBhuH1TWxGFhibxzLM4XYtbDYo");
//        if(request.getSession().getAttribute(Constant.SESSION_LOGIN_USER)==null) {
//            JSONObject jso = HttpClientUtils.getRemote("/nouser/findUserByOpenId?openid="+ request.getSession().getAttribute(Constant.SESSION_OPEN_ID));
//            if ("success".equals(jso.getString("message"))) {
//                LoginUser user = new LoginUser()
//                .setUserid(jso.getString("userid"))
//                .setOpenid(jso.getString("openid"))
//                .setState(jso.getString("state"));
//                request.getSession().setAttribute(Constant.SESSION_LOGIN_USER,user);
//            }
//        }
        return true;
    }
}
