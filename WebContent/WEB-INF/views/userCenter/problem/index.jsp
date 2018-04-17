<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="../../common/dialog.jsp" flush="true" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>完善资料</title>
<link href="<c:url value='/resources/css/web/userProblem.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/js/excessive/css/default.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/js/excessive/css/animations.css'/>" />
<!-- 自定义控件样式 -->
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/js/excessive/css/component.css'/>" />
<script type="text/javascript"	src="<c:url value='/resources/js/excessive/modernizr.custom.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
 <script type="text/javascript">
var SITE_BASE_PATH = '<c:url value="/"/>';
var baseUrl='${baseUrl}';
var uid='${userId}';//从session获取

var logFlg = 0;
var currentAll = 0, pagesCountAll = 0;

</script>
<script type="text/javascript">

</script>
		<!--重新页面滑动组件代码(添加事件左右滑动效果) <div >
			<button id="nextPage"  page="5" class="pt-touch-button">下一页</button>
			<button id="lastPage"  page="6" class="pt-touch-button">前一页</button>
		</div> -->
<body>
	 <div class="headerContent">
       <ul>
          
          <li class="headerFont">回答问题即可获得金币</li>
          
          <input type="hidden" id="pageCode" value="" />
       </ul>  
    </div>	
		<div id="pt-main" class="pt-perspective">
			<c:forEach items="${codes}"  var="i"  varStatus="vstatus" >
			<div  class="pt-page pt-page-${vstatus.index}">
				<p class="Percent">${i.disIndex }</p>
			    <div id='${i.code}'  class="content">
			    </div>
			 </div> 
			 </c:forEach>
			<div id="special" class="pt-page pt-page-${fn:length(codes)}">
				<p class="Percent">${fn:length(codes)+1}/${fn:length(codes)+1}</p>
			    <div class="content">
					<p class="nameFont">请选择所在地</p>
					<select class="select" id="s" onchange="tab(this);"></select><br/><br/>
				   	<select class="select" id="q"></select>			    	
			    </div>
			 </div> 			   
			<!-- <div class="pt-page pt-page-3">3</div>
			<div class="pt-page pt-page-4">4</div>
			<div class="pt-page pt-page-5">5</div>
			<div class="pt-page pt-page-6">6</div> -->
			<!-- <div class="tjbutton"><input onclick="marry()" type="button"  value="提交"></div> -->
	</div>
    <div class="bottom">
	    <ul>
			<li class="headerimg" id="lastPage"  page="58">
		          	
		          	<a class="leftPage">上一题</a>
		     </li>
		     <li class="headerRight" id="nextPage"  page="59">
		          	
		          	<a class="rightPage">下一题</a>
		     </li>
		      <li class="headerRight" id="finalPage" style="display:none;">
		          	<a class="rightPage"  href="javascript:marry(1);">提交</a>
		      </li>
	     </ul>
     </div>
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript"	src="<c:url value='/resources/js/excessive/jquery.dlmenu.js'/>"></script>


<script type="text/javascript">
function marry(){
	
	showDialog("请确认填写的资料真实性之后提交!","","取消","javascript:work()","确定");
	
	
}
function work(){
	submitPrototype($("#pageCode").val());
}
var quesId ;
var parentId;
var shareData = {			
		requrl:"<c:url value='/share/sharePrepare'></c:url>",
		param:location.href
};	
$(function() {
	//个人中心不允许有多余菜单出现 
	hideOptionMenu(shareData);
	var first=$(".content")[0];
	var firstCode=$(first).attr("id");
	$("#pageCode").val(firstCode);
	inde(firstCode,false,null);
});

