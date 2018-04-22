package com.suyin.decorate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

/**
 * 装修活动接口请求类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/decorate")
public class DecorateController {

	//	    String result=HttpClientUtils.getRemote("/activity/numberplus").toString();
	//      String result=HttpClientUtils.postRemote("/actrecord/joinAct",  Utils.convert(request, ModuleNameService.EXP),null).toString();
	/**
	 * 进入平台介绍页面
	 * @return
	 */
	@RequestMapping("/introduction.html")
	public ModelAndView toIntroduction(){

		ModelMap  model=new ModelMap();
		return new ModelAndView("/decorate/introduction",model);
	}
	/**
	 * 进入用户协议页面
	 * @return
	 */
	@RequestMapping("/agreement.html")
	public ModelAndView toAgreement(){

		ModelMap  model=new ModelMap();
		return new ModelAndView("/decorate/agreement",model);

	}
	/**
	 * 我的资料面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/mydata.html")
	public ModelAndView mydata(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		String openId = Utils.getOpenId(request);
    	net.sf.json.JSONObject result=HttpClientUtils.getRemote("/expdecorateuser/findUserInfoByUserIdOrOpenId" + "?openId="+openId);
		model.put("result",result);	
		return new ModelAndView("decorate/mydata",model);
	}
	/**
	 * 我的邀请页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/invite.html")
	public ModelAndView invite(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/invite",model);
	}
	/**
	 * 我的券页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/voucher.html")
	public ModelAndView voucher(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/voucher",model);
	}

	/**
	 * 我的消息页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/message.html")
	public ModelAndView message(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/message",model);
	}
	/**
	 * 新手指南页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/newhelp.html")
	public ModelAndView newhelp(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/newhelp",model);
	}
	/**
	 * 关于我们页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/about.html")
	public ModelAndView about(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/about",model);
	}

	/**
	 * 分享页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/share.html")
	public ModelAndView share(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		try{
			model=setDataInfo("","","");
		}catch(Exception ex){

		}
		return new ModelAndView("decorate/share",model);
	}
	/**
	 * 组装主题月数据信息
	 * @param detailId
	 * @param userId
	 * @param expTimeId
	 * @return
	 * @throws JSONException 
	 * @see
	 */
	private  ModelMap setDataInfo(String detailId,String userId,String expTimeId) throws JSONException{
		ModelMap  model=new ModelMap();
		//请求主题月相关信息
		String themeInfo=HttpClientUtils.getRemote("/thememonth/findThemeMonthInfo").toString();
		JSONObject a=new JSONObject(themeInfo);
		if("success".equals(a.get("message"))){
			if(null!=a.getString("data")){
				JSONObject  s=new JSONObject(a.get("data").toString());

				model.put("color", s.get("color"));
				model.put("bottomPic", s.get("bottom_pic"));
				model.put("themeLogo", s.get("theme_logo"));
				model.put("themeTitle", s.get("theme_title"));
				model.put("themePic", s.get("theme_pic"));
			}
		}else{

			model.put("color", "");
			model.put("bottomPic", "");
			model.put("themeLogo", "");
			model.put("themeTitle", "");
			model.put("themePic", "");
		}

		return model;
	}

	/**
	 * 排名页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/rank.html")
	public ModelAndView rank(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/rank",model);
	}


	/**
	 * 活动首页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/index.html")
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
/*		net.sf.json.JSONObject result=HttpClientUtils.getRemote("/indecorate/findDecorateById");
		model.put("result", result);*/
		return new ModelAndView("decorate/index",model);
	}
	
	@RequestMapping(value="/findDecorateInfoById")
	public @ResponseBody String findDecorateInfoById(Integer id){
		net.sf.json.JSONObject result=HttpClientUtils.getRemote("/indecorate/findDecorateById" + "?id="+id);
		return result.toString();
	}


	/**
	 * 账户信息页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/account.html")
	public ModelAndView account(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/account",model);
	}



	/**
	 * 个人中心页面跳转
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/center.html")
	public ModelAndView center(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		return new ModelAndView("decorate/center",model);
	}

}
