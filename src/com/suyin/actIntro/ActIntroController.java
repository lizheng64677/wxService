/*
 * 文件名：ActIntroController.java
 * 版权：Copyright by www.suyin.net
 * 描述：
 * 修改人：WX
 * 修改时间：2015-10-23
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package com.suyin.actIntro;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.NameValuePair;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

@Controller
@RequestMapping("/actIntro")
public class ActIntroController {

    @RequestMapping("/toIntroDetail")
    public String toIntroduction() {
	return "/actIntro/intro";
    }

    @RequestMapping(value = "/get")
    public @ResponseBody
    String getIntroduct(HttpServletRequest request) {
	List<NameValuePair> list = Utils.convert(request, "actIntro");
	return HttpClientUtils.postRemote("/no/actIntro", list).toString();
    }
}
