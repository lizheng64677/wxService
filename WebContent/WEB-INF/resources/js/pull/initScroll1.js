//在该项目情况下，参数elm就是$(document),参数bH和tos两个相互配合，设置滑动区域的高度和位置
function fixed(elm,bH,tos) {
	var myScroll,count,pullUpEl, pullUpOffset;
	var serverURL,display;
	var searchCondition={"page.currentPage":1};
	if ($.mobile.activePage.data("iscroll-plugin")) {
		return;
	}
	elm.css({overflow : 'hidden'});
	var barHeight = bH; // 页头页尾高度
    var $header = elm.find('[data-role="header"]');
    if ($header.length) {
    	$header.css({
    		"z-index": 1000,
    		padding: 0,
    		width: "100%"
    	});
    	barHeight += $header.height();
    }
    // 设置页尾样式
    var $footer = elm.find('[data-role="footer"]');
    if ($footer.length) {
    	$footer.css({
    		"z-index": 1500,
    		padding: 0,
    		width: "100%"
    	});
    	barHeight += $footer.height();
    }
	var $wrapper = elm.find('[data-role="content"]');
	if ($wrapper.length) {
		$wrapper.css({
			"z-index" : 1
		});
		//$wrapper.height($(window).height());
		$wrapper.bind('touchmove', function(e) {
			e.preventDefault();
		});
	}
	var scroller = elm.find('[data-iscroll="scroller"]')
			.get(0);
	if (!scroller) {
		$($wrapper.get(0)).children().wrapAll(
				"<div data-iscroll='scroller'></div>");
	}
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	pullUpLabel=pullUpEl.querySelector('.pullUpLabel');
	myScroll = new iScroll(
			$wrapper.get(0),
			{
				useTransition : true, 
				topOffset : tos,
				hScroll : true,
				vScroll : true,
				hScrollbar : false,
				vScrollbar : true,
				fixedScrollbar : true,
				fadeScrollbar : true,
				hideScrollbar : true,
				bounce : true,
				momentum : true,
				lockDirection : true,
				checkDOMChanges : true,
				onScrollMove : function() {
					if (this.y < (this.maxScrollY - 15) && !pullUpEl.className .match('flip')) {
						pullUpEl.className = 'flip';
						pullUpEl .querySelector('.pullUpLabel').innerHTML = '松手开始更新...';
						this.maxScrollY = this.maxScrollY;
					} else if (this.y > (this.maxScrollY + 15) && pullUpEl.className .match('flip')) {
						pullUpEl.className = '';
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
						this.maxScrollY = pullUpOffset;
					}
				},
				onScrollEnd : function() {
					if (pullUpEl.className.match('flip')) {
						if (searchCondition['page.currentPage'] != -1&& Number(searchCondition['page.currentPage']) >Number(count)) {
							pullUpEl.className = '';
							myScroll.refresh();
							pullUpEl.querySelector('.pullUpLabel').innerHTML = '已加载完全部信息';
							return ;
						}						
						pullUpEl.className = 'loading';
						pullUpLabel.innerHTML = '加载中...';
						pullUpAction();
					}
				},
			});
	$.mobile.activePage.data("iscroll-plugin", myScroll);
	function pullUpAction() {
		setTimeout(loadData,300);
	}
	function loadData() {
		if(!searchCondition['page.currentPage']) searchCondition['page.currentPage']=1;
		console.log("当前页：" + searchCondition['page.currentPage'] + " || 总页数：" + count);
		$.ajax({
				//async : false,
				url : serverURL, 
				type : 'post',
				data :searchCondition,
				dataType:"json",
				timeout : 6000,
				success : function(datas) {
					//应该服务器端传回总共几页
					count=datas.args.page.totalPage;
					display(datas);
					myScroll.refresh(); 
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
					if (Number(searchCondition['page.currentPage']) >= Number(count)) {
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '已加载完全部信息';
						myScroll.refresh();
						pullUpEl.className = '';
					}
					searchCondition['page.currentPage']+=1;
				},
				error : function(xhr) {
					alert("当前网络状况不稳定!");
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';					
					myScroll.refresh();
				}
			});
	}
	window.setTimeout(function() {
		myScroll.refresh();
	}, 200);
	
	return {
		setSearchCondition:function(sc){searchCondition=sc;},
		getSearchCondition:function(){return searchCondition},
		setUrl:function(url){serverURL=url;},
		setDisplay:function(dis){display=dis},
		initSearch:function(){
			pullUpEl.className = 'loading';
			pullUpLabel.innerHTML = '加载中...';			
			pullUpAction();
		}
	}
}
