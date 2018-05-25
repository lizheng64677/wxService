<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的消息</title>
<link href="<c:url value='/resources/css/web/mymessage.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
</head>
<body>
<div data-role="page" data-iscroll="enable">
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
<script src="<c:url value='/resources/js/pull/initScrollList.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
var scroll;
var ROOT="<c:url value='/'/>";
$(document) .bind("pageshow", function() {
	initScroller();
	$.ajax({
		url:"<c:url value='/sen/readMsg'/>",
		method:"post"
	});
});


function initScroller(){
	scroll=fixed($(document),46,43);
	scroll.setUrl("<c:url value='/wxDecorateVoucher/findUserInfoByOpenIdMessage' />");
	scroll.setSearchCondition({"page.currentPage":1});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

function display(data) {
	var main=$("#main");
	if(data.data){
		for(var i=0;i<data.data.length;i++){
			main.append($(createSingleLi(data.data[i])));
		}
	}
}
function createSingleLi(data){
	return $("#htmlText").html().replace("#content",data.content?data.content:"未知操作")
	.replace("#createTime",data.createTime);
}
var shareData = {			
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
};	
$(function(){
	
	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);
})
</script>
<script id="htmlText">
<div class="drMainList">
<div class="nameBox">
    <div class="name">
        <span class="tx"><img src="<c:url value='/resources/images/web/sjlogo01.png'/>"></span>
    </div> 
</div>

<div class="storyCommentBox">
	<div class="sj"></div>
    <div class="messageBox">
    	<p>#content</p>
        <h6>#createTime</h6>
    </div>
</div>
</div>
</script>
</body>
</html>
