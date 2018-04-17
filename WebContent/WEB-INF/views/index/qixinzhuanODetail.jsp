<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/dialog.jsp" flush="true" />
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport"	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title id="title"></title>
<link href="<c:url value='/resources/css/web/expdetail/common.css'/>"	rel="stylesheet" type="text/css" />
<link href="<c:url value='/resources/css/web/qixinzhuanDetail.css'/>"	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="content">
		<div class="data">
			<div class="dataLeft">
				<p>
					总资产：<span id="total"></span>
				</p>
				<p>
					剩&nbsp;&nbsp;&nbsp;余：<span id="remain"></span>
				</p>
			</div>
			<div class="border"></div>
			<div class="dataRight">
				<p>
					浏览奖励：<span id="browse"></span>
				</p>
				<p>
					最高限额：<span id="perP"></span>
				</p>
			</div>
			 <p class="tips">*本次活动转发享受<span id="shareNum"></span>金币的奖励</p>
		</div>
		<div class="Process1">
			<div class="myProcess">我的进程</div>
			<li class="headerFont1" id="titles"></li>
			<div class="processContect1">
				<ul>
					<li class="read1" style="width:49%;float:left;text-align:center;"> 
						<img src="<c:url value='/resources/images/web/u5.png'/>">阅读量：<span id="pc"></span>
					</li>
					<li class="readBorder1"></li>
					<li class="gold1" style="width:49%;float:right;text-align:center;"> 
						<img src="<c:url value='/resources/images/web/u4.png'/>">获得金币：<span id="pcc"></span>
					</li>
				</ul>
			</div>
		
		<div style="margin: 10px;height: 120px;">
			<div style="font-size: 14px; margin-left: 20px;">
				<p> * 阅读量实时兑换金币。</p>
				<p> * 个人所得金币数=转发奖励+浏览奖励*浏览次数，且个人所得最高金币数须小于等于活动配置的最高限额。</p>
				<p> * 当任务的剩余资产为0时，之后所产生的阅读量将无效，并无法转换为金币。</p>
			</div>
		</div>
		</div>
	</div>
	<script type="text/javascript"	src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
	<script type="text/javascript"	src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
	<script type="text/javascript"	src="<c:url value='/resources/js/common/common.js'/>"></script>
	<script src="<c:url value='/resources/js/expdetail/common.js'/>"></script>
	<script type="text/javascript"	src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
	<script type="text/javascript"	src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>
	<script type="text/javascript">
	var shareData = {
			title: '${title}',
		    desc: '${title}',   
		    link: 'http://'+location.host+'/wxService/index/myToShare?expId=${expId}&userId=${userId}',        
		    imgUrl: '${img}',  
			requrl:"<c:url value='/share/sharePrepare'/>",
			param:location.href
	    };
		$(document).ready(function() {
			initData();
			hideOptionMenu(shareData);
		});
		function initData() {
			var data=${result};
			$("#title").html(data.data.title);
			$("#titles").html(data.data.title);
			$("#total").html(data.data.exp_count_gold + "金币");
			$("#remain").html(data.data.exp_remain_gold + "金币");
			$("#browse").html(data.data.exp_gold_min + "金币/次");
			$("#shareNum").html(data.data.user_share_gold);
			$("#perP").html(data.data.user_max_gold + "金币/人");
			$("#pc").html(data.data.browse_count1);
			$("#pcc").html(data.data.total_gold1);
			$("#ccc").html(data.data.exp_info);
		}
	</script>
</body>
</html>
