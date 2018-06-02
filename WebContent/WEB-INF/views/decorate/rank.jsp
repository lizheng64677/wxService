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
<link href="<c:url value='/resources/css/web/xjjj.css'/>"  rel="stylesheet" type="text/css"/>

<style type="text/css">
.ui-loader{display:none;}
.swipe-wrap img {height:200px;}
.textNameBox{height:35px;}
.he20{line-height:21px;}
.line{
	border-bottom:2px #f00 solid;
	height:35px;
	}
.nav{
	width:100%;
	height:40px;
	background:#fff;
    float: left;
	}
.nav ul li{
	width:20%;
	float:left;
	text-align:center;
	line-height:30px;
	color: #4f4f4f;
}
.nav ul li span{
	float: right;
	}
.paddingcss{
    padding: 5px;
}
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
    <div class="titleTextBox paddingcss">
	    <div class="nav">
	          <ul>
	               <li data-status="-1" class="line">总收益榜<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li>
	               <li data-status="0">人气榜<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li>
	               <li data-status="1">体验榜<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li>
	               <li data-status="2">签单榜<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li>
 			       <li data-status="3">社区榜<span><img src="<c:url value='/resources/images/web/u3.png'/>"></span></li>
	          </ul>
	          <span></span>
	    </div>
    </div>
</div>
<div class="hdgzBox">
	<div class="hdgz">
        <span>整体排名</span>
    </div>
<!--     <div class="hdgzData"> -->
<!--          <ul> -->
<!--              <li>头像</li> -->
<!--              <li>号码</li> -->
<!--              <li>金额 </li> -->
<!--              <li>排名</li>            -->
<!--          </ul> -->
<!--     </div> -->
<!--     <div class="hdgzContent"> -->
<!--          <ul id="fuckf"> -->
            
<!--          </ul> -->
<!--     </div> -->
    
</div>
<!-- <div class="hdgz"> -->
<!--        <span>整体排名</span> -->
<!--  </div>   -->
 <div class="hdgzData">
      <ul>
          <li>头像</li>
          <li>号码</li>
          <li id="sellName">金额</li>
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
	      <a href="<c:url value='/decorate/vouchehome.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/bottomIcon02-2.png'/>"><p class="he20">福券</p></li></a>
	      <a href="<c:url value='/decorate/center.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
	</div>
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/swipe.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script type="text/javascript">
var scroll;
$(document).ready(function(){
// 	initRank("-1");
	initScroller("-1");
	$(".nav").on("click","li",function(){
		$("#main").empty();
		$(".nav li").removeClass("line"); 
		$(this).addClass("line");
		if($(this).data("status")=="-1"){
		 		initRank("-1");
		 		initScroller("-1");
		 		$("#sellName").html("金额");
		}else if($(this).data("status")=="0"){
		 		initRank("0");
		 		initScroller("0");
		 		$("#sellName").html("人气");
		}else if($(this).data("status")=="1"){
		 		initRank("1");
		 		initScroller("1");
		 		$("#sellName").html("位数");
		}else if($(this).data("status")=="2"){
		 		initRank("2");
		 		initScroller("2");
		 		$("#sellName").html("单数");
		}else if($(this).data("status")=="3"){
			  showAlert("即将开放社区榜!");
		}
	});
});

function initRank(type){
	post("/rank/findMyRankInfo",{type:type},false)
	.then(function(data){
		var html=[];
		if(data.expDecorateUser.headImg.length != 0){
			html.push('<li class="hdgzContentPic"><img src="'+data.expDecorateUser.headImg+'"></li>');
		}else{
			html.push('<li class="hdgzContentPic"><img src="'+'<c:url value="/resources/images/web/tx.png"/>'+'"></li>');
		}
		html.push('<li class="hdgzFont">'+createPhone(data.expDecorateUser.userPhone)+'</li>');
		html.push('<li class="hdgzFont">'+data.expDecorateUser.countPrice+'(元)</li>');
		html.push('<li class="hdgzCg">'+data.rankNumber+'</li>');
		$("#fuckf").html($(html.join("")));
	});
}

var page={"page.currentPage":0,"page.showCount":5,type:'-1'};
var total;
function initScroller(type){
	page.type=type;
	startLoading();
	post("/rank/findAllRanInfoList",page,false)
	.then(function(data){
		total=data.args.page.totalPage;
		if(data.data){
			if(data.data.length>0){
				display(data,type);
			}
		}
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


function display(data,type) {
	var main=$("#main");
	for(var i=0;i<data.data.length;i++){
		main.append($(createSingle(data.data[i],type)));
		tempHtml=[];
	}
}

function createSingle(data,type){
	var html=[];
	html.push('<li>');
	html.push('<div class="hdgzContent">');
	html.push('<ul>');

	if(data.head_img)
		html.push('<li class="hdgzContentPic"><img src="'+data.head_img+'"></li>');
	else
		html.push('<li class="hdgzContentPic"><img src="'+'<c:url value="/resources/images/web/tx.png"/>'+'"></li>');
	html.push('    <li class="hdgzFont">'+createPhone(data.user_phone)+'</li>');
	if("-1"==type){
		html.push('	   <li class="hdgzFont">'+data.count_price+'(元)</li>');
	}else if("0"==type){
		html.push('	   <li class="hdgzFont">'+data.countpop+'(人气)</li>');
	}else if("1"==type){
		html.push('	   <li class="hdgzFont">'+data.countpop+'(位)</li>');
	}else if("2"==type){
		html.push('	   <li class="hdgzFont">'+data.countpop+'(单)</li>');
	}
	html.push('    <li class="hdgzCg">'+data.rankNum+'</li>');
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
