<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>关于我们</title>
<link href="<c:url value='/resources/css/web/notuan.css'/>"  rel="stylesheet" type="text/css"/></head>
</head>
<body>
<div class="topBg"><img src="<c:url value='/resources/images/web/rankpm.png'/>" /></div>

<div class="flMainBox">
	<ul>
    	<li ><a  style="float:left;"href="<c:url value='/decorate/introduction.html'/>">
    		<img src="<c:url value='/resources/images/web/about/ptgz.png'/>">
    		<p>平台规则</p>
    		</a>
    	</li><span class="xian"></span>
        <li><a href="<c:url value='/decorate/agreement.html'/>">
        	<img src="<c:url value='/resources/images/web/about/yhxy.png'/>">
        	<p>用户协议</p>
        	</a>
        </li>
        <li ><a  style="float:left;border-top: 1px solid #ebebeb" href="#">
        	<img src="<c:url value='/resources/images/web/about/hzsj.png'/>">
        	<p>合作商家</p>
        	</a>
        </li>
        <span class="xian martop"></span>
        
        <li ><a style="border-top: 1px solid #ebebeb;" href="#">
        	<img src="<c:url value='/resources/images/web/about/tyddz.png'/>">
        	<p>分店地址</p>
        	</a>
        </li>
    </ul>
</div>

<div class="phoneBox">
	<span><a href="tel:#"><input type="button" value="联系我们" class="buttons"></a></span>
</div>
</body>
</html>
