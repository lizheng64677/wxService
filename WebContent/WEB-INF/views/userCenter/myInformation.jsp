<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的资料</title>
<link href="<c:url value='/resources/css/web/myInformation.css'/>" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script src="<c:url value='/resources/js/pull/fastclick.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
<style type="text/css">
#s , #q{
	width: 87%;;
    border: 1px solid #dddddd;
    line-height: 35px;
    height: 35px;
    color: #707070;
    -webkit-appearance: button;
    border-radius: 20px;
    outline: none;
    padding-left: 5px;
    cursor: pointer;
    margin-left: 20px;
    margin-right: 20px;
    }
</style>
<script type="text/javascript">
var sArr = new Array();
var qArr = new Array();
var citys ; 
var updateFlg ;
var dataAll;
var shareData = {			
 			requrl:"<c:url value='/share/sharePrepare'></c:url>",
 			param:location.href
};		
	$(function() {
		//个人中心不允许有多余菜单出现 
		hideOptionMenu(shareData);
		var title = '${version}';
		if(title != "no"){
			$(".headerContent").hide();
		}
		
		$.ajax({
			url : '${baseUrl}/noUserPrototype/findUserPrototype?userId=${userId}',
			type : 'GET',
			dataType : 'jsonp',
			jsonp : "callback",
	      	beforeSend:function(){
	      		layer.open({
	      		    type: 2,
	      		    content: '数据正在加载中...'
	      		});
			},
			success : function(data) {
				layer.closeAll();
				var html="<ul>";

				dataAll = data;
				for(var i=0;i<data.length;i++){
					var options=data[i].options;
	
					if(data[i].dictionary_type == 1){
						

					}else if(data[i].dictionary_type == 2){
					
						html+='<li>';
						html+='<span class="s3">'+data[i].dictionary_name+'</span>';
						html+='<span class="s4 s5"><span>';
						
						for(var j=0;j<options.length;j++)
						{							
						 		var val=options[j];
						 		html+='<span class="woman">';
						 		
						 		if("1"==val.selected)
						 		{
						 			html+='	<input proid="'+val.prototype_id+'"  tid='+val.dictionary_id+' type="radio" onclick="checkRadio(this,\''+data[i].dictionary_code+'\')" name='+data[i].dictionary_id+' value='+val.dictionary_value+' class="radioStyle chooseRadio"/></span>';
						 		}
						 		else
						 		{
						 			html+='	<input tid='+val.dictionary_id+' type="radio" onclick="checkRadio(this,\''+data[i].dictionary_code+'\')" name='+data[i].dictionary_id+' value='+val.dictionary_value+' class="radioStyle"/></span>';
						 		}
								html+='	<span>'+val.dictionary_name+'</span>';
						 	}
						html+='</span>';
						html+='</li>';
					
					}else if(data[i].dictionary_type == 6){
						
						
						html+='<li>';
						html+='<span class="s3">'+data[i].dictionary_name+'</span>';
						html+='<span class="s4">';
				 		html+='<select	onchange="selChang(this);" class="xfBox" name='+data[i].dictionary_id+'>';

						for(var j=0;j<options.length;j++)
						{							
						 		var val=options[j];
								if("1"==val.selected)
								{
									html+='<option proid="'+val.prototype_id+'"  selected=selected tid='+val.dictionary_id+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
								}
								else
								{
									html+='<option tid='+val.dictionary_id+' value='+val.dictionary_value+'>'+val.dictionary_name+'</option>';
								}
						 	}
				 		html+='</select>';
						html+='</span>';
						html+='</li>';

						
					}
					
				}		

				html+="</ul>"
				$("#tjForm").append(html);
				
				updateFlg = '${updateFlg}';
				if(updateFlg == '0')
				{
					showMsg();
				}
				
			},
			error : function() {
				layer.closeAll();
				layer.open({
				    content: '跨域请求失败!',
				    style: 'background-color:#09C1FF; color:#fff; border:none;',
				    time: 1
				});
			}
		});
		
		var userObj = ${userCitys};
		
		if(userObj != null &&userObj.head_image_url != undefined && userObj.head_image_url != ''&& userObj.head_image_url != null)
		{
			$("#headImg").attr('src',userObj.head_image_url);
		}
		else
		{
			$("#headImg").attr('src',"/wxService/resources/images/web/tx.png");
		}
		
		
		citys = ${citys};
		for(var a=0;a<citys.length;a++)
		{
			if(citys[a].upid == 0)
				sArr.push(citys[a]);
			else 
				qArr.push(citys[a]);
		}
		//省
		var htmlStr = ""; var firstId;
		for(var b=0;b<sArr.length;b++)
		{
			if(b == 0){firstId=sArr[b].id;}
			htmlStr += "<option value="+sArr[b].id+">"+sArr[b].name+"</option>";
		}
		$("#s").html(htmlStr);
		//设置用户地区默认值
		<c:if test="${userCitys != null}">
			var userCitys = ${userCitys};
			if(userCitys != null && userCitys.provin_id != null && userCitys.city_id != null)
			{
				$("#s option[value='"+userCitys.provin_id+"']").attr("selected", "selected");
				setCityOption(userCitys.provin_id);
				$("#q option[value='"+userCitys.city_id+"']").attr("selected", "selected");
			}
			else
			{
				setCityOption(firstId);
			}
		</c:if>
		<c:if test="${userCitys == null}">
			setCityOption(firstId);
		</c:if>
		
	});
	
	function setProvinOption(objid)
	{
		for(var a=0;a<citys.length;a++)
		{
			if(citys[a].upid == objid)
				qArr.push(citys[a]);
		}
	}
	
	function setCityOption(objId)
	{
		var htmlStr ="";
		for(var c=0;c<qArr.length;c++)
		{
			if(qArr[c].upid == objId)
			{
				htmlStr +=  "<option value="+qArr[c].id+">"+qArr[c].name+"</option>";
			}
		}
		$("#q").html(htmlStr);
	}
	
	function tab(obj)
	{
		setCityOption(obj.value);
	}
	
