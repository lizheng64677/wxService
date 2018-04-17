<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="telephone=no" name="format-detection"> 
<title>轻松赚</title>
<link href="<c:url value='/resources/css/web/qixinzhuan.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
</head>
<body>
<div data-role="page" data-iscroll="enable">
 <!-- <div class="headerContent">
       <ul>
       	  <a href="javascript:history.go(-1);"><li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li></a>
          <li class="headerFont">轻松赚</li>
       </ul>  
    </div> -->
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
<script src="<c:url value='/resources/js/pull/initScrollList.js'/>"></script>
<script type="text/javascript">
	var scroll;
	var tempHtml=[];
	$(document) .bind("pageshow", function() {
		initScroller();
		initClicker();
	});
	
	function initScroller(){
		scroll=fixed($(document),46,43);
		scroll.setUrl("<c:url value='/index/findQixinZhuanList'/>");
		scroll.setSearchCondition({"page.currentPage":1,expType:1});
		scroll.setDisplay(display);
		scroll.initSearch(); 
	}
	
	function initClicker(){
		$("#main").on("click",".li-id",function(){
			//console.log($(this).attr("data-expId"));
			window.location.href="<c:url value='/index/toQuanminDetail?expId='/>"+$(this).attr("data-expId");
		});
	}
	
	function display(data) {
		var main=$("#main");
		for(var i=0;i<data.data.length;i++){
			main.append($(createSingleLi(data.data[i])));
			tempHtml=[];
		}
	}
	function createSingleLi(data){
		tempHtml.push('<li class="li-id" data-expId="'+data.exp_id+'">');
		tempHtml.push('<div class="box">');
		tempHtml.push('<ul>');
		//tempHtml.push('<li class="pic"><img src="'+data.exp_img_url+'"></li>');
		tempHtml.push('<li class="pic">');
		if(data.is_label ==1 && (data.exp_total_status!=0&&data.exp_gold_status!=0))
		{
			tempHtml.push('<p class="labels">'+data.label+'</p>');
		}
		tempHtml.push('<img src="'+data.exp_img_url+'">');
		tempHtml.push('</li>');
		tempHtml.push('<li class="bt"><span>'+data.member_name+'</span>');
		
		tempHtml.push('</li>');
		tempHtml.push('<li class="wxin">'+data.title+'</li>');
		tempHtml.push('<li class="boxmenoy"><img src="'+"<c:url value='/resources/images/web/u4.png'/>"+'"><span>'+data.exp_user_gold+'</span>金币收益</li>');
		tempHtml.push('</ul>');
		tempHtml.push('</div>');
		if(data.exp_total_status==0||data.exp_gold_status==0){
			tempHtml.push('<img  style="width: 76px;position: absolute;margin-top: -100px;margin-left: 63px;z-index: 9999;" src="'+"<c:url value='/resources/images/web/u26.png'/>"+'"/>');
		}
		tempHtml.push('</li>');
		return tempHtml.join('');
	}
</script>

</body>
</html>
