
$(function(){
	//首页面搜索
	$("#submitsearch").click(function(){
		var keyword=$("input[name=keyword]");
		if(keyword.val().length>0){
			window.location.href="/wxService/index/toIndex.html?type="+config.url_get_type+"&keyword="+$("#keyword").val();
		}else{
			showTips("请输入姓名",2000);
		}	
	});	
	//页面访问数
	numberPlus();
})

function numberPlus(){
	
	 $.ajax({
		 type:"post",
	 	 url:config.number_plus_url,
	 	 dataType:"json",
	 	 success:function(data){
	 		 if("success"==data.status){
	 			console.log("访问数成功加一");
	 		 }else{
	 			console.log("访问数增加失败");
	 		 }
	 		 
	 	 }
		 
	 });
}

function getRankingItem() {
    if (config.done || config.loading) return;
    loadStatus(1, '正在加载' + config.item_name + '中...');
    config.loading = true;
    var box = $('.ranking');
    if (!box.length) return;
    $.post({
        url: config.url_get_vote_item + '?type=' +config.url_get_type,
        data: {"page.currentPage": config.page,"page.showCount":"20"},
        async: true,
		dataType:"json",
        success: function (data) { 
            if (config.page === 1) box.find('.vote-item').remove();
            var count=data.args.page.totalPage;
            var itemObj =[];
            if (count >=config.page) {
                $.each(data.data, function (index, item) {
                	config.pm++;            
                    var link = config.url_detail + '?detailId=' + item.id+"&actId="+config.cid;                    
                    if("-1"==config.url_get_type){
	                	if(config.pm==1 && item.votes_number>0){    
	                		itemObj.push('<tr>'+                         	
	                                '<td><img src="/wxService/resources/static/img/rank1.png" width="100%" /></td>'+ 
	                                '<td> <a href="'+link+'"> '+item.number+'号：'+item.name+' </a> </td>'+ 
	                                '<td>'+item.votes_number+'</td>'+
	                                '</tr>') ;    
	                	}else if(config.pm==2 && item.votes_number>0){
			           		itemObj.push('<tr>'+                         	
		                            '<td><img src="/wxService/resources/static/img/rank2.png" width="100%" /> </td>'+ 
		                            '<td> <a href="'+link+'"> '+item.number+'号：'+item.name+' </a> </td>'+ 
		                            '<td>'+item.votes_number+'</td>'+
		                            '</tr>') ;    
			           			
			           	}else if(config.pm==3 && item.votes_number>0){
			           		itemObj.push('<tr>'+                         	
		                            '<td><img src="/wxService/resources/static/img/rank3.png" width="100%" /> </td>'+ 
		                            '<td> <a href="'+link+'"> '+item.number+'号：'+item.name+' </a> </td>'+ 
		                            '<td>'+item.votes_number+'</td>'+
		                            '</tr>') ;    			           			
			           	}else{
			          
	                    itemObj.push('<tr>'+                         	
	                            '<td>'+config.pm+' </td>'+ 
	                            '<td> <a href="'+link+'"> '+item.number+'号：'+item.name+' </a> </td>'+ 
	                            '<td>'+item.votes_number+'</td>'+
	                            '</tr>') ;
			           	}
                    }else{
                    	
                        itemObj.push('<tr>'+                         	
	                            '<td>'+config.pm+' </td>'+ 
	                            '<td> <a href="'+link+'"> '+item.number+'号：'+item.name+' </a> </td>'+ 
	                            '<td>'+item.votes_number+'</td>'+
	                            '</tr>') ;
                    }
                });
                box.append(itemObj);  
                loadStatus(2);
            } else {
                config.done = true;
                // if (config.page !== 1)
                //     loadStatus(0);
                // else
                loadStatus(3);
            }
            config.page++;
            config.loading = false;
        },
        error: function () {
            loadStatus(0);
            config.loading = false;
        }
    })
}



