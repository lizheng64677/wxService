package com.suyin.decorate;

import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;
import com.suyin.wxpay.WXPayUtil;
import com.suyin.wxpay.WXPayConstants.SignType;
import com.suyin.wxpay.service.WXPay;
import com.suyin.wxpay.service.impl.MyConfig;

/**
 * 装修活动接口请求类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/decorate")
public class DecorateController {
	/**
	 * 个人中心待支付
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/orderWxPay")
	public @ResponseBody String orderWxPay(HttpServletRequest request){
		JSONObject joo=new JSONObject();
		try {
			String openId=Utils.getOpenId(request);
			List<NameValuePair> params=new ArrayList<NameValuePair>();
			String id=request.getParameter("id");
			params.add(new BasicNameValuePair("id", id));
			String ip=Utils.getIpAddr(request);
			//查询订单
			net.sf.json.JSONObject orderOld=HttpClientUtils.postRemote("/indecoratebuyorder/findOrderByIdInfo",params,null);
			String orderNum=orderOld.getString("orderCode");
			orderOld.put("price",orderOld.getString("orderPrice"));
			orderOld.put("name", orderOld.getString("orderName"));
			if(null!=orderOld){
				net.sf.json.JSONObject jo=this.unifiedOrder(orderOld, orderNum, openId, ip);
				joo=this.generateSignature(jo);
			}


		} catch (Exception e) {
			e.printStackTrace();
		}
		return joo.toString();
	}

	/**
	 * 分享页面
	 * 详情页面
	 * 购买券
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wxBuyPay")
	public @ResponseBody String wxBuyPay(HttpServletRequest request){
		JSONObject joo=new JSONObject();
		try {
			String openId=Utils.getOpenId(request);
			String orderNum=Utils.getRandomString(16);
			List<NameValuePair> params=new ArrayList<NameValuePair>();
			String id=request.getParameter("id");
			params.add(new BasicNameValuePair("id", id));
			params.add(new BasicNameValuePair("orderNum", orderNum));
			params.add(new BasicNameValuePair("openid", openId));
			String ip=Utils.getIpAddr(request);
			net.sf.json.JSONObject result=HttpClientUtils.postRemote("/indecoratevoucher/findBuyDetial",params,null);
			if(null!=result){
				net.sf.json.JSONObject jo=this.unifiedOrder(result, orderNum, openId, ip);
				joo=this.generateSignature(jo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return joo.toString();
	}
	/**
	 * 二次签名
	 * @param jo
	 * @return
	 * @throws Exception
	 */
	private JSONObject  generateSignature(net.sf.json.JSONObject jo) throws Exception{
		JSONObject joo=new JSONObject();
		MyConfig config = new MyConfig();
		Map<String, String> data1 = new HashMap<String, String>();
		if(jo.get("result_code").equals("SUCCESS") &&jo.get("return_code").equals("SUCCESS")){
			data1.put("appId",config.getAppID());
			data1.put("package","prepay_id=" + jo.getString("prepay_id"));
			data1.put("nonceStr",jo.getString("nonce_str"));
			String timestamp=Long.toString(System.currentTimeMillis() / 1000);
			data1.put("timeStamp",timestamp);
			data1.put("signType", SignType.MD5.toString());
			String sign = WXPayUtil.generateSignature(data1,config.getKey(),SignType.MD5);//再签名一次
			data1.put("paySign", sign);
			data1.put("partnerid", Utils.getRandomString(12));//生成随机订单号
			data1.put("prepayid", jo.getString("prepay_id"));
		}
		net.sf.json.JSONObject jj=net.sf.json.JSONObject.fromObject(data1);
		joo.put("info", jj);
		return joo;
	}
	/**
	 * 统一下单获取预支付ID
	 * @param result
	 * @param orderNum
	 * @param openId
	 * @param ip
	 * @return
	 * @throws Exception
	 */
	private net.sf.json.JSONObject unifiedOrder(net.sf.json.JSONObject result,String orderNum,String openId,String ip) throws Exception{
		MyConfig config = new MyConfig();
		WXPay wxpay = new WXPay(config);
		Map<String, String> data = new HashMap<String, String>();
		BigDecimal b=new BigDecimal(result.getString("price"));  
		BigDecimal price=b.multiply(new BigDecimal(100));//乘以100(单位：分)  
		data.put("body", result.getString("name"));
		data.put("total_fee",price.intValue()+"");
		data.put("spbill_create_ip",ip);
		data.put("notify_url", config.getCallBackUrl());
		data.put("out_trade_no", orderNum);//生成随机订单号
		data.put("trade_type", "JSAPI");  // 微信公众号支付
		data.put("device_info","WEB");
		data.put("openid",openId);
		Map<String, String> resp = wxpay.unifiedOrder(data);
		net.sf.json.JSONObject jo=net.sf.json.JSONObject.fromObject(resp);
		return jo;
	}

	/**
	 * 成功后的回调地址
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/wxCallServer")
	public @ResponseBody String  wxCallServer(HttpServletRequest request) throws IOException{
		request.setCharacterEncoding("utf-8");
		BufferedReader reader = request.getReader();
		String line="";
		String returnXML ="";
		StringBuffer inputString=new StringBuffer();
		while((line=reader.readLine())!=null){
			inputString.append(line);
		}
		request.getReader().close();
		String result_code = "";
		String return_code = "";
		String out_trade_no = "";
		String openid="";
		try {
			Map<String, String> map = WXPayUtil.xmlToMap(inputString.toString());
			result_code = map.get("result_code");
			out_trade_no = map.get("out_trade_no");
			return_code = map.get("return_code");
			openid=map.get("openid");
			MyConfig config=new MyConfig();
			//重新签名判断签名是否正确
			boolean signatureValid = WXPayUtil.isSignatureValid(map,config.getKey());
			if(signatureValid){//签名正确
				//告诉微信服务器，我收到信息了，不要在调用回调action了
				List<NameValuePair> params=new ArrayList<NameValuePair>();
				params.add(new BasicNameValuePair("tradeNo", out_trade_no));
				params.add(new BasicNameValuePair("openid", openid));
				HttpClientUtils.postRemote("/indecoratebuyorder/orderState",params,null);
				returnXML = returnXML(return_code);
			}else{
				returnXML = returnXML("FAIL");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnXML;
	}


	/** 
	 * 返回给微信服务器的消息 
	 * @param return_code 
	 * @return 
	 */  
	private String returnXML(String return_code) {  
		return "<xml><return_code><![CDATA["  
				+ return_code  
				+ "]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";  
	}  

	/**
	 * 进入订单页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/order.html")
	public ModelAndView toUserOrder(HttpServletRequest request){
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");
		model.put("expId", expId);
		return new ModelAndView("/decorate/order",model);

	}
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
				model.put("isVoucher", s.get("is_voucher"));
				if(!"".equals(s.get("is_voucher"))){
					model.put("voucherId", s.get("voucher_id"));
					model.put("voucherPrice", s.get("price"));
					model.put("voucherName", s.get("name"));

				}
			}
		}else{

			model.put("color", "");
			model.put("bottomPic", "");
			model.put("themeLogo", "");
			model.put("themeTitle", "");
			model.put("themePic", "");
			model.put("isVoucher", "");
			model.put("voucherId","");
			model.put("voucherPrice", "");
			model.put("voucherName","");
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
