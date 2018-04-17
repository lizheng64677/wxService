<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人账户安全</title>
<link href="<c:url value='/resources/css/web/accountSecurity.css'/>"  rel="stylesheet" type="text/css"/></head>
<body>
      <!--  <div class="headerContent">
           <ul>
           	<a href="javascript:history.go(-1);"><li class="headerimg"><img src="<c:url value='/resources/images/web/leftjt.png'/>" width="20"></li></a>
              <li class="headerFont">账户安全</li>
           </ul>  
        </div>  -->
   <div class="content">
      <ul>
          <li>
             <span class="pwdFont1">姓名<br><span style="font-size: 12px;color: #e83228;">(实名认证姓名)</span></span>
             <span class="pwdInput"><input type="text" value="${ali_user_name}" class="inputStyle" id="userName" placeholder="请输入支付宝认证实名" <c:if test="${!empty ali_user_name}">readonly='readonly'</c:if> ></span>
          </li>
          <li>
             <span class="pwdFont1">支付宝账号</span>
             <span class="pwdInput">
                <input type="text" class="inputStyle" id="zfb" value="${ali_pay }" <c:if test="${!empty ali_pay}">readonly='readonly'</c:if>  placeholder="请输入支付宝账户">
             </span>
          </li>          
          <li>
             <span class="pwdFont1">手机号码</span>
              <span class="pwdInput">
              <input type="text" value="${user_phone }" class="inputStyle" placeholder="请输入手机号码" id="userPhone"  readonly="readonly">
            </span>
          </li> 
         <%--  <li>
             <span class="pwdFont1">登录密码</span>
             <span class="pwdInput">
                <input type="password" class="inputStyle" id="login"   placeholder="<c:if test="${user_password!='' }">*******</c:if><c:if test="${user_password==''}">请输入登录密码</c:if>">                              
             </span>
          </li>  --%>
          <li>
             <span class="pwdFont1">钱包提现密码</span>
             <span class="pwdInput">
             	 <c:if test="${empty withdrawals_password}">
                	<input type="password" class="inputStyle"  id="wpassword" placeholder="请设置钱包提现密码">
          		</c:if>
                <c:if test="${!empty withdrawals_password}">
                	<input type="password" class="inputStyle1"  id="wpassword" placeholder="*******"readonly='readonly'>
          			<a href="javascript:void(0);" id="modifyPwd"><span class="modClass">修改</span></a>
          		</c:if>
             </span>
          </li>
          <c:if test="${empty withdrawals_password}">
	          <li>
	             <span class="pwdFont1">确认提现密码</span>
	             <span class="pwdInput">
	                <input type="password" class="inputStyle"  id="wpassword1" placeholder="<c:if test="${withdrawals_password!='' }">*******</c:if><c:if test="${withdrawals_password==''}">重新输入提现密码</c:if>">
	             </span>
	          </li>
          </c:if>
      </ul>
      <c:if test="${empty withdrawals_password}">
        <div class="qdOver"><a href="javascript:void(0);" id="sumbit">提交保存</a></div>
       </c:if>
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
			var zfb=$("#zfb").val();
			var wpassword=$("#wpassword").val().trim();
			var wpassword1=$("#wpassword1").val().trim();
			//var login=$("#login").val();
			var userPhone=$("#userPhone").val();
			var userName=$("#userName").val();
			var reg = /^[a-zA-Z0-9]{6,18}$/; 
			if(userName.trim() == "") {
				showAlert("姓名不能为空");
				return;
			}
			/* if(login.trim() == "") {
				showAlert("登录密码不能为空");
				return;
			} */
			/* if(login.trim() != ""&& !reg.test(login.trim())){
				showAlert("登录密码为字母或数字的组合，6到18位");
				return;
			}		 */	
			
			if(wpassword.trim() == "") {
				showAlert("钱包提现密码不能为空");
				return;
			}
			
			if( wpassword.trim() != ""&&!reg.test(wpassword)){
				showAlert("提现密码为字母或数字的组合，6到18位");
				return;
			}
			if((wpassword.trim()!='' || wpassword1.trim()!='')&&  wpassword1!=wpassword){
				showAlert("两次提现密码不一致");
				return;
			}
			if(zfb.trim() == "") {
				showAlert("支付宝账号不能为空");
				return;
			}
			post("/userlr/updateSecurityInfo",
					{"ali_pay":zfb,
					"wpassword":wpassword,
					//"login_password":login,
					"user_phone":userPhone,
					"ali_user_name":userName},true,'提交中').then(function(result){
						if("success"==result.message){
							//showAlert("信息修改成功！");
							showDialog("信息提交成功！","<c:url value='/user/toWallet'/>","我的钱包","<c:url value='/user/toMain'/>","个人中心");
// 						 	window.location.href="<c:url value='/user/toMain'/>";
						}else if("aliPayRepeat"==result.message){
							showAlert("支付宝账号已存在！",3);
						}else{
							
							showAlert("信息提交失败！",3);
						}
		
			});
		});
		
 		$("#modifyPwd").bind("click",function(){
 			location.href = "<c:url value='/user/toWithPwd'/>";
 		});
 	});
 	
 </script>
</body>
</html>
