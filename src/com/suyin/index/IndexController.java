package com.suyin.index;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.log.LogUtils;
import com.suyin.common.service.ModuleNameService;
import com.suyin.model.LoginUser;
import com.suyin.utils.Constant;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;


@Controller
@RequestMapping("/index")
public class IndexController {
	//首页全民赚和齐心赚的更多
	private static final String FIND_EXP_ZHUAN="/expz/findExp";
	//首页查找全民赚和齐心赚的两个
	private static final String FIND_EXP_ZHUAN_TWO="/expz/findTwo";	
	//查看两个赚详情
	private static final String FIND_EXP_ZHUAN_DETAIL="/expz/findExpById";
	//
	private static final String FIND_EXP_ZHUAN_DETAIL_TWO="/expz/findExpByIdTwo";
	//查找首页广告
	private static final String FIND_ADVS="/advs/find";		
	//有人点击了齐心赚分享出去的东西，只有要加金币什么的,该方法其实没有什么好返回的
	private static final String CLICKEXPTASKB="/expz/clickExpTaskB";
	//免费活动查询
	private static final String FIND_EXP_INFO="/exp/findTwo";
	//查找app 操作流程及信息
	private static final String FIND_EXP_APP_INFO="/expz/findExpZAppDownInfo";
	//根据活动id查询该活动分享的信息
	private static final String FIND_EXP_SHARE_INFO="/expz/findExpShareInfo";

	
	/**
	 * 进入投票首页
	 * @return
	 */
	@RequestMapping("/toIndex.html")
	public ModelAndView toAction(HttpServletRequest request) {
		ModelMap map=new ModelMap();
		String type=request.getParameter("type");//0:标兵 1:警嫂
		String keyword=request.getParameter("keyword");
		JSONObject result=HttpClientUtils.getRemote("/activity/findActivityDetailById");
		JSONObject statistics=HttpClientUtils.getRemote("/activity/getStatistics");
		map.put("position",result);	
		if(null!=type){
			map.put("type", type);
		}else{
			map.put("type", "-1");
		}
		map.put("keyword", keyword);
		map.put("statistics",statistics);
		return new ModelAndView("voting/index",map);
	}
	
	
	/**
	 * 进入首页
	 * @return
	 */
//	@RequestMapping("/toIndex")
	public ModelAndView toIndex(HttpServletRequest request) {
		ModelMap map=new ModelMap();
		map.put("position","index");
		return new ModelAndView("index/index",map);
	}

