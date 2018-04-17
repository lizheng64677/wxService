package com.suyin.city;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

@Controller
@RequestMapping("/city")
public class CityController {
	//热门城市
    private static final String FIND_HOTCITY_INFO="/city/findHotCity";
    //城市定位
    private static final String FIND_CITY="/city/findCity";
    
	
	//进入城市选择页面
	@RequestMapping(value="/toCitySelection")
	public ModelAndView toCitySelection(HttpServletRequest request)
	{
		ModelMap model=new ModelMap();
		model.put("lat", request.getParameter("lat"));	
		model.put("lng",request.getParameter("lng"));	
		return new ModelAndView("city/citySelection",model);
	}
		
	/**
	 * 获取热门城市信息
	 */
	@RequestMapping(value="/findHotCityInfo")
	public @ResponseBody String findHotCityInfo(HttpServletRequest request)
	{
		String result=HttpClientUtils.postRemote(FIND_HOTCITY_INFO,Utils.convert(request, ModuleNameService.CITY),null).toString();
		return result;
		
	}
	
	/**
	 * 获取城市定位的城市信息
	 */
	@RequestMapping(value="/findCityInfoByName")
	public @ResponseBody String findCityInfoByName(HttpServletRequest request)
	{
		String result=HttpClientUtils.postRemote(FIND_CITY, Utils.convert(request, ModuleNameService.CITY), null).toString();
		return result;
	}
}
