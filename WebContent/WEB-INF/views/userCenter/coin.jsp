<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="telephone=no" name="format-detection"> 
<title>我的资产</title>
<link href="<c:url value='/resources/css/web/myAsset.css'/>"  rel="stylesheet" type="text/css"/></head>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<body>
<div data-role="page" data-iscroll="enable">
    <div class="header" data-role="header">
        <div class="headerContent">
           <ul>
              <li class="headerFont">我的资产</li>
           </ul>  
        </div> 
        <div class="headeGold"><span id="coin"></span>金币</div>   
    </div>
	<div class="content" data-role="content" style="margin-top:4px;">
		<div id="wrapperIndex" class="wrapper" >
			<div id="scrollerIndex" class="scroller actListBox">
				<div class="qListBox">
					<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 40px;">
					</ul>
					<div id="pullUp" class="loading" style="margin-top:5px;">
						<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="button">
       <div class="buttonContent">
           <input type="button" value="提取至钱包" class="buttonMoney" onclick="window.location.href='<c:url value='/user/tocoin2Cash'/>'"/>
           <!-- <input type="button" value="兑换奖品" class="buttonBox"/> -->
       </div>
</div>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>

<script type="text/javascript">
var scroll;
var ROOT="<c:url value='/'/>";
$(document) .bind("pageshow", function() {
	post("/sen/getUserSInfo",{},false).then(function(data){
		$("#coin").html(data.gold_coin);
	});
	initScroller();
});

function initScroller(){
	scroll=fixed($(document),46,43);
	scroll.setUrl("<c:url value='/sen/getCoin' />");
	scroll.setSearchCondition({"page.currentPage":1,status:0});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

function display(data) {
	var main=$("#main");
	for(var i=0;i<data.data.length;i++){
// 		main.append($(createSingleLi(data.data[i])));
		main.append($(createHtml(data.data[i])));
	}
}
function createSingleLi(data){
	if(data.direction==2)
		return $("#htmlTextDown").html().replace("#content",data.content?data.content:"未知操作")
		.replace("#createTime",data.createTime)
		.replace("#money",data.goldCoin)
		.replace("#status",data.status);
	else
		return $("#htmlTextUp").html().replace("#content",data.content?data.content:"未知操作")
		.replace("#createTime",data.createTime)
		.replace("#money",data.goldCoin)
		.replace("#status",data.status);
}

function createHtml(data){
	var html="";
	html+="<li>";
	html+="<div class='box'>";
	html+="<ul>";
	html+="  <li class='bt'>"+data.content+"</li>";
	if(data.direction==2){
		html+=" <li class='pic'><img src='<c:url value='/resources/images/web/xia.png'/>' width='15'></li>";
		if(data.status==0){
			html+=" <li class='money'>-"+data.goldCoin+"金币</li>";
		}else if(data.status==1){
			
			html+=" <li class='money'>审核中</li>"; 
		}else if(data.status==2){
			
			html+=" <li class='money'>被驳回</li>"; 
		}
	}else{
		
		html+=" <li class='pic'><img src='<c:url value='/resources/images/web/upjt.png'/>' width='15'></li>";
		if(data.status==0){
			html+=" <li class='money'>+"+data.goldCoin+"金币</li>";
		}else if(data.status==1){
			
			html+=" <li class='money'>审核中</li>"; 
		}else if(data.status==2){
			
			html+=" <li class='money'>被驳回</li>"; 
		}
	}
    	html+=" <li class='time'>"+data.createTime+"</li>";
	


	html+="</ul>";
	html+="</div>";
	html+="</li>";
	return html;
}
var shareData = {			
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };		
$(function(){
	
	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);
});
</script>

</body>
</html>
