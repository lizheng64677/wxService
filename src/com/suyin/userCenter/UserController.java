package com.suyin.userCenter;


import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.http.NameValuePair;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.SystemPropertiesHolder;
import com.suyin.utils.Utils;


/**
 * 用户中心的请求比较多，为了防止controller过大，拆分usercenter的请求
 * 
 * UserController 只负责进入某个页面必须的分发，进入页面后的逻辑一概不管
 * 如：进入签到页，我的参与页，我的消息页，体验店地址页，合作商家页
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/user")
public class UserController
{
    private static final String FIND_EXP_ZHUAN_DETAIL = "/nouser/findUserByOpenId?openid=";
    //是否完善资料
    private static final String  FIND_EXP_ALLbYWX="/noUserPrototype/queryUserPrototypeAllByWx?userId=";
    //到个人中心首页
    @RequestMapping("/toMain")
    public ModelAndView toIndex(HttpServletRequest request)
    {
        ModelMap model=new ModelMap();
        if (request.getSession().getAttribute(Constant.SESSION_LOGIN_USER) == null)
        {
            JSONObject jso = HttpClientUtils.getRemote(FIND_EXP_ZHUAN_DETAIL+request.getSession().getAttribute(Constant.SESSION_OPEN_ID));
            if ("1".equals(jso.getString("error"))) throw new RuntimeException("请求时网络出错了");
            if ("success".equals(jso.getString("message")))
            {
                LoginUser user = new LoginUser();
                user.setUserid(jso.getString("userid"));
                user.setOpenid(jso.getString("openid")); 
                user.setState(jso.getString("state"));
                request.getSession().setAttribute(Constant.SESSION_LOGIN_USER, user);

            }
        }else{
            //资料是否完成判断 
            LoginUser logUser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
            String count = HttpClientUtils.getRemoteGyString(FIND_EXP_ALLbYWX+logUser.getUserid());
            if(count.equals("0")){

                model.put("isWait", "N");
            }else{

                model.put("isWait", "Y");
            }

        }
        return new ModelAndView("userCenter/index",model);
    }

    //进入登录页
    @RequestMapping(value = "/toLogin")
    public String toLogin()
    {
        return "userCenter/login";
    }

    //进入注册页
    @RequestMapping(value = "/toRegister")
    public String toRegister(HttpServletRequest request)
    {
        return "userCenter/register";
    }

    //进入签到页
    @RequestMapping(value = "/toSignIn")
    public String toSignIn()
    {
        return "userCenter/signIn";
    }

    //进入我的参与页
    @RequestMapping(value = "/toMyJoin")
    public String toMyJoin()
    {
        return "userCenter/myJoin";
    }

    //进入我的消息页
    @RequestMapping(value = "/toMyMessage")
    public String toMyMessage()
    {
        return "userCenter/myMessage";
    }

    //进入体验店地址
    @RequestMapping(value = "/toAddressList")
    public String toAddressList()
    {
        return "userCenter/about/addressList";
    }

    //进入合作商家
    @RequestMapping(value = "/toCompany")
    public String toCompany()
    {
        return "userCenter/about/company";
    }

    //进入我的钱包
    @RequestMapping(value = "toWallet")
    public String toWallet()
    {
        return "userCenter/wallet";
    }

    //进入我的金币
    @RequestMapping(value = "toCoin")
    public String toCoin()
    {
        return "userCenter/coin";
    }

    //进入我的参与
    @RequestMapping(value = "/toInvolvement")
    public String toInvolvement()
    {
        return "userCenter/involvement";
    }

    //进入我的券
    @RequestMapping(value = "/toVouch")
    public String toVouch()
    {
        return "userCenter/vouch";
    }

    //进入我的券
    @RequestMapping(value = "/tocoin2Cash")
    public String tocoin2Cash()
    {
        return "userCenter/coinToCash";
    }

    /**
     * 提现至支付宝页面跳转
     * @return 
     * @see
     */
    @RequestMapping(value = "/toCash2Ali")
    public ModelAndView toCash2Ali(HttpServletRequest request)
    {
        ModelMap model = new ModelMap();
        LoginUser loguser = (LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        try
        {
            String str = HttpClientUtils.getRemote("/nouser/findNouserStaticInfo?userId=" + loguser.getUserid()).toString();
            org.json.JSONObject js = new org.json.JSONObject(str);
            org.json.JSONObject ji = new org.json.JSONObject(js.get("result").toString());

            if ("success".equals(ji.get("message")))
            {
                org.json.JSONObject jo = new org.json.JSONObject(ji.get("data").toString());
                model.put("user_id", jo.get("user_id"));
                model.put("gold_coin", jo.get("gold_coin"));
                model.put("frozen_gold_coin", jo.get("frozen_gold_coin"));
                model.put("money", jo.get("money"));
                model.put("frozen_money", jo.get("frozen_money"));
                model.put("ali_pay", jo.get("ali_pay"));
                model.put("ali_user_name", jo.get("ali_user_name"));
                model.put("withdrawals_password", jo.get("withdrawals_password"));
                model.put("user_phone", jo.get("user_phone"));
                model.put("user_password", jo.get("user_password"));
            }
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return new ModelAndView("userCenter/cashToAli", model);
    }

    //进入我的资料
    @RequestMapping(value = "/toMyInfo")
    public String toMyInfo(HttpServletRequest request)
    {
        String userId = "";
        if (null != request.getParameter("userId"))
        {
            userId = request.getParameter("userId");
            request.setAttribute("userId", userId);
        }
        else
        {
            LoginUser loginUser = (LoginUser)request.getSession().getAttribute(
                Constant.SESSION_LOGIN_USER);
            userId = loginUser.getUserid();
            request.setAttribute("userId", userId);
        }
        //进入之前判断是否全部完善资料，没有则进入完善资料页面
        String count = HttpClientUtils.getRemoteGyString("/noUserPrototype/queryUserPrototypeAllByWx?userId="+ userId);
        if (count.equals("0"))
        {
            //进入完善资料页面
            if (null != request.getParameter("version")
                && ("ios".equals(request.getParameter("version")) || "android".equals(request.getParameter("version"))))
            {

                return "redirect:/userProblem?version=ios&userId=" + userId;
            }
            return "redirect:/userProblem";
        }
        else
        {
            if (null != request.getParameter("version")
                && ("ios".equals(request.getParameter("version")) || "android".equals(request.getParameter("version"))))
            {
                request.setAttribute("version", request.getParameter("version"));
            }
            else
            {
                request.setAttribute("version", "no");
            }
        }

        request.setAttribute("baseUrl", SystemPropertiesHolder.get("ROOT_URL"));
        //获取城市接口
        request.setAttribute("citys",
            HttpClientUtils.getRemoteGyString("/noUserPrototype/findCitysByInface"));
        request.setAttribute(
            "userCitys",
            HttpClientUtils.getRemoteGyString("/noUserPrototype/findUserCitysByInface?userId="
                + userId));
        //获取当前用户是否可以修改资料
        request.setAttribute(
            "updateFlg",
            HttpClientUtils.getRemoteGyString("/noUserPrototype/findUserUpdateFlg?userId="
                + userId));
        return "userCenter/myInformation";
    }

    //进入我的资料
    @RequestMapping(value = "/toAbout")
    public String toAbout()
    {
        return "userCenter/about/notuan";
    }

    //进入我的资料
    @RequestMapping(value = "/toIntroduct")
    public String toIntroduct()
    {
        return "userCenter/about/introduct";
    }

    @RequestMapping(value = "/toProtocol")
    public String toProtocol()
    {
        return "userCenter/about/protocol";
    }

    /**
     * 安全账户页面跳转
     * @param request
     * @return
     * @throws JSONException 
     * @see
     */
    @RequestMapping(value = "toASecurity")
    public ModelAndView toASecurity(HttpServletRequest request)
        throws JSONException
        {
        ModelMap model = new ModelMap();
        LoginUser loguser = (LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        try
        {
            String str = HttpClientUtils.getRemote("/nouser/findNouserStaticInfo?userId=" + loguser.getUserid()).toString();
            org.json.JSONObject js = new org.json.JSONObject(str);
            org.json.JSONObject ji = new org.json.JSONObject(js.get("result").toString());

            if ("success".equals(ji.get("message")))
            {
                org.json.JSONObject jo = new org.json.JSONObject(ji.get("data").toString());
                model.put("user_id", jo.get("user_id"));
                model.put("gold_coin", jo.get("gold_coin"));
                model.put("frozen_gold_coin", jo.get("frozen_gold_coin"));
                model.put("money", jo.get("money"));
                model.put("frozen_money", jo.get("frozen_money"));
                model.put("ali_pay", jo.get("ali_pay"));
                model.put("ali_user_name", jo.get("ali_user_name"));
                model.put("withdrawals_password", jo.get("withdrawals_password"));
                model.put("user_phone", jo.get("user_phone"));
                model.put("user_password", jo.get("user_password"));
            }
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return new ModelAndView("userCenter/accountSecurity", model);
        }

    /**
     * 头像上传
     * @return 
     * @throws UnsupportedEncodingException 
     * @see
     */
    @RequestMapping(value = "/toUploadHead")
    @ResponseBody
    public String toDiscuzAddInfo(HttpServletRequest request)throws UnsupportedEncodingException{

        return HttpClientUtils.postRemote("/nouserCenter/uploadHead",Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
    }

    /**
     * 进入忘记密码页面
     * @return 
     * @see
     */
    @RequestMapping(value = "/toBackPWD")
    public String toBackPWD()
    {
        return "userCenter/backPassword";
    }

    /**
     * 签到
     * @return 
     * @see
     */
    @RequestMapping(value = "/signInByDay")
    @ResponseBody
    public String signIn(HttpServletRequest request)
    {
        return HttpClientUtils.postRemote("/nouserCenter/signIn",Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
    }

    /**
     * 进入忘记密码页面
     * @return 
     * @see
     */
    @RequestMapping(value = "/toWithPwd")
    public ModelAndView toWithPwd(HttpServletRequest request)
    {
        ModelMap model = new ModelMap();
        try {
            LoginUser loguser = (LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
            String str = HttpClientUtils.getRemote("/nouser/findNouserStaticInfo?userId=" + loguser.getUserid()).toString();
            org.json.JSONObject js = new org.json.JSONObject(str);
            org.json.JSONObject ji = new org.json.JSONObject(js.get("result").toString());

            if ("success".equals(ji.get("message")))
            {
                org.json.JSONObject jo = new org.json.JSONObject(ji.get("data").toString());
                model.put("user_id", jo.get("user_id"));
                model.put("user_phone", jo.get("user_phone"));
            }
            model.put("userPhone", loguser.getUserPhone());

        } catch (JSONException e) {
            e.printStackTrace();
        }
        return new ModelAndView("userCenter/modifyWithdrawalsPwd", model);
    }

}
