package com.suyin.decorate;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;
/**
 * 福利券查询入口
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/wxDecorateVoucher")
public class ExpDecorateVoucherController {
	
	 /**
     * 通过用户openId查询我的消息
     * @param userId
     * @param openId
     * @return
     */
    @RequestMapping(value="/findUserInfoByOpenIdMessage")
    public @ResponseBody String findUserInfoByOpenIdMessage(HttpServletRequest request) {
		String result=HttpClientUtils.postRemote("/indecoratemessage/findUseMessageList",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
    }
	 /**
     * 通过用户openId查询我的订单
     * @param userId
     * @param openId
     * @return
     */
    @RequestMapping(value="/findOrderListByIdInfo")
    public @ResponseBody String findOrderInfoByOpenId(HttpServletRequest request) {
		String result=HttpClientUtils.postRemote("/indecoratebuyorder/findUserOrderList",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
    }
	/**
	 * 个人模块 查询我的券
	 * findVoucher
	 * @return
	 */
	@RequestMapping("/findByUserVoucher")
	public @ResponseBody String findByUserVoucher(HttpServletRequest request){
		String result=HttpClientUtils.postRemote("/indecoratevoucher/findByUserVoucherList",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}
	/**
	 * 查询首页模块 信息固定六条
	 * findVoucher
	 * @return
	 */
	@RequestMapping("/findVoucher")
	public @ResponseBody String findVoucher(HttpServletRequest request){
		String result=HttpClientUtils.postRemote("/indecoratevoucher/findTwo",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}
	
	/**
	 * 查询券详情
	 * findVoucherDetail
	 * @return
	 */
	@RequestMapping("/findVoucherDetail")
	public @ResponseBody String findVoucherDetial(HttpServletRequest request){
		String result=HttpClientUtils.postRemote("/indecoratevoucher/findDetial",  Utils.convert(request, ModuleNameService.EXP),null).toString();
		return result;
	}
}
