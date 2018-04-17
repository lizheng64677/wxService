<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>NO团网</title>
<link href="<c:url value='/resources/css/web/index.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/swiper.css'/>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/swiper.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jquery.lazyload.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/sea.js'/>"></script>
<script type="text/javascript">
 var shareData = {
		title : 'NO团网',
		desc : 'NO团网',
		link : 'http://' + location.host + '/wxService/',
		imgUrl : 'http://' +location.host + '/wxService/resources/images/web/topbg_02.png', 
		requrl : "<c:url value='/share/sharePrepare'></c:url>",
		param : location.href,
		posUrl:"<c:url value='/city/findCityInfoByName'/>"
	};
 	seajs.use('index/wxpostion',function(wx) { 
 		
		wx.inintWx(shareData); 
 		//测试
		//wx.initTest();
    }); 
</script>	
</head>
<body>
<header>

  <input type="hidden" id="cityid" value="${id}"/>
  <input type="hidden" id="position" value="${position}"/>
  <ul>
     <li class="Return"><input type="button" class="select" id="city" value="${name}">
     </li>
     <li class="headerFont">任务大厅  </li> 

  </ul>
</header>
<div class="bannerBox" style="position: relative;">
	<div id="slider" class="slider_swipe" > 
	 	<div id="swipe-wrap" class="swiper-wrapper" style="height:190px">
	 	</div> 
	 	<div class="swiper-pagination"></div>
    </div>
</div>
<!--全民赚-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">轻松赚</h1>
        <p class="fRight">
        	<a href="<c:url value='/index/toQuanminZhuanList'/>">
        		<font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        	</a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="quanminzhuan">
        </dl>
    </div>
</div>
<!--齐心赚-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">帮我赚</h1>
        <p class="fRight">  
        	<a href="javascript:void(0);" id="qx_more">       	
        		<font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        	</a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="qixinzhuan">
        </dl>
    </div>
</div>
<!--试用式-->
<!-- <div class="hotProductBox"> -->
<!-- 	<div class="titleBox"> -->
<!--     	<h1 class="fLeft">试用式</h1> -->
<!--         <p class="fRight"> -->
<%--         <a href="<c:url value='/experience/tryList'/>"> --%>
<%--         <font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" /> --%>
<!--         </a> -->
<!--         </p> -->
        
<!--     </div> -->
<!--     <div class="projectMainBox"> -->
<!--     	<dl id="try"> -->

<!--         </dl> -->
<!--     </div> -->
<!-- </div> -->

<!--抽奖式-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">抽奖乐</h1>
        <p class="fRight">
        <a href="javascript:void(0);" id="prize_more">
        <font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        </a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="prize">
       
        </dl>
    </div>
</div>

<!--人气王-->
<div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">人气王</h1>
        <p class="fRight">
        <a href="javascript:void(0);" id="pop_more">
        <font>更多  </font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        </a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="pop">
        
        </dl>
    </div>
</div>

<!--兑换式-->
<%-- <div class="hotProductBox">
	<div class="titleBox">
    	<h1 class="fLeft">金币兑</h1>
        <p class="fRight">
         <a href="<c:url value='/experience/echageList?cityid=${id}'/>">
        <font>更多</font><img src="<c:url value='/resources/images/web/rightjt.png'/>" />
        </a>
        </p>
    </div>
    <div class="projectMainBox">
    	<dl id="echage">
        
        </dl>
    </div>
</div> --%>
<!--底部导航-->
<div class="he60"></div>
<div class="bottom">
  <ul>
      <a href="<c:url value='/index/toIndex'/>"><li class="Mybottom"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he30">首页</p></li></a>
      <a href="<c:url value='/find/toThemeIndex'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian.png'/>"><p class="he20">发现</p></li></a>
      <a href="<c:url value='/user/toMain'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_0.png'/>"/><p class="he20">我的</p></li></a>
  </ul>
</div>

<script type="text/javascript">

	$(document).ready(function(){

		initClicker();
		var cityname=$("#city").val();
		if($.trim(cityname).length>3){
			str = $("#city").val().substr(0,3) + "...";		 
			$("#city").val(str);
		}
		//跳转到城市选择页面
		$("#city").bind("click",function(){		
			location.href = "<c:url value='/city/toCitySelection?lat='/>"+localStorage.getItem("lat")+"&lng="+localStorage.getItem("lng");
		});
		//帮我赚的更多点击事件
		$("#qx_more").bind("click",function(){
			
			location.href="<c:url value='/index/toQixinZhuanList?cityid='/>"+$("#cityid").val();
		})
		
		//抽奖乐的更多点击事件
		$("#prize_more").bind("click",function(){
			
			location.href="<c:url value='/experience/prizeList?cityid='/>"+$("#cityid").val();
		})
		
		//人气王的更多点击事件
		$("#pop_more").bind("click",function(){
			
			location.href="<c:url value='/experience/popList?cityid='/>"+$("#cityid").val();
		})
	});
	function expDetailInfo(detailId, expType) {

		location.href = "<c:url value='/experience/toExpDetaiInfo?detailId='/>"+ detailId + "&expType=" + expType + "";
	}
	function initClicker() {
		$("#quanminzhuan").on("click","dt",function() {
			
			window.location.href = "<c:url value='/index/toQuanminDetail?expId='/>"+ $(this).attr("eid");
		});
		$("#qixinzhuan").on("click","dt",function() {
			window.location.href = "<c:url value='/index/toQixinZhuanDetail?expId='/>"+ $(this).attr("eid");
        });
	}
	


</script>
</body>
</html>
