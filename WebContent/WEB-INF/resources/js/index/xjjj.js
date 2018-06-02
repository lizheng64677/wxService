/**
 * 首页的js 各模块初始化
 */
define(function(require, exports, module){
	
	var _initAds=function(){
		console.log("初始化广告位模块");
		post("/index/findAdvs", {type : 0}, false).then(function(data) {
			var d;
			var html = [];
			for (var i = 0; i < data.data.length; i++) {
				d = data.data[i];
				html.push('<div class="swiper-slide slider_swipe">');
				if (d.link_url && d.link_url.length > 0) {
					html.push('<a href="'+d.link_url+'">');
					html.push('<img data-original="' + d.pic_url+'"style="height:100%;"/>');
					html.push('</a>');
				} else {
					html.push('<a href="/wxService/index/toTuWenAdvs?id='+ d.adv_id + '">');
					html.push('<img data-original="' + d.pic_url+ '" style="height:100%;"/>');
					html.push('</a>');
				}
				html.push('</div>');
			}							

			$("#swipe-wrap").html(html.join(''));	
			
			$(".bannerBox img").lazyload({ 
				placeholder : "/wxService/resources/images/web/rankpm.png",
				effect : "fadeIn", 
				threshold : 300,
				failurelimit : 10
			}); 

		}).then(function() {
			new Swiper("#slider",{
				autoplay : 2500,
				autoplayDisableOnInteraction : false,
				pagination : '.swiper-pagination',
				paginationClickable : true
			});
		});
	}



	//加载福利券
	var _initDataTask=function(){
		console.log("初始化福利券");
		post("/wxDecorateVoucher/findVoucher",{},false)
		.then(function(data){
			//福利券
			if(data.data["0"].length>0){
				$("#fuli").append($(createQMZhuanHtml(data.data["0"])));
			}
			//体验券
			if(data.data["1"].length>0){
				$("#tiyan").append($(createQMZhuanHtml(data.data["1"])));
			}
			//优惠券
			if(data.data["2"].length>0){
				$("#youhui").append($(createQMZhuanHtml(data.data["2"])));
			}
			$(".hotProductBox img").lazyload({ 
				placeholder : "/wxService/resources/images/web/rankpm.png",  
				effect : "fadeIn", 
				threshold : 300,
				failurelimit : 10
			}); 
		});
	}

	function createQMZhuanHtml(data){
		var html = [];
		if (data.length > 0) {
	      for (var i = 0; i < data.length; i++) {
	    	html.push("<div>");
				html.push('<dt class="fLeft" eid="'+data[i].id+'"> ');
				html.push('<p><img data-original="'+data[i].voucheUrl+'" /></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[i].title + '</h2>');
				html.push('<h6 class="fRight rightcolor">'+ data[i].price + '<span>元</span></h6>');
				html.push('</div>');
				html.push('</dt>');
			html.push("</div>");
			}
		}
		return html.join('');
	}


	exports.initExp=function(){

		_initAds();
		_initDataTask();
		console.log("init module status success");
 
	}
});

