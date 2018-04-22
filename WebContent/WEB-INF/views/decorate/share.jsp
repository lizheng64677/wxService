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
<style>
.nametext{
	overflow: hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
}
.zuBox .picBox img{
    width: 20%;
    border-radius: 160px;
    height: 20%;
    }
</style>
<script type="text/javascript">
$(function(){
	var color = '${color}';
	$("body").css("background",color);
});

function toDetail(detailId,userId){
	window.location.href="<c:url value='/decorate/index.html'/>?id=${expId}";
}
</script>
</head>

<body>

<div class="topMainBox">
	<img src="${themePic }" />
</div>
<div class="topMiddle"><img src="${themeLogo}" /></div>
<div class="zuBox">
  		<span class="picBox">
  			<img id="img" src="${user.headImg}"/>
  		</span>
  		</br>
		<span>"${user.nickName }"</span>真诚邀请您!
</div>

<div class="sjProductMain">
	<div class="sjProductBox">
    	<span class="picBox"><img id="img" src="${decorate.activeImg }"/></span>
        <span class="commentMainBox">
        	<h2 class="nametext">${decorate.name }</h2>
            <h3 class="nametext">${decorate.title }</h3>            
        </span>
        <div class="ckxq"><input type="button" value="查看活动" onclick="toDetail('${expId}');"/></div>
    </div>
</div>

<div class="bottomPic"><img src="${bottomPic}" /></div>

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
	    link: 'http://'+location.host+'/wxService/decorate/share.html?publishopenid=${publishopenid}&expId=${expId}', // 
	    imgUrl:img, 
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };

$(document).ready(function(){

	prodetailshar(shareData);//回调处理   
	
});

</script>
</html>