function savePrototype(pageCode)
{
   var imgs=$("#"+pageCode).find("img");
   var jsonArray=new Array();
   var jsonObject;
   
   //img
   for(var i=0;i<imgs.length;i++)
   {
	   jsonObject=new Object();
	   jsonObject.uid=uid;
	   jsonObject.code=$("#pageCode").val();
	  	var src=$(imgs[i]).attr("src");
	  	if(src.indexOf("11")!=-1)
	  	{
	  		jsonObject.did=$(imgs[i]).attr("tid");
	  		if($(imgs[i]).attr("ppid") == '0')
	  		{
	  			jsonObject.level = '1';
				jsonObject.parent_id =$(imgs[i]).attr("pid");
	  		}
	  		else
	  		{
	  			jsonObject.level = '2';
	  		}
			jsonArray.push(jsonObject);
	  	}
   }
	
    var selects=$("#"+pageCode).find("option:selected");
	for(var i=0;i<selects.length;i++)
	{
		jsonObject=new Object();
		jsonObject.uid=uid;
		jsonObject.code=$("#pageCode").val();
		jsonObject.did=$(selects[i]).attr("tid");
		if($(selects[i]).attr("ppid") == '0')
  		{
  			jsonObject.level = '1';
  			jsonObject.parent_id =$(selects[i]).attr("pid");
  		}
  		else
  		{
  			jsonObject.level = '2';
  		}
		jsonArray.push(jsonObject);
	}
	
	var selects=$("#"+pageCode).find(".noBotton");
	for(var i=0;i<selects.length;i++)
	{
		jsonObject=new Object();
		jsonObject.uid=uid;
		jsonObject.code=$("#pageCode").val();
		jsonObject.did=$(selects[i]).attr("tid");
		
		if($(selects[i]).attr("ppid") == '0')
  		{
  			jsonObject.level = '1';
  			jsonObject.parent_id =$(selects[i]).attr("pid");
  		}
  		else
  		{
  			jsonObject.level = '2';
  		}
		jsonArray.push(jsonObject);
	}

	
	var isLast = 0 ;
	//if(currentAll == pagesCountAll-1 && pagesCountAll > 0)
	//{
	//	isLast = 1;
	//}
	
	
	//执行jquery跨域添加操作
	$.ajax({
		url : baseUrl+'/noUserPrototype/addUserPrototype?userId='+uid+'&code='+$("#pageCode").val()+'&isLast='+isLast+'&logFlg='+logFlg,
		type : 'GET',
		dataType : 'jsonp',
		jsonp : "callback",
      	beforeSend:function(){
      		layer.open({
      		    type: 2,
      		    content: '正在提交数据...'
      		});
		},
		data:{paramdata:JSON.stringify(jsonArray)},
		success : function(data) {
			layer.closeAll();
			if(1==data)
			{
							
				//layer.open({
				//    content: '提交成功!',
				//    style: 'background-color:#000000;color:#fff; border:none;',
				//   time: 1
				//});
				
				//if(currentAll == pagesCountAll && pagesCountAll > 0){				
				//	logFlg = 1;
				//}
				
				//window.location.href='<c:url value="/user/toMain"/>';				
			}
		},
		error : function() {
			layer.closeAll();
			layer.open({
			    content: '跨域请求失败!',
			    style: 'background-color:#000000;color:#fff; border:none;',
			    time: 1
			});
		}
	});
}

