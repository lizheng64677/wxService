package com.suyin.wxpay.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.common.service.ModuleNameService;
import com.suyin.decorate.ExpDecorateUserController;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;
import com.suyin.wxpay.WXPayConstants.SignType;
import com.suyin.wxpay.WXPayUtil;
import com.suyin.wxpay.service.WXPay;
import com.suyin.wxpay.service.impl.MyConfig;

/**
 * 微信支付
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/wxPay")
public class WxPayController {
    private final static Logger log=Logger.getLogger(WxPayController.class);

	/**
	 * 购买券
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wxbuy")
	public @ResponseBody String wxbuy(HttpServletRequest request){
		String str="";
		String id = request.getParameter("id");  
		String name =request.getParameter("name");
		String openId=Utils.getOpenId(request);
		String ip=Utils.getIpAddr(request);
		System.out.println(ip);		
		JSONObject jo=this.unifiedSign(name, openId, ip);
		return getInfo(jo);
	
		
	}
	/**
	 * 首次签名
	 * @param name
	 * @param openId
	 * @param ip
	 * @return
	 */
	private JSONObject unifiedSign(String name,String openId,String ip){
		String orderNum=Utils.getRandomString(32);
		//插入一条订单记录
		MyConfig config = new MyConfig();
		WXPay wxpay = new WXPay(config);
		Map<String, String> data = new HashMap<String, String>();
		data.put("body", "福券-"+name);
		data.put("total_fee", "1");
		data.put("spbill_create_ip",ip);
		data.put("notify_url", config.getCallBackUrl());
		data.put("out_trade_no", orderNum);//生成随机订单号
		data.put("trade_type", "JSAPI");  // 微信公众号支付
		data.put("device_info","WEB");
		data.put("openid",openId);
		try {
			Map<String, String> resp= wxpay.unifiedOrder(data);
			JSONObject jo=JSONObject.fromObject(resp);
			return jo;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error(e);
		}
		return null;
		
	}

	/**
	 * 二次签名返回至前端发起方
	 * @param jo
	 * @return
	 */
	private String getInfo(JSONObject jo) {
		JSONObject joo=new JSONObject();
		try {	
			String timestamp=Long.toString(System.currentTimeMillis() / 1000);
			MyConfig config = new MyConfig();
			Map<String, String> data1 = new HashMap<String, String>();
			if(jo.get("result_code").equals("SUCCESS") &&jo.get("return_code").equals("SUCCESS")){
				data1.put("appId",config.getAppID());
				data1.put("partnerid", Utils.getRandomString(12));//生成随机订单号
				data1.put("prepayid", jo.getString("prepay_id"));
				data1.put("package","prepay_id=" + jo.getString("prepay_id"));
				data1.put("nonceStr",jo.getString("nonce_str"));
				data1.put("timeStamp",timestamp);
				String sign = WXPayUtil.generateSignature(data1,config.getKey(),SignType.MD5);//再签名一次
				System.out.println(sign);
				data1.put("paySign", sign);
				data1.put("signType", SignType.MD5.toString());
			}
			JSONObject jj=JSONObject.fromObject(data1);
			joo.put("info", jj);

		} catch (Exception e) {
			log.error(e);
		}
		return joo.toString();
	}

	/**
	 * 成功后的回调地址
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/callurl")
	public @ResponseBody String  callurl(HttpServletRequest request) throws IOException{
		request.setCharacterEncoding("utf-8");
		System.out.println("來到了這裏");
		BufferedReader reader = request.getReader();
		String line="";
		String returnXML ="";
		StringBuffer inputString=new StringBuffer();
		while((line=reader.readLine())!=null){
			inputString.append(line);
		}
		request.getReader().close();
		System.out.println("接受到的報文"+inputString.toString());
		String result_code = "";
		String return_code = "";
		String out_trade_no = "";
		try {
			Map<String, String> map = WXPayUtil.xmlToMap(inputString.toString());
			result_code = map.get("result_code");
			out_trade_no = map.get("out_trade_no");
			return_code = map.get("return_code");
			MyConfig config=new MyConfig();
			//重新签名判断签名是否正确
			boolean signatureValid = WXPayUtil.isSignatureValid(map,config.getKey());
			if(signatureValid){//签名正确
				//更新数据库  1，订单 2，userid表
				//告诉微信服务器，我收到信息了，不要在调用回调action了
				//				boolean updateOrderInfo = WxAndAliPayService.updateOrderInfo(out_trade_no);
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
	 * 购买券
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wxBuyPay")
	public @ResponseBody String wxBuyPay(HttpServletRequest request){
		String str="";
		String id = request.getParameter("id");  
		String openId=Utils.getOpenId(request);
		String ip=Utils.getIpAddr(request);
		System.out.println(ip);
		return getMess(request,ip,openId);
	}

	private String getMess(HttpServletRequest request,String ip,String openId) {
		JSONObject joo=new JSONObject();
		try {
			String cardname="testcardname";
			String orderNum=Utils.getRandomString(32);
			System.out.println("内部订单号"+orderNum);
			//插入一条订单记录
			MyConfig config = new MyConfig();
			WXPay wxpay = new WXPay(config);
			Map<String, String> data = new HashMap<String, String>();
			data.put("body", "pro-"+cardname);
			data.put("total_fee", "1");
			data.put("spbill_create_ip",ip);
			data.put("notify_url", config.getCallBackUrl());
			data.put("out_trade_no", orderNum);//生成随机订单号
			data.put("trade_type", "JSAPI");  // 微信公众号支付
			data.put("device_info","WEB");
			data.put("openid",openId);
			Map<String, String> resp = wxpay.unifiedOrder(data);
			JSONObject jo=JSONObject.fromObject(resp);
			Map<String, String> data1 = new HashMap<String, String>();
			if(jo.get("result_code").equals("SUCCESS") &&jo.get("return_code").equals("SUCCESS")){
				data1.put("appId",config.getAppID());
				data1.put("partnerid", Utils.getRandomString(12));//生成随机订单号
				data1.put("prepayid", jo.getString("prepay_id"));
				data1.put("packageStr","prepay_id=" + jo.getString("prepay_id"));
				data1.put("nonceStr",jo.getString("nonce_str"));
				String timestamp=Long.toString(System.currentTimeMillis() / 1000);
				data1.put("timeStamp",timestamp);
				String sign = WXPayUtil.generateSignature(data1,config.getKey(),SignType.MD5);//再签名一次
				System.out.println(sign);
				data1.put("paySign", sign);
				data1.put("signType", SignType.MD5.toString());

			}
			JSONObject jj=JSONObject.fromObject(data1);
			joo.put("info", jj);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return joo.toString();
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
		System.out.println("來到了這裏");
		BufferedReader reader = request.getReader();
		String line="";
		String returnXML ="";
		StringBuffer inputString=new StringBuffer();
		while((line=reader.readLine())!=null){
			inputString.append(line);
		}
		request.getReader().close();
		System.out.println("接受到的報文"+inputString.toString());
		String result_code = "";
		String return_code = "";
		String out_trade_no = "";
		try {
			Map<String, String> map = WXPayUtil.xmlToMap(inputString.toString());
			result_code = map.get("result_code");
			out_trade_no = map.get("out_trade_no");
			return_code = map.get("return_code");
			MyConfig config=new MyConfig();
			//重新签名判断签名是否正确
			boolean signatureValid = WXPayUtil.isSignatureValid(map,config.getKey());
			if(signatureValid){//签名正确
				//更新数据库  1，订单 2，userid表
				//告诉微信服务器，我收到信息了，不要在调用回调action了
				//				boolean updateOrderInfo = WxAndAliPayService.updateOrderInfo(out_trade_no);
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
	
	public static void main(String[] args) {
		String timestamp=Long.toString(System.currentTimeMillis() / 1000);
		System.out.println(timestamp);
		
		   System.out.println(System.currentTimeMillis() / 1000);
	        System.out.println(Calendar.getInstance().getTimeInMillis() / 1000);
	        System.out.println(new Date().getTime() / 1000);
	}

}
