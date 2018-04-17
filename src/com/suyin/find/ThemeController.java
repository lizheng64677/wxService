package com.suyin.find;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.common.service.ModuleNameService;
import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

@Controller
@RequestMapping("/find")
public class ThemeController {

	private final String FIND_URL="/theme/list";
	private final String FIND_ROMOTE_URL="/find/findTOD";



	@RequestMapping("/toThemeIndex")
	public String index() {

		return "find/found";
	}

	/**
	 * 显示主题，顶多一个分页的东西
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public String find(HttpServletRequest request) {

		return  HttpClientUtils.postRemote(FIND_ROMOTE_URL, Utils.convert(request, ModuleNameService.THEME_DISCOUNT),null).toString();
	}
}
