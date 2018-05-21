<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${pro_name }</title>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/dialog.css'/>"rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/zeroQiangDetical.css'/>"	rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/plList.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/swipe.css'/>"rel="stylesheet" type="text/css" />
<link rel="stylesheet"	href="<c:url value='/resources/css/web/expdetail/swipe_zoom.css'/>" />
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/swipe.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
$(function(){
	//初始化加载
	loadInitImg();
});

//购买
function buy(){

	involvedExp();
	
}
function involvedExp(){
	$.ajax({
		type:"post",
		url:"<c:url value='/expVolved/involVedEchage'/>",
		data:{"detailId":"${detailId}","id":"${expId}"},
		dataType:"json",
		success:function(res){
			
		}
	})
	
}
//加载头部产品图片 
function loadInitImg(){

	   $.post("<c:url value='/wxDecorateVoucher/findVoucherDetail?id=${detailId}'/>",null,function(data){		   
		 	   var result=JSON.parse(data);
		       var html = '';
		           html += '<div class="cinema_banner">';
			       html += '<img src='+result.voucheUrl+'></img>'; 
		    	   html += '</div>';
			   $(".swipe-wrap").html(html);
			   $("#ftitle").html(result.title);
			   $("#name").html(result.name);
			   $("#price").html(result.price);
			   $("#uprice").html(result.price);
			   $("#info").html(result.content);


    });
	}
</script>

</head>

<body>
	<div class="detialCommentBox">
		<div id="slider">
			<div class="swipe-wrap"></div>
			<div class="picBox">			
				<div class="textNameBox">
					<h1 class="fLeft">
						<lz id="name"></lz><font id="ftitle"></font>
					</h1>
					<div class="fRight">
						<span></span>
					</div>
				</div>
			</div>
		</div>
		<div class="titleTextBox">
			<h2><lz id="uprice"></lz>元<s id="price"></s></h2>
		   <div class="ljsqHighLigth"><input type="button" value="购买优惠" id="buy" onclick="buy();"></div>
		      
		</div>
	</div>


	<div class="hdgzBox">
		<div class="hdgz">
			<span>使用须知</span>
		</div>
		<div class="info" id="info"></div>
	</div>

	<div class="freeShopBox">
		<a href="#">
			<h5>
				<span class="sqjl">购买记录</span> <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
			</h5>
		</a>
	</div>

	<div class="he60"></div>
 
	 <div class="syqq">
	 <a href="javascript:void(0);"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
	 <a href="javascript:void(0);" class="aclass" id="buy" onclick="buy();">立即购买</a>
	 </div>     
</body>
<script type="text/javascript">
var shareData = {
		title: '${decorate.name}',
	    desc: '${decorate.shareTitle}',
	    link: 'http://'+location.host+'/wxService/decorate/share.html?expId=${expId}&publishopenid=${publishopenid}',
	    imgUrl:'http://'+location.host+"/"+'${decorate.shareImg}',   
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };
$(document).ready(function(){
	sharTimelineFun(shareData);
});

</script>

</html>
