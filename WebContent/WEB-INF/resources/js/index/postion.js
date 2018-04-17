/**
 * 根据经纬度查询系统中的
 * 城市id及名称
 */
define(function(require, exports, module){

	var _initPostionCity=function(data){
//		alert("_initpostion");
		var cityid;
		if($("#position").val()=="index"){
			cityid=localStorage.getItem("cityid");
		}else{
			cityid=$("#cityid").val();
		}
//		alert("index.js 进入查询方法"+cityid);
		if(null==cityid || cityid=="undefined"){
			$.ajax({
				type : "get",
				url : data.posUrl,
				data : {
					"lng" : localStorage.getItem('lng'),
					"lat" : localStorage.getItem('lat')
				},
				dataType : "json",
				success : function(res) {

					$("#city").val(res.name);
					$("#cityid").val(res.id);	
					localStorage.setItem('cityName', res.name); 
					localStorage.setItem('cityid', res.id); 
					require.async('./index', function(init){

						init.initExp();
					});
				}
			});
		}else{
			if($("#position").val()=="index"){
				$("#city").val(localStorage.getItem("cityName"));
				$("#cityid").val(localStorage.getItem("cityid"));	
			}else{
				$("#city").val($("#city").val());
				$("#cityid").val($("#cityid").val());	
			}
			require.async('./index', function(init){

				init.initExp();
			});

		}   
		layer.closeAll();
		console.log("获取实际城市名称");
	}
	exports.initPostion=function(data){

		_initPostionCity(data);

	}
});