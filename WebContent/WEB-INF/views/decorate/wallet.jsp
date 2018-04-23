<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="telephone=no" name="format-detection"> 
<title>我的钱包</title>
<link href="<c:url value='/resources/css/web/wallet.css'/>"  rel="stylesheet" type="text/css"/></head>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<body>
<div data-role="page" data-iscroll="enable">
    <div class="header" data-role="header">
        <div class="headerContent">
           <ul>
              <li class="headerFont">我的钱包</li>
           </ul>  
        </div> 
        <div class="headeGold">￥<span id="money">0.0</span></div>   
    </div>
	<div class="content" data-role="content" style="margin-top:4px;">
		<div id="wrapperIndex" class="wrapper" >
			<div id="scrollerIndex" class="scroller actListBox">
				<div class="qListBox">
					<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 40px; ">
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
	<input type="hidden" id="issubmit" value="no"/>
	<input type="button" onclick="work11()" value="提现">
</div>

<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">

//参数：提示信息，左边按钮链接，左边按钮，右边按钮，右边按钮
function showDialog(promtMsg, promtUrlCancel, cancelInfo, promtUrlOK, OKInfo) {

	$("#promtMsg").html(promtMsg);
	$("#promtUrlCancel").html(cancelInfo);
	$("#promtUrlOK").html(OKInfo);
	if (promtUrlCancel != "") {
		$("#promtCancel").attr("href", promtUrlCancel);
	} else {
		$("#promtCancel").attr("href", "javascript:hiddenDialog();");
	}
	if (promtUrlOK != "") {
		$("#promtOK").attr("href", "javascript:void(0)").on("click",function(){
			window.location.href=promtUrlOK;
		});
	} else {
		$("#promtOK").attr("href", "javascript:hiddenDialog();");
	}
	$("#dialog").show();
}

function hiddenDialog() {
	$("#dialog").hide();
}

var scroll;
var ROOT="<c:url value='/'/>";
$(document) .bind("pageshow", function() {
	post("/expdecorateuser/findUserInfoByUserIdOrOpenId",{},false).then(function(data){
		$("#money").html(data.balancePrice);
		 if(""!=data.password && ""!=data.alipayNumber){
			 $("#issubmit").val("yes");
		 }	
	});
	initScroller();
});
function initScroller(){
	scroll=fixed($(document),46,43);
// 	scroll.setUrl("<c:url value='/sen/getWallet' />");
	scroll.setUrl("<c:url value='/decorate/findInvite'/>");
	scroll.setSearchCondition({"page.currentPage":1,status:0});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

function display(data) {
	var main=$("#main");
	for(var i=0;i<data.data.length;i++){
		main.append($(createHtml(data.data[i])));
	}
}

function work11(){
	 if("yes"==$("#issubmit").val()){
		window.location.href="<c:url value='/decorate/cashtoali.html'/>";
	 }else{
		showDialog("请先补全资料","","取消","<c:url value='/decorate/mydata.html?id=${expId }'/>","确定");
	 }
}

function createHtml(data){
	var html="";
	html+="<li>";
	html+="<div class='box'>";
	html+="<ul>";
	html+="  <li class='bt'>余额提现</li>";
	if(data.direction==2){
		html+=" <li class='pic'><img src='<c:url value='/resources/images/web/xia.png'/>' width='15'></li>";
		if(data.status==0){
			html+=" <li class='money'>-"+data.money+"元</li>";
		}else if(data.status==1){
			
			html+=" <li class='money'>审核中</li>"; 
		}else if(data.status==2){
			
			html+=" <li class='money'>被驳回</li>"; 
		}
	}else{
		 
		html+=" <li class='pic'><img src='<c:url value='/resources/images/web/xia.png'/>' width='15'></li>";
		if(data.status==0){
			html+=" <li class='money'>+"+data.money+"元</li>";
		}else if(data.status==1){
			
			html+=" <li class='money'>审核中</li>"; 
		}else if(data.status==2){
			
			html+=" <li class='money'>被驳回</li>"; 
		}
		html+=" <li class='money'>-20 元</li>"; 

	}
    	html+=" <li class='time'>"+data.create_time+"</li>";
	

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
