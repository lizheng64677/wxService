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
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<link href="<c:url value="/resources/css/web/share/share.css"></c:url>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/>
<style> 
body{
	background:#ffffff;
}
.topMiddle{	
	margin:5px;
	border:1px #cccccc solid;
	height: 90%;
	width: 90%;
	padding: 10px;
}
.topMiddle img{
	   height: 500px;
	   width: 80$;
}
.topMainBox {
	    background-size: cover;
	    text-align: center;
	    padding-top: 20px;
	    text-align: center;
    }
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
	post('/createpost/writeImage',{id:'${expId}',"openid":"${publishopenid}",url:"http://"+location.host+"/wxService/decorate/share.html?expId=${expId}&publishopenid=${publishopenid}"},true,"专属海报生成中...").then(function(data){
	
		$("#image").attr("src",data.imgUrl);
	
	});
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

	prodetailshar(shareData);//回调处理

});

</script>
</html>
