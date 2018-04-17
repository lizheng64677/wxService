<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>图片压缩上传</title>
</head>
<body>

	<div>
		<div style="width:120px; height:150px; border:1px solid red;" >
			<img src="" id="img" style="width:120px; height:150px;">
		</div>
		<input type="file" name="test" id="test" style="display:none;">
		<div id="error">
		</div>
	</div>
	<p id="imgurl"></p>
    
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/fileCompress/mobileBUGFix.mini.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/fileCompress/compress.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/common/fileUpload.js'/>"></script>
	<script type="text/javascript">
		//重写前台验证失败后的回调
	    function showError(res){
	    	$("#error").html(res);
	    }
	    //重写上传成功后的回调
	    function showSuccess(res){
	    	console.log(res);
	    	if(res.flag==0){
	    		$("#imgurl").html(res.url);
	    	}
	    }
	</script>
</body>
</html>