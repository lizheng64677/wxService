(function($){

	$.querycity=function(input,options){

		var input=$(input);

		$(window).resize(function(){
			console.log("样式自适应");
		});        

		input.blur(function(){			

		}).keyup(function(event){

			event = window.event || event;
			var keyCode = event.keyCode || event.which || event.charCode;        
			if(keyCode != 13 && keyCode != 37 && keyCode != 39 && keyCode !=9 && keyCode !=38 && keyCode !=40 ){

				queryCity(); 
			}
		});
		function queryCity()
		{	
			var value = input.val().toLowerCase();
			if(value.length == 0){
				$(".ul").empty();
				return; 
			}else{

				var isHave = false;
				var _tmp = new Array();
				$.getJSON("/wxService/resources/js/city/selectData.js",function(data){
					for(var item in data){
						var _data = data[item];
						if(typeof(_data) != 'undefined'){

							if(_data.jpname.indexOf(value) >= 0 || _data.qpname.indexOf(value) >= 0 || _data.name.indexOf(value) >=0 ){					                   
								isHave=true;
								_tmp.push(_data);
							}
						}
					};
					if(isHave){
						$(".ul").show();
						var html=[];
						html.push('<ul>');
						for(var item in _tmp){
							var _tmp_data= _tmp[item];
							html.push("<li class='searchli' id='"+_tmp_data.id+"'>"+_tmp_data.name.toString()+"</li>");	               
						}
						html.push("</ul>");
						$(".ul").html(html);
					}else{
						$(".ul").show();
						var txt="<ul><li class='searchli' id='-1'>请输入正确的城市/拼音或汉字</li></ul>";	 
						$(".ul").html(txt);
					}
				});	 
			}

		}
	};	

	$.fn.querycity=function(options){
		var defauls={
				'data'          : {}
		};
		var opts=$.extend(defauls,options);

		this.each(function(){

			new $.querycity(this,opts);
		});
		return this;
	};

})(jQuery);