function getVoteItem() {
    if (config.done || config.loading) return;
    loadStatus(1, '正在加载' + config.item_name + '中...');
    config.loading = true;
    var box = $('.vote-item-box');
    if (!box.length) return;
    $.post({
        url: config.url_get_vote_item + '?type=' + config.url_get_type+'&keyword='+config.url_get_key,
        data: {"page.currentPage": config.page,"expType":"0","page.showCount":"30"},
        async: false,
		dataType:"json",
        success: function (data) {  
     
            if (config.page === 1) box.find('.vote-item').remove();
            var count=data.args.page.totalPage;
            if (count >= config.page) {            	
                $.each(data.data, function (index, item) {
                    var link = config.url_detail + '?detailId=' + item.id+"&actId="+config.cid;             
                    var itemObj = $('<div class="col-xs-' + config.show_column + ' vote-item">' +
                        (config.hide_cover !==1 ? '<div class="index-tag"><span>' + item.number + '号</span></div>' : '') +
                        '<div class="panel">' +
                        (config.hide_cover !==1 ? '<a class="img-box" href="' + link + '">' + '<img class="img" data-original="' + item.head_img_url + '">' + '</a>' : '') +
                        '<div class="panel-body" style="padding:10px;">' +
                        (config.hide_title !== 1 ? '<p class="t"><a href="' + link + '">' + (config.hide_cover !==1 ? '' : item.number + '号 ') + item.name + '</a></p>' : '') +
                        (config.hide_btn !== 1 ? '<p class="text-center"><a class="btn btn-sm btn-' + config.style + ' btn-block" href="javascript:;" onclick="vote(\'' + config.cid + '\',\'' + item.id + '\',\'' + item.name + '\');"><i class="fa fa-thumbs-up"></i> ' + config.btn_name + '</a></p>' : '') +
                        (config.hide_vote_count !== 1 && item.votes_number !== null ? '<p class="text-center"><span class="cnt_' + item.id + '">' + item.votes_number + '</span>' + config.unit_name + '</p>' : '') +
                        '</div>' +
                        '</div>' +
                        '</div>');
                    box.masonry().append(itemObj).masonry('appended', itemObj);
                    box.imagesLoaded(function () {
                        box.masonry();
                    });

                });
                $("img").lazyload({ 
    				placeholder : config.url_err_img,   
    				effect : "fadeIn", 
    				threshold : 300,
    				failurelimit : 10
    			});      
                loadStatus(2);
            } else {
                config.done = true;
                // if (config.page !== 1)
                //     loadStatus(0);
                // else 
                loadStatus(3);
            }
            config.page++;
            config.loading = false;
        },
        error: function () {
            loadStatus(0);
            config.loading = false;
        }
    })
}

function playAudioIframe(iframe) {
    var body = $('html');
    var audioIcon = bomObjs.audioIcon;
    var audio = $(iframe);
    if ($('iframe[_audio="1"]').length <= 0) {
        audio.attr('_audio', 1).hide();
        body.append(audio);
    }
    audioIcon.attr('_play', 1).show();
    audioIcon.bind('click', function () {
        var _play = $(this).attr('_play');
        if (_play == 1) {
            $('iframe[_audio="1"]').remove();
            $(this).attr('_play', 0).removeClass('animation-rotate');
        } else {
            $(this).attr('_play', 1).addClass('animation-rotate');
            body.append(audio);
        }
    });
}

function playAudio(path) {
    var audio;
    if (bomObjs.audio.length <= 0) {
        audio = $('<audio style="display: none;" loop="loop" controls="controls"><source src="' + path + '" type="audio/mpeg" /></audio>');
        $('html').append(audio);
        document.addEventListener("WeixinJSBridgeReady", function () {
            audio[0].play();
            verPlay(audio);
        }, false);
    } else {
        audio = bomObjs.audio;
    }
    bomObjs.audioIcon.show();
    bomObjs.audioIcon.bind('click', function () {
        if (audio[0].paused) {
            bomObjs.audioIcon.addClass('animation-rotate');
            audio[0].play();
        } else {
            bomObjs.audioIcon.removeClass('animation-rotate');
            audio[0].pause();
        }
    });
    verPlay(audio);
}

function verPlay(audio) {
    if (audio[0].paused) {
        bomObjs.audioIcon.removeClass('animation-rotate');
    } else {
        bomObjs.audioIcon.addClass('animation-rotate');
    }
}

function loadStatus(status, msg) {
    var loadbox = $('.loading-box');
    loadbox.find('.msg').unbind('click');
    loadbox.find('.msg').removeClass('btn').removeClass('btn-' + config.style).removeAttr('style');
    switch (status) {
        case 0:
            loadbox.hide();
            break;
        case 1:
            loadbox.find('img').show();
            loadbox.find('.msg').html(msg);
            loadbox.show();
            break;
        case 2:
            // loadbox.find('.msg').html('点击加载更多').addClass('btn').addClass('btn-' + config.style).css({marginBottom:'10px'});
            // loadbox.find('.msg').bind('click', function () {
            //     getVoteItem();
            // });
            loadbox.find('.msg').html('上拉加载更多~');
            loadbox.find('img').hide();
            loadbox.show();
            break;
        case 3:
            loadbox.find('.msg').html('没有更多数据了~');
            loadbox.find('img').hide();
            loadbox.show();
            break;
    }
}

function showTextRule() {
    var textRuleBox = $('.text-rule-box');
    var btnObj = $('.text-rule-a');
    textRuleBox.toggle();
    if (textRuleBox.is(':visible')) {
        btnObj.find('span').html('收起');
        btnObj.find('i').removeClass('fa-chevron-circle-right').addClass('fa-chevron-circle-down');
        // $.cookie('show_text_rule_box', null);
    } else {
        btnObj.find('span').html('展开');
        btnObj.find('i').removeClass('fa-chevron-circle-down').addClass('fa-chevron-circle-right');
        // $.cookie('show_text_rule_box', 'hide');
    }
}

