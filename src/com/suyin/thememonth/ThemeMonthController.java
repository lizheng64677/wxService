
package com.suyin.thememonth;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;




/**
 * 
 * 主题月分享页面
 * @author lz
 * @version 2015-10-14
 * @see ThemeMonthController
 * @since
 */
@Controller
@RequestMapping("/thememonth")
public class ThemeMonthController{

    private final static Logger log=Logger.getLogger(ThemeMonthController.class);

    /**
     * 
     * 主题页面内容展现
     * userId
     * detailId
     * expTimeId
     * @return 
     * @throws JSONException 
     * @throws IOException 
     * @see
     */
    @RequestMapping(value="/index")
    public ModelAndView index(HttpServletRequest request,HttpServletResponse response) throws JSONException, IOException {
        ModelMap  model=new ModelMap();
        String detailId=request.getParameter("detailId");
        //此处要考虑 ios 及 andriod 手机的传值方式 等 
        String userId=request.getParameter("userId");
        String expTimeId=request.getParameter("expTimeId");

        String code=request.getParameter("code");
        String openid="";
        String shareId="";
        String backRedirectUrl="/thememonth/index?userId="+userId+"&detailId="+detailId+"&expTimeId="+expTimeId;
        String redirectUrl="";
        if(null!=code){

            model=this.setDataInfo(detailId, userId, expTimeId);
            openid=Utils.getOpenId(code);
            if(!"".equals(openid)){

                //根据时间段expTimeId查询是否还在当前时间段内
                if(!"0".equals(expTimeId)){
                    String expTimeStauts=HttpClientUtils.getRemote("/expdetail/findExpTimeStauts?expTimeId="+expTimeId+"").toString();
                    JSONObject  b=new JSONObject(expTimeStauts);
                    if("1".equals(b.get("data"))){

                        //根据openid查询当前分享者是否已经分享过，如已分享过，再次分享视为无效
                        String shareUserInfo=HttpClientUtils.getRemote("/expdetail/findExpShareInfo?detailId="+detailId+"&userId="+userId+"&expTimeId="+expTimeId+"").toString();
                        JSONObject s=new JSONObject(shareUserInfo);
                        if(!JSONObject.NULL.equals(s.get("data")) && !"".equals(shareUserInfo)){
                            JSONObject s1=new JSONObject(s.get("data").toString());
                            shareId=s1.get("share_id").toString();
                        }
                        if(!"".equals(shareId)){

                            synchronized (ThemeMonthController.class)
                            {

                                String isShareDetail=HttpClientUtils.getRemote("/expdetail/findExpTimeSharDetail?expTimeId="+expTimeId+"&userId="+userId+"&openId="+openid+"").toString();
                                JSONObject j=new JSONObject(isShareDetail);           
                                if(!"success".equals(j.get("message"))){

                                    //插入分享者信息至t_exp_share_detail
                                    HttpClientUtils.getRemote("/expsharedetail/add?openId="+openid+"&shareId="+shareId+"");
                                    //根据shareId更新shareNum分享数 
                                    HttpClientUtils.getRemote("/expshare/editExpShareInfo?userId="+userId+"&shareId="+shareId+"");

                                    return new ModelAndView("share/share",model);
                                }

                            }
                        }else{

                            return new ModelAndView("share/share",model);

                        }

                    }
                }

            }
        }else{

            redirectUrl=Utils.getRedirectWeiXinUrl(backRedirectUrl);
            response.sendRedirect(redirectUrl);  
            return null;
        }

        return new ModelAndView("share/share",model);
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

        //根据分享的详情id查询当前产品
        String detialInfo=HttpClientUtils.getRemote("/expdetail/findExpDetail?detailId="+detailId+"").toString();
        JSONObject  b=new JSONObject(detialInfo);
        if("success".equals(b.get("message"))){
            JSONObject  s1=new JSONObject(b.get("data").toString());

            model.put("proName", s1.get("pro_name"));
            model.put("title", s1.get("title"));
            model.put("price", s1.get("price"));
            model.put("time", s1.get("time"));
            model.put("unit", s1.get("unit"));
            model.put("busname",s1.get("busname"));
            model.put("isBegin", s1.get("exp_stauts"));
            model.put("proImg", s1.get("pro_img"));
            model.put("widePic", "");

        }
        model.put("detailId",detailId );
        model.put("userId", userId);
        model.put("expTimeId", expTimeId);

        return model;
    }

    /**
     * 当前用户转发_修改原转发用户的人气数量
     * 该人气数量作为最终发券的重要凭证
     * 根据各参数入库查询各条件是否满足
     * @return 
     * @throws JSONException 
     * @throws IOException 
     * @see
     */
    @RequestMapping(value="/updateShareDetail")
    public ModelAndView updateShareDetail(HttpServletRequest request,HttpServletResponse response) throws JSONException, IOException{
        ModelMap model=new ModelMap();
        String detailId=request.getParameter("detailId");
        String userId=request.getParameter("userId");
        String expTimeId=request.getParameter("expTimeId");
        String code=request.getParameter("code");
        String openid="";
        String shareId="";
        String backRedirectUrl="/thememonth/updateShareDetail?userId="+userId+"&detailId="+detailId+"&expTimeId="+expTimeId;
        String redirectUrl="";
        if(null!=code){

            openid=Utils.getOpenId(code);
        }else{

            redirectUrl=Utils.getRedirectWeiXinUrl(backRedirectUrl);
            response.sendRedirect(redirectUrl);  
            return null;
        }
        if(!"".equals(openid)){

            //根据时间段expTimeId查询是否还在当前时间段内
            if(!"0".equals(expTimeId)){
                String expTimeStauts=HttpClientUtils.getRemote("/expdetail/findExpTimeStauts?expTimeId="+expTimeId+"").toString();
                JSONObject  b=new JSONObject(expTimeStauts);
                if("1".equals(b.get("data"))){

                    //根据openid查询当前分享者是否已经分享过，如已分享过，再次分享视为无效
                    String shareUserInfo=HttpClientUtils.getRemote("/expdetail/findExpShareInfo?detailId="+detailId+"&userId="+userId+"&expTimeId="+expTimeId+"").toString();
                    JSONObject s=new JSONObject(shareUserInfo);
                    if(!"null".equals(s.get("data")) && !"".equals(shareUserInfo)){
                        JSONObject s1=new JSONObject(s.get("data").toString());
                        shareId=s1.get("share_id").toString();
                    }
                    if(!"".equals(shareId)){

                        String isShareDetail=HttpClientUtils.getRemote("/expdetail/findExpTimeSharDetail?expTimeId="+expTimeId+"&userId="+userId+"&openId="+openid+"").toString();
                        JSONObject j=new JSONObject(isShareDetail);           
                        if(!"success".equals(j.get("message"))){
                            //插入分享者信息至t_exp_share_detail
                            HttpClientUtils.getRemote("/expsharedetail/add?openId="+openid+"&shareId="+shareId+"");
                            //根据shareId更新shareNum分享数 
                            HttpClientUtils.getRemote("/expshare/editExpShareInfo?userId="+userId+"&shareId="+shareId+"");
                            return new ModelAndView("redirect:/thememonth/index?detailId="+detailId+"&userId="+userId+"&expTimeId="+expTimeId+"");
                        }

                    }

                }else{

                    //当前活动在该时间段内已经结束
                }
            }else{

                //时间段过期 
            }

        }
        return new ModelAndView("redirect:/thememonth/index?detailId="+detailId+"&userId="+userId+"&expTimeId="+expTimeId+"");

    }

}


