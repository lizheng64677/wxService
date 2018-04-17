<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>签到</title>
<link href="<c:url value='/resources/css/web/qiandao.css'/>"  rel="stylesheet" type="text/css"/></head>

<body>
	<!-- <div class="headerContent">
           <ul>
           	<a href="javascript:history.go(-1);"><li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li></a>
              <li class="headerFont">签到</li>
           </ul>  
        </div> 
	 -->
<div class="numberMainBox">
	<ul class="sortList">

    </ul>
</div>

<div class="qdMainBox">
	<div style="height:32px;"></div>
	<h1>请按照上方数字的顺序排列矩阵</h1>
    <div class="numberBox">
    	<ul class="imgList">
        	<li allow="true" id="num0">
            	<a href="javascript:void(0);">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>1</h2>
                </a>
            </li>
            <li allow="true" id="num1">
            	<a href="#">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>2</h2>
                </a>
            </li>
            <li allow="true" id="num2">
            	<a href="#">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>3</h2>
                </a>
            </li>
            <li allow="true" id="num3">
            	<a href="#">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>4</h2>
                </a>
            </li>
            <li allow="true" id="num4">
            	<a href="#">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>5</h2>
                </a>
            </li>
            <li allow="true" id="num5">
            	<a href="#">
                	<p><img src="<c:url value='/resources/images/web/m.jpg'/>" /></p>
                    <h2>6</h2>
                </a>
            </li>
        </ul>
    </div>
    
    <div class="qdOver"><a href="#">完成签到</a></div>
</div>
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>

