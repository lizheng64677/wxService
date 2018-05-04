<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<title id="toptitle"></title>
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
			margin-buttom:18px;
		}
	.aclass{
	    text-align: center;
	    height:65%;
	    width:47%;
	    padding-top: 10px;
	    border-radius: 0px;
	    margin: 1px;
	}
</style>
</head>
<body>
   <div class="detialCommentBox">
       <img id="image" src="<c:url value='/resources/images/web/rankpm.png'/>" class="he200">
       <p id="title" align='center'></p>
       <div class="Profit">
         	<a class="aclass" id="share" href="#">分享好友</a>
         	<a class="aclass" id="imgh" href="#">获取海报</a>
      </div>
      <div class="introduction">
           <p><span>商家介绍</span></p>
           <div  id="sellerDescription"  class="introductionFont">
           </div>
      </div>
     
   </div>
    <div class="action">
             <div class="actionContent"><span>活动规则</span></div>
            <div id="rule" class="introductionFont" >
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


<div class="sqSuccessBox hidden" id="actstatus">
	<div class="sqSuccess">
    	<div class="Successbox">
            <h1 id="acttitle"></h1>
            <div><input type="button" value="确定" id="btnactstatus"/></div>
        </div>
    </div>
</div>
	<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/center.html?id=${expId }'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
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
		//关闭活动状态提示框
		$("#btnactstatus").on("click",function(){
			$("#actstatus").hide();
		});
		//生成海报请求
		$("#imgh").on("click",function(){
			
			showDialog("是否确定生成海报","","取消","<c:url value='/createpost/create.html?id=${expId}'/>","确定");
		})
	});
	var shareData = {
			title: 'NO团网',
		    desc: 'NO团网', 
		    link: 'http://'+location.host+'/wxService/decorate/share.html',
		    imgUrl: 'http://'+location.host+'/wxService/resources/images/web/rankpm.png', 
		    requrl: 'http://'+location.host+'/wxService/share/sharePrepare',
			param:location.href
	    };
	//查询数据
	function initData(){
		post('/decorate/findDecorateInfoById',{"id":"${expId}"},true).then(function(data){
			$("#title").html(data.name);
			$("#toptitle").html(data.title);
			$("#image").attr("src",data.activeImg);
			$("#sellerDescription").html(data.sellerDescription);
			$("#rule").html(data.description);
			if(1==data.isActDate){
				if(1!=data.status){
					//未启动活动，正在维护
					$("#acttitle").html("活动正在停止维护中，数据暂停服务，继续操作将不记录您与本活动之间的参与分享及扫码数据，为您带来的不便，敬请谅解!");
					$("#actstatus").show();
				}
			}else{
				if(0==data.isActDate){
					//未开始
					$("#acttitle").html("活动暂未开始，活动开始时间为"+data.beginTime+"请耐心等候!");
				}else if(2==data.isActDate){
					//已结束
					$("#acttitle").html("本次活动已经结束了，活动截止时间为"+data.endTime+"请关注后续活动!");
				}
				$("#actstatus").show();
			}
			shareData.title=data.shareTitle;
			shareData.desc=data.shareTitle;
			shareData.imgUrl='http://'+location.host+'/'+data.shareImg;
			shareData.link='http://'+location.host+'/wxService/decorate/share.html?expId=${expId}&publishopenid=${publishopenid}'; 
		});
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		sharTimelineFun(shareData);
	}); 
</script>
</body>
</html>