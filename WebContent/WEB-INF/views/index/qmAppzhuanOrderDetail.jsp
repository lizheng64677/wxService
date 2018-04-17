<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>
<c:choose>
		<c:when test="${pagePostion eq 'detail' }">
	 		任务流程示范
	 	</c:when>
	 	<c:otherwise>
	 		上传资料详情
	 	</c:otherwise>
	</c:choose>
</title>
<link href="<c:url value='/resources/css/web/expdetail/qmAppzhuanOrderDetail.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/swiper.css'/>" rel="stylesheet" type="text/css" />
<style type="text/css">
	.hide{
		display: none;
	}
	.first{
		display: block;
	}
</style>
</head>
<body>

	<div id="slider" class="slider_swipe" > 
	 	<div id="swipe-wrap" class="swiper-wrapper">
	 		<div class="swiper-slide slider_swipe">
	 			<p class="info"><img class="infoImage" src="<c:url value='/resources/images/web/shili.png'/>">示例说明</p>
	 			 <li class="rightpic"><img src="${downImageUrl }"></li>
	 			 <c:if test="${isDown eq 1 }">
					<div class="syqq">
						 <a href="javascript:void(0);" onclick="showShell1()">立即下载</a>
					</div> 
				 </c:if>
	 		</div>
	 		<div class="swiper-slide slider_swipe">
			     <p class="info"><img class="infoImage" src="<c:url value='/resources/images/web/shangchuan.png'/>">上传审核资料</p>
				 <li class="rightpic"><img src="${upImageUrl }"></li>
				 <div id="kkk">
						<c:if test="${status==0 }">
							<img furl="" fattach="" in="a" class="fuckimage first" id="imga"  src="<c:url value='/resources/images/web/21.png'/>"/>
							<img furl="" fattach="" in="aa" class="hide fuckimage" id="imgaa"  src="<c:url value='/resources/images/web/21.png'/>"/>
							<img furl="" fattach="" in="aaa" class="hide fuckimage" id="imgaaa"  src="<c:url value='/resources/images/web/21.png'/>"/>
							
							<input type="file" name="test" id="test" style="display:none;">
						</c:if>
						<c:if test="${status!=0 }">
							<%
							Object imageUrl=request.getAttribute("imageUrl");
							if(imageUrl!=null){
								String[] imgs=imageUrl.toString().split(";");
								for(String img:imgs){
									out.write("<img class='first'  src='"+img+"'/>");
								}
							}
								%>
						</c:if>
				 </div>	
				 <p class="Kcolor">点击方框添加本地照片<br>(最多添加3张图片)</p>		     
	 		</div>
	 		<div class="swiper-slide slider_swipe">
				 <p class="info"><img class="infoImage" src="<c:url value='/resources/images/web/pic1.png'/>">填写相关信息</p>
			     <div class="buttonBox">
			 		<c:if test="${status==0 }">
				 		<p style="color:#666;" class="telInput">手机号码</p>
						<p class="telInput"><input id="fckphone" maxlength="15" placeholder="请输入注册时的手机号码"  value='' class="Ktel"/></p>
						<a href="javascript:void(0);" onclick="sumbitExpApp()" class="Kbutton">提交资料</a>
					</c:if>
			 		<c:if test="${status!=0 }">
			 			<p style="color:#666;" class="telInput">手机号码</p>
			 			<p class="telInput"><input class="Ktel" id="fckphone" readonly="readonly" value='${user_phone}'  class="Ktel"/></p>		
			 		</c:if>
			 		<c:if test="${status == 1 }">
			 			<a href="javascript:void(0);"  class="Sbutton">审核中</a>
			 		</c:if>
			 		<c:if test="${status == 2 }">
			 			<a href="javascript:void(0);"  class="Sbutton">成功</a>
			 		</c:if>
			 		<c:if test="${status == 3 }">
			 			<a href="javascript:void(0);"  class="Sbutton">失败</a>
			 		</c:if>
			 	</div>			 
	 		</div>
	 	</div> 
	 	<div class="swiper-button-prev"></div>
    	<div class="swiper-button-next"></div>
    </div>
</div>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fileCompress/mobileBUGFix.mini.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fileCompress/compress.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/swiper.js'/>"></script>
<script type="text/javascript">
var fy;
$(document).ready(function(){
	/* $("#img").click(function(){
		$('#test').trigger('click');
	}); */
	$(".fuckimage").click(function(){
		fy=$(this);
		$('#test').trigger('click');
	});
	
	new Swiper("#slider", {
		  autoplay: 0,
     	  autoplayDisableOnInteraction: false,
	      prevButton:'.swiper-button-prev',
	      nextButton:'.swiper-button-next'
  });
});
var loading;
$('#test').UploadImg({
	module:'user_exp_zhuan',
    url : ROOT+'/userlr/fileUpload',
    width : '600',    //如果设置了width，就会改变原图长，那样压缩的图片更小
    quality : '1', //压缩率，默认值为0.8 ，如果是1，并且没有设置width，那就上传原图
    mixsize : '10000000',  //最大图片大小，单位是B，这里设置为大约10M
    type : 'image/png,image/jpg,image/jpeg,image/pjpeg,image/gif,image/bmp,image/x-png',
    before : function(blob){
    	if(fy)
    		fy.attr("src",blob);
       // $('#img').attr('src',blob);
    },
    error : function(res){
    	showError(res);
    },
    success : function(res){
       showSuccess(res);
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

	var showType=-1;
	$(document).ready(function(){
		initClicker();
	});
	
	function initClicker(){
		$(".headerimg").on("click",function(){
			window.history.go(-1);
		});
	}
	var res;
	function sumbitExpApp(){
		var u="",a="";
		$(".fuckimage").each(function(){
			if($(this).attr("furl")){
				u+=$(this).attr("furl")+";";
				a+=$(this).attr("fattach")+";";
			}
		});
		if(u.length==0){showAlert("请先上传图片!"); return;}
		//if(res == undefined) {showAlert("请先上传图片!"); return;}
		if(!$("#fckphone").val()) {showAlert("请输入信息!"); return;}
		//post('/sen/submitExpApp',{expId:'${expId}',imageUrl:res.url,attach:res.attach,userPhone:$("#fckphone").val()},true,"提交中")
		post('/sen/submitExpApp',{expId:'${expId}',imageUrl:u,attach:a,userPhone:$("#fckphone").val()},true,"提交中")
		.then(function(data){
			if(data.message='success'){
				//window.location.reload();
				 showDialog("提交成功，审核期见详情页，因项目而异!","<c:url value='/index/toIndex'/>","首页","<c:url value='/user/toInvolvement'/>","我的参与");
			}else{
				alert("出现未知错误");
			}
		});
	}
	
	function showSuccess(res){
		fy.attr("furl",res.url);
		fy.attr("fattach",res.attach);
		$("#img"+fy.attr("in")+"a").removeClass("hide").addClass("first");
	}
	function showShell1(){
	    window.location.href="${url}";
	}
	function showShell(){
		$(".syqq").hide();
		$(".uploadBox").show();
	}
	function hideShell(){
		$(".syqq").show();
		$(".uploadBox").hide();
	}
</script>
<script type="text/javascript">
var shareData = {
		title: 'NO团网',
	    desc: 'NO团网', 
	    link: 'http://'+location.host+'/wxService',
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