	/**
	 * 从城市选择页面，点击城市返回到首页
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/citySelectionToIndex")
	public ModelAndView citySelectionToIndex(HttpServletRequest request) throws UnsupportedEncodingException {
		ModelMap map=new ModelMap();
		String str=request.getParameter("name");
		map.put("id", request.getParameter("id"));
		String name=URLDecoder.decode(str, "UTF-8");
		String position=request.getParameter("position");
		map.put("name",name);
		map.put("position",position);
		return new ModelAndView("index/index",map);
	}

	/**
	 * 
	 * 首页面免费活动查询
	 * @param request
	 * @return 
	 * @see
	 */
	@RequestMapping(value="/findExpInfo")
	public @ResponseBody String findExpInfo(HttpServletRequest request){
		String result=HttpClientUtils.postRemote(FIND_EXP_INFO,  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}

	//查找首页广告
	@RequestMapping("/findAdvs")
	public @ResponseBody String findAdvs(HttpServletRequest request) {

		return HttpClientUtils.postRemote(FIND_ADVS,  Utils.convert(request, ModuleNameService.ADV),null).toString();
	}


	//查找首页显示的两个齐心赚和全民赚
	@RequestMapping("/findExpZ")
	public @ResponseBody String findExpZhuan(HttpServletRequest request) {

		return  HttpClientUtils.postRemote(FIND_EXP_ZHUAN_TWO, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}
	@RequestMapping("/toQixinZhuanODetail")
	public String toQixinZhuanODetail(HttpServletRequest request) {
		String s=HttpClientUtils.postRemote("/expz/findQixinZhuanODetail", Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
		request.setAttribute("result", s);
		return "index/qixinzhuanODetail";
	}

	//进入齐心赚更多的列表页
	@RequestMapping("/toQixinZhuanList")
	public ModelAndView toQixinZhuanList(HttpServletRequest request) {
		String id=request.getParameter("cityid");
		ModelMap map=new ModelMap();
		map.put("cityid", id);
		return new ModelAndView("index/qixinzhuan",map);
	}
	//查找齐心赚列表
	@RequestMapping("/findQixinZhuanList")
	public @ResponseBody String findQixinZhuanList(HttpServletRequest request) {

		return  HttpClientUtils.postRemote(FIND_EXP_ZHUAN, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}

	//进入齐心赚详情页
	@RequestMapping("/toQixinZhuanDetail")
	public ModelAndView toQixinZhuanDetail(HttpServletRequest request) {

		JSONObject jso=HttpClientUtils.postRemote(FIND_EXP_ZHUAN_DETAIL_TWO, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).getJSONObject("data");
		LoginUser user=(LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER);
		ModelMap model=new ModelMap();
		model.put("expId", request.getParameter("expId"));
		model.put("url", jso.getString("share_url"));
		model.put("img", jso.getString("share_img_url"));
		model.put("title", jso.getString("share_title"));
		if(null!=user){
			model.put("userId",user.getUserid());
		}
		return new ModelAndView("index/qixinzhuanDetail",model);
	}
	//查找齐心赚详情
	@RequestMapping("/findQixinZhuanDetail")
	public @ResponseBody String findQixinZhuanDetail(HttpServletRequest request) {

		return HttpClientUtils.postRemote(FIND_EXP_ZHUAN_DETAIL, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}


	//进入全民赚更多的列表页
	@RequestMapping("/toQuanminZhuanList")
	public String toQuanminZhuanList() {

		return "index/quanminzhuan";
	}


	//查找全民赚列表
	@RequestMapping("/findQuanminZhuanList")
	public @ResponseBody String findQuanminZhuanList(HttpServletRequest request) {

		return  HttpClientUtils.postRemote(FIND_EXP_ZHUAN, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}

	//进入全民赚详情页
	@RequestMapping("/toQuanminDetail")
	public ModelAndView toQuanminDetail(HttpServletRequest request) {
		ModelMap model=new ModelMap();
		model.put("expId", request.getParameter("expId"));
		return  new ModelAndView("index/quanminzhuanDetail",model);
	}
	//查找全民赚详情
	@RequestMapping("/findQuanminZhuanDetail")
	public @ResponseBody String findQuanminZhuanDetail(HttpServletRequest request) {

		return HttpClientUtils.postRemote(FIND_EXP_ZHUAN_DETAIL, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}
	@RequestMapping("/toTuWenAdvs")
	public String toTuWenAdvs(HttpServletRequest request) {
		request.setAttribute("id", request.getParameter("id"));
		JSONObject jso= HttpClientUtils.postRemote("/advs/findById", Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).getJSONObject("data");
		request.setAttribute("title", jso.get("adv_name"));
		request.setAttribute("description", jso.get("description"));

		return "index/tuwen";
	}

	@RequestMapping("/findTuWenAdvs")
	public @ResponseBody String findTuWenAdvs(HttpServletRequest request) {
		return HttpClientUtils.postRemote("/advs/findById", Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}   
	//进入全民赚APP下载订单详情页
	@RequestMapping("/findqmAppZhuanDetail")
	public ModelAndView findQuanminZhuanOrderDetail(HttpServletRequest request) {
		ModelMap model=new ModelMap();
		model.put("expId", request.getParameter("expId"));
		model.put("pagePostion", request.getParameter("pagePostion")); //请求页面 位置
		model.put("userId", this.getUserId(request));

		JSONObject jso=HttpClientUtils.postRemote(FIND_EXP_APP_INFO,  Utils.convert(request, "no"),null);

		try {
			model.put("downImageUrl", jso.getJSONObject("data").get("down_img_url")); 
			model.put("upImageUrl", jso.getJSONObject("data").get("up_img_url")); 
			model.put("appInfo", jso.getJSONObject("data").get("app_info")); 
			model.put("url", jso.getJSONObject("data").getString("exp_app_url"));
			model.put("status", jso.getJSONObject("data").getString("status"));
			model.put("imageUrl", jso.getJSONObject("data").getString("image_url"));
			model.put("orderId", jso.getJSONObject("data").get("order_id"));
			model.put("user_phone", jso.getJSONObject("data").get("user_phone"));
			/* model.put("tips", jso.getJSONObject("data").get("tips"));*/


		} catch (Exception e) {
		}
		return new ModelAndView("index/qmAppzhuanOrderDetail",model);
	}

	//进入全民赚Form表单订单详情页
	@RequestMapping("/findqmFormZhuanDetail")
	public String findqmFormZhuanDetail(HttpServletRequest request) {

		request.setAttribute("expId", request.getParameter("expId"));
		request.setAttribute("orderId", request.getParameter("orderId"));
		return "index/qmFormzhuanOrderDetail";
	}


	//某人点击了分享出去的链接后要到这里来
	@RequestMapping("/redirectToShareUrl")
	public void redirectToShareUrl(HttpServletRequest request,HttpServletResponse response) throws IOException {

		JSONObject jso= HttpClientUtils.postRemote(CLICKEXPTASKB, Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null);

		if("success".equals(jso.getString("message"))&&"0".equals(jso.getString("error"))) {
			response.sendRedirect(request.getParameter("url"));
		}else {
			throw new RuntimeException();
		}
	}
	/**
	 * 
	 * 齐心赚分享条件触发传递
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws JSONException 
	 * @see
	 */
	@RequestMapping(value="/myToShare")
	public ModelAndView toShare(HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		ModelMap model=new ModelMap();
		String code=request.getParameter("code");
		String expId=request.getParameter("expId");    
		String userId=request.getParameter("userId");
		String openid="";
		String backRedirectUrl="/index/myToShare?expId="+expId+"&userId="+userId;
		String redirectUrl="";
		if(null!=code){

			openid=Utils.getOpenId(code);
			synchronized (IndexController.class)
			{
				if(!"".equals(openid)){

					List<NameValuePair> params=new ArrayList<NameValuePair>();
					params.add(new BasicNameValuePair("openid",openid));
					params.add(new BasicNameValuePair("expId",expId));
					params.add(new BasicNameValuePair("userId",userId));                   
					model=this.setDataInfo(expId,userId);

					JSONObject jso=HttpClientUtils.postRemote(CLICKEXPTASKB,params,null);             
					return new ModelAndView("index/qixinzhuanOrderDetail",model);
				}
			}

		}else{

			redirectUrl=Utils.getRedirectWeiXinUrl(backRedirectUrl);
			response.sendRedirect(redirectUrl);  
			return null;
		}

		return new ModelAndView("index/qixinzhuanOrderDetail",model);


	}

	/**
	 * 
	 * 根据条件组装数据
	 * @param expId
	 * @param orderId
	 * @param userId
	 * @return
	 * @throws JSONException 
	 * @see
	 */
	private ModelMap setDataInfo(String expId,String userId) throws JSONException{
		ModelMap model=new ModelMap();
		JSONObject jsonInfo=HttpClientUtils.getRemote(FIND_EXP_SHARE_INFO+"?expId="+expId);
		model.put("expId", expId);      
		model.put("userId", userId);
		org.json.JSONObject jb=new org.json.JSONObject(jsonInfo.get("result").toString());

		if("success".equals(jb.get("message"))){
			org.json.JSONObject js=new org.json.JSONObject(jb.get("data").toString());

			model.put("url", js.get("share_url"));
			model.put("img", js.get("share_img_url"));
			model.put("title", js.get("share_title"));
		}
		return model;
	}



	@RequestMapping("/getqmFormOrderDetail")
	public @ResponseBody String getqmFormOrderDetail(HttpServletRequest request) {

		return HttpClientUtils.postRemote("/expz/findExpForm", Utils.convert(request, ModuleNameService.USER_EXP_ZHUAN),null).toString() ;
	}

	/**
	 * 获取session中的参数
	 * @param request
	 * @return 
	 * @see
	 */
	private String getUserId(HttpServletRequest request)
	{
		return ((LoginUser)request.getSession().getAttribute(Constant.SESSION_LOGIN_USER)).getUserid();
	}
}
