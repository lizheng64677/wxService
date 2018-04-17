<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<title>${themeTitle}</title>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>


<link href="<c:url value="/resources/css/web/share/share.css"></c:url>" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	var color = '${color}';
	$("body").css("background",color);
	if('${isBegin}'==3){
		$("#time").html("已结束");
	}
    var picUrl = '${detailMap.picUrl}';
    var pic = picUrl.split(",");
    $("#imgsrc").attr("src",""+pic[0]);
});
function toDetail(detailId,userId){
// 	alert(detailId+"========="+userId);
	window.location.href="<c:url value='/experience/toShareExpDetailInfo'/>?expType=1&userId="+userId+"&detailId="+detailId;
}
function experience(){
	var userId=$("#userId").val();
	var detailId=$("#detailId").val();
	var expTimeId=$("#expTimeId").val();
	console.log("share success back function ok");
// 	window.location.href="<c:url value='/thememonth/updateShareDetail'></c:url>?userId=${userId}&detailId=${detailId}&expTimeId=${expTimeId}";
	
}
</script>
</head>

<body>

<div class="topMainBox">
	<img src="${widePic }" />
</div>
<div class="topMiddle"><img src="${themeLogo}" /></div>
<div class="zuBox"><span>"${busname}"</span>倾情赞助</div>

<div class="sjProductMain">
	<div class="sjProductBox">
    	<span class="picBox"><img id="img" src="${proImg}"/></span>
        <span class="commentMainBox">
        	<h2>${proName }</h2>
            <h3>[${title }]</h3>
            <h4>￥0<s>￥${price }</s></h4>
            <div class="timeComment">
                 <span><img src="<c:url value="/resources/images/web/share/time.png"></c:url>" /></span>                 
                 <span id="time">剩余<font>${time}</font>${unit}</span>
            </div>
            
        </span>
        <div class="ckxq"><input type="button" value="查看详情" onclick="toDetail('${detailId}','${userId}');"/></div>
    </div>
</div>

<div class="bottomPic"><img src="${bottomPic}" /></div>
	<!-- 预留隐藏域参数 -->
	<input type="hidden" value="${detailId}" id="detailId"/>
	<input type="hidden" value="${expTimeId}" id="expTimeId"/>
	<input type="hidden" value="${userId}" id="userId"/>
</body>
<script>
var img="";
var imgIsSubmt='${themePic}';
var strSubString=imgIsSubmt.indexOf("http");
if(strSubString>=0){
	img="${themePic}";		
}else{
	img="http://"+location.host+"${themePic}";
}

var shareData = {
		
		title: '${themeTitle}',
	    desc: '${themeTitle}',
	    link: 'http://'+location.host+'/wxService/thememonth/index?userId=${userId}&detailId=${detailId}&expTimeId=${expTimeId}', // 
	    imgUrl:img, 
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };

$(document).ready(function(){

	prodetailshar(shareData);//回调处理  
	
});

</script>
</html>