function searchKeyword() {
    var isIOS = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    var verCodeBox = $('.so-box');
    var input = verCodeBox.find('input');
    var ly = layer.open({
        width: '200px',
        height: '120px',
        title: '请输入关键词',
        fixed: !isIOS,
        type: 1,
        shadeClose: false,
        content: verCodeBox,
        btn: ['搜索', '取消'],
        yes: function (index, layero) {
            var code = input.val();
            if (!code)
                tipsObj('请输入关键词', input);
            else {
                goUrl(config.url_search + '?keyword=' + input.val());           
                layer.close(index);
            }
        }
    });
    var st = $(document).scrollTop();
    var dh = $(window).height();
    if(isIOS){
        layer.style(ly, {
            position: 'absolute',
            top: st + dh*0.5 + 'px'
        });
    }
    input.val('');
    input.focus();
}

function searchKeyword2() {
    alertInput(function (val, index) {
        goUrl(config.url_search + '?keyword=' + val);
    }, '请输入关键词/编号')
}

function vote(actId, partId,name) {
 $.ajax({
	 type:"post",
 	 url:config.vote_url,
 	 data:{"actId":actId,"partId":partId},
 	 dataType:"json",
 	 success:function(data){
 		 if("invalid"==data.status){
 			showTips("今天你已经为"+name+"点过赞了，明天再来噢!",2000);
 		 }else if("success"==data.status){
 			showTips("点赞成功,明天继续来噢!",2000);
 		 }else if("nobegin"==data.status){
 			showTips("活动暂未开始!",2000); 
 		 }else if("end"==data.status){
 			showTips("活动已经结束!",2000);  
 		 }else if("nopart"==data.status){
 			showTips("系统识别为非法参数，请从首页进入参与点赞",2000);  
 		 }else if("invalidmain"==data.status){
 			showTips("参数获取异常，请从首页进入参与点赞",2000);  
 		 }else{
 			showTips("投票出现异常!",2000);
 		 }
 		 
 	 }
	 
 });
}

function showQrcode(h1, h2, title, saveStatus) {
    if (saveStatus && $.cookie('close_qrcode4') == 1) return;
    //页面层
    var showQrcodeBox = $('.show-qrcode-box');
    showQrcodeBox.find('.sqb-h1').html(h1);
    if (h2)
        showQrcodeBox.find('.sqb-h2').html(h2);
    else
        showQrcodeBox.find('.sqb-h2').hide();
    showQrcodeBox.find('img').attr('src', config.url_uploads_path + config.vote_success_img + config.img_tag_content).css({
        width: 200,
        height: 200
    });
    var h = title ? '400px' : '370px';
    layer.open({
        type: 1,
        title: title ? title : false,
        area: ['80%', h], //宽高
        content: showQrcodeBox,
        cancel: function () {
            if (saveStatus) $.cookie('close_qrcode4', 1, {path: '/'});
        }
    });
}

function showVerCode(cid, iid) {
    var isIOS = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    var verCodeBox = $('.ver-code-box');
    var verCodeImg = verCodeBox.find('.verify-img');
    verCodeImg.attr('src', config.url_ver);
    verCodeImg.bind('click', function () {
        $(this).attr('src', config.url_ver);
    });
    var ly = layer.open({
        width: '200px',
        height: '120px',
        title: '请输入验证码',
        fixed: !isIOS,
        type: 1,
        shadeClose: false,
        content: verCodeBox,
        btn: ['提交', '取消'],
        yes: function (index, layero) {
            var input = $('input[name="verify_code"]');
            var code = input.val();
            if (!code || code.length != 4)
                tipsObj('验证码为4位', input);
            else {
                vote(cid, iid, code);
                layer.close(index);
            }
        }
    });
    var st = $(document).scrollTop();
    var dh = $(window).height();
    if(isIOS){
        layer.style(ly, {
            position: 'absolute',
            top: st + dh*0.5 + 'px'
        });
    }
    var verCodeInput = verCodeBox.find('input');
    verCodeInput.val('');
    verCodeInput.focus();
}

function playFloatBox(content, type) {
    var bom = type === 1 ? '<span><i class="fa fa-' + content + '"></i></span>' : '<img class="not-js-style" src="' + content + '">';
    for (var i = 0; i < 20; i++) {
        $('.float-box').append('<li>' + bom + '</li>')
    }
    var param = {
        delay: [400, 12000],
        left: [0, 90],
        duration: [2000, 20000],
        width: [2, 5]
    };
    $('.float-box li').each(function (index) {
        var i = index + 1;
        var delay = Math.floor(param.delay[0] + Math.random() * (param.delay[1] - param.delay[0])) + Math.floor(200 + Math.random() * (200 - 50));
        var left = Math.floor(param.left[0] + Math.random() * (param.left[1] - param.left[0]));
        var duration = Math.floor(param.duration[0] + Math.random() * (param.duration[1] - param.duration[0])) + Math.floor(1000 + Math.random() * (1000 - 200));
        var width = Math.floor(param.width[0] + Math.random() * (param.width[1] - param.width[0] ));
        $('.float-box li:nth-child(' + i + ')').css({
            left: left + '%',
            animationDelay: delay + "ms",
            animationDuration: duration + "ms",
            width: width + 'rem',
            fontSize: width + 'rem'
        });
    });
}