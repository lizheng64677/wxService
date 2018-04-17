package com.suyin.userCenter;

import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;


/**
 * 处理用户登录注册的一切ajax请求但不包括进入登录注册页面的请求
 * @author Administrator
 *
 */
@RequestMapping("/userlr")
@Controller
public class UserLoginAndRegisterController
{
    /**登录*/
    private static final String LOGIN = "/nouser/login";

    /**注册*/
    private static final String REGNOUSER = "/nouser/regNouser";

    /**注册时获取验证码*/
    private static final String REQUESTNUMBER = "/nouser/requestNumber";

    /**修改提现密码时获取验证码*/
    private static final String WITHDRAWALSCODE = "/nouser/withdrawalsCode"; 

    /**修改提现密码 */
    private static final String MODIFYWITHDRAWALSPASSWORD = "/nouser/modifyWithdrawalsPassword";

    /**注册时验证手机是否重复*/
    private static final String VALIDUSERINFO = "/nouser/validUserInfo";

    /**图片上传地址*/
    private static final String UPLOAD_URL = "/fileUpload/upload";

    /**安全账户数据提交**/
    private static final String SECURITY_URL = "/nouser/updateSecurityInfo";

    /**根据userId查询用户是否设置安全账户**/
    private static final String FIND_SECUITY_USERINFO = "/nouser/findSecurityUserInfo";

    /**用户找回密码*/
    private static final String BACK_PWD = "/nouser/backpwd";

    /**用户找回密码**/
    private static final String BACK_PASSWORD = "/nouser/forgetPwd";

    /**用户获取找回密码的验证码*/
    private static final String BACK_CODE_NUMBER = "/nouser/backCodeNumber";

    private static final String UPDATE_STATUS = "/nouser/updateStatus";
    /**
     * 
     * 用户登录
     * @param request
     * @return
     * @throws JSONException 
     * @see
     */
    @RequestMapping(value = "/login")
    public @ResponseBody
    String login(HttpServletRequest request)throws JSONException
    {
        //逃过前台验证的,显然不是正规途径进来的，不必客气
        if (!Utils.isInvalidParameters(request, "userPhone", "userPassword")) return null;
        JSONObject jso = HttpClientUtils.postRemote(LOGIN,Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request));

        if ("success".equalsIgnoreCase(jso.getString("message")))
        {
            org.json.JSONObject js = new org.json.JSONObject(jso.get("data").toString());
            LoginUser user = new LoginUser();
            user.setUserid(js.get("userid").toString());
            user.setUserPhone(js.get("userPhone").toString());
            user.setOpenid(js.get("openid").toString());
            user.setState(js.get("state").toString());
            request.getSession().setAttribute(Constant.SESSION_LOGIN_USER, user);
        }


