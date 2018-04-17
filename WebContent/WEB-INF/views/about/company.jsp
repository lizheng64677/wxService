<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>合作商家</title>
<link href="<c:url value='/resources/css/web/company.css'/>"  rel="stylesheet" type="text/css"/>
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript">

	$(function() {
		$.ajax({
			url : '<%=basePath%>/about/tocompanytolist',
			type : 'GET',
// 		 	dataType : 'jsonp',
// 			jsonp : "callback", 
	      	beforeSend:function(){
	      		layer.open({
	      		    type: 2,
	      		    content: '数据正在加载中...'
	      		});
			},
			success : function(data) {
				layer.closeAll();
				//动态构造 列为3的表格，此处data.length为数据数量
				var html="<table  cellpadding='0' cellspacing='0'><tr>";
				for(var i=0;i<data.length;i++){
					html+="<td class='middleBox'><p><img src='"+data[i].logo_pic_url+"'></img></p><h1>"+data[i].busname+"</h1>";
					if((i+1)%3==0&&i!=data.length-1){
						html+="</td></tr><tr>";
					}else if(i==data.length-1){
						html+="</td></tr>"
					}
					
				}
				 html+=" </table>";
				$("#tablebox").append(html);
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
<div class="hzsjMainBox">合作商家</div>
	<div id="tablebox" class="sjListBox">
	</div>
	
</body>

</html>
