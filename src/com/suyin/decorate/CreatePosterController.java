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

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;
/**
 * 我的专属海报生成
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/createpost")
public class CreatePosterController {

	
	/**
	 * 图片流返回
	 * @param request
	 * @param response
	 */
	@RequestMapping("/writeImage")
	public @ResponseBody String getWriteImages(HttpServletRequest request,HttpServletResponse response){
		String result=HttpClientUtils.postRemote("/qrcode/create",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}
	/**
	 *  创建海报页面跳转
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping("/create.html")
	public ModelAndView toIntroduction(HttpServletRequest request,HttpServletResponse response) throws JSONException{
		ModelMap  model=new ModelMap();
		String expId=request.getParameter("id");
		String publishopenid=Utils.getOpenId(request);
		model=setDataInfo(expId);
		model.put("expId",expId);
		model.put("publishopenid",publishopenid);
		return new ModelAndView("/decorate/create",model);
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
	
}
