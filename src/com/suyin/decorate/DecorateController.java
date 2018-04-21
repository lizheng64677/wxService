package com.suyin.decorate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
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
	 * 分享页面跳转
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
        return new ModelAndView("decorate/index",model);
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
