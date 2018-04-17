package com.suyin.userCenter;


import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;


/**
 * 
 * 评价功能实现
 * @author wx
 * @version 2015-10-9
 * @see UserDisczController
 * @since
 */
@Controller
@RequestMapping("/discuz")
public class UserDisczController
{

    private static final String ADD_DISCUZ = "/nouserDiscuz/addDiscuz";

    /**
     * 评价信息添加
     * @return 
     * @throws UnsupportedEncodingException 
     * @see
     */
    @RequestMapping(value = "/toDiscuzAddInfo")
    @ResponseBody
    public String toDiscuzAddInfo(HttpServletRequest request)
        throws UnsupportedEncodingException
    {
        return HttpClientUtils.postRemote(ADD_DISCUZ,
        		Utils.convert(request, ModuleNameService.USER_DISCUZ), Utils.getHttpContext(request)).toString();
    }

    /**
     * 评价页面跳转 
     * @return 
     * @see 
     */
    @RequestMapping(value = "toDiscuz")
    public String toASecurity(HttpServletRequest request)
    {
    	String proId=request.getParameter("proId");
    	String memberId=request.getParameter("memberId");
    	String userId=request.getParameter("userId");
    	String detailId=request.getParameter("detailId");
    	String expType=request.getParameter("expType");
    	
    	
    	request.setAttribute("proId", proId);
    	request.setAttribute("memberId", memberId);
    	request.setAttribute("userId", userId);
    	request.setAttribute("detailId", detailId);
    	request.setAttribute("expType", expType);
        return "userCenter/evaluation";
    }
}
