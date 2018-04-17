<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>关于我们</title>
<link href="<c:url value='/resources/css/web/notuan.css'/>"  rel="stylesheet" type="text/css"/></head>

<body>
<div class="topBg"><img src="<c:url value='/resources/images/web/topbg_02.png'/>" /></div>

<div class="flMainBox">
	<ul>
    	<li><a href="<c:url value='/user/toIntroduct'/>">平台介绍</a></li>
        <li><a href="<c:url value='/user/toProtocol'/>">用户协议</a></li>
        <li><a href="#">合作商家</a></li>
        <li><a href="#">体验店地址</a></li>
    </ul>
</div>
<div class="phoneBox"><img src="<c:url value='/resources/images/web/phone.png'/>" />
<span><a href="tel:025-84685405">025-84685405</a></span>
</div>
</body>
</html>
