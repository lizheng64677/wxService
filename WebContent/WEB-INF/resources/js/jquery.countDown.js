/**
 * wzf 倒数
 */
(function($,window){
	$.fn.cW=function(config){
		var interval;
		var time=config.time;
		var kk=$(this);
		var work=function(){
			console.log("this is start");
			if(time>=0){
				kk.html(time+"秒");
			}else{
				stop();
			}
			time--;
		}
		function start(){
			$(".verification").off("click",getCheckCode);
			work();
			interval=window.setInterval(work,1000);
		}
		function stop(){
			window.clearInterval(interval);
			kk.html("获取验证码");
			$(".verification").on("click",getCheckCode);
		}
		
		return{
			start:function(){start()},
			stop:function(){stop();}
		};
	}
})(jQuery,window);
