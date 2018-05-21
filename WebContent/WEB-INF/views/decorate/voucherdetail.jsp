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
	//加载图像 
	loadInitImg();
    $("#btnExp").click(function(){
        $("#shareDialog").hide();
      	$("#sqSuccessBox").show();
        $(".sqSuccess").hide();
        $("#share").show();

    });
    $("#d2").on("click",".c1",function(){
		
		 $(".c2").attr("src",this.src);
		 $(".hide").show();
	});
	
	$(".hide").click(function(){
		$(this).hide();
	});
    
});

//参与任务 
function buy(){

	involvedExp();
	
}
function involvedExp(){
	$.ajax({
		type:"post",
		url:"<c:url value='/expVolved/involVedEchage'/>",
		data:{"detailId":"${exp_detail_id}","memberId":"${member_id}","expId":"${exp_id}"},
		dataType:"json",
		success:function(res){

			if("invalidDetailInfo"==res.message){

				showAlert("您已经参与过本期活动了!");
				return false;
			}else if("invalidExpInfo"==res.message){
				
				showAlert("当前活动查询异常！");
				return false;
				
			}else if("started"==res.message){
				
				showAlert("活动暂未开始");
				return false;
			}else if("invalidTimeExp"==res.message){
				 
				showAlert("本期活动已经结束，请期待后期项目！");
				return false;
			}else if("yprize"==res.message){
				
				showDialog("恭喜你兑换成功了！","","取消","<c:url value='/user/toVouch'/>","查看劵号"); 
				return false;
			}else if("invalidUser"==res.message){
				
				showAlert("用户信息查询有误！");
				return false;
			}else if("invlidProNum"==res.message){ 
				showAlert("很遗憾，本期奖品已经被兑光了！");
				return false;
			}else if("invalidIntegral"==res.message){
				
				showAlert("您的金币不足！");
				return false;
			}else if("Notperfect"==res.message){
				
				showDialog("您的资料不完善，请完善资料后再来参与！","","取消","<c:url value='/userProblem'/>","确定"); 
				return false;
			}else if("NotInfoExp"==res.message){
				
				showDialog("亲，您不符合该活动的参与条件，请查看其他活动，谢谢！","","取消","","确定");
				return false;
				
			}else if("notregUser"==res.message){
				
				showDialog("你还没有登录，前往登录！","","取消","<c:url value='/user/toLogin'/>","确定");
				return false;
			}
			
			
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
        <div class="hide" style="display:none;">
		   <div class="boximg">
				<img  class="c2" src="images/11.png" />
		   </div>
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
