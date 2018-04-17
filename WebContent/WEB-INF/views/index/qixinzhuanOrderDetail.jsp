<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title}</title>
</head>
<body>
<iframe src="${url}" frameborder="0" style="width:100%;height:800px;border:none;"></iframe>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/jweixin-1.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/Wxjsdkutil.js'/>"></script>

<script type="text/javascript">
	var shareData = {
		title: '${title}',
	    desc: '${title}', 
// 	    link: 'http://'+location.host+'/wxService/sen/toShare?orderId=${orderId}&expId=${expId}&userId=${user.userid}&url=${url}',
   		link: 'http://'+location.host+'/wxService/index/myToShare?expId=${expId}&userId=${userId}',    
	    imgUrl: '${img}',  
		requrl:"<c:url value='/share/sharePrepare'/>",
		param:location.href
    };
	$(document).ready(function(){
		
		prodetailshar(shareData);
	}); 
	function experience(){
		$.ajax({
			url:"<c:url value='/sen/share'/>",
			data:{expId:'${expId}',userId:'${userId}'}
		});
	}
</script>
</body>
</html>
