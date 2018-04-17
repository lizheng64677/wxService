<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的资料</title>
<link href="<c:url value='/resources/css/web/myInformation.css'/>" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : 'http://localhost/wxService/userPrototype/demo',
			type : 'GET',
		/* 	dataType : 'jsonp',
			jsonp : "callback", */
	      	beforeSend:function(){
	      		layer.open({
	      		    type: 2,
	      		    content: '数据正在加载中...'
	      		});
			},
			success : function(data) {
				layer.closeAll();
				var html="<table cellpadding='0' cellspacing='0'>";
				for(var i=0;i<data.length;i++){
					html+="<tr><td><p></p><h1>"+data[i].busname+"</h1>";
					if(i%3!=0){
						html+="</td></tr>";
					}
					
				}
				 html+=" </table>";
				$("#dtable").append(html);
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
	<div id="dtable" class="sjListBox">
	</div>
	
</body>

</html>
