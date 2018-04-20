package com.suyin.decorate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    @RequestMapping(value="/share")
    public ModelAndView share(HttpServletRequest request,HttpServletResponse response){
        ModelMap  model=new ModelMap();
        return new ModelAndView("decorate/share",model);
    }
    
    
    /**
     * 活动首页面跳转
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/index")
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
    @RequestMapping(value="/account")
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
    @RequestMapping(value="/center")
    public ModelAndView center(HttpServletRequest request,HttpServletResponse response){
        ModelMap  model=new ModelMap();
        return new ModelAndView("decorate/center",model);
    }

}
