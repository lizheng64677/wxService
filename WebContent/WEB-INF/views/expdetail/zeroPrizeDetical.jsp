<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
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
<link href="<c:url value='/resources/css/web/expdetail/plList.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<c:url value='/resources/css/web/expdetail/swipe_zoom.css'/>" />

<script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/swipe.js'/>"></script>
<script src="<c:url value='/resources/js/expdetail/canvas.js'/>"></script>
<script type="text/javascript">
$(function(){
	//加载图像 
	loadInitImg();	
	
	loadDiscuss();
	
	$("#d2").on("click",".c1",function(){
		
		 $(".c2").attr("src",this.src);
		 var h = $(window).width();
         $(".hide").css("width", h);
		 $(".hide").show();
	});
	
	$(".hide").click(function(){
		$(this).hide();
	});
});
function buy(){
	
	involvedExpUserStauts();
}

function showType(){
	
	var showType=$("#showType").val();
	//红包方式 
	if(showType==0){				
		 $(".cover").hide();
		 $(".szddPic").show(); 
		 $(".ptMainBox").hide();
		 $("#prpDialog").show();
		 
	}
	//拼图方式 
	if(showType==1){			
     console.log("暂无拼图方式");
	}
	if(showType==2){				
    //刮刮卡方式 
	init();
	$("#guaguaDialog").show(); 
	}
	
	//抽签方式 
	if(showType==3){
		
	$(".cover").show();
 	$(".szddPic").hide();
 	$("#prpDialog").show(); 

	} 

}

function hbprize(){
	
	$("#hb").attr("src","<c:url value='/resources/css/images/dhb.gif'/>");
	setTimeout(involvedExpPrize,2000);
};
function involvedExpPrize(){
	$.ajax({
		type:"post",
		url:"<c:url value='/expVolved/involVedPrize'/>",
		data:{"detailId":"${exp_detail_id}","memberId":"${member_id}","expId":"${exp_id}"},
		dataType:"json",
		success:function(res){
		 	$("#prpDialog").hide(); 

			if("yprize"==res.message){
				
				$("#fck").show();			
				return false;
			
			}else if("invlidProNum"==res.message){
				
				
			    showAlert("很遗憾，本期奖品已经被抽光了！");
			    return false;
			    
			}else if("nprize"==res.message){
				$("#fck1").show();
				
			    return false;
			}else if("invalidExpInfo"==res.message){
				
				showAlert("当前活动查询异常！");
				return false;			
			}else if("invalidTimeExp"==res.message){
				 
				showAlert("本期活动已经结束，请期待后期活动！");
				return false;
			}
	
		}
	});
}
//查询当前用户及活动的状态 
function involvedExpUserStauts(){
	post("/expVolved/inVolveTryUserStauts",{"detailId":"${exp_detail_id}","memberId":"${member_id}","expId":"${exp_id}"},true).then(function(res){
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
			 
			showAlert("本期活动已经结束，请期待后期活动！");
			return false;
		}else if("yprize"==res.message){
			showType();
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
			
	});
	
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
	
	//异步加载评价信息
	function loadDiscuss(){
		$.ajax({
			url:"<c:url value='/experience/findDiscussInfo' />",
			data:{proId:"${pro_id}",detailId:"${exp_detail_id}","page.currentPage":"0","page.showCount":3},
			type:'post',
			dataType:'json',
			success:function(data){
				var html=[];
				html.push('    <div class="plMainBox">');
				html.push('			<dl>');
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						html.push('                    <dt>');
						html.push('                        <div class="firstBox">');
						html.push('                            <div class="nameTime fLeft">'+data.data[i].userPhone+'</div>');
						html.push('                            <div class="smallStar fRight">'+data.data[i].createTime+'</div>');
						html.push('                        </div>');
						html.push('                        <div class="starMainBox">');
						for(var  k=1;k<=data.data[i].qcdScore;k++){
							html.push('                                <span><img src="<c:url value='/resources/images/web/voucher/9.png'/>"></span>');
						}
						for(var  k=1;k<=(5-data.data[i].qcdScore);k++){
							html.push('                                <span><img src="<c:url value='/resources/images/web/voucher/10.png'/>"></span>');
						}
						html.push('                        </div>');
						html.push('                        <div class="middleBox">'+data.data[i].content+'</div>');
						html.push('                        <div class="pictureBox">');
						for(var k =0;k<data.data[i].picUrl.split(",").length;k++){
							html.push('                        <span> <img class="c1"  src="'+data.data[i].picUrl.split(",")[k]+'" /></span>');
						}
						html.push('                        </div>');
						html.push('                    </dt>');
					}
				}
				html.push('        </dl>');
				html.push('    </div>');
				var html1=[];
				if(data.discussCount>1){
					html1.push('<a  style="color:#666666;margin-right: 15px;" href="<c:url value="/experience/queryDis?proId=${pro_id}&detailId=${exp_detail_id}" />">共有'+data.discussCount+'条</a>');
					html1.push('<img style="margin-left:5px;" src="<c:url value='/resources/images/web/memberjt.png'/>">');
					//html.push('        <div class="bottomBox">');
					//html.push('            <a href="<c:url value="/experience/queryDis?proId=${pro_id}&detailId=${exp_detail_id}" />">');
					//html.push('            <div class="allPl fLeft">查看所有评价<font>'+data.discussCount+'</font></div>');
					//html.push('            <div class="rjt fRight"><img src="<c:url value='/resources/images/web/memberjt.png'/>"></div>');
					//html.push('            </a>');
					//html.push('        </div>');
					$("#span1").append(html1.join(""));
				}
				$("#d2").append(html.join(""));
			}	
		});	
	}
	
	
