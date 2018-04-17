<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>帮我赚任务详情</title>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/qixinzhuanDetail.css'/>"  rel="stylesheet" type="text/css"/>
</head>
<body>
   <!-- <div class="headerContent">
       <ul>
          <li class="headerFont" id="title">
          </li>
          <a href="<c:url value='/index/toIndex'/>">
         	 <img class="imgCss" src="<c:url value='/resources/images/web/home_0.png'/>">
          </a>	
       </ul>  
    </div> -->
    <div class="content">
         <div class="data">
             <div class="dataLeft">
                 <p>总资产：<span id="total"></span></p>
                 <p>剩&nbsp;&nbsp;&nbsp;余：<span id="remain"></span></p>  
             </div>
             <div class="border"></div>
             <div class="dataRight">
                 <p>浏览奖励：<span id="browse"></span></p>
                 <p>最高限额：<span id="perP"></span></p>
             </div>
             <p class="tips">*本次活动转发享受<span id="shareNum"></span>金币的奖励</p>
         </div>
         <div class="Process">
               <div class="processBt" id="titles"></div>
               <div class="processContect"><span class="read"> <img src="<c:url value='/resources/images/web/u5.png'/>">参与人数：<span id="pc"></span></li></span> </div>
               <p>
				<div id="ccc" class="contentImage">
				</div>	
			   </p>
<!--                <div class="contentPic"><img id="banner" src=""></div> -->
         </div>
   </div>

    <div class="syqq" style="display:none;">
   <a href="<c:url value='/actIntro/toIntroDetail?type=1'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
   	<a class="aclass" id="img" href="#">参加活动</a>
   </div>
   <div class="syqqa" style="display:none;">
   <a href="<c:url value='/actIntro/toIntroDetail?type=1'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
   <a  class="aclassa" id="imga"  href="javascript:void(0);">已领完</a>
   </div>
    	<input type="hidden" id="userId" value="${userId }"/>
   <!--申请成功-->
<div class="sqSuccessBox hidden" id="sqSuccessBox">

    <div id="share" style="width: 100%;margin: 0px auto -20%;text-align:right;left: 10%;"><img src="<c:url value='/resources/css/images/share.png'/>" style="width: 50%;padding-right: 5%;"></div>
	<div class="sqSuccess">
    	<div class="Successbox">
    		<!--  <p><img src="<c:url value='/resources/css/images/smile.png'/>" id="imgId"/></p>-->
            <h1 id="promptTitle">请点击右上角分享链接，活动根据链接点击次数计算金币所得，参与后请在"我的-我的参与"中查看链接点击详情！</h1>
            <div><input type="button" value="确定" onclick="closeDialog(0)" id="btn"/></div>
        </div>
        <div class="delBox" onclick="closeDialog(0)"><img src="<c:url value='/resources/css/images/del.png'/>" /></div>
    </div>
</div>
   
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initData();
		initClicker();
		dclick();
	});
	
	function initClicker(){
		$(".headerimg").on("click",function(){
			window.history.go(-1);
		});
	}
	var edata;

	function initData(){
		post('/index/findQixinZhuanDetail',{expId:'${expId}'},false)
		.then(function(data){
			edata=data;
			$("#title").html(data.data.title);
			$("#titles").html(data.data.title);
			$("#total").html(data.data.exp_count_gold+"金币");
			$("#remain").html(data.data.exp_remain_gold+"金币");
			$("#browse").html(data.data.exp_gold_min+"金币/次");
			$("#shareNum").html(data.data.user_share_gold);
			$("#perP").html(data.data.user_max_gold+"金币/人");
			$("#pc").html(data.data.user_join);
			$("#ccc").html(data.data.exp_info);
// 			$("#banner").attr("src",data.data.exp_img_url);
			if(data.data.exp_gold_status==0){
				
				$(".syqqa").show(); 
			}else{
				
				$(".syqq").show();
			}
			if(data.data.exp_status==1){
				$("#img").html("即将开始");
				$(".syqq").show();
			}else if(data.data.exp_status==0){
				$("#img").on("click",function(){
					joinExpZ()
				});
			}else if(data.data.exp_status==2){
				$("#imga").html("已结束");
				$(".syqqa").show(); 
			}
		});
	}
	function joinExpZ(){
		if(!edata) {alert("活动还没加载完！"); return;}
		post("/expVolved/joinExpZ",{expId:'${expId}',openid:'${SESSION_OPEN_ID}',moduleType:0},true)
		.then(function(data){
			if(data.msg==2){
				showDialog("你已经参与本期活动了,可点击右上角继续分享参与或点击'查看进程'查看链接点击详情！","","取消","<c:url value='/user/toInvolvement'/>","查看进程");
				$("#sqSuccessBox").hide();								
			}else if(data.msg==1){ 
				
				showDialog("你还没有注册，前往注册！","","取消","<c:url value='/user/toRegister'/>","确定");
			}else if(data.msg==3){
				showDialog("你还没有登录，前往登录！","","取消","<c:url value='/user/toLogin'/>","确定");
			}else if(data.msg==0){
				$("#sqSuccessBox").show();
			}else if(data.msg==5){
				showDialog("您的资料不完善，请完善资料后再来参与!","","取消","<c:url value='/user/toMyInfo'/>","确定");
			}else if(data.msg=4){
				showDialog("亲，您不符合该活动的参与条件，请查看其他活动，谢谢！","","取消","","确定");
			}
		});
	}
	
//lz new add info  copy 2 qixinzhuanOrderDetail
function dclick(){
		var url="";
		var title="";
		var desc="";
		var img="";
		var imgIsSubmt='${img}';
		var strSubString=imgIsSubmt.indexOf("http");
		if(strSubString>=0){
			img="${img}";		
		}else{
			img="http://"+location.host+"${img}";
		}
		var thisId=$("#userId").val();
		if(thisId.length>1){

			url='http://'+location.host+'/wxService/index/myToShare?expId=${expId}&userId=${userId}';  
			title='${title}';
		    desc='${title}';
		}else{

			url='http://'+location.host+'/wxService/user/toMain'; 
			title='${title}';
		    desc='${title}';
		}
		//特殊嵌套处理 
		var shareData = {
				title: title,
			    desc: desc,   
			    link: url,        
			    imgUrl: img,
				requrl:"<c:url value='/share/sharePrepare'/>",
				param:location.href
		    };
		
		if(thisId.length>1){
			
			prodetailshar(shareData);
		}else{
			sharTimelineFun(shareData);
		}
	}
	function experience(){
		$.ajax({
			url:"<c:url value='/sen/share'/>",
			data:{expId:'${expId}',userId:'${userId}'},
			dataType:"json",
			success:function(res){
				
				$("#sqSuccessBox").hide();
			}
		});
	}
</script>
</body>
</html>
