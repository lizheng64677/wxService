<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<title>${themeTitle}</title>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.2.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/dialog.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/web/share/share.css"></c:url>" rel="stylesheet" type="text/css" />

<style>
.nametext{
	overflow: hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
}
.zuBox .picBox img{
    width: 20%;
    border-radius: 160px;
    height: 20%;
    }
.he60{
	height:60px;
	}
    
.syqq {
	width: 100%;
    background: #e83228;
	position: fixed;
	bottom: 0;
	padding: 10px 0;
	padding-top: 0px;
	text-align: center;
}
.aclass {
    display: inline-block;
    width: 40%;
    border-radius: 20px;
    padding: 8px 0;
    background: #e83228;
    color: #fff;
    text-align: center;
    font-size: 14px;
    }
</style>
<script type="text/javascript">
$(function(){
	var color = '${color}';
	$("body").css("background",color);
});

function toDetail(detailId,userId){
	window.location.href="<c:url value='/decorate/index.html'/>?id=${expId}";
}
</script>
</head>

<body>

<div class="topMainBox">
	<img src="${themePic }" />
</div>
<div class="topMiddle"><img src="${themeLogo}" /></div>
<div class="zuBox">
  		<span class="picBox">
  			<img id="img" src="${user.headImg}"/>
  		</span>
  		</br>
		<span>"${user.nickName }"</span>真诚邀请您!
</div>

<div class="sjProductMain">
	<div class="sjProductBox">
    	<span class="picBox"><img id="img" src="${decorate.activeImg }"/></span>
        <span class="commentMainBox">
        	<h2 class="nametext">${decorate.name }</h2>
            <h3 class="nametext">${decorate.title }</h3>            
        </span>
        <div class="ckxq"><input type="button" value="查看活动" onclick="toDetail('${expId}');"/></div>
    </div>
</div>
<input type="hidden" id="isActDate" value="${decorate.isActDate }"/>
<input type="hidden" id="status" value="${decorate.status }"/>

<div class="sqSuccessBox hidden" id="actstatus">
	<div class="sqSuccess">
    	<div class="Successbox">
            <h1 id="acttitle"></h1>
            <div><input type="button" value="确定" id="btnactstatus"/></div>
        </div>
    </div>
</div>
<div class="bottomPic"><img src="${bottomPic}" /></div>
	<div class="he60"></div>
	<c:if test="${1==isVoucher}">
	 <div class="syqq">
		 <a href="javascript:void(0);"></a>
		 <a href="javascript:void(0);" class="aclass" id="buy" onclick="buy();">${voucherPrice}(元)体验.${voucherName}</a>
	 </div>   
 	</c:if>
</body>
<script>
var img="";
var imgIsSubmt='${themePic}';
var strSubString=imgIsSubmt.indexOf("http");
if(strSubString>=0){
	img="${themePic}";		
}else{
	img="http://"+location.host+"${themePic}";
}

var shareData = {
		
		title: '${themeTitle}',
	    desc: '${themeTitle}',
	    link: 'http://'+location.host+'/wxService/decorate/share.html?publishopenid=${publishopenid}&expId=${expId}', // 
	    imgUrl:img, 
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
    };

$(document).ready(function(){

	prodetailshar(shareData);//回调处理   
	//关闭活动状态提示框
	$("#btnactstatus").on("click",function(){
		$("#actstatus").hide();
	});
	var isActDate=$("#isActDate").val();
	var actStatus=$("#status").val(); 
	if(1==isActDate){
		if(1!=actStatus){
			//未启动活动，正在维护
			$("#acttitle").html("活动正在停止维护中，数据暂停服务，继续操作将不记录您与本活动之间的参与分享及扫码数据，为您带来的不便，敬请谅解!");
			$("#actstatus").show();
		}
	}else{
		if(0==isActDate){
			//未开始
			$("#acttitle").html("活动暂未开始，活动开始时间为${decorate.beginTime}请耐心等候!");
		}else if(2==isActDate){
			//已结束
			$("#acttitle").html("活动已结束，活动截止时间为${decorate.endTime}请关注后续活动!");
		}
		$("#actstatus").show();
	}
});

</script>
</html>
