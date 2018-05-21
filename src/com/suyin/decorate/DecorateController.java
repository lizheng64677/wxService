package com.suyin.decorate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
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
	
	/**
	 * 进入券详情
	 * @return
	 */
	@RequestMapping("/voucherdetail.html")
	public ModelAndView toVoucherdetail(HttpServletRequest request){
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");
		String detailId=request.getParameter("detailId");
		String publishopenid=Utils.getOpenId(request);
		model.put("publishopenid", publishopenid);
		net.sf.json.JSONObject decorate=HttpClientUtils.getRemote("/indecorate/findDecorateById?id="+expId);
		model.put("decorate", decorate);
		model.put("expId", expId);
		model.put("detailId", detailId);
		return new ModelAndView("/decorate/voucherdetail",model);
	}
	/**
	 * 进入福利券首页
	 * @return
	 */
	@RequestMapping("/vouchehome.html")
	public ModelAndView toVouche(HttpServletRequest request){
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");
		//获取当前操作者的openid
		String publishopenid=Utils.getOpenId(request);
		model.put("publishopenid", publishopenid);
		net.sf.json.JSONObject decorate=HttpClientUtils.getRemote("/indecorate/findDecorateById?id="+expId);
		model.put("decorate", decorate);
		model.put("expId", expId);
		return new ModelAndView("/decorate/vouchehome",model);
	}
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
		String expId=request.getParameter("id");
		String openId = Utils.getOpenId(request);
		net.sf.json.JSONObject result=HttpClientUtils.getRemote("/inexpdecorateuser/findUserInfoByUserIdOrOpenId" + "?openId="+openId);
		model.put("result",result);	
		model.put("expId", expId);
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
		String expId=request.getParameter("id");
		model.put("expId", expId);
		return new ModelAndView("decorate/invite",model);
	}

	/**
	 * 查询我的邀请
	 * @param request
	 * @return
	 */
	@RequestMapping("/findInvite")
	public @ResponseBody String findInvite(HttpServletRequest request){
		String result=HttpClientUtils.postRemote("/indecoraterecord/findInvite",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
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
		String expId=request.getParameter("id");
		model.put("expId", expId);
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
		String expId=request.getParameter("id");
		model.put("expId", expId);
		return new ModelAndView("decorate/message",model);
	}


	/**
	 * 跳转至我的钱包
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/wallet.html")
	public ModelAndView wallet(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");	
		model.put("expId", expId);
		return new ModelAndView("decorate/wallet",model);
	}	
	/**
	 * 查询我的提现记录
	 * @param request
	 * @return
	 */
	@RequestMapping("/findOrderRecord")
	public @ResponseBody String findOrderRecord(HttpServletRequest request){
		String result=HttpClientUtils.postRemote("/inexpdecorateuser/findOrderRecord",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}
	/**
	 * 提现到账户
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/cashtoali.html")
	public ModelAndView cashtoali(HttpServletRequest request,HttpServletResponse response){
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");
		model.put("expId", expId);
		String openId = Utils.getOpenId(request);
		net.sf.json.JSONObject result=HttpClientUtils.getRemote("/inexpdecorateuser/findUserInfoByUserIdOrOpenId" + "?openId="+openId);
		net.sf.json.JSONObject decorate=HttpClientUtils.getRemote("/indecorate/findDecorateById?id="+expId);
		model.put("decorate", decorate);
		model.put("result",result);	
		return new ModelAndView("decorate/cashtoali",model);
	}
	/**
	 * 保存订单
	 */
	@RequestMapping(value="/withdrawCreateOrder")
	public @ResponseBody String withdrawCreateOrder(HttpServletRequest request,HttpServletResponse response){
		String result=HttpClientUtils.postRemote("/inexpdecorateuser/withdrawCreateOrder",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
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
			//邀请者openid
			String publishopenid=request.getParameter("publishopenid");
			List<NameValuePair> list=new ArrayList<NameValuePair>();
			list.add(new BasicNameValuePair("publishopenid", publishopenid));	
			//1:根据发起者openid查询邀请发起者的微信昵称和头像
			//当前活动id
			String expId=request.getParameter("expId");
			//根据活动id查询活动信息
			list.add(new BasicNameValuePair("id", expId));	
			//当前查看者openid(被邀请者)插入到记录表中
			//将发起者的营销金额增加
			String accptopenid=Utils.getOpenId(request);
			//根据发起者openid 和 受邀者openid  添加数据记录到 t_exp_decorate_record 金额根据 活动配置范围随机，
			//变更邀请者账户
			list.add(new BasicNameValuePair("accptopenid", accptopenid));	
			net.sf.json.JSONObject result=HttpClientUtils.postRemote("/qrcode/findShareProjecss",list,null);
			//查询分享主题信息
			model=setDataInfo(expId);
			model.put("expId", expId);
			model.put("publishopenid", publishopenid);
			model.put("user", result.get("user"));
			model.put("decorate", result.get("decorate"));

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
	private  ModelMap setDataInfo(String expId) throws JSONException{
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
		//获取活动id
		String expId=request.getParameter("id");
		//获取当前操作者的openid
		String publishopenid=Utils.getOpenId(request);
		model.put("publishopenid", publishopenid);
		model.put("expId", expId);
		return new ModelAndView("decorate/rank",model);
	}


	/**
	 * 活动首页面跳转
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/index.html")
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response) throws IOException{
		ModelMap  model=new ModelMap();
		//获取活动id
		String expId=request.getParameter("id");
		//获取当前操作者的openid
		String publishopenid=Utils.getOpenId(request);
		model.put("publishopenid", publishopenid);
		model.put("expId", expId);
		return new ModelAndView("decorate/index",model);
	}

	@RequestMapping(value="/findDecorateInfoById")
	public @ResponseBody String findDecorateInfoById(HttpServletRequest request){
		String id=request.getParameter("id");
		net.sf.json.JSONObject result=HttpClientUtils.getRemote("/indecorate/findDecorateById?id="+id);
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
		String expId=request.getParameter("id");
		model.put("expId", expId);
		return new ModelAndView("decorate/center",model);
	}

}
