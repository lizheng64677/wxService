package com.suyin.voting;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/voting")
public class VotingController {
	
	
	/**
	 * 页面访问数加1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/numberplus")
	public @ResponseBody String numberplus(HttpServletRequest request){
	    String result=HttpClientUtils.getRemote("/activity/numberplus").toString();
        return result;
	}
	
	/**
	 * 查询是否可以参与活动
	 * 活动是否在时间内
	 * 当天是否参与过
	 * @return
	 */

	@RequestMapping(value="/findActIsJoinState")
    public @ResponseBody String findActIsJoinState(HttpServletRequest request){       
        String result=HttpClientUtils.postRemote("/actrecord/joinAct",  Utils.convert(request, ModuleNameService.EXP),null).toString();
        return result;
    }
	
	/**
	 * 查询选手排名
	 * @return
	 */

	@RequestMapping(value="/findRanKingList")
    public @ResponseBody String findRanKingList(HttpServletRequest request){
        String result=HttpClientUtils.postRemote("/participator/findRanKingList",  Utils.convert(request, ModuleNameService.EXP),null).toString();
        return result;
    }
	/**
	 * 查询活动详情
	 * @return
	 */

	@RequestMapping(value="/findActDetail")
    public @ResponseBody String findActDetail(HttpServletRequest request){
        String detailId=request.getParameter("detailId");
        String result=HttpClientUtils.getRemote("/expdetail/findExpProImage?detailId="+detailId+"").toString();
        return result;
    }
	
	/**
	 * 查询选手详情
	 * @return
	 */

	@RequestMapping(value="/findDetail")
    public @ResponseBody String findDetail(HttpServletRequest request){
        String detailId=request.getParameter("detailId");
        String result=HttpClientUtils.getRemote("/expdetail/findExpProImage?detailId="+detailId+"").toString();
        return result;
    }
	
	
	/**
	 * 查询选手详情
	 * @return
	 */

	@RequestMapping(value="/findKeyDetail")
    public @ResponseBody String findKeyDetail(HttpServletRequest request){
        String detailId=request.getParameter("keyword");
        String result=HttpClientUtils.getRemote("/expdetail/findExpProImage?detailId="+detailId+"").toString();
        return result;
    }
	/**
	 * 首页查询选手列表
	 * @return
	 */

	@RequestMapping(value="/findListByAll")
    public @ResponseBody String findListByAll(HttpServletRequest request){        
        String result=HttpClientUtils.postRemote("/participator/findParticipatorList",  Utils.convert(request, ModuleNameService.EXP),null).toString();
        return result;
    }

	/**
	 * 首页查询活动的状态的信息，参与人，总票数，访问量
	 * @return
	 */

	@RequestMapping(value="/findHomeActStateInfo")
    public @ResponseBody String findHomeActStateInfo(HttpServletRequest request){
        String detailId=request.getParameter("detailId");
        String result=HttpClientUtils.getRemote("/expdetail/findExpProImage?detailId="+detailId+"").toString();
        return result;
    }
	
	/**
	 * 活动详情
	 * @return
	 */
	@RequestMapping("/toActdetail.html")
	public ModelAndView toActDetail(HttpServletRequest request) {
		ModelMap map=new ModelMap();
		JSONObject result=HttpClientUtils.getRemote("/activity/findActivityDetailById");
		JSONObject post=HttpClientUtils.getRemote("/activity/findActivityDetailById");
		map.put("result", result);
		map.put("position",result);
		return new ModelAndView("voting/actdetail",map);
	}
	

	/**
	 * 人物活动详情
	 * @return
	 */
	@RequestMapping("/toDetail.html")
	public ModelAndView toDetail(HttpServletRequest request) {
		ModelMap map=new ModelMap();
		String detailId=request.getParameter("detailId");
		String actId=request.getParameter("actId");
		JSONObject result=HttpClientUtils.getRemote("/participator/findParticipatorDetailById?id=" + detailId + "");
		JSONObject poorVotes=HttpClientUtils.getRemote("/participator/getPoorVotes?id="+detailId+"");
		JSONObject post=HttpClientUtils.getRemote("/activity/findActivityDetailById");
		map.put("result", post);
		map.put("position",result);
		map.put("value",poorVotes);
		map.put("actId", actId);
		map.put("detailId", detailId);
		return new ModelAndView("voting/detail",map);
	}
	
	
	/**
	 * 进入排名页面
	 * @return
	 */
	@RequestMapping("/toRanking.html")
	public ModelAndView ranking(HttpServletRequest request) {
		ModelMap map=new ModelMap();
		String type=request.getParameter("type");
		JSONObject result=HttpClientUtils.getRemote("/activity/findActivityDetailById");
		map.put("result", result);
		map.put("position","index");
		if(null!=type){
			map.put("type", type);
		}else{
			map.put("type", "-1");
		}
		return new ModelAndView("voting/ranking",map);
	}
	
}
