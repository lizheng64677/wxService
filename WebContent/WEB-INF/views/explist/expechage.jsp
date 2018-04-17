<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>金币兑</title>
<link href="<c:url value='/resources/css/web/qixinzhuan.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/explist/zeroTest.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
</head>
<body>
<div data-role="page" data-iscroll="enable">
<!--  <div class="headerContent"> -->
<!--        <ul> -->
<%--           <li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li> --%>
<!--           <li class="headerFont">兑换式</li> -->
<!--        </ul>   -->
<!--     </div> -->
    <div class="content" data-role="content" style="margin-top:4px;">
    	<div id="wrapperIndex" class="wrapper" >
    		<div id="scrollerIndex" class="scroller actListBox">    		
			<div class="productMainList">
			<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 40px;">
			</ul>
			</div>
			<div class="m10" id="main">
			</div>
			<div id="pullUp" class="loading" style="margin-top:5px;">
				<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
			</div>	       
	       </div>
       </div>
    </div>

</div>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScrollList.js'/>"></script>
<script type="text/javascript">
	var scroll;
	var tempHtml=[];
	$(document) .bind("pageshow", function() {
		initScroller();
		initClicker();
	});
	
	function initScroller(){
		scroll=fixed($(document),46,43);
		scroll.setUrl("<c:url value='/expVolved/tryListInfo'/>");
		scroll.setSearchCondition({"page.currentPage":1,expType:2});
		scroll.setDisplay(display);
		scroll.initSearch(); 
	}
	
	function initClicker(){
		$("#main").on("click",".li-id",function(){
			window.location.href="<c:url value='/experience/toExpDetaiInfo?expType=2&detailId='/>"+$(this).data("exp_detail_id");
			
		});
	}
	
	function display(data) {
		var main=$("#main");
		for(var i=0;i<data.data.length;i++){
			main.append($(createSingleLi(data.data[i])));
			tempHtml=[];
		}
	}
	function createSingleLi(now){
		var html = '';
		html += "<div class='box1'>";
		html += "<li>";
		html += "<a href='javascript:void(0);' class='li-id' data-exp_detail_id='"+now.exp_detail_id+"'>";
		html += "<div class='picBox fLeft'>";
		html += '<img src='+now.exp_img_url+'>';
		html += "<div class='dwPic'><img src='<c:url value='/resources/images/web/explist/test0.png'/>' /></div>";
		if(now.exp_stauts == 1){//正在进行
			html += "<div class='jjsx'></div>";
		}else if(now.exp_stauts == 2){//即将开始
			html += "<div class='jjsx'><img src='<c:url value='/resources/images/web/explist/jjsx.png'/>'/></div>";
		}else{//往期回顾
			html += "<div class='jjsx'><img src='<c:url value='/resources/images/web/explist/over.png'/>'/></div>";
		}
		html += "</div>";
		html += "<div class='commentMainBox fRight'>";
		html += "<div class='titleBox'>";
		html += "<h2>"+now.title+"</h2>";
		html += "</div>";
		html += "<h3>["+now.proTitle+"]</h3>";
		html += "<h4>￥0<s>￥"+now.price+"</s></h4>";
		html += "<div class='timeButtonBox'>";
		html += "<div class='time'>";
		html += "<div class='timeComment'>";
		html += "<span><img src='<c:url value='/resources/images/web/explist/pp.png'/>'></span>";
		html += "<span>"+now.cg_name+"</span>";
		html += "<span><img src='<c:url value='/resources/images/web/explist/dw.png'/>'></span>";
		html += "<span>"+now.region_name+"</span>";
		html += "</div>";
		html += "<p>提供<font>"+now.pro_num+"</font>份&nbsp;&nbsp;累计<font class='number'>"+now.exp_num+"</font>人兑换</p>";
		html += "</div></div></div></a></li>";
		html += "</div>";
		return html;
	}
</script>

</body>
</html>
