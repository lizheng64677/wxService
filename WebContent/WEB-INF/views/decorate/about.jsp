<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>关于我们</title>
<link href="<c:url value='/resources/css/web/notuan.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
	var shareData = {
		title: '营销活动',
	    desc: '营销活动', 
	    link: 'http://'+location.host+'/wxService/decorate/index.html?id=${expId }', 
	    imgUrl: 'http://'+location.host+'/wxService/resources/images/web/memberjt.png', 
	    requrl: 'http://'+location.host+'/wxService/share/sharePrepare',
		param:location.href
    };
	$(document).ready(function(){
		 hideOptionMenu(shareData);
	}); 
</script>
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
