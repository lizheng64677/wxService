function wecharPay(payData){
	$.ajax({
		type:"post",
		url:payData.requrl,
		data:{"id":payData.id,"name":payData.name},
		dataType:"json",
		success:function(data){
			   WeixinJSBridge.invoke(
				       'getBrandWCPayRequest', {
				           "appId" : data.info.appId,       //公众号名称，由商户传入
				           "timeStamp":data.info.timeStamp, //时间戳，自1970年以来的秒数     
				           "nonceStr" : data.info.nonceStr, //随机串     
				           "package" : data.info.package,     
				           "signType" :data.info.signType,  //微信签名方式：     
				           "paySign" : data.info.paySign     //微信签名 
				       },
				       function(res){ 
				           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
				               window.location.replace("order.html");
				           }else if(res.err_msg == "get_brand_wcpay_request:cancel"){
				               window.location.replace("order.html");
				           }
				       }
				   );
		   }
		});
	
}

//扫一扫
function scanQRCode(shareData){
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
					jsApiList: ['scanQRCode']
				});
			}
		}
	})
}

function scanQRCode(){
    wx.scanQRCode({
        needResult: 1,
        desc: 'scanQRCode desc',
        success: function (res) {
          alert(JSON.stringify(res));
        }
      });	
}
//去除微信的基本上所有的菜单
function hideOptionMenu(shareData){
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
					jsApiList: ['hideOptionMenu',
					            'chooseWXPay']
				});
				wx.ready(function () {
					wx.hideOptionMenu();
				});
			}else{
				alert("系统操作请求异常！！！！");
			}
		}})
}



function showOptionMenu(shareData){
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
					jsApiList: ['showOptionMenu']
				});
				wx.ready(function () {
					wx.showOptionMenu();
				});
			}else{
				alert("系统操作请求异常！！！！");
			}
		}})
}
/**
 * 详情页面分享
 * @param shareData
 */
function prodetailshar(shareData){
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
					            'getNetworkType',
					            'scanQRCode',
					            'chooseWXPay'					          
					            ]
				});
				wx.ready(function () {
					wx.showOptionMenu();
					wx.hideMenuItems({
						menuList: [
						           'menuItem:copyUrl',
						           'menuItem:openWithQQBrowser'
						           ]
					});
					//分享到朋友圈
					wx.onMenuShareTimeline({
						title: shareData.title,
						link: shareData.link,
						imgUrl:shareData.imgUrl, 
						success: function () { 				
							
						}
					});
					//分享给朋友
					wx.onMenuShareAppMessage({
						title: shareData.title,
						desc:shareData.desc,
						link: shareData.link,
						imgUrl:shareData.imgUrl, 
						success: function (res) {
		
						}
					});
				});
			}else{
				alert("系统操作请求异常！！！！");
			}
		}})

}




/**
 * js sdk 处理自定义分享
 * @param reqData
 * @param shareData
 */
function sharTimelineFun(shareData){
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
					            'getNetworkType',
					            'chooseWXPay'
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
	})
}







