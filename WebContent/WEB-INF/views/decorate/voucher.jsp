<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="telephone=no" name="format-detection"> 
<title>我的券</title>
<link href="<c:url value='/resources/css/web/quan.css'/>"  rel="stylesheet" type="text/css"/></head>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<body>
<div data-role="page" data-iscroll="enable">
	<div data-role="header">
		<div class="qNavBox">
			<input type="hidden" id="liStatus" />
			<ul class="nav">
		    	<li data-status="0"><a class="wxf chooseBox"  href="#">未消费</a></li>
		        <li data-status="1"><a href="#">已消费</a></li>
		        <li data-status="2"><a class="yxf" href="#">已作废</a></li>
		    </ul>
		</div>
	</div>
	<div class="content" data-role="content" style="margin-top:4px;">
		<div id="wrapperIndex" class="wrapper" >
			<div id="scrollerIndex" class="scroller actListBox">
				<div class="qListBox">
					<ul data-role="listview" data-theme="a" class="list-fpmx"  id="main" style="padding-top: 40px;">
					</ul>
					<div id="pullUp" class="loading" style="margin-top:5px;">
						<span class="pullUpIcon"></span><span class="pullUpLabel">加载中...</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/jquery.mobile.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script src="<c:url value='/resources/js/pull/iscroll.js'/>"></script>
<script src="<c:url value='/resources/js/pull/initScroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
var scroll;
var ROOT="<c:url value='/'/>";
$(document) .bind("pageshow", function() {
	initScroller();
	$(".nav").on("click","li",function(){
		$("#liStatus").val($(this).data("status"));
		$("#main").empty();
		$(".nav li a").removeClass("chooseBox");
		$(this).find("a").addClass("chooseBox");
		scroll.setSearchCondition({"page.currentPage":1,status:$(this).data("status")});
		scroll.initSearch(); 
	});
});

function initScroller(){
	scroll=fixed($(document),46,43);
	scroll.setUrl("<c:url value='/sen/getVouch' />");
	scroll.setSearchCondition({"page.currentPage":1,status:0});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

function display(data) {
	var main=$("#main");
	if(2 == $("#liStatus").val()) {
		for(var i=0;i<data.data.length;i++){
			main.append($(createSingleLi(data.data[i])));
			$("[class^=bgColor]").eq(i).attr("class", "bgColor6");
		}
	} else {
		for(var i=0;i<data.data.length;i++){
			main.append($(createSingleLi(data.data[i])));
			$("[class^=bgColor]").eq((data.args.page.currentPage-1)*10+i).show();
			$("[class^=bgColor]").eq((data.args.page.currentPage-1)*10+i).attr("class", "bgColor" + (i%5+1)); 
		}
	}
	
}
function createSingleLi(data){
	var html=$("#htmlText").html();
	 var ht="";
	 if(data.isDiscuss==1 && data.status==1){
			ht='<a href="javascript:void(0)">已评价</a>';
	 }else if(data.isDiscuss!=1 && data.status==1){

			ht='<a href="javascript:void(0)"  class="vouch" data-detailid="#detailId" data-proid="#proId" data-memberid="#memberId" data-userid="#userId" data-exptype="#expType">评价</a>';
		}
	return html.replace("#vouCode",data.vouCode)
	.replace("#isDiscuss",ht)
	.replace("#validity",data.validity)
	.replace("#title",data.proName)
	.replace("#proId",data.proId)
	.replace("#memberId",data.memberId)
	.replace("#userId",data.userId)
	.replace("#detailId",data.detailId)
	.replace("#expType",data.type)
	.replace("#type",data.status)
	;
}

var shareData = {			
			requrl:"<c:url value='/share/sharePrepare'></c:url>",
			param:location.href
};		
$(function(){
	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);

	//评价
	$(".qListBox").on("click",".vouch",function(){
		var proId=$(this).data("proid");
		var memberId=$(this).data("memberid");
		var userId=$(this).data("userid");
		var detailId=$(this).data("detailid");
		var expType=$(this).data("exptype");
		window.location.href="<c:url value='/discuz/toDiscuz?proId="+proId
				+"&memberId="+memberId+"&userId="+userId+"&detailId="+detailId+"&expType="+expType+"'/>";
	});
	
});

</script>
<ul id="htmlText">
	
<li  class="bgColor"  style="display: none;" >
	<div class="nameTimeBox">
      	<h1 class="fLeft">券号：#vouCode</h1>
        <p class="fRight"><img src="<c:url value='/resources/images/web/time.png'/>" /><span>有效期：#validity</span></p>        	
    </div>
    <div class="qCommentBox">
        <div class="fLeft leftNameBox">
           <h2>#title</h2>
           <p>*此券不得转让，仅限本人使用
           		
           </p>
           
         </div>
         
         <div class="fRight rightButon">
         	<h3>免费券</h3>
         </div>
         <div   style="width: 20%; float: left; margin-top: 11px;margin-left: 10px;" id="ddsds">
         	#isDiscuss
         </div>
    </div>
    <div class="byBox1"><img src="<c:url value='/resources/images/web/leftby.png'/>" /></div>
    <div class="byBox2"><img src="<c:url value='/resources/images/web/rightby.png'/>" /></div>
</li>
</ul>
</body>
</html>
