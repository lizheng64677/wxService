/**
 * 
 */
$(document).ready(function(){
		$("#img").click(function(){
			$('#test').trigger('click');
		});
	});
	var loading;
    $('#test').UploadImg({
        url : ROOT+'/userlr/fileUpload',
        width : '600',    //如果设置了width，就会改变原图长，那样压缩的图片更小
        quality : '1', //压缩率，默认值为0.8 ，如果是1，并且没有设置width，那就上传原图
        mixsize : '10000000',  //最大图片大小，单位是B，这里设置为大约10M
        type : 'image/png,image/jpg,image/jpeg,image/pjpeg,image/gif,image/bmp,image/x-png',
        before : function(blob){
            $('#img').attr('src',blob);
        },
        error : function(res){
        	 //前台验证， res==1表示图片太大了，res==2表示格式不正确
        	showError(res);
        },
        success : function(res){
        	//上传成功后，只有res.flag==0表示上传成功
           showSuccess(res);
        },
        loadStart:function(){
        	//开始加载的遮罩,这里用的是layer.m的遮罩，换个更好的吧
        	loading=layer.open({
    		    type: 2,
    		    content: '上传中'
    		});
        },
        loadStop:function(){
        	layer.close(loading);
        }
    });
    
    //下面两个是默认的失败/成功后的回调，如果需要可以重写他们
    function showError(res){
    	if(res==1)
    		$("#error").html("图片太大了");
    	else if(res==2)
    		$("#error").html("格式不正确");
    }
    function showSuccess(res){
    	if(res.flag==0){
    		$("#imgurl").html(res.url);
    	}
    }