/*
 * 文件名：ExpInvolvedController.java
 * 版权：Copyright by www.isure.net
 * 描述：
 * 修改人：windows7
 * 修改时间：2015-9-23
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package com.suyin.exp;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

/**
 * 免费活动参与
 * @author lz
 * @version 2015-9-23
 * @see ExpInvolvedController
 * @since
 */
@Controller
@RequestMapping("/expVolved")
public class ExpInvolvedController
{
    //试用式列表
    private static final String FIND_EXP_TRY_LIST="/exp/findExp";
    //参与活动
    private static final String FIND_EXP_inVolvedExp="/inVolve/inVolvedExp";
    //试用式问题收集 
    private static final String FIND_EXP_DETAIINFO="/inVolve/inVolveTry";
    //试用式操作时用户状态及活动状态查询
    private static final String FIND_EXP_USER_TRY_INFO="/inVolve/inVolveTryUserStauts";
    private static final String TRY_EXP_INFO_ADD="/expdetail/involVedTryaddInfo";
    //参与两个赚的活动
    private final String JOINEXPZ="/expz/joinExp";
    //查找试用式列表
    @RequestMapping("/tryListInfo")
    public @ResponseBody String findQixinZhuanList(HttpServletRequest request) {
        return  HttpClientUtils.postRemote(FIND_EXP_TRY_LIST, Utils.convert(request, ModuleNameService.EXP),null).toString();
    }



    /**
     * 参与两个赚的活动
     * 为了不影响全局的用户拦截设置 
     * 在此类中进行所有活动的参加
     * @param request
     * @return 
     * @throws JSONException 
     * @see
     */
    @RequestMapping(value="/joinExpZ")
    public @ResponseBody String joinExpZ(HttpServletRequest request) throws JSONException {
        String result="";
        LoginUser loginUser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        if(null!=loginUser){

            result= HttpClientUtils.postRemote(JOINEXPZ, Utils.convert(request, "a")).toString();
        }else{

            result=tempResultStatus();         
        }
        return result;
    }

    /**
     * 临时解决两个赚未登录的状态
     * @return
     * @throws JSONException 
     * @see
     */
    private String tempResultStatus() throws JSONException{
        JSONObject jso=new JSONObject();
        jso.put("msg", "3");//提示登录操作
        jso.put("error","0");
        return jso.toString();
    }


    /**
     * 人气式活动参与
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedExpPop")
    public @ResponseBody String involVedExpPop(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String result="";
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        if(null!=loguser){

            result=HttpClientUtils.getRemote(FIND_EXP_inVolvedExp+"?regtype=0&expId="+expId+"&userId="+loguser.getUserid()+"&detailId="+detailId+"&memberId="+memberId+"&expType=1").toString();

        }else{

            result=this.notFindUserInfo();
        }
        return result;
    }

    private boolean  isLogUserStatus(HttpServletRequest request){
        boolean status=false;
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        if(null!=loguser){

            status=true;
        }
        return status;
    }

    private String notFindUserInfo(){

        JSONObject js=new JSONObject();
        try
        {
            js.put("error", "0");
            js.put("message","notregUser");//没有注册
        }
        catch (JSONException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return js.toString();
    }

    /**
     * 抽奖式活动参与
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedPrize")
    public @ResponseBody String involVedPrize(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        String result="";
        if(null!=loguser){

            result=HttpClientUtils.getRemote(FIND_EXP_inVolvedExp+"?regtype=0&expId="+expId+"&userId="+loguser.getUserid()+"&detailId="+detailId+"&memberId="+memberId+"&expType=0").toString();
        }else{

            result=this.notFindUserInfo();
        }
        return result;
    }


    /**
     * 兑换式活动参与
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedEchage")
    public @ResponseBody String involVedEchage(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        String result="";
        if(null!=loguser){
            result=HttpClientUtils.getRemote(FIND_EXP_inVolvedExp+"?regtype=0&expId="+expId+"&userId="+loguser.getUserid()+"&detailId="+detailId+"&memberId="+memberId+"&expType=2").toString();
        }else{

            result=this.notFindUserInfo();
        }
        return result;
    }


    /**
     * 问卷页面弹出是查看当前用户是否已经参与过活动了 
     * @param exp
     * @param condition
     * @return 
     * @see
     */
    @RequestMapping(value="/inVolveTryUserStauts")
    public @ResponseBody String inVolveTryUserStauts(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        String result="";
        if(null!=loguser){

            result=HttpClientUtils.getRemote(FIND_EXP_USER_TRY_INFO+"?expId="+expId+"&userId="+loguser.getUserid()+"&detailId="+detailId+"&memberId="+memberId+"&expType=1").toString();
        }else{

            result=this.notFindUserInfo();
        }
        return result;
    }

    /**
     * 试用式活动参与
     * 参与活动 
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedTry")
    public @ResponseBody String involVedTry(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        String result="";
        if(null!=loguser){

            result=HttpClientUtils.getRemote(FIND_EXP_inVolvedExp+"?regtype=0&expId="+expId+"&userId="+loguser.getUserid()+"&detailId="+detailId+"&memberId="+memberId+"&expType=3").toString();
        }else{

            result=this.notFindUserInfo();
        }
        return result;
    }

    /**
     * 
     * 保存试用问卷信息
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedTryaddInfo")
    public String dd(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String jsonData=request.getParameter("paramdata");
        String expId=request.getParameter("expId");
        String result="";
        if(null!=loguser){

            result=HttpClientUtils.postRemote(TRY_EXP_INFO_ADD,  Utils.convert(request, "no"),null).toString();

        }else{

            result=this.notFindUserInfo();
        }
        return "";
    }

}
