<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>排名</title>
<link href="<c:url value='/resources/css/web/zeroPopRankDetail.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/swipe.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/expdetail/swipe_zoom.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/>
<style type="text/css">
.ui-loader{display:none;}
.swipe-wrap img {height:200px;}
.textNameBox{height:35px;}
</style>
</head>
<body>
<div data-role="page" data-iscroll="enable">
<div class="detialCommentBox">
	<div id="slider">
		<div class="swipe-wrap" style="height: 200px;">
		     <div class="cinema_banner">
				     <img src='<c:url value='/resources/images/web/rankpm.png'/>'></img>
			</div>
	    </div>
		<div class="picBox">
	        <div class="textNameBox" >
<!-- 	        	<h1 class="fLeft">活动标题<font></font></h1> -->
	            <!-- <div class="fRight"><span></span></div> -->
	        </div>
	    </div>
    </div>
    <div class="titleTextBox">
      
    </div>
</div>
<div class="hdgzBox">
	<div class="hdgz">
        <span>我的排名</span>
    </div>
    <div class="hdgzData">
         <ul>
             <li>头像</li>
             <li>号码</li>
             <li>金额 </li>
             <li>排名</li>           
         </ul>
    </div>
    <div class="hdgzContent">
         <ul id="fuckf">
            
         </ul>
    </div>
    
</div>
<div class="hdgz">
       <span>整体排名</span>
 </div>  
 <div class="hdgzData">
      <ul>
          <li>头像</li>
          <li>号码</li>
          <li>金额</li>
          <li>排名</li>
      </ul>
 </div>	
    <div class="hdgzBox" data-role="content" style="margin-top:4px;">
    	<div id="wrapperIndex" class="wrapper" >
    		<div id="scrollerIndex" class="scroller actListBox">
			<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main">
			</ul>
			<div id="pullUp" class="loading" style="margin-top:5px;">
				<span class="pullUpIcon"></span><span class="pullUpLabel">正在加载......</span>
			</div>	       
	       </div>
       </div>
    </div>
</div>
	<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/center.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
	</div>
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/swipe.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script type="text/javascript">
$(document).ready(function(){
	initRank();
	initScroller();
});

function initRank(){
	post("/experience/findRankForMySelf",{detailId:'${exp_detail_id}'},false)
	.then(function(d){
		var data=d.data;
		var html=[];
		if(data.head_image_url){
			html.push('<li class="hdgzContentPic"><img src="'+data.head_image_url+'"></li>');
		}else{
			html.push('<li class="hdgzContentPic"><img src="'+'<c:url value="/resources/images/web/tx.png"/>'+'"></li>');
		}
		html.push('<li class="hdgzFont">'+data.share_num+'</li>');
		html.push('<li class="hdgzFont">'+data.rank+'</li>');
		if(data.status==0)
			html.push('<li class="hdgzCg">进行中</li>');
		else if(data.status==1)
			html.push('<li class="hdgzCg">成功</li>');
		else if(data.status==2){
			html.push('<li class="hdgzCg">失败</li>');
		}
		$("#fuckf").html($(html.join("")));
	});
}

var page={"page.currentPage":0,"page.showCount":5,detailId:'${exp_detail_id}'};
var total;
function initScroller(){
	startLoading();
	post("/experience/findExpRank",page,false)
	.then(function(data){
		total=data.args.page.totalPage;
		display(data);
		stopLoading();
	});
}
//开始加载前的准备工作，包括页数加一，显示“正在加载”的字样，以及去掉pullUp的rclick事件
function startLoading(){
	page["page.currentPage"]=page["page.currentPage"]+1;
	if($("#pullUp").not(".loading"))
		$("#pullUp").addClass("loading");
	$(".pullUpLabel").html("正在加载......");
	$("#pullUp").off("click");
}

//结束加载后要改变字样，并且根据当前页数判断是否要给pullUp加click事件
function stopLoading(){
	$("#pullUp").removeClass("loading");
	$(".pullUpLabel").html("点击加载更多信息");
	if(page["page.currentPage"]>=total){ 
		$(".pullUpLabel").html("已加载完全部信息");
		return;
	}
	initClicker();
}


function initClicker(){
	$("#pullUp").on("click",function(){
		
		
		initScroller();
	});
	
}


function display(data) {
	var main=$("#main");
	for(var i=0;i<data.data.length;i++){
		main.append($(createSingle(data.data[i])));
		tempHtml=[];
	}
}

function createSingle(data){
	var html=[];
	html.push('<li>');
	html.push('<div class="hdgzContent">');
	html.push('<ul>');
	if(data.head_image_url)
		html.push('    <li class="hdgzContentPic"><img src="'+data.head_image_url+'"></li>');
	else
		html.push('    <li class="hdgzContentPic"><img src="'+'<c:url value="/resources/images/web/tx.png"/>'+'"></li>');
	html.push('    <li class="hdgzFont">'+createPhone(data.user_phone)+'</li>');
	html.push('	   <li class="hdgzFont">'+data.share_num+'</li>');
	html.push('    <li class="hdgzCg">'+data.rank+'</li>');
	html.push('</ul>');
	html.push('</div>');
	html.push('</li>');
	return html.join('');
}
    
function createPhone(p){
	return p.substr(0,3)+"***"+p.substr(8,3);
}
</script>

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
</body>
</html>
