<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的</title>
<link href="<c:url value='/resources/css/web/My.css'/>"  rel="stylesheet" type="text/css"/></head>
<script type="text/javascript">
<c:if test="${SESSIONUSER==null || SESSIONUSER==''}">
	window.location.href="<c:url value='/user/toLogin'/>";
</c:if>
</script>
<body>
 <!--  <div class="headerContent">
           <ul>
              <li class="headerFont">
                  <span class="title">我的</span>
	              
              </li>
              <li class="headerimg"></li>
           </ul>  
        </div>  -->
 <div class="topBox">
	<div class="txPic">
		<img id="img" src="<c:url value='/resources/images/web/tx.png'/>" />
		<input type="file" name="test" id="test" style="display:none;">
	</div>
<%--  <div class="qiandao"><a id="signInEntry" class="headerbotton" value="签到" href="<c:url value='/user/toSignIn'/>">签到</a> --%>
</div>   
<div class="twoNavBox">
	<a href="<c:url value='/user/toCoin'/>" class="leftBox">
    	<ul>
            
            <li class="zcFont">我的资产</li>
            <li class="zcFont"><span id="coin"></span><i>金币</i></li>
        </ul>
    </a>
    <a href="<c:url value='/user/toWallet'/>">
    	<ul>
           
            <li class="zcFont">我的钱包</li>
            <li class="qbFont">￥<span id="money"></span></li>
        </ul>
    </a>
    <a href="<c:url value='/user/toCoin'/>" class="leftBox">
    	<ul>
            
            <li class="zcFont">我的券</li>
            <li class="zcFont"><span id="coin"></span>金币</li>
        </ul>
    </a>
</div>
</div>
<div class="navListBox">
	<ul>
    	<a href="<c:url value='/user/toInvolvement'/>"><li>
            <p class="fLeft"><img src="<c:url value='/resources/images/web/my/10.png'/>" /></p>
            <div class="fRight rightTextBox">
            	<span class="mycj">我的参与</span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>
         <a href="<c:url value='/user/toVouch'/>"><li>
            <p class="fLeft"><img src="<c:url value='/resources/images/web/my/20.png'/>" /></p>
            <div class="fRight rightTextBox">
            	<span class="mycj">我的券</span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>
        
        <a href="<c:url value='/user/toMyMessage'/>"><li>
            <p class="fLeft"><img src="<c:url value='/resources/images/web/my/40.png'/>" /></p>
            <div class="fRight rightTextBox">
            	<span class="mycj">我的消息<b class="yuan" style="display: none;"></b></span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>
    </ul>
    <ul>
        <a href="<c:url value='/about/toGuide'/>"><li>
            <p class="fLeft"><img style="height: 20px; width: 15px;" src="<c:url value='/resources/images/web/my/50.png'/>" /></p>
            <div class="fRight rightTextBox">
            	<span class="mycj">新手指南</span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>
        <a href="<c:url value='/about/toaboutUs'/>"><li>
            <p class="fLeft"><img src="<c:url value='/resources/images/web/my/60.png'/>" /></p>
            <div class="fRight rightTextBox">
            	<span class="mycj">关于我们</span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>
        <a href="<c:url value='/user/toASecurity'/>"><li>
            <p class="fLeft"><img src="<c:url value='/resources/images/web/my/70.png'/>" /></p>
            <div class="fRight rightTextBox lastBox">
            	<span class="mycj">账户安全</span>
                <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
            </div>
        </li></a>    
    </ul>
</div>
<!--底部导航-->
<div class="he60"></div>
	<div class="bottom">
	  <ul>
	      <a href="<c:url value='/decorate/index.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/home_1.png'/>"><p class="he20">首页</p></li></a>
	      <a href="<c:url value='/decorate/rank.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/faxian_1.png'/>"><p class="he20">排名</p></li></a>
	      <a href="<c:url value='/decorate/center.html'/>"><li class="mokuai"><img src="<c:url value='/resources/images/web/my_1.png'/>"/><p class="he20">我的</p></li></a>
	  </ul>
	</div>
<input type="hidden" value="${isWait}" id="isWait"/>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fileCompress/mobileBUGFix.mini.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fileCompress/compress.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/resources/js/common/fileUpload.js'/>"></script> --%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    var isWait=$("#isWait").val();

		post("/sen/getUserSInfoAndSignIn",{},false).then(function(data){
			$("#money").html(data.userInfo.money);
			$("#coin").html(data.userInfo.gold_coin);
			$("#img").attr("src",data.userInfo.head_image_url);
			if(data.userInfo.unread >0){
				$(".yuan").show();
			}
			// 设置右上角签到
			if(data.msg == "1") {
				// 已签到
				$("#signInEntry").attr("class", "headerbottonNoSignIn");
				$("#signInEntry").html("已签到");
				$('#signInEntry').removeAttr('href');
			} else if (data.msg == "0") {
				// 未签到
				$("#signInEntry").attr("class", "headerbotton");
				$("#signInEntry").html("签到");
				$("#signInEntry").attr("href", "/wxService/user/toSignIn");
			} else {
				// 已签到
				$("#signInEntry").attr("class", "headerbottonNoSignIn");
				$("#signInEntry").html("已签到");
				$('#signInEntry').removeAttr('href');
			}
		});
	    if(isWait=="N"){	    	
			showDialog("您的资料不完善，请先完善资料！","","取消","<c:url value='/userProblem'/>","确定");
			return false; 
	    }
	});
</script>
<script type="text/javascript">
	var shareData = {
		title: 'NO团网',
	    desc: 'NO团网', 
	    link: 'http://'+location.host+'/wxService/user/toMain',
	    imgUrl: 'http://'+location.host+'/wxService/resources/images/web/memberjt.png', 
	    requrl: 'http://'+location.host+'/wxService/share/sharePrepare',
		param:location.href
    };
	$(document).ready(function(){
		 //hideOptionMenu(shareData);
	}); 
</script>
<script type="text/javascript">
//重写前台验证失败后的回调
function showError(res){
	$("#error").html(res);
}
//重写上传成功后的回调
function showSuccess(res){
	if(res.flag==0){
		alert("chenggong");
	}
}

// 上传头像
$(document).ready(function(){
	$("#img").click(function(){
		$('#test').trigger('click');
	});
});
var loading;
var uId = ${SESSIONUSER.userid };
$('#test').UploadImg({
	module:'user_center',
    url : '../userlr/fileUpload',
    width : '600',    //如果设置了width，就会改变原图长，那样压缩的图片更小
    quality : '0.8', //压缩率，默认值为0.8 ，如果是1，并且没有设置width，那就上传原图
    mixsize : '10000000',  //最大图片大小，单位是B，这里设置为大约10M
    type : 'image/png,image/jpg,image/jpeg,image/pjpeg,image/gif,image/bmp,image/x-png',
    before : function(blob){
        $('#img').attr('src',blob);
    },
    error : function(res){
    	showError(res);
    },
    success : function(res){
       //showSuccess(res);
	    // 发请求保存图片
	   	$.post("../user/toUploadHead", {url:res.url, userId:uId});
    },
    loadStart:function(){
    	loading=layer.open({
		    type: 2,
		    content: '上传中'
		});
    },
    loadStop:function(){
    	layer.close(loading);
    }
});

function showError(res){
	if(res==1)
		$("#error").html("图片太大了");
	else if(res==2)
		$("#error").html("格式不正确");
}
function showSuccess(res){
	if(res.flag==0){
		$("#imgurl").html(res.url);
	}
}
</script>
</body>
</html>