</script>
</head>
<body>

<div  id="fck" style="display:none; z-index:1000; position: fixed;top:0px;left:0px;width:100%;height: 100%;background-color:rgba(0, 0, 0, 0.5);">
	<div style="margin: auto; width: 70%; position: fixed; top: 24%; left: 11%;">
		<span onclick="javascript:$('#fck').hide()"><img style="width: 30px; position: absolute; top: 12px; left: 85%;" src='<c:url value="/resources/images/web/7.png"/>'/></span>
		<span><img style="width:120%;" src='<c:url value="/resources/images/web/9.png"/>'/></span>
		<span><a href='<c:url value='/user/toVouch'/>'><img style="width: 100%; position: relative; top: -73px;left: 12%;" src='<c:url value="/resources/images/web/8.png"/>'/></a></span>
	</div>
</div>
<div id="fck1" style="display:none; z-index:1000; position: fixed;top:0px;left:0px;width:100%;height: 100%;background-color:rgba(0, 0, 0, 0.5);">
	<div style="margin: auto; width: 70%; position: fixed; top: 24%; left: 15%;">
		<span onclick="javascript:$('#fck1').hide()"><img style="width: 30px; position: absolute; top: 12px; left: 85%;" src='<c:url value="/resources/images/web/7.png"/>'/></span>
		<span><img style="width:120%;margin-left: -16%;" src='<c:url value="/resources/images/web/10.png"/>'/></span>
	</div>
</div>

<div class="detialCommentBox">
	<div id="slider">
		<div class="swipe-wrap">
		
	    </div>
	    <div class="picBox">
        <p><img src="<c:url value='/resources/images/web/time01.png'/>"><span>
	        <c:if test="${exp_stauts eq 1 }">
	        	剩余${time}${unit }
	        </c:if>
		     <c:if test="${exp_stauts eq 2 }">
				即将开始
	        </c:if>
	          <c:if test="${exp_stauts eq 3 }">
	        	已结束
	        </c:if>
        	</span></p>
        <div class="textNameBox">
           <h1 class="fLeft">${title }<font>${proTitle }</font></h1>         
          <div class="fRight"><span><label id="npage">1</label><label>/</label><label id="countpage">5</label> </span></div>
        </div>
    </div>
	</div>
	<input type="hidden" value="${show_type }"  id="showType" />
    <div class="titleTextBox">
        <h2>￥0<s>￥${price }</s><br /></h2>      
        <p><span>提供<font>${pro_num*installments}</font>份</span>
        <c:if test="${exp_stauts!=3 }">
        <span>剩余<font>${pro_num-exp_num }</font>份</span>
        </c:if>
        <span>累计<font>${exp_num1 }</font>人申请</span></p>
        <c:if test="${exp_stauts eq 1 }">
         <c:choose>
         <c:when test="${time>0 }">
        <div class="ljsqHighLigth"><input type="button" value="立即领取" id="buy" onclick="buy();"></div>
        </c:when>
        <c:otherwise>
                <div class="ljsq"><input type="button" value="已结束" ></div>
        </c:otherwise>
 		</c:choose>
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
    <div class="info">${pro_info }</div>
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
    		<a href="${address_url }">
	        	<li>
	            	<span class="address">${address }</span>
	                <span class="iconBox"><img src="<c:url value='/resources/images/web/dw.png'/>"></span>
	            </li>
            </a>
            <a href="tel:${telephone }">
	            <li class="telBox">
	            	<span class="address">${telephone }</span>
	                <span class="iconBox"><img src="<c:url value='/resources/images/web/phone01.png'/>"></span>
	            </li>
	        </a>
        </ul>
    </div>
