<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${pro_name }</title>

<link href="<c:url value='/resources/css/web/expdetail/common.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/dialog.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/expdetail/zeroQiangDetical.css'/>"  rel="stylesheet" type="text/css"/>
<link href="<c:url value='/resources/css/web/expdetail/swipe.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/expdetail/swipe_zoom.css'/>" />
<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/swipe.js'/>"></script>
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
});

function buy(){
	$.ajax({
		type:"post",
		url:"<c:url value='/expVolved/inVolveTryUserStauts'/>",
		data:{"detailId":"${exp_detail_id}","memberId":"${member_id}","expId":"${exp_id}"},
		dataType:"json",
		success:function(res){
			if("invalidDetailInfo"==res.message){

				alert("您已经参与过本期活动了!");
				return false;
			}else if("invalidExpInfo"==res.message){
				
				alert("当前活动查询异常！");
				return false;
				
			}else if("started"==res.message){
				
				alert("活动暂未开始");
				return false;
			}else if("invalidTimeExp"==res.message){
				 
				alert("本期活动已经结束，请期待后期项目！");
				return false;
			}else if("yprize"==res.message){
				
				//跳转至问题收集页面 
				window.location.href="<c:url value='/experience/involVedTryInfo'/>?detailId=${exp_detail_id}&memberId=${member_id}&expId=${exp_id}";
				return false;
			}else if("invalidUser"==res.message){
				
				alert("您的资料不完善，请完善资料后再次参加！");
				return false;
			}else if("invlidProNum"==res.message){
				alert("该活动产品数量不足！");
				return false;
			}
			
			
		}
	})

	
}

//加载头部产品图片 
function loadInitImg(){

	   $.post("<c:url value='/experience/findExpDetaiImages?detailId=${exp_detail_id}'/>",null,function(data){		   
		  var result=JSON.parse(data);
		   if("success"==result.message){
			       var html = '';
			       var pic =result.data;
			 	   var n=1;
			 
			       $("#countpage").text(pic.length);
			       $("#npage").text(n);
			       for(var i = 0;i < pic.length;i++){
			           html += '<div class="cinema_banner">';
				       html += '<img src='+pic[i].display_path+'></img>'; 
			    	   html += '</div>';
		
				   }
				   $(".swipe-wrap").html(html);
			      new Swipe(document.getElementById("slider"), {
				      speed : 1000,
				      auto : 3000,
				      callback : function() {
				    	 if(n<=pic.length){
				    		 
				    	   $("#npage").text(n++);
				    	   
				    	 }else{
				    		 
				    		 n=1;
				    	 }				    
				   }
			   });
		   }
    });
	}

</script>

</head>
</head>

<body>
<div class="detialCommentBox">
    <div id="slider">
		<div class="swipe-wrap">
		
	    </div>
	    <div class="picBox">
        <p><img src="<c:url value='/resources/images/web/time01.png'/>"><span>剩余${time}${unit }</span></p>
<%--     	<img src="<c:url value='/resources/images/web/pic06.png'/>"> --%>
        <div class="textNameBox">
           <h1 class="fLeft">${title }<font>${proTitle }</font></h1>         
          <div class="fRight"><span><label id="npage">1</label><label>/</label><label id="countpage">5</label> </span></div>
        </div>
    </div>
	</div>
    <div class="titleTextBox">
        <h2>￥0<s>￥${price }</s></h2>
        <p><span>限量<font>${pro_num }</font>份</span><span><font>${exp_num }</font>人已申请</span></p>
         <c:if test="${exp_stauts eq 1 }">
        <div class="ljsqHighLigth"><input type="button" value="我要申请" id="buy" onclick="buy();"></div>
        </c:if>
          <c:if test="${exp_stauts eq 2 }">
        <div class="ljsqHighLigth"><input type="button" value="即将开始"></div>
        </c:if>
          <c:if test="${exp_stauts eq 3 }">
        <div class="ljsq"><input type="button" value="已结束" ></div>
        </c:if>
    </div>
</div>

<div class="hdgzBox">
	<div class="hdgz">
        <span>套餐详情</span>
    </div>
    <div class="info">
    ${pro_info }
    </div>
</div>

<div class="hdgzBox">
	<div class="hdgz">
        <span>使用须知</span>
    </div>
    <div class="info">
    ${user_info }
	</div>
</div>


<div class="freeShopBox">
	<div class="businessPro">

    <a href="#">
	<span class="bs1"><img src="${logo_pic_url }"></span>
    <span class="bs2">
    	<h4>${busname }</h4>
		<p class="bs6">
        	<img src="<c:url value='/resources/images/web/star01.png'/>">
            <img src="<c:url value='/resources/images/web/star01.png'/>">
            <img src="<c:url value='/resources/images/web/star01.png'/>">
            <img src="<c:url value='/resources/images/web/star01.png'/>">
            <img src="<c:url value='/resources/images/web/star01.png'/>">
        </p>
	</span>
   

    </a>
</div>
    <div class="addressPhoneBox">
    	<ul>
        	<li>
            	<span class="address">${address }</span>
                <span class="iconBox"><img src="<c:url value='/resources/images/web/dw.png'/>"></span>
            </li>
            <li class="telBox">
            	<span class="address">${telephone }</span>
                <span class="iconBox"><img src="<c:url value='/resources/images/web/phone01.png'/>"></span>
            </li>
        </ul>
    </div>
</div>


<div class="freeShopBox">
	<a href="#">
    <h5>
        <span class="sqjl">申请记录</span>
        <span><img src="<c:url value='/resources/images/web/memberjt.png'/>" /></span>
    </h5>
    </a>
</div>

<div class="hdgzBox">
	<div class="topBox">
        <div class="hdgz1 fLeft">
            <span>评价</span>
        </div>
        <div class="starBox fRight">
            <span><img src="<c:url value='/resources/images/web/memberjt.png'/>"></span>
        </div>
    </div>
    <div class="plMainBox">
    	<dl>
        	<dt>
            	<div class="firstBox">
                	<div class="nameTime fLeft">航航</div>
                    <div class="smallStar fRight">2014-12-30</div>
                </div>
                <div class="starMainBox">
                	<span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                   	<span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                </div>
                <div class="middleBox">非常好，环境舒适，服务周到。菜的口味不错，略微偏咸了一点！很划算的一次体验！</div>
                <div class="pictureBox">
                	<span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                </div>
            </dt>
            <dt>
            	<div class="firstBox">
                	<div class="nameTime fLeft">航航</div>
                    <div class="smallStar fRight">2014-12-30</div>
                </div>
                <div class="starMainBox">
                	<span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                   	<span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/star01.png'/>"></span>
                </div>
                <div class="middleBox">非常好，环境舒适，服务周到。菜的口味不错，略微偏咸了一点！很划算的一次体验！</div>
                <div class="pictureBox">
                	<span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                    <span><img src="<c:url value='/resources/images/web/pic01.png'/>"></span>
                </div>
            </dt>
        </dl>
    </div>
    <div class="bottomBox">
    	<a href="#">
        <div class="allPl fLeft">查看所有评价<font>（184）</font></div>
        <div class="rjt fRight"><img src="<c:url value='/resources/images/web/memberjt.png'/>"></div>
        </a>
    </div>
</div>


<div class="he60"></div>
 <c:if test="${exp_stauts eq 1 }">
<div class="syqq"><a href="javascript:void(0);" id="buy" onclick="buy();">我要申请</a></div>
</c:if>
</body>
</html>
