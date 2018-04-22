/**
 * 
 */
//这个root最好把 http://ip等等都写上，不要省
ROOT="/wxService";


var layIndex;
post=function(url,data,isShell,loadingMsg){
	if(isShell) layIndex=layer.open({type: 2,content: loadingMsg?loadingMsg:'加载中' });
	var deffered=$.Deferred();
	$.ajax({
		url:ROOT+url,
		data:data,
		type:"post",
		dataType:"json",
		success:function(data){
			debugger;
			if(isShell) layer.close(layIndex);
			//此处是wxService后台请求inService服务时，如果他们之间的网断了，就是error==1
			if(data.error==1){
			}else if(data.error==0){
				deffered.resolve(data);	
			}
		},
		//这是wxService自己的服务器挂了
		error:function(){
			layer.closeAll();
		}
	})
	return deffered.promise();
}

function showAlert(text){
	layer.open({ 
		content:text ,
	    style: 'background-color:black; color:#fff; border:none;',
	    time: 2
	});
}
