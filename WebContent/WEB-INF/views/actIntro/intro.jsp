<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>NO团网活动使用说明</title>
<link href="<c:url value='/resources/css/web/introduction.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/agreement.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var type = getUrlParam('type');
		
		//0:轻松赚，1：帮我赚，2：抽奖式，3：人气式，4：0元式，5：兑换式
		if(type == 0) {
			$("h1").html("轻松赚使用说明");
			$(document).attr("title","轻松赚使用说明");
		} else if(type == 1) {
			$("h1").html("帮我赚使用说明");
			$(document).attr("title","帮我赚使用说明");
		} else if(type == 2) {
			$("h1").html("抽奖乐使用说明");
			$(document).attr("title","抽奖乐使用说明");
		} else if(type == 3) {
			$("h1").html("人气王使用说明");
			$(document).attr("title","人气王使用说明");
		} else if(type == 4) {
			$("h1").html("0元式使用说明");
			$(document).attr("title","0元式使用说明");
		} else if(type == 5) {
			$("h1").html("兑换式使用说明");
			$(document).attr("title","兑换式使用说明");
		}
		
		post("/actIntro/get",{type:type},false)
		.then(function(data){
			$(".firstOne").html(data.data.content);
		});
	});
	
	//获取url中的参数
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
    }
</script>
</head>
<body>
<div class="logoBox"><img src="<c:url value='/resources/images/web/logo.png'/>" /></div>
<div class="jsTextBox">
	<h1></h1>
    <div class="firstOne">

    </div>
</div>
</body>
</html>