</script>

<script type="text/javascript">
	function checkRadio(obj,code){
		
		if(code != undefined && code != '' && code == 'sex')
		{
			return;
		}
		
		var name=$(obj).attr("name");
		var proId = "";
	    $("input[name='"+name+"']").each(function(){
	    	
			   if ($(this).attr('proid') != undefined)
				   proId = $(this).attr('proid');
	    });
		$("input[name='"+name+"']").removeClass("chooseRadio");
		$(obj).addClass("chooseRadio");
		$("input[name='"+name+"']:checked").attr('proid',proId);
	}
	
	
	function selChang(obj)
	{
		var proId ;
		$(obj).find("option").each(function(){
			if ($(this).attr('proid') != undefined)
				   proId = $(this).attr('proid');
		});
		
		$(obj).find("option:selected").attr('proid',proId);
	}
</script>
<script type="text/javascript">

	function showMsg()
	{
		//layer.open({
		//    content: '每月只能修改一次用户资料!',
		//    style: 'background-color:#423F40; color:#fff; border:none;',
		//    time: 1
		//});
		showDialog("每月只能修改资料一次！","","取消","<c:url value="/user/toMain"/>","个人中心");
	}

	function assembleUserPrototype(){
		if(updateFlg == '0')
		{
			showMsg();
			return;
		}
		
		var jsonArray=new Array();
		var jsonObject;
		var uid=${userId};//从session获取
		//获取select元素选中值
		var selects=$("#tjForm").find("option:selected");
		for(var i=0;i<selects.length;i++)
		{
			jsonObject=new Object();
			jsonObject.did=$(selects[i]).attr("tid");
			jsonObject.uid=uid;
			jsonObject.prototype_id=$(selects[i]).attr("proid");
			jsonArray.push(jsonObject);
		}
		//获取radios的单选按钮选中值
		var radios=$("#tjForm").find(".chooseRadio");
		for(var i=0;i<radios.length;i++)
		{
			jsonObject=new Object();
			jsonObject.did=$(radios[i]).attr("tid");
			jsonObject.uid=uid;
			jsonObject.prototype_id=$(radios[i]).attr("proid");
			jsonArray.push(jsonObject);
		}
		
		var areaObj = new Object();
		areaObj.provin_id = $("#s").val();
		areaObj.city_id = $("#q").val();
		areaObj.uid = uid;
		//执行jquery跨域添加操作
		$.ajax({
			url : '${baseUrl}/noUserPrototype/addUserPrototype?code=userPrototype&logFlg=1&userId='+uid+'&upFlag=1',
			type : 'GET',
			dataType : 'jsonp',
			jsonp : "callback",
	      	beforeSend:function(){
	      		layer.open({
	      		    type: 2,
	      		    content: '正在提交数据...'
	      		});
			},
			data:{paramdata:JSON.stringify(jsonArray),userArea:JSON.stringify(areaObj)},
			success : function(data) {
				layer.closeAll();
				if(1==data)
				{
					//layer.open({
					//    content: '提交成功!',
					//    style: 'background-color:#423F40; color:#fff; border:none;',
					//    time: 1
					//});
					//window.location.href='<c:url value="/user/toMain"/>';
					showDialog("修改资料成功！","","取消","<c:url value="/user/toMain"/>","个人中心");
				}
				else if(-1 == data)
				{
					//layer.open({
					//    content: '每月只能修改资料一次!',
					//    style: 'background-color:#423F40; color:#fff; border:none;',
					//   time: 1
					//});
					showDialog("每月只能修改资料一次！","","取消","<c:url value="/user/toMain"/>","个人中心");
				}
			},
			error : function() {
				layer.closeAll();
				layer.open({
				    content: '跨域请求失败!',
				    style: 'background-color:#423F40; color:#fff; border:none;',
				    time: 1
				});
			}
		});
	}
</script>
</head>

<body>
	<!-- <div class="headerContent">
		<ul>
			<a href="javascript:history.go(-1);"><li class="headerimg">
			<img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li></a>
			<li class="headerFont">我的资料</li>
		</ul>
	</div> -->
	<div class="txMainBox">
		<p>
			<img src="" id="headImg">
			<%--<input name="" id=""	class="scBox" type="file"/>--%>
		</p>
		<%-- <div class="pic">
			<img src="<c:url value='/resources/images/web/xiangji.png'/>"	width="25" />
		</div> --%>
	</div>
	
	<div class="tjForm" id="tjForm">

	</div>
	
	<p class="nameFont">请选择所在地</p>
	<select class="select" id="s" onchange="tab(this);"></select><br/><br/>

   	<select class="select" id="q"></select>
	
	
		<div class="qrxg">
			<img src="<c:url value='/resources/images/web/tishi.png'/>"
				width="20" /><span>本信息只允许每月修改一次</span>
		</div>
		<div class="tjbutton"><input id="subButton" onclick="assembleUserPrototype()" type="button"  value="提交"></div>
</body>

</html>
