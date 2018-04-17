package com.suyin.userCenter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.NameValuePair;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suyin.utils.HttpClientUtils;
import com.suyin.utils.Utils;

@Controller
@RequestMapping("/about1")
public class About1Controller {

    @RequestMapping(value="/get")
    public @ResponseBody String getIntroduct(HttpServletRequest request) {

        String result=HttpClientUtils.postRemote("/no/about", Utils.convert(request, "no"), null).toString();
        return result;

    }
}
