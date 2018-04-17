<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>发现</title>
<link href="<c:url value='/resources/css/web/theme.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/found.css'/>"/>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<style type="text/css">
.boxgoing{
	background:url(${pageContext.request.contextPath}/resources/images/web/a16.png) no-repeat;
	background-size: 60px 30px;
}
.boxgoing1{
	background:url(${pageContext.request.contextPath}/resources/images/web/a15.png) no-repeat;
	background-size: 60px 30px;
}
.actListBox ul{
	padding-top: 20px;
}
#fpmxListPage{
}
</style>
</head>
<body>
<div data-role="page" id="fpmxListPage" data-iscroll="enable">
	<!-- <div data-role="header">
	   <div class="headerContent">
	       <ul>	       	 
	          <li class="headerFont">发现</li>
	       </ul>  
	    </div> 
	</div> -->
	<div data-role="content" data-role="content">
		<div id="wrapperIndex" class="wrapper">
			<div id="scrollerIndex" class="scroller actListBox">
					<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" >
					</ul>
				
				<div id="pullUp" class="loading" style="margin-bottom:30px; margin-top:30px;">
					<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
				</div>
			</div>
		</div>
	</div>
</div>
   
<!--底部导航-->

<div class="bottom" data-role="footer">
  <ul>
      <a href="<c:url value='/index/toIndex'/>" target="_self"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_0.png'/>"><p class="he30">首页</p></li></a>
      <a href="<c:url value='/find/toThemeIndex'/>"><li class="Mybottom"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he30">发现</p></li></a>
      <a href="<c:url value='/user/toMain'/>" target="_self"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_0.png'/>"/><p class="he30">我的</p></li></a>
  </ul>
</div>

<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>

<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript">
    $("body").css("background","white");
	var path = '${pageContext.request.contextPath}';
	var scroll;
	$(document).bind("pageshow", function() {
		scroll=fixed($(this),0,30);
		scroll.setUrl("<c:url value='/find/list'/>");
		scroll.setSearchCondition({currentPage:1,type:4});
		scroll.setDisplay(display);
		$(".ui-loader").remove();
		$(".ui-content").css("padding-top","5px");
		scroll.initSearch(); 
	});
	
	function display(data) 
	{
		var html=[];
		if (data != null && data != "") 
		{
			for(var i=0;i<data.data.length;i++)
			{
				html.push('<li class="back1" onclick=dddd("'+data.data[i].url+'")>');
				html.push('<a href="'+data.data[i].url+'">');
				html.push('<img src="'+data.data[i].image+'">');
				html.push('<div class="textBox">');
				html.push('<h1>'+data.data[i].title+'</h1></div>');
				
				
				html.push('</a>');
				if(data.data[i].isover == 0 && data.data[i].isstart == 1 )
				{
					html.push('<div class="boxgoing"><span>进行中</span></div>');
				}
				else if(data.data[i].isover == 1)
				{
					html.push('<div class="boxgoing boxgoing1"><span>已结束</span></div>');
				}
				else
				{
					html.push('<div class="boxgoing"><span>即将上线</span></div>');
				}
				html.push('</li>');
			}
	
		
			$("#main").append(html.join(''));
			$("#main").listview("refresh");
		}
	}
	function dddd(url){

		window.location.href=url;
	}
</script>
</body>
</html>