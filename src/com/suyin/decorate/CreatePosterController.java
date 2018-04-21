package com.suyin.decorate;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/createpost")
public class CreatePosterController {

	/**
	 * 进入平台介绍页面
	 * @return
	 */
	@RequestMapping("/create.html")
	public ModelAndView toIntroduction(){

		ModelMap  model=new ModelMap();
		return new ModelAndView("/decorate/create",model);
	}
}
