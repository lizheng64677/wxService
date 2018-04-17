var imgSrc = "/wxService/resources/css/images/bg2.png";
var result = 0;
var s = 0;
var r_s = 0;
var scroWidth = $(window).width();
var scroHeight = $(window).height();
var height = 0.211*scroHeight;
var width  = 0.728*scroWidth;
var promptMsg="";
function init(){
	//取图片所占比例
	r_s = 0;
	s = 0;
	result = 0;
	$("#gua1_img").width(0.767*scroWidth).height(0.235*scroHeight);
	$("#front").css({"top":"40.8%","left":"13%"});
	bodys(height,width);
}
function bodys(height,width){
	s = height*width;
	var img = new Image();         
	var canvas = document.querySelector('canvas');         
	canvas.style.position = 'absolute';           
	img.addEventListener('load',function(e){  
		var ctx;
		var w = width, h = height;             
		var offsetX = canvas.offsetLeft, offsetY = canvas.offsetTop;     
		var mousedown = false;               
		function layer(ctx){                 
			ctx.fillStyle = 'gray';                 
			ctx.fillRect(0, 0, w, h);     
			//设置字体样式
			ctx.lineWidth=50;
			ctx.textAlign="center";
			ctx.textBaseline='middle';
		    ctx.font = "25px Courier New";
		    //设置字体填充颜色
		    ctx.fillStyle = "white";
		    //从坐标点(50,50)开始绘制文字
		    ctx.fillText("请用手指轻轻刮开", 0.494*width, 0.5*height);
		}   
		function eventDown(e){                 
			e.preventDefault();                 
			mousedown=true;             
		}   
		function eventUp(e){            
			e.preventDefault();                 
			mousedown=false;             
		}               
		function eventMove(e){
			e.preventDefault();                 
			if(mousedown){                     
				if(e.changedTouches){                         
					e=e.changedTouches[e.changedTouches.length-1];                     
				}                     
				var x = (e.clientX + document.body.scrollLeft || e.pageX) - offsetX || 0,                         
				y = (e.clientY + document.body.scrollTop || e.pageY) - offsetY || 0;    
				with(ctx){                    
					beginPath();                     
					arc(x, y, 30, 0, Math.PI * 2);                         
					fill();
					r_s = r_s + 900*3.14;
					if(r_s/s > 2){
						if(result == 0){
							//移除事件禁止继续
						    canvas.removeEventListener('touchstart', eventDown);             
							canvas.removeEventListener('touchend', eventUp);             
							canvas.removeEventListener('touchmove', eventMove);             
							canvas.removeEventListener('mousedown', eventDown);             
							canvas.removeEventListener('mouseup', eventUp);             
							canvas.removeEventListener('mousemove', eventMove);
							callBack();
						}
						result = 1;
					}
				}                
			}             
		}               
		canvas.width=w;             
		canvas.height=h; 
		
		canvas.style.backgroundImage='url('+img.src+')';              
		ctx=canvas.getContext('2d');         
		//ctx.fillStyle='b9b9b9';             
		ctx.fillRect(0, 0, w, h);

		layer(ctx);               
		ctx.globalCompositeOperation = 'destination-out';               
		canvas.addEventListener('touchstart', eventDown);             
		canvas.addEventListener('touchend', eventUp);             
		canvas.addEventListener('touchmove', eventMove);             
		canvas.addEventListener('mousedown', eventDown);             
		canvas.addEventListener('mouseup', eventUp);             
		canvas.addEventListener('mousemove', eventMove);       
	});
	
	img.src = imgSrc;
	(document.body.style);
}
//刮刮乐重新绘图
function callBack(){
	postAjax();
	//重新设置绘图区域
	var canvas = document.querySelector('canvas');         
	canvas.style.position = 'absolute';
	canvas.width=width;             
	canvas.height=height; 
	//设置背景
	canvas.style.backgroundImage=imgSrc;              
	var ctx=canvas.getContext('2d');         
	ctx.fillStyle = '#ffd700';   
		ctx.fillRect(0, 0, width, height);     
		//设置字体样式
	ctx.lineWidth=50;
	ctx.textAlign="center";
	ctx.textBaseline='middle';
    ctx.font = "bold 35px Courier New";
    //设置字体填充颜色
    ctx.fillStyle = "gray";
    //从坐标点(50,50)开始绘制文字
    if(promptMsg == ""){
    	promptMsg = "感谢您的参与!";
    }
    ctx.fillText(promptMsg, 0.494*width, 0.5*height);
    //移除事件禁止继续
    canvas.removeEventListener('touchstart', eventDown);             
	canvas.removeEventListener('touchend', eventUp);             
	canvas.removeEventListener('touchmove', eventMove);             
	canvas.removeEventListener('mousedown', eventDown);             
	canvas.removeEventListener('mouseup', eventUp);             
	canvas.removeEventListener('mousemove', eventMove);
}
//关闭刮刮乐弹窗
function closeGuaDialog(){
	$("#guaguaDialog").hide();
}
//抽签js
function statr(){
	$(".sprite").css("animation","play 0.8s steps(5) infinite");
	$(".sprite").css("-webkit-animation","play 0.8s steps(5) infinite");
	$('.result').show();
	setTimeout(showDecode, 2000);
};

function showDecode(){
	$('.cover').hide();
	setTimeout(fim(),500);
}

function fim(){
	$(".gglMainBox").show();
	$("#prpDialog").hide();
	$(".sprite").css("animation","");
	$(".sprite").css("-webkit-animation","");
	involvedExpPrize();
}

function postAjax(){
	
	$.ajax({
		type:"post",
		url:"/wxService/expVolved/involVedPrize",
		data:{"detailId":$("#detailId").val(),"memberId":$("#memberId").val(),"expId":$("#expId").val()},
		dataType:"json",
		async:false,
		success:function(res){
			if("invalidDetailInfo"==res.message){

				promptMsg="您已经参与过本期活动了!";				
				
			}else if("invalidExpInfo"==res.message){
				
				promptMsg="当前活动查询异常！";
				
			}else if("started"==res.message){
				
				promptMsg="活动暂未开始";
	
			}else if("invalidTimeExp"==res.message){
				 
				promptMsg="本期活动已经结束，请期待后期项目！";
	
			}else if("yprize"==res.message){
				
				promptMsg="活动参与成功！！！！请晒给你的好伙伴！！";

			}else if("invalidUser"==res.message){
				
				promptMsg="您的资料不完善，请完善资料后再次参加！";				

			}else if("invlidProNum"==res.message){
		
				promptMsg="该活动产品数量不足！";	
			}
			
		}
	});
	
	
	
}
