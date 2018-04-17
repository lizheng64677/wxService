package com.suyin.userCenter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;








import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.SystemPropertiesHolder;

@Controller
@RequestMapping("/userProblem")
public class UserProblemController {

	// 进入注册页
	@RequestMapping(value = "")
	public String index(HttpServletRequest request) throws JSONException {
		//this.setLoginUser(request);
		String jsonObject= HttpClientUtils.getRemoteGyString("/noUserPrototype/findCodeByMoudleTypeByInface");
		JSONArray array = new JSONArray(jsonObject);
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Map<String,Object> data;
		for(int i=0;i<array.length();i++){
			data=new HashMap<String,Object>();
			data.put("code", array.getJSONObject(i).get("code").toString());
			data.put("disIndex", i+1+"/"+(array.length()+1));
			list.add(data);
			
		}
		if(null!=request.getParameter("userId")  && null!=request.getParameter("version") &&("ios".equals(request.getParameter("version"))||"android".equals(request.getParameter("version")))){
			request.setAttribute("userId",request.getParameter("userId"));
		}else{
			LoginUser loginUser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
			request.setAttribute("userId",loginUser.getUserid());
			
		}

		request.setAttribute("baseUrl", SystemPropertiesHolder.get("ROOT_URL"));
		request.setAttribute("codes", list);
		//获取城市接口
		request.setAttribute("citys", HttpClientUtils.getRemoteGyString("/noUserPrototype/findCitysByInface"));
		return "userCenter/problem/index";
	}
	
	/**
	 * 测试方法不能用与生产环境
	 * @param request
	 */
	private void setLoginUser(HttpServletRequest request){
		 Integer i=(int)(Math.random()*5);
		 LoginUser logUser=new LoginUser();
		 logUser.setUserid(i.toString());
		 request.getSession().setAttribute(Constant.SESSION_LOGIN_USER, logUser);
	}
}
