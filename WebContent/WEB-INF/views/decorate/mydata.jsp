<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的资料</title>
<link href="<c:url value='/resources/css/web/accountSecurity.css'/>"  rel="stylesheet" type="text/css"/></head>
<body>
      <div class="headerContent">
           <ul>
           	  <a href="javascript:history.go(-1);">
           	  <li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li>
           	  </a>
              <li class="headerFont">我的资料</li>
           </ul>  
        </div>  
        
   <div class="content">
     <input type="hidden" name="openid"  id="openid" value="${result.openid}" />
       <input type="hidden" name="userId"   id="userId" value="${result.userId}" />
      <ul>
          <li>
             <span class="pwdFont1">姓名<br><span style="font-size: 12px;color: #e83228;">(实名认证姓名)</span></span>
             <span class="pwdInput"><input type="text" value="${result.userName}" class="inputStyle" id="userName" placeholder="请输入支付宝认证实名"></span>
          </li>
          <li>
             <span class="pwdFont1">支付宝账号</span>
             <span class="pwdInput">
                <input type="text" class="inputStyle" id="zfb" value="${ result.alipayNumber }"  placeholder="请输入支付宝账户">
             </span>
          </li>          
          <li>
             <span class="pwdFont1">手机号码</span>
              <span class="pwdInput">
              <input type="text" value="${result.userPhone}" class="inputStyle" placeholder="请输入手机号码" id="userPhone"  >
            </span>
          </li> 

          <li>
             <span class="pwdFont1">钱包提现密码</span>
             <span class="pwdInput">
                    <input type="password" class="inputStyle" value="${result.password }"  id="wpassword" placeholder="请输入提现密码">
             </span>
          </li>
 
      </ul>
        <div class="qdOver"><a href="javascript:void(0);" id="sumbit">提交保存</a></div>
   </div>
 
 <script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/validate.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
 <script type="text/javascript">
	var shareData = {			
			requrl:"<c:url value='/share/sharePrepare'></c:url>",
			param:location.href
	    };		
	
 	$(document).ready(function(){
 		//个人中心不允许有多余菜单出现 
 		hideOptionMenu(shareData);
		var url="";
		$("#sumbit").bind("click",function(){
			var zfb=$("#zfb").val().trim();
			var wpassword=$("#wpassword").val().trim();
			var openid=$("#openid").val().trim();
			var userId=$("#userId").val().trim();
			var userPhone=$("#userPhone").val();
			var userName=$("#userName").val();
			var reg = /^[a-zA-Z0-9]{6,18}$/; 
			if(userName.trim() == "") {
				showAlert("姓名不能为空");
				return;
			}
			if(zfb.trim() == "") {
				showAlert("支付宝账号不能为空");
				return;
			}
			if(wpassword.trim() == "") {
				showAlert("钱包提现密码不能为空");
				return;
			}
			
			if( wpassword.trim() != ""&&!reg.test(wpassword)){
				showAlert("提现密码为字母或数字的组合，6到18位");
				return;
			}
	
			var data={
					"alipayNumber":zfb,
					"password":wpassword,
					"userPhone":userPhone,
					"openid":openid,
					"userId":userId,
					"userName":userName
					};
			post("/expdecorateuser/saveOrUptateExpDecorateUserInfo",data,
					true,'提交中').then(function(result){
						if(result.result==1){
							showDialog("信息提交成功！","","取消","<c:url value='/decorate/center.html?id=${expId}'/>","确定");
						}else{
							showAlert("信息提交失败！",3);
						} 
		
			});
		});
 	});
 	
 </script>
</body>
</html>
