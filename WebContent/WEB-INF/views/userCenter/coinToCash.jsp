<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="telephone=no" name="format-detection"> 
<title>金币提取到钱包</title>
<link href="<c:url value='/resources/css/web/coins.css'/>"  rel="stylesheet" type="text/css"/></head>

<body>
  <!-- <div class="headerContent">
           <ul>
              <li class="headerFont">现金提现至钱包</li>
           </ul>  
        </div>  -->
     <div class="content">
         <div class="gold">
             <ul>
                 <li>总资产</li>
                 <li><span id="coin"></span>金币</li>
             </ul>
         </div>
         <p class="goldBorder"></p>
         <div class="goldNum">
             <ul>
                 <li>提现金币</li>
                 <li><input id="goldinput" class="goldinput" type="text" value="" /></li>
                 <li><img src="<c:url value='/resources/images/web/gold.png'/>" width="16"><span>金币兑换比例：10金币=￥1</span></li>
             </ul>
         </div>
     </div>
     <div class="goldtishi">
       <!--  <p>*金币提现到钱包审核期为5个工作日，金币提现审核中无法再提交提现申请。</p>-->
        <p>*金币起提数为大于0的整数</p> 
        <div class="goldCoins">
           	本次转出<span id="money">￥0</span>至钱包
        </div>
     </div>
     <div class="goldbutton"><input id="submit" type="button" value="确认转出"/></div> 
     <!--转出提示-->
     <div class="turnOut">
        <div class="turnOutkuang">
           <p>转出成功,查看账户资产信息</p>
         <div class="Kpwd"><input id="IKnow" type="button" value="知道了"/></div> 
         </div>
     </div>
 <script src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/validate.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
 <script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
 
 <script type="text/javascript">
 	var coin;
 	var shareData = {			
 			requrl:"<c:url value='/share/sharePrepare'></c:url>",
 			param:location.href
 	    };		
 	$(document).ready(function(){
 		//个人中心不允许有多余菜单出现 
 		hideOptionMenu(shareData);
 		
 		post("/sen/getUserSInfo",{},false).then(function(data){
 			coin=data.gold_coin;
 			$("#coin").html(data.gold_coin);
 			$("#goldinput").attr("placeholder","本次最多可提现"+data.gold_coin+"金币");
 		});
 		var temp;
 		$("#goldinput").on("keydown",function(){
 			temp=$(this).val();
 			if(!temp) temp="";
 		});
 		$("#goldinput").on("input",function(){
 			var v=$(this).val();
 			if(v.isNumber()){
 				if(v>coin){
 					showAlert("你没有那么多资产!");
 	 				$("#goldinput").val(temp);
 				}else
 					$("#money").html("￥"+v/10.0);
 			}else if(v.isEmpty()){
 				$("#money").html("￥0");
 			}else if(!v.isNumber()){
 				showAlert("请输入数字");
 				$("#goldinput").val(temp);
 			}
 		});
 		$("#submit").on("click",function(){
 			var v=$("#goldinput").val();
 			if(v.isNumber()){
 				if(v<=0){
 					showAlert("金币起提数要大于0的数字！");
 					return;
 				}
 				if(v>coin){
 					showAlert("你没有那么多资产!");
 	 				$("#goldinput").val(temp);
 				}else{
					post("/sen/coin2Cash",{coin:v},false)
					.then(function(data){
						if(data.message=='success'){
							$(".turnOut").show();
							$("#coin").html($("#coin").html()-v);
						}
						/* else if(data.message=="notaudit"){
							
							showAlert("您上次提交的金币提取钱包还未审核，审核通过后，再次操作！");
						} */
					});
 				}
 			}else if(v.isEmpty()){
 				showAlert("金币不能为空");
 			}else if(!v.isNumber()){
 				showAlert("请输入数字");
 				$("#goldinput").val(temp);
 			}
 		});
 		$("#IKnow").on("click",function(){
 			$(".turnOut").hide();
 			window.location.href="<c:url value='/user/toCoin'/>";
 		});
 	});
 </script>
</body>
</html>
