package com.suyin.userCenter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.SystemPropertiesHolder;


@Controller
@RequestMapping("/userPrototype")
public class UserPrototypeController {

	@RequestMapping(value = "")
	public String userInfoMation(HttpServletRequest request) {
	    //this.setLoginUser(request);
		request.setAttribute("baseUrl", SystemPropertiesHolder.get("ROOT_URL"));
		LoginUser loginUser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
		request.setAttribute("userId",loginUser.getUserid());
		return "userCenter/myInformation";
	}
	
	private void setLoginUser(HttpServletRequest request){
		 Integer i=(int)(Math.random()*5);
		 LoginUser logUser=new LoginUser();
		 logUser.setUserid("1");
		 request.getSession().setAttribute(Constant.SESSION_LOGIN_USER, logUser);
	}
}
