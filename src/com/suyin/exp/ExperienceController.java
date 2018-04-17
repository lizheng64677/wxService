/*
 * 文件名：ExperienceController.java
 * 版权：Copyright by www.isure.net
 * 描述：
 * 修改人：windows7
 * 修改时间：2015-9-24
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package com.suyin.exp;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

/**
 * 免费活动页面跳转
 * @author lz
 * @version 2015-9-24
 * @see ExperienceController
 * @since
 */
@Controller
@RequestMapping("/experience")
public class ExperienceController
{
    //试用式列表
    private static final String FIND_EXP_DETAIL="/expdetail/findExpDetail";
    /**
     * 试用式列表展现
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/tryList")
    public ModelAndView tryList(HttpServletRequest request){
        ModelMap model=new ModelMap();
        return new ModelAndView("/explist/exptry",model);
    }

    /**
     * 试用式活动问题页面跳转 
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/involVedTryInfo")
    public ModelAndView involVedTryInfo(HttpServletRequest request){
        ModelMap model=new ModelMap();
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String memberId=request.getParameter("memberId");
        String expId=request.getParameter("expId");
        model.put("detailId", detailId);
        model.put("expId", expId);
        model.put("memberId", memberId);
        model.put("userId", loguser.getUserid());
        return new ModelAndView("/expdetail/zeroTryDetailInfo",model);
    }
    /**
     * 抽奖式列表展现
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/prizeList")
    public ModelAndView prizeList(HttpServletRequest request){
        ModelMap model=new ModelMap();
        model.put("cityid", request.getParameter("cityid"));
        return new ModelAndView("/explist/expprize",model);
    }

    /**
     * 人气式列表展现
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/popList")
    public ModelAndView popList(HttpServletRequest request){
        ModelMap model=new ModelMap();
        model.put("cityid", request.getParameter("cityid"));
        return new ModelAndView("/explist/exppop",model);
    }

    /**
     * 兑换式列表展现
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/echageList")
    public ModelAndView echageList(HttpServletRequest request){
        ModelMap model=new ModelMap();
        return new ModelAndView("/explist/expechage",model);
    }
    /**
     * 免费活动详情页面跳转
     * 活动类型：0 抽奖式,1人气式,2兑换式，3试用式
     * 根据传入expType 不同类型 跳转不同页面
     * @param request
     * @return 
     * @throws Exception 
     * @see
     */
    @RequestMapping(value="/toExpDetaiInfo")
    public ModelAndView toExpDetailInfo(HttpServletRequest request) throws Exception{
        ModelMap model=new ModelMap();
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        String detailId=request.getParameter("detailId");
        String expType=request.getParameter("expType");
        model.put("detailId", detailId);
        model.put("expType", expType);
        if("0".equals(expType)){

            model=createPrizeData(detailId, expType,loguser);
            if(null!=loguser){
                model.put("userId", loguser.getUserid());
            }
            
            return new ModelAndView("/expdetail/zeroPrizeDetical",model);
        }else if("1".equals(expType)){

            model=createPopData(detailId, expType,loguser);
            if(null!=loguser){

                model.put("userId", loguser.getUserid());
                ModelMap resultTheme=setDataInfo();
                model.put("themeTitle",resultTheme.get("themeTitle"));
                model.put("themePic",resultTheme.get("themePic"));
            }
            return new ModelAndView("/expdetail/zeroPopDetical",model);
        }else if("2".equals(expType)){

            model=createEchageData(detailId,expType,loguser);
            if(null!=loguser){
                model.put("userId", loguser.getUserid());
            }
            return new ModelAndView("/expdetail/zeroEchageDetical",model);
        }else if("3".equals(expType)){

            model=createTryData(detailId, expType,loguser);
            if(null!=loguser){
                model.put("userId", loguser.getUserid());
            }
            return new ModelAndView("/expdetail/zeroTryDetical",model);
        }
        return null;
    }


	/**
     * 
     * 人气进程详情
     * @param request
     * @return
     * @throws JSONException 
     * @see
     */
    @RequestMapping("/toExpRankDetaiInfo")
    public ModelAndView toExpRankDetaiInfo(HttpServletRequest request) throws JSONException {
        ModelMap model=new ModelMap();

        String detailId=request.getParameter("detailId");
        model=createPopData_Rank(detailId, "1");
        model.put("detailId", detailId);
        return new ModelAndView("/expdetail/zeroPopRankDetical",model);
    } 
    @RequestMapping("/findExpRank")
    public @ResponseBody String findExpRank(HttpServletRequest request) {

        String result=HttpClientUtils.postRemote("/expshare/findRankForShare",  Utils.convert(request, "no"),null).toString();
        return result;

    }
    @RequestMapping("/findRankForMySelf")
    public @ResponseBody String findRankForMySelf(HttpServletRequest request) {

        String result=HttpClientUtils.postRemote("/expshare/findRankForMySelf",  Utils.convert(request, "no"),null).toString();
        return result;
    }

