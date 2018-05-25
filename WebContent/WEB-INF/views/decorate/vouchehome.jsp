<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${decorate.shareTitle}</title>
<link href="<c:url value='/resources/css/web/index.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/swiper.css'/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/swiper.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jquery.lazyload.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/sea.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/index/xjjj.js'/>"></script>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/xjjj.css'/>"  rel="stylesheet" type="text/css"/>

<style type="text/css">
.projectMainBox dl dt {
    width: 48%;
    overflow: hidden;
}
.fLeft {
    float: left;
    margin-left: 2%;
}

</style>
<script type="text/javascript">
 	seajs.use('index/xjjj',function(wx) { 		
		wx.initExp(); 
    }); 
</script>
</head>
<body>
<!-- <header></header> -->
<div class="bannerBox" style="position: relative;">
	<div id="slider" class="slider_swipe" > 
	 	<div id="swipe-wrap" class="swiper-wrapper" style="height:190px">
	 	</div> 
	 	<div class="swiper-pagination"></div>
    </div>
</div>
<!--福利券-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">福利券</h1>
        <p class="fRight">
        	<a href="javascript:void(0);" id="fl_more">
        		<font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        	</a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="fuli">
        </dl>
    </div>
</div>
<!--优惠券-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">优惠券</h1>
        <p class="fRight">  
        	<a href="javascript:void(0);" id="yh_more">       	
        		<font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        	</a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="youhui">
        </dl>
    </div>
</div>
<!--体验券-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">体验券</h1>
        <p class="fRight">  
        	<a href="javascript:void(0);" id="ty_more">       	
        		<font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        	</a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="tiyan">
        </dl>
    </div>
</div>
<!--底部导航-->
<div class="he60"></div>
<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/vouchehome.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/bottomIcon02-2.png'/>"><p class="he20">福券</p></li></a>
	      <a href="<c:url value='/decorate/center.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
</div>
<script type="text/javascript">
var shareData = {
		title: '${decorate.name}',
	    desc: '${decorate.shareTitle}',
	    link: 'http://'+location.host+'/wxService/decorate/share.html?expId=${expId}&publishopenid=${publishopenid}',
	    imgUrl:'http://'+location.host+"/"+'${decorate.shareImg}',   
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };
</script>
<script type="text/javascript">

	function initClicker() {
		$("#fuli,#youhui,#tiyan").on("click","dt",function() {
			window.location.href= "<c:url value='/decorate/voucherdetail.html?id=${expId}&detailId='/>"+$(this).attr("eid");
		});
	}

	$(document).ready(function(){
		sharTimelineFun(shareData);
		initClicker();
	});

</script>

</body>
</html>