function submitPrototype(pageCode)
{
   var imgs=$("#"+pageCode).find("img");
   var jsonArray=new Array();
   var jsonObject;
   
   //img
   for(var i=0;i<imgs.length;i++)
   {
	   jsonObject=new Object();
	   jsonObject.uid=uid;
	   jsonObject.code=$("#pageCode").val();
	  	var src=$(imgs[i]).attr("src");
	  	if(src.indexOf("11")!=-1)
	  	{
	  		jsonObject.did=$(imgs[i]).attr("tid");
	  		if($(imgs[i]).attr("ppid") == '0')
	  		{
	  			jsonObject.level = '1';
				jsonObject.parent_id = $(imgs[i]).attr("pid");
	  		}
	  		else
	  		{
	  			jsonObject.level = '2';
	  		}
			jsonArray.push(jsonObject);
	  	}
   }
	
    var selects=$("#"+pageCode).find("option:selected");
	for(var i=0;i<selects.length;i++)
	{
		jsonObject=new Object();
		jsonObject.uid=uid;
		jsonObject.code=$("#pageCode").val();
		jsonObject.did=$(selects[i]).attr("tid");
		if($(selects[i]).attr("pid") == '0')
  		{
  			jsonObject.level = '1';
			jsonObject.parent_id = parentId;
  		}
  		else
  		{
  			jsonObject.level = '2';
  		}
		jsonArray.push(jsonObject);
	}
	
	var selects=$("#"+pageCode).find(".noBotton");
	for(var i=0;i<selects.length;i++)
	{
		jsonObject=new Object();
		jsonObject.uid=uid;
		jsonObject.code=$("#pageCode").val();
		jsonObject.did=$(selects[i]).attr("tid");
		
		if($(selects[i]).attr("pid") == '0')
  		{
  			jsonObject.level = '1';
			jsonObject.parent_id = parentId;
  		}
  		else
  		{
  			jsonObject.level = '2';
  		}
		jsonArray.push(jsonObject);
	}
	
	var isLast = 0 ;
	if(currentAll == pagesCountAll-1 && pagesCountAll > 0)
	{
		isLast = 1;
	}
	var area1={};
	if(isLast=1){
		area1={"city_id":$("#q").val(),"provin_id":$("#s").val(),"uid":uid};
	}
	
	//执行jquery跨域添加操作
	$.ajax({
		url : baseUrl+'/noUserPrototype/addUserPrototype?userId='+uid+'&code='+$("#pageCode").val()+'&isLast='+isLast+'&logFlg='+logFlg,
		type : 'GET',
		dataType : 'jsonp',
		jsonp : "callback",
      	beforeSend:function(){
      		layer.open({
      		    type: 2,
      		    content: '正在提交数据...'
      		});
		},
		data:{paramdata:JSON.stringify(jsonArray),userArea:JSON.stringify(area1)},
		success : function(data) {
			layer.closeAll();
			if(1==data)
			{
				//layer.open({
				//    content: '提交成功!',
				//    style: 'background-color:#000000;color:#fff; border:none;',
				//   time: 1
				//});
				
				if(currentAll == pagesCountAll-1 && pagesCountAll > 0){				
					logFlg = 1;
					
					//layer.open({
					//   content: '提交成功!',
					//   style: 'background-color:#000000;color:#fff; border:none;',
					//   	time: 1
					//});
					
				    //window.location.href='<c:url value="/user/toMain"/>';	
				    showDialog("完善资料成功,已获得10个金币奖励！","<c:url value='/index/toIndex'/>","首页","<c:url value='/user/toMain'/>","个人中心");
				    			
				}
				
			}
		},
		error : function() {
			layer.closeAll();
			layer.open({
			    content: '跨域请求失败!',
			    style: 'background-color:#000000;color:#fff; border:none;',
			    time: 1
			});
		}
	});
}

</script>
<script type="text/javascript">
	var ps;
	$(document).ready(function(){
		$.getJSON("<c:url value='/resources/city.js'/>",function(data){
			ps=data;
			var html=[];
			for(var i in data){
				html.push("<option value="+data[i].proid+">"+data[i].proname+"</option>");
			}
			$("#s").html(html.join(''));
			
			var cs=ps[0].citys;
			html=[];
			for(var j in cs){
				html.push("<option value="+cs[j].cityid+">"+cs[j].cityname+"</option>");
			}
			$("#q").html(html.join(''));
		});
	});
	function tab(obj){
		for(var i in ps){
			if(ps[i].proid==$(obj).val()){
				var cs=ps[i].citys;
				var html=[];
				for(var j in cs){
					html.push("<option value="+cs[j].cityid+">"+cs[j].cityname+"</option>");
				}
				$("#q").html(html.join(''));
				break;
			}
		}
	}
</script>
<script type="text/javascript"	src="<c:url value='/resources/js/excessive/pagetransitions.js'/>"></script>	
</body>
</html>
