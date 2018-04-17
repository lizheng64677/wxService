<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册</title>
<link href="<c:url value='/resources/css/web/registered.css'/>"  rel="stylesheet" type="text/css"/>
<style type="text/css">
	.hidden
	{
	display:none;
	color: red;
    font-size: 14px;
    line-height: 14px;
    height: 14px;
    text-align: center;
    }
</style>
</head>
<body>
    <!-- <header>
       <h3>注册</h3>
    </header> -->
    <div class="content">
       <ul>
           <li>请填写手机号码</li>
           <li><input class="logintel contentInput" id="userPhone" type="text" value="${number }" placeholder="手机号码" ></li>
           <li>密码</li>
           <li><input class="logintel contentInput" id="userPassword" type="password" placeholder="密码" ></li>
           <li>确认密码</li>
           <li><input class="logintel contentInput" id="repeatPassword" type="password" placeholder="确认密码"></li>
           <li>验证码</li>
           <li >
           	 <input class="logintel ss" id="code" type="text" placeholder="验证码">
          	 <span class="verification">获取验证码</span>
           </li>
       </ul>
    </div>
    <div class="div-error" style="margin-bottom:45%;margin-top: 70px;">
    	<p class="hidden empty-userPhone">*请输入手机号码</p>
    	<p class="hidden empty-userPassword">*请输入密码</p>
    	<p class="hidden empty-code">*请输入验证码 </p>
    	<p class="hidden same-userPhone">*该手机号码已被注册了 </p>
    	<p class="hidden invalid-userPhone">*手机号码格式不正确 </p>
    	<p class="hidden invalid-userPassword">*密码为字母加数字的组合，6到18位</p>
    	<p class="hidden invalid-repeatPassword">*两次输入密码不一致 </p>
    	<p class="hidden invalid-code">*验证码不正确 </p>
    	<p class="hidden invalid-code-timeout">*验证码超时了，请重新获取 </p>
    	<p class="hidden invalid-empty-code">*请先获取验证码</p>
    </div>
     <input id="openid" type="hidden" name="openid" value="${SESSION_OPEN_ID}"/>
    <div class="footer">
        <input type="button" value="立即注册">
    </div>
 <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/jquery.countDown.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/jquery.md.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/validate.js'/>"></script>
 <script type="text/javascript">
    var cw;
 	$(document).ready(function(){
 		$(".footer").on("click","input",register);
 		$(".verification").on("click",getCheckCode);
 		//这是验证码的倒数器
 		cw=$(".verification").cW({time:300});
 	});
 	function register(){
 		//$(".hidden").hide();
 		var data={userPhone:$("#userPhone").val(),
 				userPassword:$("#userPassword").val(),
 				code:$("#code").val(),
 				rePassword:$("#repeatPassword").val(),
 				openid:$("#openid").val()};
 				
 		if(invalidRegisterData(data)) return;
 		
 		post("/userlr/register",data)
 		.then(function(data){
 			if(data.message=='repeat'){

 				showAlert("该手机号码已被注册了");
 			}else if(data.message=='timeout'){

 				showAlert("验证码超时了，请重新获取");
 			}else if(data.message=='invalidcode'){

 				showAlert("验证码不正确");
 			}else if(data.message=='error'){

 				showAlert("请先获取验证码");
 			}else if(data.message=='success'){

 				showDialog("注册成功,已获得5个金币奖励！","","取消","<c:url value='/user/toMain'/>","确定"); 
 			}else{
 				
 				showAlert("发生未知错误，请联系客服");
 				layer.closeAll();
 			}
 		});
 	}
 	function getCheckCode(){
 		//$(".hidden").hide();
 		var phone=$("#userPhone").val();
 		
		if(invalidPhone(phone)) return;
		
  		$.when((function(){
 	 		var dtd = $.Deferred();
 	 		layer.open({type: 2,content: '获取中' });
 			setTimeout(dtd.resolve, 1000);
 			return dtd.promise(); 			
 		})())
 		.then(function(){
 			return post("/userlr/checkPhone",{userPhone:$("#userPhone").val()},false);
 		})
 		.then(function(data){
 			//验证手机号成功后，获取验证码
 			if(data.message!='success')
 				 post("/userlr/getCheckCode",{userPhone:$("#userPhone").val()},false).then(function(data){
 					if(data.message=='success'){
 		 				//倒数开始了 
 		 				cw.start();
						layer.closeAll();
 		 			} 		
 				 });
 			else{
 				
 				layer.closeAll();
 				showDialog("该手机号已经被注册过了","","取消","","确定");
 				
 			}
 		}); 
 	}
 	
 	function invalidRegisterData(data){
 		var invalid=false;
 		var reg = /^[a-zA-Z0-9]{6,18}$/; 
 		
 		
 		
		if(data.userPhone.isEmpty()){
 			//$(".empty-userPhone").show();
 			
 			showAlert("请输入手机号码");
 			invalid=true;
 		}else if(!data.userPhone.isTel()){

 			showAlert("手机号码格式不正确");
 			return false;			
 		}else if(data.userPassword.isEmpty()){

 			showAlert("请输入密码");
 			invalid=true;
 		}else if(!reg.test(data.userPassword)){
 	
 			showAlert("密码为字母或数字的组合，6到18位");
 			invalid=true;
 		}else if(data.userPassword!=data.rePassword){

 			showAlert("两次输入密码不一致");
 			invalid=true;
 		}else if(data.code.isEmpty()){

 			showAlert("请输入验证码");
 			invalid=true;
 		}
 		return invalid;
 	}
 	
 	function invalidPhone(phone){
 		var invalid=false;
		if(phone.isEmpty()){

 			showAlert("请输入手机号码");
 			invalid=true;
 		}else if(!phone.isTel()){

 			showAlert("手机号码格式不正确");
 			invalid=true;
 		}
		return invalid;
 	}
 </script>
</body>
</html>
