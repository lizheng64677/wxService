function loadStar(fn,score,fullSrc,halfSrc,emptySrc,appendWay){
	var inte = Math.floor(score);
	var decimal = score-inte;
	var res = 5 - inte;
	var html = '';
	for(var i = 0;i< inte ;i++){
		html += '<span><a href="javascript:void(0)"><img src="'+fullSrc+'"></a></span>';
	}
	if(decimal>0.4){
		html += '<span><a href="javascript:void(0)"><img src="'+halfSrc+'"></a></span>';
		res = res - 1;
	}
	if(res > 0){
		for(var i=0;i<res;i++){
			html += '<span><a href="javascript:void(0)"><img src="'+emptySrc+'"></a></span>';
		}
	}
	if(appendWay=="appendTo"){
		$(html).appendTo(fn);
	}else if(appendWay=="prependTo"){
		$(html).prependTo(fn);
	}else{
		$(fn).html(html);
	}
}
function showPromptDialog(imgSrc,btnName,promptTitle,promptMsg,linkUrl){
	$("#imgId").attr("src",imgSrc);
	$("#promptTitle").html(promptTitle);
	$("#promptMsg").html(promptMsg);
	$("#btn").val(btnName);
	$("#btn").attr("name",linkUrl);
	$("#sqSuccessBox").show();
}
function closeDialog(isSkip){
	$("#sqSuccessBox").hide();
	if(isSkip=='1'){
		var linkUrl = $("#btn").attr("name");
		if(linkUrl!=""){
			location.href = linkUrl;
		}
	}
}



function headerBanner(){
	
    var f_obj = document.getElementById('headerBanner');
    if(f_obj) {
        var f_y = f_obj.offsetTop;
        var f_class = f_obj.className;
        document.onscroll = function(){
        	if(document.body.scrollTop>f_y){
        		f_obj.className += " fixed_t";
        	}else{
        		f_obj.className = f_class;
        	}
        }         
    }   
}