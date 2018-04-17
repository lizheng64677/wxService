<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>写评价</title>
<link href="<c:url value="/resources/css/web/voucher/writepj.css"></c:url>" rel="stylesheet" type="text/css" />

<script type="text/javascript">
var SITE_BASE_PATH = '<c:url value="/"/>';
var baseUrl='${baseUrl}';
var uid='${userId}';//从session获取
</script>

</head>

<body>
<input type="hidden" name="qcd_score" class="qcd_score"  value="1"/>
<input type="hidden" name="pro_id" class="pro_id"  value="${requestScope.proId }" />
<input type="hidden" name="detail_id" class="detail_id" value="${requestScope.detailId }" />
<input type="hidden" name="member_id" id="member_id"  value="${requestScope.memberId }" />
<input type="hidden" name="exp_type" class="exp_type"  value="${requestScope.expType }" />
<input type="hidden" name="user_id" class="user_id"  value="${requestScope.userId }" />
<input type="hidden" name="pic_url"   class="pic_url"  />
<div class="head">
 <span>写评价</span>
 </div>
 
<div class="content">
 
 <div id="box" class="p1"><p>综合评分 
	<img class="imga" src="<c:url value="/resources/images/web/voucher/9.png"/>" >
	<img src="<c:url value="/resources/images/web/voucher/10.png"/>" >
	<img src="<c:url value="/resources/images/web/voucher/10.png"/>" >
	<img src="<c:url value="/resources/images/web/voucher/10.png"/>" >
	<img src="<c:url value="/resources/images/web/voucher/10.png"/>" >
</p></div>
  
 <div class="evaluation">
  <textarea name="content" class="textareas" rows="5" cols="30" >你填写的申请宣言会被当作重要参考依据,1-200个字符</textarea>
 <p class="p2">
 	<span id="s1">
 		<input type="file" name="test" id="test" style="display:none;">
 		<img class="img" in="1"  id="img1"  style="width:50px;height:50px;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="2" id="img2" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="3" id="img3" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="4" id="img4" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="5" id="img5" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="6" id="img6" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="7" id="img7" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="8" id="img8" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 		<img class="img" in="9"  id="img9" style="width:50px;height:50px; display: none;"  src="<c:url value="/resources/images/web/voucher/8.png"/>">
 	</span>
 	
 </p>
 
 </div>
</div>

<div class="footer" id="box">
    <input id="subButton" type="button" class="buttons" value="提交评价">
</div> 
 
 <script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
 <script type="text/javascript" src="<c:url value='/resources/js/fileCompress/mobileBUGFix.mini.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/fileCompress/compress.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript">
var fy;
$(function () {
	var path="";
	//给提交按钮加事件
	$("#subButton").on("click",function(){
		var jsonObject=new Object();
		jsonObject.content = $("textarea[name='content']").val().trim() == "你填写的申请宣言会被当作重要参考依据,1-200个字符" ? "" : $("textarea[name='content']").val();
		if(jsonObject.content.length<1){
			showAlert("最少1个字符哦");
			return;
		}
		if(jsonObject.content.length>200){
			showAlert("最多200个字符哦");
			return;
		}
		var u="";
		$(".img").each(function(i){
			
			if($(this).attr("furl")){
				if(i==0){
					u=$(this).attr("furl");
				}else{
					u+=","+$(this).attr("furl");
				}
			}
		});
		jsonObject.picUrl=u;//上传图片url
		if(jsonObject.picUrl=="" || jsonObject.picUrl==null){
			showAlert("最少上传一张图片哦");
			return;
		}
		jsonObject.qcdScore = $(".qcd_score").val();
		if(jsonObject.picUrl=="" || jsonObject.picUrl==null){
			showAlert("评分最低1分哦");
			return;
		}
		jsonObject.proId=$(".pro_id").val();//产品id
		
		jsonObject.detailId=$(".detail_id").val();//产品详情id
		jsonObject.memberId=$("#member_id").val();//所属商家id
		jsonObject.expType=$(".exp_type").val();//活动类型
		jsonObject.userId=$(".user_id").val();//活动类型
		
		// 添加
		$.ajax({
			url : 'toDiscuzAddInfo',
			type : 'post',
			data : jsonObject,
			dataType:"json",
			success : function(data) {
			console.log("response status"+data.message);
			 if("success"==data.message){
				showAlert("提交成功");
				window.location.href="<c:url value='/user/toVouch'/>";
				
			 }else if("reset"==data.message){
				showAlert("您已经评论过啦");
			 }
			 
			}
		});
	});
	
	// 评分画星星
	$("#box img").click(function(){
		var cate = $(this).closest("div").attr("id");
		var score = $(this).index()+1;
		$(".qcd_score").val(score);
		var imgs = $("div[id="+cate+"] p").children();
		$("div[id="+cate+"] p").children().each(function () {
			if($(this).index() < score) {
				$(this).attr("src", "<c:url value='/resources/images/web/voucher/9.png'/>");
			} else {
				$(this).attr("src", "<c:url value='/resources/images/web/voucher/10.png'/>");
			}
		});
	});
	
	// 评论内容
	$("textarea[name='content']").focus(function () {
		if($("textarea[name='content']").val().trim() == "你填写的申请宣言会被当作重要参考依据,1-200个字符") {
			$("textarea[name='content']").val("");
		}
	});
	$("textarea[name='content']").blur(function () {
		if($("textarea[name='content']").val().trim() == "") {
			$("textarea[name='content']").val("你填写的申请宣言会被当作重要参考依据,1-200个字符");
		}
	});
	
	$(".img").click(function(){
		fy =$(this);
		if($(".img").length>=10){
			showAlert("最多上传9张图片哦！");
			return;
		}
		
		$('#test').trigger('click');
	});
	
	
});




var loading;
$('#test').UploadImg({
	module:'user_discuz',
    url : '../userlr/fileUpload',
    width : '600',    //如果设置了width，就会改变原图长，那样压缩的图片更小
    quality : '1', //压缩率，默认值为0.8 ，如果是1，并且没有设置width，那就上传原图
    mixsize : '10000000',  //最大图片大小，单位是B，这里设置为大约10M
    type : 'image/png,image/jpg,image/jpeg,image/pjpeg,image/gif,image/bmp,image/x-png',
    before : function(blob){
    	fy.attr("src",blob);
    	
    	//$("#s1").append("<img class='c1' onclick='upload()' style='width:50px;height:50px;' src='"+blob+"' />");
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
function showSuccess(res){
	fy.attr("furl",res.url);
	var i =parseInt(fy.attr("in"))+1;
	$("#img"+i).show();
}

</script>
 

</body>
</html>
