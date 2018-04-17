/**
 * js sdk 处理自定义分享
 * 包含定位的地理位置信息
 * @param reqData
 * @param shareData
 */
define(function(require, exports, module){

	var _testHomeIndex=function(){
		localStorage.setItem('lng', "118.72944");  // 纬度，浮点数，范围为90 ~ -90
		localStorage.setItem('lat', "31.982765");  // 经度，浮点数，范围为180 ~ -180。
		//用户拒绝上传位置信息默认南京市
		require.async('./postion', function(init){

			init.initPostion(shareData);
		});
		
	}
	var _sharTimelineFunAndGetLocation=function(shareData){
		$.ajax({
			type:"get",
			url:shareData.requrl,
			data:{"url":shareData.param},
			dataType:"json",
			success:function(result){
				if(result.status=="ok"){

					wx.config({
						debug: false,
						appId:result.appId,
						timestamp:result.timestamp,
						nonceStr: result.nonceStr,
						signature:result.signature,
						jsApiList: [
						            'onMenuShareTimeline',
						            'onMenuShareAppMessage',
						            'onMenuShareQQ',
						            'onMenuShareWeibo',
						            'hideMenuItems',
						            'showMenuItems',
						            'hideOptionMenu',
						            'showOptionMenu',
						            'getLocation'
						            ]
					});
					wx.ready(function(){
						wx.showOptionMenu();
						wx.hideMenuItems({
							menuList: [
							           'menuItem:copyUrl',
							           'menuItem:openWithQQBrowser'
							           ]
						});
						wx.onMenuShareTimeline({
							title: shareData.title,
							desc:shareData.desc,
							link: shareData.link,
							imgUrl:shareData.imgUrl, 
							success: function () { 
							}
						});
						wx.onMenuShareAppMessage({
							title: shareData.title,
							desc:shareData.desc,
							link: shareData.link,
							imgUrl:shareData.imgUrl, 
							success: function (res) {
							}
						});
						wx.onMenuShareQQ({
							title: shareData.title,
							desc:shareData.desc,
							link: shareData.link,
							imgUrl:shareData.imgUrl, 
							success: function () { 
							}
						});
						wx.onMenuShareWeibo({
							title: shareData.title,
							desc:shareData.desc,
							link: shareData.link,
							imgUrl:shareData.imgUrl, 
							success: function () { 
							}
						});
					})
				}else{
					alert("系统操作请求异常！！！！");
				}
			}
		});

	}

	exports.inintWx=function(data){
		console.log("初始化威信签名");	
		_sharTimelineFunAndGetLocation(data);
	}

	exports.initTest=function(){
		console.log("pc端测试");
		_testHomeIndex();
	}
});