</div>
<!-- 
<div class="freeShopBox">
	<a href="#">
    <h5>
        <span class="sqjl">申请记录</span>
        <span><img src="<c:url value='/resources/images/web/memberjt.png'/>"></span>
    </h5>
    </a>
</div>
 -->
<div id="d2" class="hdgzBox">
	<div class="topBox">
        <div class="hdgz1 fLeft">
            <span>评价</span>
        </div>
        <div class="starBox fRight">
            <span id="span1"></span>
            
        </div>
    </div>
</div>

<input type="hidden" value="${exp_detail_id}" id="detailId"/>
<input type="hidden" value="${member_id}" id="memberId"/>
<input type="hidden" value="${exp_id}" id="expId"/>
<!--刮刮乐-->
<div class="sqSuccessBox2 hidden" id="guaguaDialog">
	<div class="gglMainBox2">	
		<img id="close" src="<c:url value='/resources/css/images/close.png'/>" style="width:25px;height:25px;position: absolute;left:82.5%;top:38.5%;z-index:99999;opacity:0.8'" onclick="closeGuaDialog();"/>
		<img id="gua1_img" src="<c:url value='/resources/css/images/gua_image.png'/>" style="position: absolute;left:11%;top:39.5%"/>
		<canvas id="front" style="position:absolute;"/>
	</div>
</div>
<div class="sqSuccessBox hidden" id="prpDialog">
	<div class="gglMainBox">
        <!--抽奖-->
        <div class="szggPic szddPic" style="display:none;">
        	<div class="hbdjBox">
        		<img src="<c:url value='/resources/images/web/4.png'/>" id="hb"/>
	        	<a href="javascript:void(0)" class="szdd" id="szdd" onclick="hbprize();"><img src="<c:url value='/resources/css/images/ddButton.png'/>"/></a>
        	</div>
       	</div>
       	<!--抽签 -->
       	<div class="cover result">
       		<div class="item">
				<div class="sprite"></div>
			</div>
            <div class="ptOver"><a href="javascript:statr();">开始抽签</a></div>
        </div>
    </div>
    <!-- 抽签中奖提示信息 -->
	<div class="fi" onclick="cancelCQ()">恭喜你中奖了！</div>
</div>

<div class="he60"></div>
      <c:if test="${exp_stauts eq 1 }">
         <c:choose>
         <c:when test="${time>0 }">
  		 <div class="syqq">
  		 <a href="<c:url value='/actIntro/toIntroDetail?type=2'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
  		 <a href="javascript:void(0);" class="aclass" id="buy" onclick="buy();">立即领取</a>
  		 </div>
        </c:when>
        <c:otherwise>
             <div class="syqqa ">
             <a href="<c:url value='/actIntro/toIntroDetail?type=2'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
             <a href="javascript:void(0);" class="aclassa">已结束</a></div>
        </c:otherwise>
 		</c:choose>
       </c:if>
        <c:if test="${exp_stauts eq 2 }">
  		<div class="syqq">
  		<a href="<c:url value='/actIntro/toIntroDetail?type=2'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
  		<a href="javascript:void(0);" class="aclass">即将开始</a></div>
        </c:if>
        <c:if test="${exp_stauts eq 3 }">
       	<div class="syqqa">
       	<a href="<c:url value='/actIntro/toIntroDetail?type=2'/>"><img class="intro" src="<c:url value='/resources/images/web/intro.png'/>"></a>
       	<a href="javascript:void(0);" class="aclassa">已结束</a></div>
        </c:if>
        
        
        <div class="hide" style="display:none;">
		   <div class="boximg" >
				<img  class="c2" src="images/11.png" />
		   </div>
 	    </div>
</body>

</html>
