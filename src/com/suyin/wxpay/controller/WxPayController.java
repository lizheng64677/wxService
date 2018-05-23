package com.suyin.wxpay.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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


	/**
	 * 购买券
	 * @param request
	 * @return
	 */
	@RequestMapping("/wxBuyPay")
	public @ResponseBody String wxBuyPay(HttpServletRequest request){
		String str="";
//		String ip = request.getParameter("ip");  
		String ip="58.240.21.178";
		return getMess(ip);
	}
	/**
	 * 获取随机字符
	 * @param length
	 * @return
	 */
	public  String getRandomString(int length){
		StringBuffer buffer=new StringBuffer("0123456789");
		StringBuffer sb=new StringBuffer();
		Random r=new Random();
		int range=buffer.length();
		for(int i=0;i<length;i++){
			sb.append(buffer.charAt(r.nextInt(range)));
		}
		return sb.toString();
	}
	private String getMess(String ip) {
		JSONObject joo=new JSONObject();
		try {
			String cardname="测试";
			String cardprice="0.01";
			System.out.println("money"+cardprice);
			float cardprice1=Float.parseFloat(cardprice)*100;//微信的支付单位是分所以要转换一些单位
			int cardmoney=(int) cardprice1;
			System.out.println("money1"+cardmoney);
			String totalproce=String.valueOf(cardmoney);
			String orderNum="jspapi"+this.getRandomString(12);
			String timestamp=Long.toString(System.currentTimeMillis() / 1000);
			//插入一条订单记录
			MyConfig config = new MyConfig();
			WXPay wxpay = new WXPay(config);

			Map<String, String> data = new HashMap<String, String>();
			data.put("body", "哈哈哈-"+cardname);
			data.put("out_trade_no", orderNum);//生成随机订单号
			data.put("total_fee", totalproce);
			data.put("spbill_create_ip",ip);
			data.put("notify_url", config.getCallBackUrl());
			data.put("trade_type", "JSAPI");  // 微信公众号支付
			data.put("openid","");
			Map<String, String> resp = wxpay.unifiedOrder(data);
			JSONObject jo=JSONObject.fromObject(resp);
			Map<String, String> data1 = new HashMap<String, String>();
			if(jo.get("result_code").equals("SUCCESS") &&jo.get("return_code").equals("SUCCESS")){
				data1.put("appid",config.getAppID());
				data1.put("partnerid", this.getRandomString(12));//生成随机订单号
				data1.put("prepayid", jo.getString("prepay_id"));
				data1.put("package","Sign=WXPay");
				data1.put("noncestr",jo.getString("nonce_str"));
				data1.put("timestamp",timestamp);
				String sign = WXPayUtil.generateSignature(data1,config.getKey(),SignType.MD5);//再签名一次
				System.out.println(sign);
				data1.put("sign", sign);
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
}