        return jso.toString();
    }

    @RequestMapping(value="/updateStatus")
    public @ResponseBody String updateStatus(HttpServletRequest request){
        String result="";
        //逃过前台验证的,显然不是正规途径进来的，不必客气
        try
        {
            if (!Utils.isInvalidParameters(request, "userPhone", "userPassword")) return null;

            result= HttpClientUtils.postRemote(UPDATE_STATUS,Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;

    }

    /**
     * 用户注册
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/register")
    public @ResponseBody  String register(HttpServletRequest request)
    {
        if (!Utils.isInvalidParameters(request, "userPhone", "userPassword", "code"))
        {
            return null;
        }
        JSONObject jso = HttpClientUtils.postRemote(REGNOUSER, Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request));
        if ("success".equalsIgnoreCase(jso.getString("message")))
        {

        }
        return jso.toString();
    }

    /**
     * 获取效验验证码
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/getCheckCode")
    public @ResponseBody
    String getCheckCode(HttpServletRequest request)
    {
        if (!Utils.isInvalidParameters(request, "userPhone"))
        {
            return null;
        }
        //如果手机格式不正确，说明逃过了前台验证，直接返回去,避免过度消耗资源
        if (!Pattern.compile(Constant.PHONE_PATTERN).matcher(request.getParameter("userPhone")).matches())
        {
            return null;
        }
        String str = HttpClientUtils.postRemote(REQUESTNUMBER,
            Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
        return str;
    }

    /**
     * 获取修改提现密码验证码
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/getWithdrawalsCode")
    public @ResponseBody
    String getWithdrawalsCode(HttpServletRequest request)
    {
        if (!Utils.isInvalidParameters(request, "userPhone"))
        {
            return null;
        }
        //如果手机格式不正确，说明逃过了前台验证，直接返回去,避免过度消耗资源
        if (!Pattern.compile(Constant.PHONE_PATTERN).matcher(request.getParameter("userPhone")).matches())
        {
            return null;
        }
        String str = HttpClientUtils.postRemote(WITHDRAWALSCODE,
            Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
        return str;
    }

    /**
     * 修改提现密码
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/modifyWithdrawalsPwd")
    public @ResponseBody
    String modifyWithdrawalsPwd(HttpServletRequest request)
    {
        if (!Utils.isInvalidParameters(request, "userPhone", "userId", "wPwd", "code"))
        {
            return null;
        }
        String str = HttpClientUtils.postRemote(MODIFYWITHDRAWALSPASSWORD,
            Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
        return str;
    }

    /**
     * 个人中心及活动参与手机号码验证
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/checkPhone")
    public @ResponseBody
    String checkPhone(HttpServletRequest request)
    {
        if (!Utils.isInvalidParameters(request, "userPhone"))
        {
            return null;
        }
        if (!Pattern.compile(Constant.PHONE_PATTERN).matcher(request.getParameter("userPhone")).matches())
        {
            return null;
        }
        String str = HttpClientUtils.postRemote(VALIDUSERINFO,
            Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
        return str;

    }

    /**
     * 全民赚订单_参与图片上传
     * @param request
     * @return 
     * @see
     */
    @RequestMapping("/fileUpload")
    public @ResponseBody
    String fileUpload(HttpServletRequest request)
    {
        return HttpClientUtils.postRemote(UPLOAD_URL,
            Utils.convert(request, ModuleNameService.USER), null).toString();
    }

    /**
     * 
     * 更新个人中心安全账户操作 
     * 
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/updateSecurityInfo")
    public @ResponseBody   String updateSecurityInfo(HttpServletRequest request){

        String result=HttpClientUtils.postRemote(SECURITY_URL, Utils.convert(request, "no"), null).toString();
        return result;
    }

    /**
     * 
     * 根据userId查询用户是否设置安全账户
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/findSecurityUserInfo")
    public @ResponseBody String findSecurityUserInfo(HttpServletRequest request){

        String result = "";
        result = HttpClientUtils.getRemote(FIND_SECUITY_USERINFO + "?userId=" + this.getUserId(request)).toString();
        return result;
    }

    /**
     *获取session中参数 
     * @param request
     * @return 
     * @see
     */
    private String getUserId(HttpServletRequest request){

        return ((LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER)).getUserid();
    }

    /**
     * 忘记密码，获取验证码
     * @param request
     * @return 
     * @see
     */
    @RequestMapping("/backCodeNumber")
    public @ResponseBody  String backCodeNumber(HttpServletRequest request){
        //如果手机格式不正确，说明逃过了前台验证，直接返回去,避免过度消耗资源
        if (!Pattern.compile(Constant.PHONE_PATTERN).matcher(request.getParameter("userPhone")).matches()){
            return null;
        }
        return HttpClientUtils.postRemote(BACK_CODE_NUMBER,Utils.convert(request, ModuleNameService.USER), null).toString();
    }

    /**
     * 忘记密码
     * @param request
     * @return 
     * @see
     */
    @RequestMapping("/backPWD")
    public @ResponseBody String backPWD(HttpServletRequest request){

        if (!Utils.isInvalidParameters(request, "userPhone", "newPassword", "code")){

            return null;
        }
        return HttpClientUtils.postRemote(BACK_PASSWORD, Utils.convert(request, ModuleNameService.USER), Utils.getHttpContext(request)).toString();
    }
}
