<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>体验店地址</title>
<link href="<c:url value='/resources/css/web/addressList.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript">
$(function() {
	$.ajax({
		url : '<%=basePath%>/about/tostoretolist',
		type : 'GET',
//		 	dataType : 'jsonp',
//			jsonp : "callback", 
      	beforeSend:function(){
      		layer.open({
      		    type: 2,
      		    content: '数据正在加载中...'
      		});
		},
		success : function(data) {
			layer.closeAll();
var ulli="<ul>";
for(var i=0;i<data.length;i++)
{   ulli+="<li><a href='"+data[i].store_address_url+"'><span class='picbox'><img src='<c:url value='"+data[i].store_pic_url+"'/>'></span>"
    ulli+="<span class='actTextBox'><h1>"+data[i].store_name+"</h1> <p>"+data[i].store_address+"</p></span></a></li>"
}
ulli+="</ul>";
$("#ul").append(ulli);
},
error : function() {
	layer.closeAll();
	layer.open({
	    content: '跨域请求失败!',
	    style: 'background-color:#09C1FF; color:#fff; border:none;',
	    time: 1
	});
}
});
});
</script>
</head>
<body>
<div id="ul" class="actListBox">

</div>
</body>
</html>
