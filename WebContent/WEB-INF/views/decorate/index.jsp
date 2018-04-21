<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<title> ${result.title}</title>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/dialog.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/Task.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/>
<!-- 重新样式 -->
<style>

	.mokuai {
	    width: 33.3%;
	    height: 60px;
	    color: #999;
	    font-size: 12px;
	    text-align: center;
	    padding-top: 8px;
	    float: left;
	}
	.Profit{
			padding:10px;
			margin-buttom:10px;
		}
	.aclass{
		margin-left: 1%;
	    text-align: center;
	    height:65%;
	    width:45%;
	    padding-top: 15px;
	}
</style>
</head>
<body>
   <div class="detialCommentBox">
       <img id="image" src="<c:url value='/resources/images/web/rankpm.png'/>" class="he200">
       <p id="title">${result.title}</p>
       <div class="Profit">
         	<a class="aclass" id="share" href="#">分享好友</a>
         	<a class="aclass" id="imgh" href="#">获取海报</a>
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

   <!--申请成功-->
<div class="sqSuccessBox hidden" id="sqSuccessBox">

    <div id="share" style="width: 100%;margin: 0px auto -20%;text-align:right;left: 10%;"><img src="<c:url value='/resources/css/images/share.png'/>" style="width: 50%;padding-right: 5%;"></div>
	<div class="sqSuccess">
    	<div class="Successbox">
<%--     		 <p><img src="<c:url value='/resources/css/images/smile.png'/>" id="imgId"/></p> --%>
            <h1 id="promptTitle">请点击右上角的分享链接，邀请您的亲朋还有一起参与!</h1>
            <div><input type="button" value="确定" onclick="closeDialog(0)" id="btn"/></div>
        </div>
        <div class="delBox" onclick="closeDialog(0)"><img src="<c:url value='/resources/css/images/del.png'/>" /></div>
    </div>
</div>
	<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/center.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
	var showType=-1;
	$(document).ready(function(){
		initData();
		//分享层弹出
		$("#share").on("click",function(){
		
			$("#sqSuccessBox").show();
		});
		//生成海报请求
		$("#imgh").on("click",function(){
			
			showDialog("是否确定生成海报","","取消","<c:url value='/createpost/create.html'/>","确定");
		})
	});
	
	//查询数据
	function initData(){
		post('/index/findQuanminZhuanDetail',{expId:'${expId}'},true).then(function(data){
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