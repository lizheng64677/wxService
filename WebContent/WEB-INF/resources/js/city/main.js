/**
 * 城市选择
 */
define(function(require, exports, module){
	require("./_postion.js");
	require("./querycity.js");
	var str=["a","b","c","d","e","f","g","h","j","k","l","m","n","p","q","r","s","t","w","x","y","z"];  
	$('#searchtext').querycity({"data":str});
	var _mycityList=function(){

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
	var _initGetlocation=function() {
		$.ajax({
			type : "get",
			url : "/wxService/city/findCityInfoByName",
			data : {
				lng :localStorage.getItem("lng"),
				lat :localStorage.getItem("lat")
			},
			dataType : "json",
			success : function(res) {
				$("#cityname").val(res.name);
				$("#cityid").val(res.id);
			}
		})
	};
	var tempHtml=[];
	//热门城市
	var _hotCityList=function(){

		$.ajax({
			type : "get",
			url : "/wxService/city/findHotCityInfo",
			data : {},
			dataType : "json",
			success : function(data) {
				if(data.data.length>0){
					for(var i=0;i<data.data.length;i++){
						$("#hotcitys").append($(createHotCity(data.data[i])));	
						tempHtml=[];
					}				
				}
			}
		})

	}
	function createHotCity(data){
		tempHtml.push('<li class="li-id " data-cityId="'+data.id+'">');
		tempHtml.push(data.name);
		tempHtml.push('</li>');
		return tempHtml.join('');
	}
	exports.cityList=function(){

		_initGetlocation();
		_hotCityList();
//		_mycityList();
	}

});