    /**
     * 
     * 分享链接进入
     * @param request
     * @return
     * @throws JSONException 
     * @see
     */
    @RequestMapping(value="/toShareExpDetailInfo")
    public ModelAndView toShareExpDetailInfo(HttpServletRequest request) throws JSONException{
        ModelMap model=new ModelMap();
        String userId=request.getParameter("userId"); //首次分享人的userId
        String detailId=request.getParameter("detailId");
        String expType=request.getParameter("expType");
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);  
        model=createPopData(detailId, expType,loguser);
        if(null!=loguser){
            model.put("userId", loguser.getUserid());
            ModelMap resultTheme=setDataInfo();
            model.put("themeTitle",resultTheme.get("themeTitle"));
            model.put("themePic",resultTheme.get("themePic"));
        }        
        model.put("detailId", detailId);
        model.put("expType", expType);
        return new ModelAndView("/expdetail/zeroPopDetical",model);
    }

    /**
     * 组装主题月信息 
     * @return
     * @throws JSONException 
     * @see
     */
    private  ModelMap setDataInfo() throws JSONException{
        ModelMap  model=new ModelMap();

        String themeInfo=HttpClientUtils.getRemote("/thememonth/findThemeMonthInfo").toString();
        JSONObject a=new JSONObject(themeInfo);
        if("success".equals(a.get("message"))){
            if(null!=a.getString("data") && !"null".equals(a.getString("data"))){
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
     * 组装抽奖式详情数据
     * @param detailId
     * @param expType
     * @return
     * @throws JSONException 
     * @see
     */
    public ModelMap createPrizeData(String detailId,String expType,LoginUser loguser) throws JSONException{
        ModelMap model=new ModelMap();
        String toInfo=findExpDetailInfo(detailId,expType,loguser);
        
        JSONObject j=new JSONObject(toInfo);
        
        if("success".equals(j.get("message"))){

            JSONObject s=new JSONObject(j.get("data").toString());
            model.put("busname", s.get("busname").toString());
            model.put("logo_pic_url", s.get("logo_pic_url").toString());
            model.put("member_id", s.get("member_id").toString());
            model.put("address", s.get("address").toString());
            model.put("address_url", s.get("address_url").toString());
            model.put("telephone", s.get("telephone").toString());
            model.put("title", s.get("title").toString());
            model.put("proTitle", s.get("proTitle").toString());
            model.put("exp_id", s.get("exp_id").toString());
            model.put("exp_type", s.get("exp_type").toString());
            model.put("show_type", s.get("show_type").toString());
            model.put("exp_detail_id", s.get("exp_detail_id").toString());
            model.put("pro_num", s.get("pro_num").toString());
            model.put("exp_num", s.get("exp_num").toString());
            model.put("exp_num1",s.get("exp_num1").toString());
            model.put("price", s.get("price").toString());
            model.put("pro_id", s.get("pro_id").toString());
            model.put("pro_name", s.get("pro_name").toString());
            model.put("pro_info", s.get("pro_info").toString());
            model.put("user_info", s.get("use_info").toString());
            model.put("exp_stauts", s.get("exp_stauts").toString());
            model.put("time", s.get("time").toString());
            model.put("unit", s.get("unit").toString());
            model.put("exp_time_id", s.get("exp_time_id").toString());

        }
        return model;
    }


    /**
     * 组装兑换式详情数据
     * @param detailId
     * @param expType
     * @return
     * @throws JSONException 
     * @see
     */
    public ModelMap createEchageData(String detailId,String expType, LoginUser  loguser) throws JSONException{
        ModelMap model=new ModelMap();
        String toInfo=findExpDetailInfo(detailId,expType,loguser);
        JSONObject j=new JSONObject(toInfo);
        if("success".equals(j.get("message"))){

            JSONObject s=new JSONObject(j.get("data").toString());
            model.put("busname", s.get("busname").toString());
            model.put("logo_pic_url", s.get("logo_pic_url").toString());
            model.put("member_id", s.get("member_id").toString());
            model.put("address", s.get("address").toString());
            model.put("address_url", s.get("address_url").toString());
            model.put("telephone", s.get("telephone").toString());
            model.put("title", s.get("title").toString());
            model.put("proTitle", s.get("proTitle").toString());
            model.put("exp_id", s.get("exp_id").toString());
            model.put("exp_type", s.get("exp_type").toString());
            model.put("exp_detail_id", s.get("exp_detail_id").toString());
            model.put("pro_num", s.get("pro_num").toString());
            model.put("exp_num", s.get("exp_num").toString());
            model.put("integral", s.get("integral").toString());
            model.put("price", s.get("price").toString());
            model.put("pro_id", s.get("pro_id").toString());
            model.put("pro_name", s.get("pro_name").toString());
            model.put("pro_info", s.get("pro_info").toString());
            model.put("user_info", s.get("use_info").toString());
            model.put("exp_stauts", s.get("exp_stauts").toString());
            model.put("time", s.get("time").toString());
            model.put("unit", s.get("unit").toString());
            model.put("beginTime", s.get("begin_time"));
            model.put("exp_time_id", s.get("exp_time_id").toString());

        }
        return model;
    }
    /**
     * 组装人气式进程详情数据
     * 为不影响其他当前正常方法
     * 单独执行_和其他任何没有关联
     * @param detailId
     * @param expType
     * @return
     * @throws JSONException 
     * @see
     */
    public ModelMap createPopData_Rank(String detailId,String expType) throws JSONException{
        ModelMap model=new ModelMap();
        String toInfo=findExpDetailInfo__Rank(detailId);
        JSONObject j=new JSONObject(toInfo);
        if("success".equals(j.get("message"))){

            JSONObject s=new JSONObject(j.get("data").toString());
            model.put("busname", s.get("busname").toString());
            model.put("logo_pic_url", s.get("logo_pic_url").toString());
            model.put("member_id", s.get("member_id").toString());
            model.put("address", s.get("address").toString());
            model.put("address_url", s.get("address_url").toString());
            model.put("telephone", s.get("telephone").toString());
            model.put("title", s.get("title").toString());
            model.put("proTitle", s.get("proTitle").toString());
            model.put("exp_id", s.get("exp_id").toString());
            model.put("exp_type", s.get("exp_type").toString());
            model.put("exp_detail_id", s.get("exp_detail_id").toString());
            model.put("pro_num", s.get("pro_num").toString());
            model.put("exp_num", s.get("exp_num").toString());
            model.put("exp_num1",s.get("exp_num1").toString());
            model.put("price", s.get("price").toString());
            model.put("pro_id", s.get("pro_id").toString());
            model.put("pro_name", s.get("pro_name").toString());
            model.put("pro_info", s.get("pro_info").toString());
            model.put("user_info", s.get("use_info").toString());
            model.put("exp_stauts", s.get("exp_stauts").toString());
            model.put("time", s.get("time").toString());
            model.put("unit", s.get("unit").toString());
            model.put("exp_time_id", s.get("exp_time_id").toString());
            model.put("installments", s.get("installments").toString());
        }
        return model;
    }


    /**
     * 组装人气式详情数据
     * @param detailId
     * @param expType
     * @return
     * @throws JSONException 
     * @see
     */
    public ModelMap createPopData(String detailId,String expType,LoginUser  loguser) throws JSONException{
        ModelMap model=new ModelMap();
        String toInfo=findExpDetailInfo(detailId,expType,loguser);
        JSONObject j=new JSONObject(toInfo);
        if("success".equals(j.get("message"))){

            JSONObject s=new JSONObject(j.get("data").toString());
            model.put("busname", s.get("busname").toString());
            model.put("logo_pic_url", s.get("logo_pic_url").toString());
            model.put("member_id", s.get("member_id").toString());
            model.put("address", s.get("address").toString());
            model.put("address_url", s.get("address_url").toString());
            model.put("telephone", s.get("telephone").toString());
            model.put("title", s.get("title").toString());
            model.put("proTitle", s.get("proTitle").toString());
            model.put("exp_id", s.get("exp_id").toString());
            model.put("exp_type", s.get("exp_type").toString());
            model.put("exp_detail_id", s.get("exp_detail_id").toString());
            model.put("pro_num", s.get("pro_num").toString());
            model.put("exp_num", s.get("exp_num").toString());
            model.put("exp_num1",s.get("exp_num1").toString());
            model.put("price", s.get("price").toString());
            model.put("pro_id", s.get("pro_id").toString());
            model.put("pro_name", s.get("pro_name").toString());
            model.put("pro_info", s.get("pro_info").toString());
            model.put("user_info", s.get("use_info").toString());
            model.put("exp_stauts", s.get("exp_stauts").toString());
            model.put("time", s.get("time").toString());
            model.put("unit", s.get("unit").toString());
            model.put("exp_time_id", s.get("exp_time_id").toString());
            model.put("installments", s.get("installments").toString());

        }
        return model;
    }

    /**
     * 组装试用式详情数据
     * @param detailId
     * @param expType
     * @return
     * @throws JSONException 
     * @see
     */
    public ModelMap createTryData(String detailId,String expType, LoginUser  loguser) throws JSONException{
        ModelMap model=new ModelMap();
        String toInfo=findExpDetailInfo(detailId,expType,loguser);
        JSONObject j=new JSONObject(toInfo);
        
        if("success".equals(j.get("message"))){

            JSONObject s=new JSONObject(j.get("data").toString());
            model.put("busname", s.get("busname").toString());
            model.put("logo_pic_url", s.get("logo_pic_url").toString());
            model.put("member_id", s.get("member_id").toString());
            model.put("address", s.get("address").toString());
            model.put("address_url", s.get("address_url").toString());
            model.put("telephone", s.get("telephone").toString());
            model.put("title", s.get("title").toString());
            model.put("proTitle", s.get("proTitle").toString());
            model.put("exp_id", s.get("exp_id").toString());
            model.put("exp_detail_id", s.get("exp_detail_id").toString());
            model.put("pro_num", s.get("pro_num").toString());
            model.put("exp_num", s.get("exp_num").toString());
            model.put("price", s.get("price").toString());
            model.put("pro_id", s.get("pro_id").toString());
            model.put("pro_name", s.get("pro_name").toString());
            model.put("pro_info", s.get("pro_info").toString());
            model.put("user_info", s.get("use_info").toString());
            model.put("exp_stauts", s.get("exp_stauts").toString());
            model.put("time", s.get("time").toString());
            model.put("unit", s.get("unit").toString());
            model.put("exp_time_id", s.get("exp_time_id").toString());

        }
        return model;
    }

    //接口请求详情数据
    public @ResponseBody String findExpDetailInfo(String detailId,String expType, LoginUser  loguser) {
        String userId="-1";
        if(null!=loguser){
            userId=loguser.getUserid();
        }
        String result=HttpClientUtils.getRemote("/expdetail/findExpDetail?detailId="+detailId+"&expType="+expType+"&regtype=0&version=1&userId="+userId+"&module=expdetal").toString();
        return result;
    }

    //根据商家id 查询商家评价
    @RequestMapping(value="/findDiscussInfo")
    public @ResponseBody void findDiscussInfo(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
	    response.setCharacterEncoding("utf-8");
    	String proId=request.getParameter("proId");
    	String detailId=request.getParameter("detailId");
    	String currpage=request.getParameter("page.currentPage");
    	String result=HttpClientUtils.getRemote("/nouserDiscuz/findDiscuss?detailId="+detailId+"&proId="+proId+"&page.currentPage="+currpage).toString();
    	JSONObject obj = new JSONObject(result);
    	PrintWriter writer =response.getWriter();
    	writer.print(obj);
    }
    
    //根据商家id 查询商家评价
    @RequestMapping(value="/queryDis")
    public  ModelAndView  queryDis(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	ModelMap model = new ModelMap();
    	model.put("proId", request.getParameter("proId"));
    	model.put("detailId", request.getParameter("detailId"));
    	return new ModelAndView("/expdetail/discussList",model);
    }
    
    
    //根据商家id 查询商家评价
    @RequestMapping(value="/findAllDiscussInfo")
    public @ResponseBody void findAllDiscussInfo(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
	    response.setCharacterEncoding("utf-8");
    	String proId=request.getParameter("proId");
    	String detailId=request.getParameter("detailId");
    	String currpage=request.getParameter("currpage");
    	String result=HttpClientUtils.getRemote("/nouserDiscuz/findDiscuss?detailId="+detailId+"&proId="+proId+"&currpage="+currpage).toString();
    	JSONObject obj = new JSONObject(result);
    	PrintWriter writer =response.getWriter();
    	writer.print(obj);
    	
    	
    }
    
    //人气进程数据独立
    public @ResponseBody String findExpDetailInfo__Rank(String detailId){
        String result=HttpClientUtils.getRemote("/expdetail/findExpDetailRank?detailId="+detailId+"").toString();
        return result;
    }

    /**
     * 加载产品图片
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/findExpDetaiImages")
    public @ResponseBody String findExpDetaiImages(HttpServletRequest request){
        String detailId=request.getParameter("detailId");
        String result=HttpClientUtils.getRemote("/expdetail/findExpProImage?detailId="+detailId+"").toString();
        return result;
    }

    /**
     * 查找试用式问卷调查题目
     * ExperienceTaskOrder
     * moduleType 1 全民赚问卷调查，2试用问卷调查
     * @param request
     * @return 
     * @see
     */
    @RequestMapping(value="/findExpTryDoubt")
    public @ResponseBody String findExpTryDoubt(HttpServletRequest request){
        LoginUser  loguser=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
        ModelMap modelMap=new ModelMap();
        String expId=request.getParameter("expId");
        String moduleType="2";
        String result=HttpClientUtils.getRemote("/expdetail/findExpTryDoubt?expId="+expId+"&moduleType="+moduleType+"&userId="+loguser.getUserid()+"").toString();      
        return result;

    }
}
