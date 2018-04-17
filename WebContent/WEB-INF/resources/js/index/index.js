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
				placeholder : "/wxService/resources/images/web/notuan_default.png",  
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



	//加载齐心赚的两个
	var _initDataTask=function(){
		console.log("初始化赚金币任务活动");
		post("/index/findExpZ",{"city_id":$("#cityid").val()},false)
		.then(function(data){
			if(data.data["0"].length>0){
				$("#qixinzhuan").append($(createQXZhuanHtml(data.data["0"])));
		
			}
			if(data.data["1"].length>0){
				$("#quanminzhuan").append($(createQMZhuanHtml(data.data["1"])));
			}
			$(".hotProductBox img").lazyload({ 
				placeholder : "/wxService/resources/images/web/notuan_default.png",  
				effect : "fadeIn", 
				threshold : 300,
				failurelimit : 10
			}); 
		});
	}

	function createQXZhuanHtml(data){
		if (data.length > 0) {
			var html = [];
			if(data[0].is_label==1)
			{	
				html.push('<p class="labelLeft">'+data[0].label+'</p>');
			}
			html.push('<dt class="fLeft" eid="'+data[0].exp_id+'">');
			html.push('<p><img data-original="'+data[0].exp_img_url+'" /></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight rightcolor"><span>'+ data[0].user_share_gold + '~' + data[0].user_max_gold+ '</span>金币</h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				if(data[1].is_label==1)
				{	
					html.push('<p class="labelRight">'+data[1].label+'</p>');
				}
				html.push('<dt class="fRight" eid="'+data[1].exp_id+'">  ');
				html.push('<p><img data-original="'+data[1].exp_img_url+'" /></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight rightcolor"><span>'+ data[1].user_share_gold + '~' + data[1].user_max_gold+ '</span>金币</h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}
	function createQMZhuanHtml(data){
		var html = [];
		if (data.length > 0) {
			if(data[0].is_label==1)
			{	
				html.push('<p class="labelLeft">'+data[0].label+'</p>');
			}
			html.push('<dt class="fLeft" eid="'+data[0].exp_id+'"> ');
			html.push('<p><img data-original="'+data[0].exp_img_url+'" /></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight rightcolor">'+ data[0].exp_user_gold + '<span>金币</span></h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				if(data[1].is_label==1)
				{	
					html.push('<p class="labelRight">'+data[1].label+'</p>');
				}
				html.push('<dt class="fRight" eid="'+data[1].exp_id+'">  ');
				html.push('<p><img data-original="'+data[1].exp_img_url+'" /></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight rightcolor">'+ data[1].exp_user_gold + '<span>金币</span></h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}


	//加载免费活动信息
	var _initExpData=function(){
		console.log("初始化免费的4个活动");
		post("/index/findExpInfo?cityId=" +$("#cityid").val(), {}, false).then(function(data) {

			$("#prize").append($(createPrizeHtml(data.exp.data["0"])));
			$("#pop").append($(createPopHtml(data.exp.data["1"])));
			$("#echage").append($(createEchageHtml(data.exp.data["2"])));
			//$("#try").append($(createTryHtml(data.exp.data["3"])));
			$(".hotProductBox img").lazyload({ 
				placeholder : "/wxService/resources/images/web/notuan_default.png",  
				effect : "fadeIn", 
				threshold : 300,
				failurelimit : 10
			}); 
		});
	}

	function createEchageHtml(data){

		if (data.length > 0) {
			var html = [];
			html.push('<dt class="fLeft">');
			html.push('<p><img data-original="' + data[0].exp_img_url+ '" onclick="expDetailInfo(' + data[0].exp_detail_id + ','+ data[0].exp_type + ')"/></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight num"><s>￥' + data[0].price	+ '</s></h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				html.push('<dt class="fRight">');
				html.push('<p><img data-original="' + data[1].exp_img_url+ '" onclick="expDetailInfo(' + data[1].exp_detail_id+ ',' + data[1].exp_type + ')"/></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight num"><s>￥' + data[1].price	+ '</s></h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}

	function createPopHtml(data){
		var html = [];
		if (data.length > 0) {
			if(data[0].is_label==1)
			{	
				html.push('<p class="labelLeft">'+data[0].label+'</p>');
			}
			html.push('<dt class="fLeft">');
			html.push('<p><img data-original="' + data[0].exp_img_url	+ '" onclick="expDetailInfo(' + data[0].exp_detail_id + ','+ data[0].exp_type + ')"/></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight num"><s>￥' + data[0].price	+ '</s></h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				if(data[1].is_label==1)
				{	
					html.push('<p class="labelRight">'+data[1].label+'</p>');
				}
				html.push('<dt class="fRight">');
				html.push('<p><img data-original="' + data[1].exp_img_url	+ '" onclick="expDetailInfo(' + data[1].exp_detail_id+ ',' + data[1].exp_type + ')"/></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight num"><s>￥' + data[1].price	+ '</s></h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}

	function createPrizeHtml(data){
		var html = [];
		if (data.length > 0) {
			if(data[0].is_label==1)
			{	
				html.push('<p class="labelLeft">'+data[0].label+'</p>');
			}
			html.push('<dt class="fLeft">');
			html.push('<p><img data-original="' + data[0].exp_img_url	+ '" onclick="expDetailInfo(' + data[0].exp_detail_id + ','	+ data[0].exp_type + ')"/></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight num"><s>￥' + data[0].price	+ '</s></h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				if(data[1].is_label==1)
				{	
					html.push('<p class="labelRight">'+data[1].label+'</p>');
				}
				html.push('<dt class="fRight">');
				html.push('<p><img data-original="' + data[1].exp_img_url	+ '" onclick="expDetailInfo(' + data[1].exp_detail_id+ ',' + data[1].exp_type + ')"/></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight num"><s>￥' + data[1].price	+ '</s></h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}

	function createTryHtml(data){
		var html = [];
		if (data.length > 0) {
			html.push('<dt class="fLeft">');
			html.push('<p><img data-original="' + data[0].exp_img_url	+ '" onclick="expDetailInfo(' + data[0].exp_detail_id + ','	+ data[0].exp_type + ')"/></p>');
			html.push('<div class="picNameBox">');
			html.push('<h2 class="fLeft">' + data[0].title + '</h2>');
			html.push('<h6 class="fRight num"><s>￥' + data[0].price	+ '</s></h6>');
			html.push('</div>');
			html.push('</dt>');
			if (data.length > 1) {
				html.push('<dt class="fRight">');
				html.push('<p><img data-original="' + data[1].exp_img_url+ '" onclick="expDetailInfo(' + data[1].exp_detail_id+ ',' + data[1].exp_type + ')"/></p>');
				html.push('<div class="picNameBox">');
				html.push('<h2 class="fLeft">' + data[1].title + '</h2>');
				html.push('<h6 class="fRight num"><s>￥' + data[1].price	+ '</s></h6>');
				html.push('</div>');
				html.push('</dt>');
			}
		}
		return html.join('');
	}


	exports.initExp=function(){

		_initAds();
		_initDataTask();
		_initExpData();
		console.log("init module status success");
 
	}
});

