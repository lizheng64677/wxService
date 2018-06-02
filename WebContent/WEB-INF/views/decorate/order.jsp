<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="telephone=no" name="format-detection"> 
<title>我的订单</title>
<link href="<c:url value='/resources/css/web/quan.css'/>"  rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<c:url value='/resources/css/web/pull/pull.css'/>" />
<style>
.qNavBox .wxf{
    border-radius: 0px 0 0 0px; 
}
.qNavBox .yxf {
    border-radius: 0 0px 00px 0;
}
.newBgcolor{
	border:1px solid #ccc;
	background:#fff;
}
.qListBox .nameTimeBox h1 {
    color: #989090;
    font-size: 14px;
    height: 30px;
    line-height: 20px;
}
.qListBox .nameTimeBox p span {
    color: #989090;
    font-size: 12px;
    vertical-align: middle;
    margin-left: 6px;
    line-height: 24px;
}
.qListBox .nameTimeBox {
    border-bottom: 1px dashed rgba(129, 165, 165, 0.7);
    overflow: hidden;
}
.qListBox .leftNameBox h2 {
    color: #989090;
    font-size: 16px;
    font-weight: normal;
    line-height: 22px;
    height: 44px;
}
.qListBox .rightButon a {
    display: inline-block;
    width: 80px;
    padding: 8px 0;
    border: 1px solid #989090;
    border-radius: 3px;
    text-align: center;
    color: #989090;
    font-size: 14px;
}
</style>
</head>
<body>
<div data-role="page" data-iscroll="enable">
	<div data-role="header">
		<div class="qNavBox">
			<input type="hidden" id="liStatus" />
			<ul class="nav">
		    	<li data-status=""><a class="wxf chooseBox"  href="#">全部</a></li>
		        <li data-status="0"><a href="#">未支付</a></li>
		        <li data-status="1"><a class="yxf" href="#">已支付</a></li>
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
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
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
		scroll.setSearchCondition({"page.currentPage":1,state:$(this).data("status")});
		scroll.initSearch(); 
	});
});
//购买
function buy(id){
	var payData = {
			requrl:"<c:url value='/decorate/orderWxPay'></c:url>",
			id:id,
			name:$("#name").html()
	    };
	wecharPay(payData);
	
}
function initScroller(){
	scroll=fixed($(document),46,43);
	scroll.setUrl("<c:url value='/wxDecorateVoucher/findOrderListByIdInfo' />");
	scroll.setSearchCondition({"page.currentPage":1,state:0});
	scroll.setDisplay(display);
	scroll.initSearch(); 
}

function display(data) {
	var main=$("#main");
	if(data.data){
		if("1"== $("#liStatus").val()) {
			for(var i=0;i<data.data.length;i++){
				main.append($(createSingleLi(data.data[i])));
				$("[class^=bgColor]").eq(i).show();
				$("[class^=bgColor]").eq(i).attr("class",  "newBgcolor");
			}
		}else if("0"== $("#liStatus").val()){
			for(var i=0;i<data.data.length;i++){
				main.append($(createSingleLi(data.data[i])));
				$("[class^=bgColor]").eq(i).show();
				$("[class^=bgColor]").eq(i).attr("class",  "newBgcolor");
			}
		}else{
			for(var i=0;i<data.data.length;i++){
				main.append($(createSingleLi(data.data[i])));
				$("[class^=bgColor]").eq((data.args.page.currentPage-1)*10+i).show();
				$("[class^=bgColor]").eq((data.args.page.currentPage-1)*10+i).attr("class", "newBgcolor"); 
			}
		}
	}
	
}
function createSingleLi(data){
	var html=$("#htmlText").html();
    var ht="";
	 if("0"!=data.orderState){
			ht='<a href="javascript:void(0)">已支付</a>';
	 }else{

			ht='<a href="javascript:void(0)"  class="vouch" onclick="buy('+data.orderId+')">待支付</a>';
		}
	return html.replace("#vouCode",data.orderCode)
	.replace("#title",data.orderName)
	.replace("#validity",data.createTime)
	.replace("#voucherType",ht);
	
}

var shareData = {			
			requrl:"<c:url value='/share/sharePrepare'></c:url>",
			param:location.href
};		
$(function(){
	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);

});

</script>
<ul id="htmlText">
	
<li  class="bgColor"  style="display: none;" >
	<div class="nameTimeBox">
      	<h1 class="fLeft">订单号：#vouCode</h1>
        <p class="fRight"><img src="<c:url value='/resources/images/web/time.png'/>" /><span>订单日期：#validity</span></p>        	
             	
    </div>
    <div class="qCommentBox">
        <div class="fLeft leftNameBox">
           <h2>#title</h2>
              
         </div>
         
         <div class="fRight rightButon">
         	<h3>#voucherType</h3>
         </div>
    </div>
</li>
</ul>
</body>
</html>
