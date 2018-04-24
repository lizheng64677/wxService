<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>提现</title>
<link href="<c:url value='/resources/css/web/coinszhifubao.css'/>"  rel="stylesheet" type="text/css"/></head>

<body>
    <!--  <div class="headerContent">
             <ul>
                <li class="headerFont">提现至支付宝账户</li>
             </ul>  
    </div> -->
       <input type="hidden" name="openid"  id="openid" value="${result.openid}" />
       <input type="hidden" name="userId"   id="userId" value="${result.userId}" />    
       <input type="hidden" id="tqMoney" value="${decorate.tqMoney }"/>  
       
    <div class="content">
       <div class="box">
           <ul>
               <li class="alipayName">支付宝姓名<br><span>(实名认证姓名)</span></li>
               <li class="alipayNameInput"><input class="input" type="text" id="name" value="${result.userName}" maxlength="10" readonly="readonly"></li>
           </ul>
        </div>
        <div class="box">
           <ul>
             <li class="alipayNum">支付宝账号</li>
             <li class="accountNumber"><input class="input" type="text" id="ali" value="${ result.alipayNumber }" maxlength="40" readonly="readonly"></li>
           </ul>
        </div>
        <div class="box">
           <ul>
             <li class="alipayGold">提取金额</li>
             <input type="hidden"   id="blackmoney" value="${result.balancePrice}" /> 
             <li class="alipayGoldNumber"><input class="input" type="text" id="money" maxlength="6" placeholder="提取金额"></li>
          </ul>
        </div>
        <div class="box">
           <ul>
             <li class="alipayGold" style="margin-bottom:100px">提取密码</li>
             <li class="alipayGoldNumber"><input class="input" type="password" id="password" maxlength="18" placeholder="提取密码"></li>
          </ul>
        </div>
    </div>
    <div class="footer">
        <input type="button" value="提交" id="submit">
        <p class="notes">*提现起提数是${decorate.tqMoney }元，不足${decorate.tqMoney }元不可提现。</p>
    </div>
     <!--end-->
     <!--转出提示-->
     <div class="turnOut">
        <div class="turnOutkuang">
           <p>您的申请已提交，提现到账期为3个工作日，请注意查看账户信息。</p>
         <div class="Kpwd"><input id="IKnow"  type="button" value="知道了"></div> 
         </div>
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
 		$("#submit").on("click",function(){
 			var m=$("#money").val();
 			var name=$("#name").val();
 			var p=$("#password").val();
 			var ali=$("#ali").val();
 			var tqmoney=$("#tqMoney").val();
 			var money=$("#blackmoney").val();
 			if(m.isEmpty()){
 				showAlert("提取金额不能为空！"); return ;
 			}
 			if(name.isEmpty()){
 				showAlert("姓名不能为空！");return ;
 			}
			if(p.isEmpty()){
				showAlert("密码不能为空！");return ;
			}
 			if(ali.isEmpty()){
 				showAlert("支付宝不能为空！");return ;
 			}
 			if(!m.isMoney()){
 				showAlert("提取金额的格式不正确！");return ;
 			}
 			if(tqmoney>m){
 				showAlert("提取金额必须大于"+tqmoney+"元！");return ;
 			}
 			if(m>money){
 				showAlert("账户中金额不足！");return ;
 			}
 			post("/decorate/withdrawCreateOrder",{"withdrawPrice":m,"password":p},true,'提交中')
 			.then(function(data){
 		
 				if(data.result.message=='success'){
 					$(".turnOut").show();
 				}else if(data.result.message=='invalidP'){
 					showAlert("提现密码错误！！");
 				}else if(data.result.message=='lessmoney'){
 					
 					showAlert("账户中金额不足！"); 					
 				}else if(data.result.message=='notaudit'){
 					showAlert("您上次提现的金额暂未审核，审核通过后才可继续提现！");
 				}else{
 					showAlert("发生未知错误，请联系客服！");
 				}
 			});
 		});
 		
 		
 		$("#IKnow").on("click",function(){
 			$(".turnOut").hide();
 			window.location.href="<c:url value='/decorate/wallet.html?id=${expId }'/>";
 		});		
 	});
 </script>
</body>
</html>
