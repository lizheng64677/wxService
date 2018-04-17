<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户评论</title>
<link rel="stylesheet" href="<c:url value='/resources/css/web/expdetail/swipe_zoom.css'/>" />

<link href="<c:url value='/resources/css/web/expdetail/plList.css'/>" rel="stylesheet" type="text/css" />


<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />



</head>
<body>
<div data-role="page" data-iscroll="enable">
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


<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript">
	var scroll;
	var tempHtml=[];
	$(document).bind("pageshow", function() {
		initScroller();
		
	});
	
	function initScroller(){
		scroll=fixed($(document),46,43);
		scroll.setUrl("<c:url value='/experience/findDiscussInfo'/>");
		scroll.setSearchCondition({"page.currentPage":1,proId:"${proId}",detailId:"${detailId}"});
		scroll.setDisplay(display);
		scroll.initSearch(); 
		
	}
	
	function display(data) {
		var main=$("#main");
		main.append($(createSingleLi(data)));
		tempHtml=[];
	}
	function createSingleLi(data){
		var html=[];
		
		html.push('    <div class="plMainBox">');
		html.push('			<dl>');
		if(data.data.length>0){
			for(var i=0;i<data.data.length;i++){
				html.push('<dt>');
				html.push('                        <div class="firstBox">');
				html.push('                            <div class="nameTime fLeft">'+data.data[i].userPhone+'</div>');
				html.push('                            <div class="smallStar fRight">'+data.data[i].createTime+'</div>');
				html.push('                        </div>');
				html.push('                        <div class="starMainBox">');
				for(var  k=1;k<=data.data[i].qcdScore;k++){
					html.push('                                <span><a class="a1" href="<c:url value='/resources/images/web/voucher/9.png'/>" ><img src="<c:url value='/resources/images/web/voucher/9.png'/>"></a></span>');
				}
				for(var  k=1;k<=(5-data.data[i].qcdScore);k++){
					html.push('                                <span><img src="<c:url value='/resources/images/web/voucher/10.png'/>"></span>');
				}
				html.push('                        </div>');
				html.push('                        <div class="middleBox">'+data.data[i].content+'</div>');
				html.push('                        <div class="pictureBox">');
				for(var k =0;k<data.data[i].picUrl.split(",").length;k++){
					html.push('                        <span> <img class="c1"  src="'+data.data[i].picUrl.split(",")[k]+'" /></span>');
				}
				html.push('                        </div>');
				html.push('                    </dt>');
			}
		}
		html.push('        </dl>');
		html.push('    </div>');
		return html.join("");
	}
	
	
</script>

<script type="text/javascript">
$(function(){
	$("#main").on("click",".c1",function(){
		
		 $(".c2").attr("src",this.src);
		 $(".hide").show();
	});
	
	$(".hide").click(function(){
		$(this).hide();
	});
});
	
</script>

 <div class="hide" style="display:none;">
   <div class="boximg">
		<img  class="c2" src="images/11.png" />
   
   </div>
 
 </div>
</body>
</html>
