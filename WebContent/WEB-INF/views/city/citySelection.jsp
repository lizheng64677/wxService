<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>城市选择</title>
<link href="<c:url value='/resources/css/web/citySelection/CitySelection.css'/>" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="search">
<img  class="magnifying" src="<c:url value='/resources/images/web/citySelection/iconfont-fangdajing.png'/>">
<input type="text" class="searchtext" value="" id="searchtext"  placeholder="拼音或城市搜索">
<div class="ul">

</div>
</div>
<div class="content">

<p class="current">当前定位城市
 <span>
<input type="hidden" class="city" id="cityid" value="">
<input type="button" class="city" id="cityname" value="">
</span>
</p>
<p class="current hotcity">热门城市</p>
<div class="hotcitys">
<ul id="hotcitys"></ul>
</div>
<p class="current hotcity">全部城市</p>
</div>
<div class="menu" id="menu_id">

</div>

<div class="rightbox">
<ul id="rightul">
<li class="li-id A">A</li>
<li class="li-id B">B</li>
<li class="li-id C">C</li>
<li class="li-id D">D</li>
<li class="li-id E">E</li>
<li class="li-id F">F</li>
<li class="li-id G">G</li>
<li class="li-id H">H</li>
<li class="li-id J">J</li>
<li class="li-id K">K</li>
<li class="li-id L">L</li>
<li class="li-id M">M</li>
<li class="li-id N">N</li>
<li class="li-id P">P</li>
<li class="li-id Q">Q</li>
<li class="li-id R">R</li>
<li class="li-id S">S</li>
<li class="li-id T">T</li>
<li class="li-id W">W</li>
<li class="li-id X">X</li>
<li class="li-id Y">Y</li>
<li class="li-id Z">Z</li>

</ul>
</div>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/layer.m/layer.m.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/city/querycity.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/city/_postion.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/sea.js'/>"></script>

<script type="text/javascript">
    var tempHtml=[];
    $(document).ready(function(){
  	 	 var str=["a","b","c","d","e","f","g","h","j","k","l","m","n","p","q","r","s","t","w","x","y","z"];  
  	 	//拼音或汉子搜索城市
    	$('#searchtext').querycity({"data":str});
 	
 		init();
 		initData(); 
 		initGetlocation();

		//热门城市列表点击事件
		$(".hotcitys").on("click",".li-id",function(){
			
			window.location.href="<c:url value='/index/citySelectionToIndex?position=city&id='/>"
					+ $(this).attr("data-cityid")+"&name="+encodeURI(encodeURI($(this).text()));
		})
		
		//全部城市信息点击事件
		$(".menu").on("click",".cc",function(){
			
			window.location.href="<c:url value='/index/citySelectionToIndex?position=city&id='/>"
					+ $(this).attr("data-id")+"&name="+encodeURI(encodeURI($(this).text()));
		})
		
		//搜索出的城市的点击跳转事件
		$(".ul").on("click",".searchli",function(){
			
			if($(this).attr("id")=="-1"){
				showAlert("请选择正确的城市");
				return false;
			}else{
				window.location.href="<c:url value='/index/citySelectionToIndex?position=city&id='/>"+ $(this).attr("id")+"&name="+encodeURI(encodeURI($(this).text()));
				
			}
		})
		//右侧26个英文字母点击事件		
		$(".rightbox").on("click",".li-id",function(){			
			var className=this.className.slice(6);
			var div = document.getElementById("menu_id");  
		    var dl = div.getElementsByTagName("dl");
		    for(var i = 0; i < dl.length;i++){ 
				 if(dl[i].id==className){
					 dl[i].scrollIntoView();
				}				 
			 }
		});
		
		//定位城市跳转事件
		$("#cityname").bind("click",function(){
			window.location.href="<c:url value='/index/citySelectionToIndex?position=city&id='/>"
				+ $("#cityid").val()+"&name="+encodeURI(encodeURI($("#cityname").val()));
		})
    }) 
    
    //获取热门城市信息
	function initData(){
		post("/city/findHotCityInfo",{},false).then(function(data){
			
			if(data.data.length>0){
				for(var i=0;i<data.data.length;i++){
					$("#hotcitys").append($(createHotCity(data.data[i])));	
					tempHtml=[];
				}				
			}
		});
	}
	function createHotCity(data){
		tempHtml.push('<li class="li-id " data-cityId="'+data.id+'">');
		tempHtml.push(data.name);
		tempHtml.push('</li>');
		return tempHtml.join('');
	}
   
	//按城市拼音首字母分组显示城市信息
   function init()
   {
		layer.open({ 
			content:"数据加载中..." ,
			style: 'background-color:black; color:#fff; border:none;'
		});

		  var str=["a","b","c","d","e","f","g","h","j","k","l","m","n","p","q","r","s","t","w","x","y","z"];  
    	  		var html=[];
    	  		for(var i in data){
					html.push('<dl id='+str[i].toUpperCase()+'>');
					html.push('<dt class="group">' + str[i].toUpperCase() + '</dt>');
					for (var j in data[i][str[i]]){
						
						html.push('<dd class="cc" data-id='+data[i][str[i]][j].id+'>'+ data[i][str[i]][j].name+'</dd>');
					}
					html.push('</dl>');
					$(".menu").append(html);
				}     		
	}
	
   
  //获取定位城市信息
  function initGetlocation() {
	$.ajax({
		type : "get",
		url : "<c:url value='/city/findCityInfoByName'/>",
		data : {
			lng :localStorage.getItem("lng"),
			lat :localStorage.getItem("lat")
		},
		dataType : "json",
		success : function(res) {
		  $("#cityname").val(res.name);
		  $("#cityid").val(res.id);
		 layer.closeAll();
	   }
	})
  };
</script>
</body>
</html>
