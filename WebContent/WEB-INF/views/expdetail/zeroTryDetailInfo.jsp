<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>试用问题申请</title>
<link href="<c:url value='/resources/css/web/myInformation.css'/>"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript">
	$(function() {
		$("#demo").click(function(){ 
			assembleUserPrototype();
		});
		
		$.ajax({
			url : '<c:url value="/experience/findExpTryDoubt"/>',
			type : 'post',
			data:{"expId":"${expId}"},
			dataType:"json",
			success : function(data) {
		 		layer.open({
	      		    type: 2,
	      		    content: '数据正在加载中...'
	      		});
				var html="<ul>";

				for(var i=0;i<data.result.length;i++){
					
					var options=data.result[i].options;
					if(data.result[i].dictionary_type == 1){
						html+='<li>';
						html+='<span class="s3">'+data.result[i].dictionary_name+'</span>';
						html+='<span class="s4 s5"><span>';
						for(var j=0;j<options.length;j++){
						 		var val=options[j];
						 		html+='<span class="woman">';
					
						 			html+='	<input pid='+val.parentId+' tid='+val.dictionary_id+' type="text" onclick="checkRadio(this)" name='+data.result[i].dictionary_id+' value='+val.dictionary_value+'/></span>';
						
								html+='	<span>'+val.dictionary_name+'</span>';
						 	}
						html+='</span>';
						html+='</li>';

					}else if(data.result[i].dictionary_type == 2){
					
						html+='<li>';
						html+='<span class="s3">'+data.result[i].dictionary_name+'</span>';
						html+='<span class="s4 s5"><span>';
						for(var j=0;j<options.length;j++){			
						 		var val=options[j];
						 		html+='<span class="woman">';
						 		if("1"==val.selected){
						 			html+='	<input pid='+val.parentId+' tid='+val.dictionary_id+' type="radio" onclick="checkRadio(this)" name='+data.result[i].dictionary_id+' value='+val.dictionary_value+' class="radioStyle chooseRadio"/></span>';
						 		}else{
						 			html+='	<input pid='+val.parentId+' tid='+val.dictionary_id+' type="radio" onclick="checkRadio(this)" name='+data.result[i].dictionary_id+' value='+val.dictionary_value+' class="radioStyle"/></span>';
						 		}
								html+='	<span>'+val.dictionary_name+'</span>';
						 	}
						html+='</span>';
						html+='</li>';
					
					}else if(data.result[i].dictionary_type == 3){
						
						
						html+='<li>';
						html+='<span class="s3">'+data.result[i].dictionary_name+'</span>';
						html+='<span class="s4">';
				 		html+='<select	class="xfBox" name='+data.result[i].dictionary_id+'>';

						for(var j=0;j<options.length;j++){							
						 		var val=options[j];
								if("1"==val.selected){
									html+='<option selected=selected  pid='+val.parentId+' tid='+val.dictionary_id+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
								}else{
									html+='<option  pid='+val.parentId+' tid='+val.dictionary_id+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
								}
						 		
						
						 	}
				 		html+='</select>';
						html+='</span>';
						html+='</li>';

						
					}
					
				}		

				html+="</ul>"
				$("#tjForm").append(html);
				layer.closeAll();
			},
			error : function() {
				layer.closeAll();
				layer.open({
				    content: '请求失败!',
				    style: 'background-color:#09C1FF; color:#fff; border:none;',
				    time: 1
				});
			}
		});
	});
	
	function involvedExp(){
		$.ajax({
			type:"post",
			url:"<c:url value='/expVolved/involVedTry'/>",
			data:{"detailId":"${detailId}","memberId":"${memberId}","expId":"${expId}"},
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
					
					alert("活动参与成功！！！！请晒给你的好伙伴！！");	
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

</script>

<script type="text/javascript">
	function checkRadio(obj){
		var name=$(obj).attr("name");
		$("input[name='"+name+"']").removeClass("chooseRadio");
		$(obj).addClass("chooseRadio");
	}
</script>
<script type="text/javascript">
	function assembleUserPrototype(){
		var jsonArray=new Array();
		var jsonObject;
		var expId=$("#expId").val();
		//获取select元素选中值 
		var selects=$("#tjForm").find("option:selected");
		for(var i=0;i<selects.length;i++){
			jsonObject=new Object();
			jsonObject.did=$(selects[i]).attr("tid");
			jsonObject.pid=$(selects[i]).attr("pid");
			jsonObject.expid=expId;
			jsonObject.moduletype=2;
			jsonObject.value='';
			jsonArray.push(jsonObject);
		}
		//获取radios的单选按钮选中值
		var radios=$("#tjForm").find(".chooseRadio");
		for(var i=0;i<radios.length;i++){
			jsonObject=new Object();
			jsonObject.did=$(radios[i]).attr("tid");
			jsonObject.pid=$(radios[i]).attr("pid");
			jsonObject.expid=expId;
			jsonObject.moduletype=2;
			jsonObject.value='';
			jsonArray.push(jsonObject);
		}
		var inputs=$("#tjForm").find("input[type='text']");
		$(inputs).each(function(i,val){
			jsonObject=new Object();
			jsonObject.did=$(val).attr("tid");
			jsonObject.pid=$(val).attr("pid");
			jsonObject.value=$(val).val();
			jsonObject.expid=expId;
			jsonObject.moduletype=2;
			jsonArray.push(jsonObject);
	
		});

		$.ajax({
			url : '<c:url value="/expVolved/involVedTryaddInfo"/>', 
			type : 'post',
			dataType : 'json',
			data:{"paramdata":JSON.stringify(jsonArray),"expId":"${expId}"},
			success : function(data) {
				layer.open({
	      		    type: 2,
	      		    content: '正在提交数据...'
	      		});			
				if(1==data){ 
					layer.open({
					    content: '操作成功!',
					    style: 'background-color:#09C1FF; color:#fff; border:none;',
					    time: 1
					});
				}
				layer.closeAll();
			},
			error : function() {
				layer.closeAll();
				layer.open({
				    content: '请求失败!',
				    style: 'background-color:#09C1FF; color:#fff; border:none;',
				    time: 1
				});
			}
		});
	}
</script>
</head>

<body>
	<input type="hidden" value="${expId }"  id="expId"/>
	<div class="headerContent">
		<ul>
			<li class="headerimg"><img
				src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li>
			<li class="headerFont">回问题享试用</li>
		</ul>
	</div>

	<div class="tjForm" id="tjForm"></div>


	<input id="demo" type="button" value="提交参与" />
</body>

</html>
