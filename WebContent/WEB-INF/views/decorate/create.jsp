<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>我的专属海报</title>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<link href="<c:url value="/resources/css/web/share/share.css"></c:url>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/xjjj.css'/>"  rel="stylesheet" type="text/css"/>

<style> 
body{
	background:#ffffff;
}
.topMiddle{	
 	margin:1px; 
	height: 90%;
	width: 99%;
 }
.topMiddle img{
	   margin-left:1px;
	   height: 500px;
	   width: 100%;
}
.topMainBox {
	    background-size: cover;
	    text-align: center;
	    padding-top: 1px;

 }
.he20{line-height:21px;}

</style>
</head>

<body>
<div class="topMainBox">
  <p class="alertinfo">(*)长按图片保存，分享至朋友圈</p>
</div>
<div class="topMiddle">
	<img id="image" src="<c:url value='/resources/images/web/template1.jpg'/>" />
</div>
<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/vouchehome.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/bottomIcon02-2.png'/>"><p class="he20">福券</p></li></a>
	      <a href="<c:url value='/decorate/center.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
	</div>
</body>
<script type="text/javascript">
$(function(){
	initData();//查询数据
})
//查询数据
function initData(){  
	var url="http://"+location.host+"/wxService/decorate/share.html";
	$("#image").attr("src","<c:url value='/createpost/writeImageStream'></c:url>?id=${expId}&openid=${publishopenid}&url="+url);
}
</script>
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
	    link: 'http://'+location.host+'/wxService/decorate/share.html?publishopenid=${publishopenid}&expId=${expId}',  	    imgUrl:img, 
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };

$(document).ready(function(){

	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);

});

</script>
</html>
