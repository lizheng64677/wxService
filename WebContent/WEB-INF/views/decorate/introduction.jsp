<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>平台规则</title>
<link href="<c:url value='/resources/css/web/introduction.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/agreement.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<link href="<c:url value='/resources/css/web/notuan.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
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
<script type="text/javascript">
	$(document).ready(function(){
		post("/about1/get",{type:0},false)
		.then(function(data){
			$(".firstOne").html(data.data[0].content);
		});
	});
</script>
</head>

<body>
<div class="topBg">
<img src="<c:url value='/resources/images/web/rankpm.png'/>" />
</div>
<%-- <div class="logoBox"><img src="<c:url value='/resources/images/web/logo.png'/>" /></div> --%>
<div class="jsTextBox">
	<h1>平台规则</h1>
    <div class="firstOne">

    </div>
</div>
</body>
</html>
