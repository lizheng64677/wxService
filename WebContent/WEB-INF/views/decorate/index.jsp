<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>轻松赚任务详情</title>
<link href="<c:url value='/resources/css/web/Task.css'/>" rel="stylesheet" type="text/css" />
</head>
<body>
   <div class="detialCommentBox">
       <img id="image" src="" class="he200">
       <p id="title"></p>
       <div class="Profit">
           <ul>
               <li class="ProfitPic"><img src="<c:url value='/resources/images/web/u37.png'/>"></li>
               <li class="ProfitFont" id="exp_user_gold"></li>
               <li class="receive"><span id="user_total"></span></li>
           </ul>
      </div>
      <div class="introduction">
           <p><span>商家介绍</span></p>
           <div class="introductionFont">
           </div>
      </div>
     
   </div>
    <div class="action">
             <div class="actionContent"><span>活动规则</span></div>
            <div id="rule" class="introductionFont">
            
            </div>
      </div>
   <div class="he60"></div>
   	
   <div class="syqq" style="display:none;">
   <a href="<c:url value='/actIntro/toIntroDetail?type=0'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
   	<a class="aclass" id="img" href="#">领取任务</a>
   </div>
   <div class="syqqa" style="display:none;">
   <a href="<c:url value='/actIntro/toIntroDetail?type=0'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
   <a  class="aclassa" id="imga"  href="javascript:void(0);">已领完</a>
   </div>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
	var showType=-1;
	$(document).ready(function(){
		initData();
		initClicker();
	});
	
	function initClicker(){
		$(".headerimg").on("click",function(){
			window.history.go(-1);
		});
	}
	function initData(){
		post('/index/findQuanminZhuanDetail',{expId:'${expId}'},true)
		.then(function(data){
			$("#title").html(data.data.title);
			$("#image").attr("src",data.data.exp_img_url);
			$("#user_total").html(data.data.user_join+"人已领取");
			$("#exp_user_gold").html("收益："+data.data.exp_user_gold+"金币");
			$(".introductionFont").html(data.data.member_info);
			$("#rule").html(data.data.exp_info);
			showType=data.data.show_type;
			if(data.data.exp_total_status==0){
				
				$(".syqqa").show(); 
			}else{
				
				$(".syqq").show();
			}
			if(data.data.exp_status==1){
				$("#img").html("即将开始");
				$(".syqq").show();
			}else if(data.data.exp_status==0){
				$("#img").on("click",function(){
					var u = navigator.userAgent, app = navigator.appVersion;
					var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
// 					if(!isiOS){
						
						joinExpZ();
// 					}else{
						
// 						showAlert("本活动暂不支持IOS苹果操作系统参与"); 
// 					}
				});
			}else if(data.data.exp_status==2){
				$("#imga").html("已结束");
				$(".syqqa").show();
			}
			
		});
	}
	function joinExpZ(){
		if(showType==-1) {alert("活动还没加载完！"); return;}
		post("/expVolved/joinExpZ",{expId:'${expId}',openid:'${SESSION_OPEN_ID}',moduleType:1},true)
		.then(function(data){
			if(data.msg==2){
				if(showType==0){ //进入APP上传图片页
					//window.location.href="<c:url value='/index/findqmAppZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail";
					showDialog("您已领取过此任务，请点击查看任务完成进度。","","取消","<c:url value='/index/findqmAppZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail","查看详情");
				}else if(showType==1){ //进入form填写页
					//window.location.href="<c:url value='/index/findqmFormZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail";
					showDialog("您已领取过此任务，请点击查看任务完成进度。","","取消","<c:url value='/index/findqmFormZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail","查看详情");
				}
				//showDialog("你已经参与过该活动了！","","取消","<c:url value='/user/toInvolvement'/>","查看进程");
			}else if(data.msg==1){
				showDialog("你还没有注册，前往注册！","","取消","<c:url value='/user/toRegister'/>","确定");
			}else if(data.msg==3){
				showDialog("你还没有登录，前往登录！","","取消","<c:url value='/user/toLogin'/>","确定");
			}else if(data.msg==11){
				showAlert("任务已经被领光了");
			}else if(data.msg==0){
				if(showType==0){ //进入APP上传图片页
					window.location.href="<c:url value='/index/findqmAppZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail";
				}else if(showType==1){ //进入form填写页
					window.location.href="<c:url value='/index/findqmFormZhuanDetail'/>"+"?expId="+${expId}+"&pagePostion=detail";
				}
				return post("/sen/queryUserPrototypeAll",{},true);
			}else if(data.msg==5){
				showDialog("您的资料不完善，请完善资料后再来参与！","","取消","<c:url value='/user/toMyInfo'/>","确定");
			}
		});
	}
</script>
<script type="text/javascript">
var shareData = {
		title: 'NO团网',
	    desc: 'NO团网', 
	    link: 'http://'+location.host+'/wxService/',
	    imgUrl: 'http://'+location.host+'/wxService/resources/images/web/memberjt.png', 
	    requrl: 'http://'+location.host+'/wxService/share/sharePrepare',
		param:location.href
    };
	$(document).ready(function(){
		sharTimelineFun(shareData);
	}); 
</script>
</body>
</html>