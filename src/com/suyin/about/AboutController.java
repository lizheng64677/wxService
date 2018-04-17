package com.suyin.about;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.suyin.utils.HttpClientUtils;

@Controller
@RequestMapping("/about")
public class AboutController {
	//关于我们
	@RequestMapping("/toaboutUs")
	public String toaboutUs(){
	return "/about/aboutUs";
	}
	
	//进入平台介绍页面
	@RequestMapping("/toIntroduction")
	public String toIntroduction(){
	return "/about/introduction";
	}
	//进入用户协议页面
    @RequestMapping("/toAgreement")
    public String toAgreement(){
    	return "/about/agreement";
    	
    }
	//进入合作商家页面
    @RequestMapping("/toCompany")
    public String toCompany(){
    	return "/about/company";
    	
    }
    //进入体验店页面
    @RequestMapping("/toAddressList")
    public String toAddressList(){
    	return "/about/addressList";
    	
    }
    //返回合作商家List数据
	@RequestMapping(value = "/tocompanytolist")
	public @ResponseBody JSONArray tocompanytolist() {
		String jsonObject= HttpClientUtils.getRemoteGyString("/about/findMemberByAll");
		JSONObject on=JSONObject.fromObject(jsonObject);
		return JSONArray.fromObject(on.get("data"));
	}
	
	//显示合作商家
	@RequestMapping(value = "showCompany")
	public String showCompany() {
		return "about/company";
	}
	//返回体验店List数据
	@RequestMapping(value="/tostoretolist")
	public @ResponseBody JSONArray tostoretolist(){
		String jsonObject = HttpClientUtils.getRemoteGyString("/about/findStoreByAll");
		JSONObject on=JSONObject.fromObject(jsonObject);
		return JSONArray.fromObject(on.get("data"));
	}
	//显示体验店
	@RequestMapping(value = "showStore")
	public String showStore() {
		return "about/addressList";
	}
	//新手指南
		@RequestMapping("/toGuide")
		public String toGuide() {
			return "about/guide";
		}
}
