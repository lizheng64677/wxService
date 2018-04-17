<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>主题活动</title>
<link href="<c:url value='/resources/css/web/theme.css'/>" rel="stylesheet" type="text/css" />
<%-- <link rel="stylesheet" href="<c:url value='/resources/css/web/pull/jquery.mobile.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/theme/theme.min.css'/>" />  --%>
<%-- <link rel="stylesheet" href="<c:url value='/resources/css/web/pull/styles.css'/>" />  --%>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
</head>
<body>
<div data-role="page" id="fpmxListPage" data-iscroll="enable">
	<div style="height:50px;">
	</div>
	<div data-role="content" >
		<div id="wrapperIndex" class="wrapper" >
			<div id="scrollerIndex" class="scroller actListBox">
				<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 20px;">
				</ul>
				<div id="pullUp" class="loading" style="margin-bottom:30px; margin-top:30px;">
					<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/mobileinit.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript">
	var path = '${pageContext.request.contextPath}';
	var scroll;
	$(document) .bind("pageshow", function() {
		scroll=fixed($(this),0,30);
		scroll.setUrl("<c:url value='/find/list'/>");
		scroll.setSearchCondition({currentPage:1,type:4});
		scroll.setDisplay(display);
		scroll.initSearch(); 
	});
	function displayB(){
		for(var i=0;i<10;i++){
			$("#main").append($("<li>"+i+"</li>"));
		}
	}
	
	function display(data) {
		var html="";
		if (data != null && data != "") {
			for(var i=0;i<data.data.length;i++){

// 				$("#main").append(createHTML(data.data[i]));
				

				html+='<li>';
				html+='<a href="'+data.data[i].url+'">';	
				html+='<span class="picbox"><img height="60" src="'+data.data[i].image+'"></span>';
				html+='<span class="actTextBox">';
				html+='<h1>'+data.data[i].title+'</h1>';
				html+='<p>活动时间:';
				
				html+=formatTime(data.data[i].beginDate);
				html+='至';
				html+=formatTime(data.data[i].endDate);			
				html+='</p>';
				html+='</span>';
				html+='</a>';
				if(data.data[i].isover == 0)
					html+=' <div class="overBox"><img src="'+path+'/resources/images/web/over.png" /></div>';
				html+='</li>';
				$("#main").append(html);
			}
			$("#main").listview("refresh");
		}
	}
	var now=new Date();
	var temp=new Date();
	var beginString,endString;
	function createHTML(data){
		var html="";
		html+='<li>';
		html+='<a href="'+data.url+'">';	
		html+='<span class="picbox"><img height="60" src="'+data.image+'"></span>';
		html+='<span class="actTextBox">';
		html+='<h1>'+data.title+'</h1>';
		html+='<p>活动时间:';
		temp.setTime(data.beginDate);
		html+=temp.format("M.d");
		html+='至';
		temp.setTime(data.endDate);
		html+=temp.format("M.d");			
		html+='</p>';
		html+='</span>';
		html+='</a>';
		if(temp.compare(now)<0)
			html+=' <div class="overBox"><img src="images/fcodefree/oactivity/over.png" /></div>';
		html+='</li>';
		return html;
	}
	
	
	var formatTime = function(str)
	{
		var m = str.split("-")[1];
		var d = str.split("-")[2];
		return m + "." + d ;
	}
	
</script>
</body>
</html>
