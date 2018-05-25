
package com.suyin.decorate;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;



@Controller
@RequestMapping("/expdecorateuser")
public class ExpDecorateUserController{

    private final static Logger log=Logger.getLogger(ExpDecorateUserController.class);
   
   
    /**
     * 通过用户ID和openId查询用户信息
     * @param userId
     * @param openId
     * @return
     */
    @RequestMapping(value="/findUserInfoByUserIdOrOpenId")
    public @ResponseBody String findUserInfoByUserIdOrOpenId(HttpServletRequest request) {
		String openId = Utils.getOpenId(request);
    	net.sf.json.JSONObject result=HttpClientUtils.getRemote("/inexpdecorateuser/findUserInfoByUserIdOrOpenId" + "?openId="+openId);
		return result.toString();
    }
    
    /**
     * 保存提现订单
     * @param request
     * @return
     */
    @RequestMapping(value = "/saveOrUptateExpDecorateUserInfo")
    public @ResponseBody String saveOrUptateExpDecorateUserInfo(HttpServletRequest request) {
        ModelMap map=new ModelMap();
        String result = HttpClientUtils.postRemote("/inexpdecorateuser/saveOrUptateExpDecorateUserInfo",  Utils.convert(request, ModuleNameService.EXP),null).toString();
        return result;
    }
}

