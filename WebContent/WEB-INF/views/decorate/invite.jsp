<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的邀请</title>
<link href="<c:url value='/resources/css/web/involvement.css'/>"  rel="stylesheet" type="text/css"/></head>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<body>
<div data-role="page" data-iscroll="enable">
	<div data-role="header">
	   <div class="headerContent">
	       <ul>
	       	  <a href="javascript:history.go(-1);"><li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li></a>
	          <li class="headerFont">我的邀请名单</li>
	       </ul>  
	    </div>  
<!-- 	    <div class="nav"> -->
<!-- 	          <ul> -->
<%-- 	               <li data-status="-1" class="line">全部<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li> --%>
<%-- 	               <li data-status="0">未提交<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li> --%>
<%-- 	               <li data-status="1">进行中<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li> --%>
<%-- 	               <li data-status="2">成功<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li> --%>
<!-- 	               <li data-status="3">失败</li> -->
<!-- 	          </ul> -->
<!-- 	          <span></span> -->
<!-- 	    </div> -->
    </div>
    <div class="content" data-role="content" style="margin-top:4px;">
		<div id="wrapperIndex" class="wrapper" >
			<div id="scrollerIndex" class="scroller actListBox">
				<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 40px;">
				</ul>
				<div id="pullUp" class="loading" style="margin-top:5px;">
					<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
				</div>
			</div>
		</div>    	
    </div>
</div>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>

<script type="text/javascript">
var scroll;
var tempHtml=[];
var ROOT="<c:url value='/'/>";
$(document) .bind("pageshow", function() {
		initScroller();
	$(".nav").on("click","li",function(){
		$("#main").empty();
		$(".nav li").removeClass("line"); 
		$(this).addClass("line");
		if($(this).data("status")=="-1"){
			scroll.setSearchCondition({"page.currentPage":1});
		}else{
			scroll.setSearchCondition({"page.currentPage":1,status:$(this).data("status")});
		}
		scroll.initSearch(); 
	});
	
});

function initScroller(){
	scroll=fixed($(document),46,43);
	scroll.setUrl("<c:url value='/decorate/findInvite'/>");
	scroll.setSearchCondition({"page.currentPage":1});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

//显示数据，所有的tab可以共用这一个显示方法
function display(data) {
	debugger;
	var main=$("#main");
	for(var i=0;i<data.data.length;i++){
		main.append($(createSingleLi(data.data[i])));
		tempHtml=[];
	}
}
function createSingleLi(data){
	tempHtml.push('<li>');
	tempHtml.push('<div class="box" qmType='+data.qmType+' orderId="'+data.orderId+'"  orderType="'+data.orderType+'"  expId="'+data.expId+'" showType="'+data.showType+'">');
	tempHtml.push('<ul>');
	tempHtml.push('<li class="pic"><img src="'+data.head_img+'"></li>');
	tempHtml.push('<li class="boxfont">'+data.title+'</li>');
	tempHtml.push('<li class="boxcg"><span class="Conduct">进行中</span></li>');
	tempHtml.push('</ul>');
	tempHtml.push('</div>');
	tempHtml.push('</li>');
	return tempHtml.join('');
}

function work(){
	
}
var shareData = {			
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
};	
$(function(){
	//个人中心不允许有多余菜单出现 
	sharTimelineFun(shareData);
	
})
</script>
</body>
</html>
