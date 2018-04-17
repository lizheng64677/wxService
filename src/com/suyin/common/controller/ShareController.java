package com.suyin.common.controller;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.utils.SystemPropertiesHolder;
import com.suyin.utils.WxUtils;

/**
 * 要自定义微信的分享必须经过这个controller的toShare方法处理一下
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/share")
public class ShareController {

	@RequestMapping("/sharePrepare")
	@ResponseBody
	public String sharePrepare(@RequestParam("url") String url, HttpServletRequest request) {
		JSONObject jso=new JSONObject();
		String nonceStr=UUID.randomUUID().toString();
		String timestamp=Long.toString(System.currentTimeMillis() / 1000);
		jso.put("nonceStr", nonceStr);
		jso.put("timestamp", timestamp);
		jso.put("appId", SystemPropertiesHolder.get("APP_ID"));
		jso.put("signature", this.getSignature(nonceStr, timestamp, WxUtils.getJspApi(request), url));
		jso.put("status", "ok");
		return jso.toString();
	}
	
	private String getSignature(String nonceStr,String timestamp,String jsapi_ticket,String url) {
		String signature=null;
		String   string1 = "jsapi_ticket=" + jsapi_ticket +
	            "&noncestr=" + nonceStr +
	            "&timestamp=" + timestamp +
	            "&url=" + url;
	    MessageDigest crypt;
		try {
			crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(string1.getBytes("UTF-8"));
			signature = byteToHex(crypt.digest());
		} catch (Exception e) {
			throw new RuntimeException();
		}
        return signature;
	}
	
    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
}
