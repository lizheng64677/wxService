<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录</title>
<link href="<c:url value='/resources/css/web/login.css'/>"  rel="stylesheet" type="text/css"/>
<style type="text/css">
	.hidden{display: none;color:red; font-size: 14px; line-height: 14px; height: 14px; text-align: center;}
</style>
</head>
<body>
    <!--  <header>
        <h3>登录</h3>
    </header>-->
    <div class="content">
        <img style="width: 200px;margin-top: 50px;" src="<c:url value='/resources/images/web/logo.png'/>" width="100%">
        <div class="loginbar">
           <ul>
               <li>
	               <img src="<c:url value='/resources/images/web/phone02.png'/>" width="15" class="loginimg">
	               <input class="logintel" id="userPhone" type="text" placeholder="手机号码" value="">
               </li>
               <li>
	               <img src="<c:url value='/resources/images/web/pwd.png'/>" width="15" class="loginimg">
	               <input class="logintel" id="userPassword" type="password" placeholder="密码" value="">
	               
               </li>
           </ul>
        </div>
    </div>
    <div class="div-error" style="height: 0px;">
    	<p class="hidden empty-userPhone">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*请输入手机号码</p>
    	<p class="hidden empty-userPassword">*请输入密码</p>
    	<p class="hidden invalid-userPhone">*用户信息不存在 </p>
    	<p class="hidden invalid-userPassword">*密码不正确 </p>
    </div>
    <div class="loginbutton"><input  type="button" value="登录"></div>
    
    <p style="text-align: center;margin-top: 10px;color: #afafaf;font-size: 13px;">NO团网老用户通过找回密码进行登录</p>
    <div class="registered">
         <ul>
             <li>
             <a href="<c:url value='/user/toRegister'/>"><span>注册</span></a>
             <input type="hidden" id="openid" name="openid"  value="${SESSION_OPEN_ID}"/>
             
             <a href="<c:url value='/user/toBackPWD'/>"><span style="float:right;">找回密码</span></a>
             </li>            
             
         </ul>
    </div>
	<div class="goldpwd" id="dialog1" style="dislay:none;">
		<div class="goldkuang">
		   <ul>
		       <p id="Msg">请确认绑定该微信号！</p>
		      
		   </ul>
		<a href="javascript:cancel();"><div  class="Kpwd1" id="Cancel" >取消</div></a>
		<a href="javascript:userStatus();"><div  class="Kpwd" id="OK" >确认</div></a>
		</div>
	</div>
    
 <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/jquery.md.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/validate.js'/>"></script>
 <script type="text/javascript">
 	$(document).ready(function(){
 		$(".loginbutton").on("click","input",function(){
 			login();
 		});
 	});
 	function login(){
 		$(".hidden").hide();
 		var phone=$("#userPhone").val();
 		var pwd=$("#userPassword").val();
 		var invalid=false;
 		if(phone.isEmpty()){
 			
 			showAlert("请输入手机号码");
 			invalid=true;
 		}
 		else if(pwd.isEmpty()){
 	
 			showAlert("请输入密码");
 			invalid=true;
 		}
 		if(invalid) return;
 		post("/userlr/login",{userPhone:phone,userPassword:pwd,openid:$("#openid").val(),loginType:"0"},true)
 		.then(function(data){
 			console.log(data);
 			if(data.userStatus=="binding"){
 				$("#dialog1").show();
 				 //showDialog("请确认绑定该微信号！","","取消","javascript:userStatus();","确定");
 				/* if(confirm("请确认绑定该微信号！")){ 					
 					userStatus();					
 				} 	 */			
 				return false;
 			}else if(data.userStatus=="invalidOpenid"){ 		
 				showAlert("该手机号已经绑定过其他微信号，请切换微信号后操作");
 				return false;
 			}else{
	 			if(data.message=='invalidPwd' || data.message=='validPwd' ){

	 				showAlert("密码不正确");
	 			}else if(data.message=='invalidInfo'||data.message=='validInfo'){
	 				
	 	 		   showDialog("该手机号码没有注册,前往注册","","取消","<c:url value='/user/toRegister'/>","确定"); 
	 			}else if(data.message=='success'){
	 				window.location.href="<c:url value='/user/toMain'/>";
	 			}else if(data.message=='invalidPwdBack'){
	 				
	 				showDialog("您已为NO团用户,请点击确定后找回密码","","取消","<c:url value='/user/toBackPWD'/>","确定"); 
	 			}

 			}
 		});
 	}
 	function userStatus(){
 		var phone=$("#userPhone").val();
 		var pwd=$("#userPassword").val();
 			$.ajax({
 				type:"post",
 				url:"<c:url value='/userlr/updateStatus'/>",
 				data:{userPhone:phone,userPassword:pwd,openid:$("#openid").val(),loginType:"0"},
 				dataType:"json",
 				success:function(res){
 					if("success"==res.message){
 						$("#dialog1").hide();
 						showAlert("绑定成功请重新点击登录按钮！");
 						
 					}else{
 						showAlert("绑定过程中出现异常请联系网站客服！");
 					}
 				}
 			});
 			
 		}
 		function cancel(){
 			$("#dialog1").hide();
 		}
 </script>   
</body>
</html>
