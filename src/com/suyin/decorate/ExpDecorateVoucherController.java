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