<script type="text/javascript">
	var shareData = {			
			requrl:"<c:url value='/share/sharePrepare'></c:url>",
			param:location.href
	};	
	$(document).ready(function(){
		//个人中心不允许有多余菜单出现 
		hideOptionMenu(shareData);
		resetPic(); 
		ImgListMouseDownEvent();
		SortListMouseDownEvent();		
		$(".qdOver").on("click",function(){
			submitSignInfo();
		});
	});

	var index=6;
	var tarr=[0,1,2,3,4,5];
	function y(){
		var temp;
		var tempIndex;
		for(var i=4;i>0;i--){
			tempIndex = Math.floor(Math.random()*i);
			temp=tarr[i+1];
			tarr[i+1]=tarr[tempIndex];
			tarr[tempIndex]=temp;
		}
	}
	
	function resetPic(){
		$(".sortList").html("");
		y();
		for(var i=0; i<index; i++){
			$(".sortList").append("<li ><div class='sortListBg  Bg"+tarr[i]+ "' id='picZ"+tarr[i]+ "'></div></li><input type='hidden' id='"+tarr[i]+"'/>");//<input type='hidden' id='"+tarr[i]+"'/>
		}
	}

	//注册鼠标在图片上的事件(按下事件和单击事件)
	function ImgListMouseDownEvent() {
		
		$(".imgList > li").unbind("mousedown").unbind("click");//为图片绑定(注册)鼠标按下事件和鼠标单击事件
		$(".imgList > li[allow]").mousedown(function (event) {

			$(document.body).data("_eventx_", event.pageX); //鼠标在图片上按下事件时鼠标的x坐标值
			$(document.body).data("_eventy_", event.pageY); //鼠标在图片上按下事件时鼠标的y坐标值
			$(document.body).data("_li_", $(this)); //鼠标在图片上按下事件时当前的li元素

			$(document.body).data("_imgtop_", (event.pageY - $(this).offset().top) * 0.26);
			$(document.body).data("_imgleft_", (event.pageX - $(this).offset().left) * 0.38);

	
		}).click(function (event) {
			$(".imgList > li").unbind("mousedown").unbind("click");//为图片绑定(注册)鼠标按下事件和鼠标单击事件
			$(".sortList > li").unbind("mousedown").unbind("click");//为已选图片绑定(注册)鼠标按下事件和鼠标单击事件

			var _this_ = $(this);//鼠标在图片上单击事件时当前的li元素
			var _img_ = $("img", _this_);//鼠标在图片上单击事件时当前的图片元素
			var _div_ = $("div", _this_);//鼠标在图片上单击事件时当前的div元素


			var targetLi; //定义目标
			
// 			alert(targetLi);
			//循环目标的li元素
			$(".sortList > li").each(function (i, e) {
				if ($("img", $(this)).length == 0 && (!$(this).attr("allow") || $(this).attr("allow") == false)) {
					targetLi = $(this); //目标为符合条件的当前li元素
					return false;
				}
			});
			
			//alert($("div",targetLi).attr("class")); 
			if (targetLi) { //目标li存在
				var targetLeft = targetLi.offset().left;
				var targetTop = targetLi.offset().top;

				_this_.removeAttr("allow").addClass("image_shadow"); //排序前的当前li元素移除allow属性 添加样式：image_shadow
				targetLi.attr("allow", true);//排序后的目标元素添加属性allow为true

				var _dropDivID_ = "_divDrop_" + _this_.attr("id").replace("_s_", ""); //动画层id

				$("<div class='DropDiv' style='display:none;' id='" + _dropDivID_ + "'><img src='"+_img_.attr("src")+"'/> </div>").appendTo($(document.body)); //创建动画层
				$("#" + _dropDivID_).html(_div_.html())
				   .css({ top: event.pageY - (event.pageY - $(this).offset().top) * 0.26, left: event.pageX - (event.pageX - $(this).offset().left) * 0.38 })
				   .height(74)
				   .width(74)
				   .fadeIn(100, function () {

					   $(this).animate({ top: targetTop - 2, left: targetLeft + 2 }, 500, "linear", function () {

						   $(this).fadeOut(100, function () {

							   $(this).remove();

							   //生成图片和文字 
							   targetLi.empty()
								   .html("<img width=74 height=74 style='display:none;' src=" + _img_.attr("src") + " />")
								   .removeAttr("id")
								   .attr("id", "_s_" + _this_.attr("id").replace("_s_", ""));
								   	var yid=_this_.attr("id").replace("num", "");//这个是移动过来的id
								   	var mid=$("#"+"_s_"+_this_.attr("id")).next().attr("id");//这个是目标放置的id
									$("img", targetLi).show();//图片效果
									if(yid==mid){
										
										$("img", targetLi).attr("class","img_ok");
					
									}else{
										
										$("img", targetLi).attr("class","image_no");

									}
									
								

						   });
					   });
				   });
				ImgListMouseDownEvent();//重新注册鼠标在图片上的事件(按下事件和单击事件)
				SortListMouseDownEvent();//重新注册鼠标在排序后图片上的事件(按下事件和单击事件)
			}

		})
	}

	//注册鼠标在排序后图片上的事件(按下事件和单击事件)
	function SortListMouseDownEvent() {
		$(".sortList li").unbind("mousedown").unbind("click").unbind("mouseout");
		$(".sortList li[allow=true]").mousedown(function (event) {

	
			$(document.body).data("_eventx_", event.pageX);
			$(document.body).data("_eventy_", event.pageY);
			$(document.body).data("_li_", $(this));
	
			$(document.body).data("_imgtop_", (event.pageY - $(this).offset().top));
			$(document.body).data("_imgleft_", (event.pageX - $(this).offset().left));

		}).click(function (event) {

			//debugger;
			$(".imgList > li").unbind("mousedown").unbind("click");
			$(".sortList li").unbind("mousedown").unbind("click");

			var _this_ = $(this);//鼠标在排序后图片上单击事件时当前的li元素
			var _img_ = $("img", _this_);//鼠标在排序后图片上单击事件时当前的图片元素
			var _div_ = $("div", _this_);//鼠标在排序后图片上单击事件时当前的div元素
			var _li_ = $("li", _this_);//鼠标在排序后图片上单击事件时当前的div元素 

			var targetLi = $("#" + _this_.attr("id").replace("_s_", ""));//得到目标元素（为鼠标在排序前图片上单击事件时当初的li元素）
			
			var classNextId=$("#" + _this_.attr("id")).next().attr("id");//获取目标元素后第一个兄弟节点id 
			var classPrevId=$("#" + _this_.attr("id")).prev().attr("id");//获取目标元素前第一个兄弟节点id  

			var _dropDivID_ = "_divDrop_" + _this_.attr("id").replace("_s_", ""); //动画层id
	
			$("<div class='DropDiv' style='display:none;' id='" + _dropDivID_ + "'><img src='"+_img_.attr("src")+"'/> </div>").appendTo($(document.body));//创建动画层

			targetLi.attr("allow", true);//排序前的原元素添加属性allow为true
			_this_.removeAttr("allow");//排序后的当前li元素移除allow属性 
		
			$("#" + _dropDivID_).html(_div_.html())
							.css({ top: _this_.offset().top - 2, left: _this_.offset().left + 2 })
							.height(74)
							.width(74)
							.fadeIn(100, function () {
								$(this).animate({ top: targetLi.offset().top + (targetLi.height() * 0.5) / 2, left: targetLi.offset().left + (targetLi.width() * 0.5) / 2 }, 500, "linear", function () {

									$(this).remove();

									_this_.empty().removeAttr("id");

									targetLi.removeClass("image_shadow");

									addNoImgLiCss(classNextId); //添加无图片样式 addNoImgLiCss 
									

								});

							});

			ImgListMouseDownEvent();//重新注册鼠标在图片上的事件(按下事件和单击事件)
			SortListMouseDownEvent();//重新注册鼠标在排序后图片上的事件(按下事件和单击事件)

		});
	}

	//#region 添加无图片样式 addNoImgLiCss
	function addNoImgLiCss(classId) {

		var _dli_=$("#" + classId).prev();
		_dli_.html("");
		_dli_.html("<div class='sortListBg Bg" + classId + "'></div>");
	}
	//#endregion

	//判断位置是否全部对应
	function submitSignInfo(){
			var xi=0;
			$('img', $(".sortList")).each(function () {
				if($(this).attr("class")=="img_ok"){
					xi++;
				}
			});
		if(xi==index){
			signIn();
		}else{
			showAlert("请按照正确顺序签到！");
		}
	}
	
	var uId = ${SESSIONUSER.userid};
	function signIn(){
		$.ajax({
			url : '/wxService/user/signInByDay',
			type : 'get',
			data : {userId : uId},
			success : function(data) {
				var json = eval('(' + data + ')');
				if(json.error == "0"){
					showAlert("签到成功!");
					setTimeout("window.location.href='/wxService/user/toMain'",2000);
				}
			}
		});
		
		
	}



</script>
</body>
</html>
