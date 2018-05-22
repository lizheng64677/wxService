package com.suyin.wxpay.service.impl;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import com.suyin.utils.Utils;
import com.suyin.wxpay.service.WXPayConfig;

public class MyConfig implements WXPayConfig{
	private byte[] certData;
	public MyConfig() throws Exception {	
		//从微信商户平台下载的安全证书存放的目录
		File file = new File(Utils.cerUrl);
		InputStream certStream = new FileInputStream(file);
		this.certData = new byte[(int) file.length()];
		certStream.read(this.certData);
		certStream.close();
	}
	public String getAppID() {
		return Utils.appId;//如初appid
	}

	public String getMchID() {
		return Utils.mchID;//商户号
	}	

	public String getKey() {
		return Utils.wxcallBackUrl;//密钥
	}

	public InputStream getCertStream() {
		ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
		return certBis;
	}
	public int getHttpConnectTimeoutMs() {
		return 8000;
	}
	public int getHttpReadTimeoutMs() {
		return 10000;
	}
	
	public String getCallBackUrl() {
		// TODO Auto-generated method stub
		return Utils.wxcallBackUrl;
	}
}