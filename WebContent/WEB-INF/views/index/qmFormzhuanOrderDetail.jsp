<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>任务详情</title>
<link href="<c:url value='/resources/css/web/Task.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/qmForm.css'/>" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="tjForm" id="tjForm">
</div>
 <div class="syqq" style="display: none;">
 	<a href="#" onclick="sumbitExpForm()" id="kkk1" >提交</a>
 </div>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".tjForm").on("click","input[type='radio']",function(){
		$("input[type='radio']").removeClass("chooseRadio");
		$("input[type='radio']:checked").addClass("chooseRadio");
	});
	
	//加载问题
	post("/index/getqmFormOrderDetail",{expId:'${expId}'},true,'加载中')
	.then(function(d){
		var data=d.data;
		layer.closeAll();
		var html="<ul>";
		for(var i=0;i<data.length;i++){
			var options=data[i].children;
			if(data[i].dictionary_type == 1){
				html+='<li>';
				html+='<span class="s3">'+data[i].dictionary_name+'</span>';
				html+='<span class="inputs"><input type="text" class="surveytel" did='+data[i].did+'  pdid='+data[i].pdid+'   /></span>';
				html+='</li>';
			}else if(data[i].dictionary_type == 2){
				html+='<li>';
				html+='<span class="s3">'+data[i].dictionary_name+'</span>';
				html+='<span class="s4 s5"><span>';
				for(var j=0;j<options.length;j++){							
				 		var val=options[j];
				 		html+='<span class="woman">';
				 		html+='	<input tid='+val.did+' type="radio"  did='+options[j].did+'  pdid='+options[j].pdid+'  name='+data[i].did+' value='+val.dictionary_value+' class="radioStyle"/></span>';
						html+='	<span>'+val.dictionary_name+'</span>';
				 	}
				html+='</span>';
				html+='</li>';
			
			}else if(data[i].dictionary_type==3){
				html+='<li>';
				html+='<span class="s3">'+data[i].dictionary_name+'</span>';
				html+='<span class="s4">';
				for(var j=0;j<options.length;j++){							
			 		var val=options[j];
			 		html+='<span>';
			 			html+='	<input tid='+val.did+' type="checkbox"  did='+options[j].did+'  pdid='+options[j].pdid+'  name='+data[i].did+' value='+val.dictionary_value+' class="checkboxStyle"/></span>';
					html+='	<span>'+val.dictionary_name+'</span>';
			 	}				
				html+='</span>';
				html+='</li>';
			}else if(data[i].dictionary_type == 6){
				html+='<li>';
				html+='<span class="s3">'+data[i].dictionary_name+'</span>';
				html+='<span class="s4">';
		 		html+='<select	class="xfBox" name='+data[i].did+'>';

				for(var j=0;j<options.length;j++){							
				 		var val=options[j];
						if("1"==val.selected){
							html+='<option  did='+options[j].did+'  pdid='+options[j].pdid+'   selected=selected tid='+val.did+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
						}else{
							html+='<option  did='+options[j].did+'  pdid='+options[j].pdid+'   tid='+val.did+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
						}
				 	}
		 		html+='</select>';
				html+='</span>';
				html+='</li>';
			}
		}		
		html+="</ul>";
		$("#tjForm").append(html);
		
		//加载好问题之后加载答案
		return post('/sen/getExpFormAnswer',{expId:'${expId}',orderId:'${orderId}',openid:'${SESSION_OPEN_ID}'},false);
	})
	.then(function(d){
		if(d&&d.data&&d.data.length==0){
			$(".syqq").show();
			return;
		}
		var data=d.data;
		var fuck;
		//如果有答案的话，把答案弄上去
		for(var i=0;i<data.length;i++){
			fuck=data[i];
			if(fuck.dictionary_type==1){ //text
				$("[did="+fuck.dictionary_id+"]").val(fuck.text_value);
			}else if(fuck.dictionary_type==2){ //radio
				$("[did="+fuck.dictionary_id+"]").prop("checked","checked");
				$("[did="+fuck.dictionary_id+"]").addClass("chooseRadio");
			}else if(fuck.dictionary_type==3){  //checkbox
				$("[did="+fuck.dictionary_id+"]").prop("checked","checked");
			}else if(fuck.dictionary_type==6){  //select
				$("[did="+fuck.dictionary_id+"]").prop("selected","selected");
			}
		}
		if(d&&d.data&&d.data.length>0){
			$("input,select").attr("disabled","disabled"); 
		}
	});
});
</script>
<script>
	var fdata=[];

	function sumbitExpForm(){
		//匹配radio，checkbox ，select
		$(":checked").each(function(index){
			var d={};
			d["did"]=$(this).attr("did");
			d["pdid"]=$(this).attr("pdid");
			d["userId"]='${SESSIONUSER.userid}';
			d["expId"]='${expId}';
			d["orderId"]='${orderId}';
			d["moduleType"]=1;
			d["textValue"]='';
			fdata.push(d);
		});	 
		
		$("input[type='text']").each(function(){
			var d={};
			d["did"]=$(this).attr("did");
			d["pdid"]=$(this).attr("pdid");
			d["userId"]='${SESSIONUSER.userid}';
			d["expId"]='${expId}';
			d["orderId"]='${orderId}';
			d["textValue"]=$(this).val();
			d["moduleType"]=1;
			fdata.push(d);
		});
		console.log(fdata);
		post("/sen/submitExpTaskFormA",{data:JSON.stringify(fdata),orderId:'${orderId}',openid:'${SESSION_OPEN_ID}'},true,'提交中')
		.then(function(data){
			if(data.message=='success'){
				window.location.reload();
			}
		}); 
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".Return").on("click",function(){
			window.history.go(-1);
		});
	});
</script>
</body>
</html>