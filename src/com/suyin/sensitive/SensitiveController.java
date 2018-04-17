package com.suyin.sensitive;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;


@RequestMapping("/sen")
@Controller
public class SensitiveController
{
    /**获取用户参与*/
    private final String INVOLVEMENT = "/nouserCenter/findInvolvement";

    /**获取用户的券*/
    private final String VOUCH = "/nouserCenter/findVouch";

    /**获取用户钱包变化记录*/
    private final String WALLET = "/nouserCenter/findCashLog";

    /**获取用户金币的变化记录*/
    private final String COIN = "/nouserCenter/findCoinLog";

    /**获取用户的一些属性，如钱，金币，等等*/
    private final String USERINFO = "/nouserCenter/userInfo";

    /**获取我的消息*/
    private final String MESSAGE = "/nouserCenter/findMessage";

    private final String COIN2CASH = "/nouserCenter/coinToCash";

    //有人点击了齐心赚分享出去的东西，只有要加金币什么的,该方法其实没有什么好返回的
    private static final String CLICKEXPTASKB = "/expz/clickExpTaskB";

    /**获取用户的一些属性，如钱，金币，等等，附带签到状态*/
    private final String USERINFO_AND_SIGNIN = "/nouserCenter/userInfoAndSignIn";

    @RequestMapping(value = "/getUserSInfo")
    public @ResponseBody  String getUserSInfo(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(USERINFO,  Utils.convert(request, "no"),null).toString();
        return result;
    }

    @RequestMapping(value = "/getInvolvement")
    public @ResponseBody   String getInvolvement(HttpServletRequest request){

        String result=HttpClientUtils.postRemote(INVOLVEMENT, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/getVouch")
    public @ResponseBody  String getVouch(HttpServletRequest request){

        String result=HttpClientUtils.postRemote(VOUCH, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/getWallet")
    public @ResponseBody
    String getWallet(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(WALLET, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/getCoin")
    public @ResponseBody
    String getCoin(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(COIN, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/getMessage")
    public @ResponseBody   String getMessage(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(MESSAGE, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/coin2Cash")
    public @ResponseBody  String coin2Cash(HttpServletRequest request){

        String result=HttpClientUtils.postRemote(COIN2CASH, Utils.convert(request, "no"), null).toString();
        return result;
    }

    private final String SUBMITEXPAPP = "/expz/submitExpTaskA";

    @RequestMapping(value = "submitExpApp")
    public @ResponseBody   String submitExpApp(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(SUBMITEXPAPP, Utils.convert(request, "no"), null).toString();
        return result;
    }

    private static final String FIND_EXP_ZHUAN_DETAIL = "/expz/findExpById";

    /**
     * 
     * 齐心赚分享条件触发传递
     * @param request
     * @param response
     * @return
     * @throws IOException 
     * @see
     */
    @RequestMapping(value = "/toShare")
    public ModelAndView toShare(HttpServletRequest request, HttpServletResponse response)
        throws IOException
        {
        ModelMap model = new ModelMap();
        String code = request.getParameter("code");
        String expId = request.getParameter("expId");
        String orderId = request.getParameter("orderId");
        String userId = request.getParameter("userId");
        String shareUrl = request.getParameter("url");
        String shareImgUrl = request.getParameter("shareImgUrl");
        String shareTitle = request.getParameter("shareTitle");
        String openid = "";
        String backRedirectUrl = "/sen/toShare?orderId=" + orderId + "&expId=" + expId
            + "&userId=" + userId + "&url=" + shareUrl + "&shareImgUrl="
            + shareImgUrl + "&shareTitle=" + shareTitle;
        String redirectUrl = "";
        if (null != code)
        {

            openid = Utils.getOpenId(code);
            if (!"".equals(openid))
            {

                List<NameValuePair> params = new ArrayList<NameValuePair>();
                params.add(new BasicNameValuePair("openid", openid));
                params.add(new BasicNameValuePair("expId", expId));
                params.add(new BasicNameValuePair("userId", userId));
                params.add(new BasicNameValuePair("orderId", orderId));

                JSONObject jso = HttpClientUtils.postRemote(CLICKEXPTASKB, params, null);
                model.put("expId", expId);
                model.put("orderId", orderId);
                model.put("url", shareUrl);
                model.put("img", shareImgUrl);
                model.put("title", shareTitle);
                model.put("userId", userId);
                return new ModelAndView("index/qixinzhuanOrderDetail", model);
            }

        }
        else
        {

            redirectUrl = Utils.getRedirectWeiXinUrl(backRedirectUrl);
            response.sendRedirect(redirectUrl);
            return null;

        }
        return null;

        }

    private final String SHAREEXP = "/expz/shareExp";

    /**用户分享了齐心赚，要给金币*/
    @RequestMapping(value = "/share")
    public @ResponseBody   String share(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(SHAREEXP, Utils.convert(request, "no"), null).toString();
        return result;
    }

    private final String CASHTOALI = "/nouserCenter/cash";

    @RequestMapping(value = "/cashToAli")
    public @ResponseBody
    String cashToAli(HttpServletRequest request)
    {

        String result=HttpClientUtils.postRemote(CASHTOALI, Utils.convert(request, "no"), null).toString();
        return result;
    }

    private final String CHANGEPF = "/nouserCenter/updatePF";

    @RequestMapping(value = "/changePF")
    public @ResponseBody   String changePF(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(CHANGEPF, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/findExpZAppOrder")
    public @ResponseBody   String findExpZAppOrder(HttpServletRequest request){

        String result=HttpClientUtils.postRemote("/expz/findExpZAppOrder", Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/submitExpTaskFormA")
    public @ResponseBody   String submitExpTaskFormA(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote("/expz/submitExpTaskFormA", Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping("/getExpFormAnswer")
    public @ResponseBody  String getExpFormAnswer(HttpServletRequest request){

        String result=HttpClientUtils.postRemote("/expz/getExpFormAnswer", Utils.convert(request, "no"), null).toString();
        return result;
    }

    /**
     * 获取session中的参数
     * @param request
     * @return 
     * @see
     */
    private String getUserId(HttpServletRequest request){
        
        return ((LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER)).getUserid();
    }

    /**
     * 查询个人信息，附带签到状态
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value = "/getUserSInfoAndSignIn")
    public @ResponseBody String getUserSInfoAndSignIn(HttpServletRequest request){
        
        String result=HttpClientUtils.postRemote(USERINFO_AND_SIGNIN, Utils.convert(request, "no"), null).toString();
        return result;
    }

    @RequestMapping(value = "/queryUserPrototypeAll")
    public @ResponseBody String queryUserPrototypeAll(HttpServletRequest request) {
        
        String result=HttpClientUtils.postRemote("/noUserPrototype/queryUserPrototypeAll", Utils.convert(request, "no"), null).toString();
        return result;
    }
    @RequestMapping(value = "/readMsg")
    public @ResponseBody String readMsg(HttpServletRequest request) {

        String result=HttpClientUtils.postRemote("/nouserCenter/readMsg", Utils.convert(request, "no"), null).toString();
        return result;
    }
}
