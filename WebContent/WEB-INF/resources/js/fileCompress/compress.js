    /**
     * 获得base64
     * @param {Object} o
     * @param {Number} [o.width] 图片需要压缩的宽度
     * @param {Number} [o.height] 图片需要压缩的高度，为空则会跟随宽度调整
     * @param {Number} [o.quality=0.8] 压缩质量，不压缩为1
     * @param {Number} [o.mixsize] 上传图片大小限制
     * @param {Number} [o.type] 上传图片格式限制 'image/png,image/jpg,image/jpeg,image/pjpeg,image/gif,image/bmp,image/x-png'
     * @param {Function} [o.before(blob)] 处理前函数,this指向的是input:file
     * @param {Function} o.success(obj) 处理后函数
     * @param {Function} o.error(obj) 处理后函数
     * @example
     *
     */

    $.fn.UploadImg = function(o){
        this.change(function(){
            var file = this.files['0'];
            if(file.size && file.size > o.mixsize){
                o.error(1);
                this.value='';
            }else if(o.type && o.type.indexOf(file.type) < 0){
                o.error(2);
                this.value='';
            }else{
            	if(FileReader){
	            	var reader = new FileReader();
	        		reader.onload = function(e) {
	        			 o.before(e.target.result);
	        			 _compress(e.target.result,file);
	        		};
	        		o.loadStart();
	            	reader.readAsDataURL(file);
            	}else{
            		//如果不支持FileReader就等死吧...
            		var U = window.URL || window.webkitURL;
            		var blob =U.createObjectURL(file);
            		o.before(blob);
            		_compress(blob,file);
            		this.value='';
            	}
            }
        });


        function _compress(blob,file){
            var img = new Image();
            img.src = blob;
            img.onload = function(){
                var canvas = document.createElement('canvas');
                var ctx = canvas.getContext('2d');
                if(!o.width && !o.height && o.quality == 1){
                    var w = this.width;
                    var h = this.height;
                }else{
                	var w,h;
                	if(o.width<this.width){
                		w = o.width || this.width;
                		h = o.height || w/this.width*this.height;
                	}else{
                		w=this.width;
                		h=this.height;
                	}
                }
                $(canvas).attr({width : w, height : h});
                ctx.drawImage(this, 0, 0, w, h);
                var base64 = canvas.toDataURL(file.type, (o.quality || 0.8)*1 );
                if( navigator.userAgent.match(/iphone/i) ) {
                    var mpImg = new MegaPixImage(img);
                    mpImg.render(canvas, { maxWidth: w, maxHeight: h, quality: o.quality || 0.8, orientation: 1});
                    base64 = canvas.toDataURL(file.type, o.quality || 0.8 );
                }
                
                // 修复android
                if( navigator.userAgent.match(/Android/i) ) {
                    var encoder = new JPEGEncoder();
                    base64 = encoder.encode(ctx.getImageData(0,0,w,h), o.quality * 100 || 80 );
                }
                _ajaximg( base64,file);
            };
        }

        function _ajaximg(base64,file){
        	$.ajax({
        		url:o.url,
        		data:{base64:base64,type:file.type,name:file.name,size:file.size,module:o.module},
        		dataType:'json',
        		type:'post',
        		success:function(res){
        			o.loadStop();
        			o.success(res);
        		}
        	});
        }
    };


    