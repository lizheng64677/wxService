//该参数用来标志 radio，checkbox之类有没有被选中过（必须回答了问题之后才能进入下一题）
//思路是，append radio 和checkbox是把fuckflag改为true，在选中事件里把fuckflag改为false，最后如果fuckflag=true，则表表示还有至少一题没有回答
var fuckflag=true;
var kkflag=false;
var PageTransitions = (function() {

	var $main = $( '#pt-main' ),
		$pages = $main.children( 'div.pt-page' ),
		$nextPage = $( '#nextPage' ),
		$lastPage = $( '#lastPage' ),
		animcursor = 1,
		pagesCount = $pages.length,
		current = 0,
		isAnimating = false,
		endCurrPage = false,
		endNextPage = false,
		animEndEventNames = {
			'WebkitAnimation' : 'webkitAnimationEnd',
			'OAnimation' : 'oAnimationEnd',
			'msAnimation' : 'MSAnimationEnd',
			'animation' : 'animationend'
		},
		// animation end event name
		animEndEventName = animEndEventNames[ Modernizr.prefixed( 'animation' ) ],
		// support css animations
		support = Modernizr.cssanimations;
	
	function init() {

		$pages.each( function() {
			var $page = $( this );
			$page.data( 'originalClassList', $page.attr( 'class' ) );
		} );

		$pages.eq( current ).addClass( 'pt-page-current' );

		$( '#dl-menu' ).dlmenu( {
			animationClasses : { in : 'dl-animate-in-2', out : 'dl-animate-out-2' },
			onLinkClick : function( el, ev ) {
				ev.preventDefault();
				nextPage( el.data( 'animation' ) );
			}
		} );

		$lastPage.on( 'click', function() {
			if( isAnimating ) {
				return false;
			}
			
			var page=$(this).attr("page");
			nextPage(page*1,"last");
			
			
			var pageS=$(".pt-page-"+current).find("div");
			//alert($(pageS).attr("id"));
			$("#pageCode").val($(pageS).attr("id"));
			inde($(pageS).attr("id"),false,null);
			
			//控制最后一页向右箭头显示
			if( current >= pagesCount - 2 && current >0) {
				$("#nextPage").show();
				$("#finalPage").hide();
			}
		} );
		
		$nextPage.on( 'click', function() {
			if( isAnimating ) {
				return false;
			}
			var pageCode=$("#pageCode").val();
			var select1=$("#"+pageCode).find(".noBotton");
			var select2=$("#"+pageCode).find("option:selected");
			//var imgs=$("#"+pageCode).find("img");
			var flag=false;
			//如果存在下列框，那么一定要有选项
			$("#"+pageCode).find("select").each(function(){
				if($(this).val()==-1)
					flag=true;
			});
			//如果存在radio，那么一点要有选过
			
			//如果存在checkbox，那么一定要选过
			
			
			if( $("#"+pageCode).find(".yesBotton").length>0&& select1.length*2 < $("#"+pageCode).find(".yesBotton").length || flag){
				showAlert("请完善选项!");
				return false;
			}
			flag=false;
			if($(".homeStatus").length>0){
				$(".homeStatus").find("img").each(function(){
					if($(this).attr("src").indexOf("11")>0)
						flag=true;
				});
				if(!flag){
					showAlert("请完善选项!");
					return false;			
				}
			}
			flag=false;
			if($(".pt-page-current").find(".CarBox,.noneCarBox").length>0){
				$(".CarBox,.noneCarBox").find("img").each(function(){
					if($(this).attr("src").indexOf("11")>0)
						flag=true;
				});
				if(!flag){
					showAlert("请完善选项!");
					return false;			
				}
				
			}

			
//			var retFlag = false;
//			for(var i=0;i<imgs.length;i++)
//			{				  
//				  var src=$(imgs[i]).attr("src");
//				  if(src.indexOf("11")==-1)
//				  {			  	
//					retFlag = true;
//					return ;
//				  }
//			}
//			if(retFlag){
//				showAlert("请完善选项!");
//				return false;
//			}
			
			var page=$(this).attr("page");
			nextPage(page*1,"next");
			
			
			var pageS=$(".pt-page-"+current).find("div");
			//alert($(".pt-page-"+pageCount).attr("class"));
		
			//var pageCode=$("#pageCode").val();
			savePrototype(pageCode);
		
			//nextPage(page*1,"next");
			
			inde($(pageS).attr("id"),false,null);
			$("#pageCode").val($(pageS).attr("id"));
			
		} );

	}

	function nextPage( animation,pageType ) {
		
		
		
		if( isAnimating ) {
			return false;
		}

		isAnimating = true;
		
		var $currPage = $pages.eq( current );

		if("last"==pageType){
			--current;
		}else if("next"==pageType){
			++current;
		}
		
		currentAll = current;
		pagesCountAll = pagesCount ;
		
		//控制最后一页提交显示
		if( current >= pagesCount - 1 && current >0) {
			$("#nextPage").hide();
			$("#finalPage").show();
		}
		
		if( current >= pagesCount - 1 ) {
			current=pagesCount-1;
		}
		else if(current<=0){
			current = 0;
		}

		var $nextPage = $pages.eq( current ).addClass( 'pt-page-current' ),
			outClass = '', inClass = '';

		switch( animation ) {

			case 1:
				outClass = 'pt-page-moveToLeft';
				inClass = 'pt-page-moveFromRight';
				break;
			case 2:
				outClass = 'pt-page-moveToRight';
				inClass = 'pt-page-moveFromLeft';
				break;
			case 3:
				outClass = 'pt-page-moveToTop';
				inClass = 'pt-page-moveFromBottom';
				break;
			case 4:
				outClass = 'pt-page-moveToBottom';
				inClass = 'pt-page-moveFromTop';
				break;
			case 5:
				outClass = 'pt-page-fade';
				inClass = 'pt-page-moveFromRight pt-page-ontop';
				break;
			case 6:
				outClass = 'pt-page-fade';
				inClass = 'pt-page-moveFromLeft pt-page-ontop';
				break;
			case 7:
				outClass = 'pt-page-fade';
				inClass = 'pt-page-moveFromBottom pt-page-ontop';
				break;
			case 8:
				outClass = 'pt-page-fade';
				inClass = 'pt-page-moveFromTop pt-page-ontop';
				break;
			case 9:
				outClass = 'pt-page-moveToLeftFade';
				inClass = 'pt-page-moveFromRightFade';
				break;
			case 10:
				outClass = 'pt-page-moveToRightFade';
				inClass = 'pt-page-moveFromLeftFade';
				break;
			case 11:
				outClass = 'pt-page-moveToTopFade';
				inClass = 'pt-page-moveFromBottomFade';
				break;
			case 12:
				outClass = 'pt-page-moveToBottomFade';
				inClass = 'pt-page-moveFromTopFade';
				break;
			case 13:
				outClass = 'pt-page-moveToLeftEasing pt-page-ontop';
				inClass = 'pt-page-moveFromRight';
				break;
			case 14:
				outClass = 'pt-page-moveToRightEasing pt-page-ontop';
				inClass = 'pt-page-moveFromLeft';
				break;
			case 15:
				outClass = 'pt-page-moveToTopEasing pt-page-ontop';
				inClass = 'pt-page-moveFromBottom';
				break;
			case 16:
				outClass = 'pt-page-moveToBottomEasing pt-page-ontop';
				inClass = 'pt-page-moveFromTop';
				break;
			case 17:
				outClass = 'pt-page-scaleDown';
				inClass = 'pt-page-moveFromRight pt-page-ontop';
				break;
			case 18:
				outClass = 'pt-page-scaleDown';
				inClass = 'pt-page-moveFromLeft pt-page-ontop';
				break;
			case 19:
				outClass = 'pt-page-scaleDown';
				inClass = 'pt-page-moveFromBottom pt-page-ontop';
				break;
			case 20:
				outClass = 'pt-page-scaleDown';
				inClass = 'pt-page-moveFromTop pt-page-ontop';
				break;
			case 21:
				outClass = 'pt-page-scaleDown';
				inClass = 'pt-page-scaleUpDown pt-page-delay300';
				break;
			case 22:
				outClass = 'pt-page-scaleDownUp';
				inClass = 'pt-page-scaleUp pt-page-delay300';
				break;
			case 23:
				outClass = 'pt-page-moveToLeft pt-page-ontop';
				inClass = 'pt-page-scaleUp';
				break;
			case 24:
				outClass = 'pt-page-moveToRight pt-page-ontop';
				inClass = 'pt-page-scaleUp';
				break;
			case 25:
				outClass = 'pt-page-moveToTop pt-page-ontop';
				inClass = 'pt-page-scaleUp';
				break;
			case 26:
				outClass = 'pt-page-moveToBottom pt-page-ontop';
				inClass = 'pt-page-scaleUp';
				break;
			case 27:
				outClass = 'pt-page-scaleDownCenter';
				inClass = 'pt-page-scaleUpCenter pt-page-delay400';
				break;
			case 28:
				outClass = 'pt-page-rotateRightSideFirst';
				inClass = 'pt-page-moveFromRight pt-page-delay200 pt-page-ontop';
				break;
			case 29:
				outClass = 'pt-page-rotateLeftSideFirst';
				inClass = 'pt-page-moveFromLeft pt-page-delay200 pt-page-ontop';
				break;
			case 30:
				outClass = 'pt-page-rotateTopSideFirst';
				inClass = 'pt-page-moveFromTop pt-page-delay200 pt-page-ontop';
				break;
			case 31:
				outClass = 'pt-page-rotateBottomSideFirst';
				inClass = 'pt-page-moveFromBottom pt-page-delay200 pt-page-ontop';
				break;
			case 32:
				outClass = 'pt-page-flipOutRight';
				inClass = 'pt-page-flipInLeft pt-page-delay500';
				break;
			case 33:
				outClass = 'pt-page-flipOutLeft';
				inClass = 'pt-page-flipInRight pt-page-delay500';
				break;
			case 34:
				outClass = 'pt-page-flipOutTop';
				inClass = 'pt-page-flipInBottom pt-page-delay500';
				break;
			case 35:
				outClass = 'pt-page-flipOutBottom';
				inClass = 'pt-page-flipInTop pt-page-delay500';
				break;
			case 36:
				outClass = 'pt-page-rotateFall pt-page-ontop';
				inClass = 'pt-page-scaleUp';
				break;
			case 37:
				outClass = 'pt-page-rotateOutNewspaper';
				inClass = 'pt-page-rotateInNewspaper pt-page-delay500';
				break;
			case 38:
				outClass = 'pt-page-rotatePushLeft';
				inClass = 'pt-page-moveFromRight';
				break;
			case 39:
				outClass = 'pt-page-rotatePushRight';
				inClass = 'pt-page-moveFromLeft';
				break;
			case 40:
				outClass = 'pt-page-rotatePushTop';
				inClass = 'pt-page-moveFromBottom';
				break;
			case 41:
				outClass = 'pt-page-rotatePushBottom';
				inClass = 'pt-page-moveFromTop';
				break;
			case 42:
				outClass = 'pt-page-rotatePushLeft';
				inClass = 'pt-page-rotatePullRight pt-page-delay180';
				break;
			case 43:
				outClass = 'pt-page-rotatePushRight';
				inClass = 'pt-page-rotatePullLeft pt-page-delay180';
				break;
			case 44:
				outClass = 'pt-page-rotatePushTop';
				inClass = 'pt-page-rotatePullBottom pt-page-delay180';
				break;
			case 45:
				outClass = 'pt-page-rotatePushBottom';
				inClass = 'pt-page-rotatePullTop pt-page-delay180';
				break;
			case 46:
				outClass = 'pt-page-rotateFoldLeft';
				inClass = 'pt-page-moveFromRightFade';
				break;
			case 47:
				outClass = 'pt-page-rotateFoldRight';
				inClass = 'pt-page-moveFromLeftFade';
				break;
			case 48:
				outClass = 'pt-page-rotateFoldTop';
				inClass = 'pt-page-moveFromBottomFade';
				break;
			case 49:
				outClass = 'pt-page-rotateFoldBottom';
				inClass = 'pt-page-moveFromTopFade';
				break;
			case 50:
				outClass = 'pt-page-moveToRightFade';
				inClass = 'pt-page-rotateUnfoldLeft';
				break;
			case 51:
				outClass = 'pt-page-moveToLeftFade';
				inClass = 'pt-page-rotateUnfoldRight';
				break;
			case 52:
				outClass = 'pt-page-moveToBottomFade';
				inClass = 'pt-page-rotateUnfoldTop';
				break;
			case 53:
				outClass = 'pt-page-moveToTopFade';
				inClass = 'pt-page-rotateUnfoldBottom';
				break;
			case 54:
				outClass = 'pt-page-rotateRoomLeftOut pt-page-ontop';
				inClass = 'pt-page-rotateRoomLeftIn';
				break;
			case 55:
				outClass = 'pt-page-rotateRoomRightOut pt-page-ontop';
				inClass = 'pt-page-rotateRoomRightIn';
				break;
			case 56:
				outClass = 'pt-page-rotateRoomTopOut pt-page-ontop';
				inClass = 'pt-page-rotateRoomTopIn';
				break;
			case 57:
				outClass = 'pt-page-rotateRoomBottomOut pt-page-ontop';
				inClass = 'pt-page-rotateRoomBottomIn';
				break;
			case 58:
				outClass = 'pt-page-rotateCubeLeftOut pt-page-ontop';
				inClass = 'pt-page-rotateCubeLeftIn';
				break;
			case 59:
				outClass = 'pt-page-rotateCubeRightOut pt-page-ontop';
				inClass = 'pt-page-rotateCubeRightIn';
				break;
			case 60:
				outClass = 'pt-page-rotateCubeTopOut pt-page-ontop';
				inClass = 'pt-page-rotateCubeTopIn';
				break;
			case 61:
				outClass = 'pt-page-rotateCubeBottomOut pt-page-ontop';
				inClass = 'pt-page-rotateCubeBottomIn';
				break;
			case 62:
				outClass = 'pt-page-rotateCarouselLeftOut pt-page-ontop';
				inClass = 'pt-page-rotateCarouselLeftIn';
				break;
			case 63:
				outClass = 'pt-page-rotateCarouselRightOut pt-page-ontop';
				inClass = 'pt-page-rotateCarouselRightIn';
				break;
			case 64:
				outClass = 'pt-page-rotateCarouselTopOut pt-page-ontop';
				inClass = 'pt-page-rotateCarouselTopIn';
				break;
			case 65:
				outClass = 'pt-page-rotateCarouselBottomOut pt-page-ontop';
				inClass = 'pt-page-rotateCarouselBottomIn';
				break;
			case 66:
				outClass = 'pt-page-rotateSidesOut';
				inClass = 'pt-page-rotateSidesIn pt-page-delay200';
				break;
			case 67:
				outClass = 'pt-page-rotateSlideOut';
				inClass = 'pt-page-rotateSlideIn';
				break;

		}

		$currPage.addClass( outClass ).on( animEndEventName, function() {
			$currPage.off( animEndEventName );
			endCurrPage = true;
			if( endNextPage ) {
				onEndAnimation( $currPage, $nextPage );
			}
		} );

		$nextPage.addClass( inClass ).on( animEndEventName, function() {
			$nextPage.off( animEndEventName );
			endNextPage = true;
			if( endCurrPage ) {
				onEndAnimation( $currPage, $nextPage );
			}
		} );

		if( !support ) {
			onEndAnimation( $currPage, $nextPage );
		}

	}

	function onEndAnimation( $outpage, $inpage ) {
		endCurrPage = false;
		endNextPage = false;
		resetPage( $outpage, $inpage );
		isAnimating = false;
	}

	function resetPage( $outpage, $inpage ) {
		$outpage.attr( 'class', $outpage.data( 'originalClassList' ) );
		$inpage.attr( 'class', $inpage.data( 'originalClassList' ) + ' pt-page-current' );
	}

	init();

	return { init : init };

})();



function inde(code,isAppend,id){
	//alert("inde id = " + id);
	var url=baseUrl+'/noUserPrototype/findUserProblemPrototype?userId='+uid+'&code='+code;
	if(null!=id)
	{
		url=baseUrl+'/noUserPrototype/findUserProblemPrototype?userId='+uid+'&dictionaryId='+id;
	}
	$.ajax({
		url : url,
		type : 'GET',
		dataType : 'jsonp',
		jsonp : "callback",
		async:false,
      	beforeSend:function(){
      		layer.open({
      		    type: 2,
      		    content: '数据正在加载中...'
      		});
		},
		success : function(data) {
			layer.closeAll();
			//alert(JSON.stringify(data));
			var html=createHtml(data,id);
			if(!isAppend){
				$("#"+code).html('');
			}
			$("#"+code).append(html);
			if(kkflag)
				inde(code,true,kkflag);
			//kkflag=false;
			console.log("kkflag is "+kkflag);
		},
		error : function() {
			layer.closeAll();
			layer.open({
			    content: '跨域请求失败!',
			    style: 'background-color:#000000; color:#fff; border:none;',
			    time: 1
			});
		}
	});
}

function createHtml(data,id){
	var options;
	var html="";
	if(null!=id){
		html+="<div id="+id+">";
	}
	kkflag=false;
	for(var i=0;i<data.length;i++)
	{
		fuckflag=true;
		 options=data[i].options;
		 parentId = data[i].dictionary_id;
		 if( 2==data[i].dictionary_type && 3<=data[i].isChildren)
		 {
			 
			 html+="<p class='status' >"+data[i].dictionary_name+"</p><div class='tt'>";
			      for(var j=0;j<options.length;j++)
			      {
			    	  	if(1==options[j].selected)
			    	  	{
			    	  		html+="<div class='CarBox'><ul onclick='checkReaUi(this)'>";
			    	  		html+="<li class='CarBoxPic'><img ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'  tid='"+options[j].dictionary_id+"' src='/wxService/resources/images/web/u11.png'/></li>";
			    	  		html+="<li class='CarBoxFont'>"+options[j].dictionary_name+"</li>";
			    	  		html+="</ul></div>";
			    	  		
			    	  	}else{
			    	  		html+="<div class='noneCarBox'><ul onclick='checkReaUi(this)'>";
			    	  		html+="<li class='CarBoxPic'><img ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"' src='/wxService/resources/images/web/u10.png'/></li>";
			    	  		html+="<li class='CarBoxFont'>"+options[j].dictionary_name+"</li>";
			    	  		html+="</ul></div>";
			    	  	}
			      }
			      html+="</div>";
		 }else if(6==data[i].dictionary_type){
			 
			 html+="<p class='status' >"+data[i].dictionary_name+"</p><select class='select'>";
			 html+="<option tid='-1' value='-1'>==请选择==</option>";
			 for(var j=0;j<options.length;j++){
		    	  	if(1==options[j].selected){
		    	  		html+="<option ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"' selected='selected'>"+options[j].dictionary_name+"</option>";
		    	  	}else{
		    	  		html+="<option ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"'  >"+options[j].dictionary_name+"</option>";
		    	  	}
		      }
			 html+="</select>";
		 }else if(2==data[i].dictionary_type && 2==data[i].isChildren){
			 html+="<p class='status' >"+data[i].dictionary_name+"</p> <div class='box'>";
			 var kk=false;
			 for(var j=0;j<options.length;j++){
				 if(1==options[j].selected){
		    	  		html+="<input type='button' ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"' op='"+options[j].isChildren+"' onclick='checkButton(this)' value='"+options[j].dictionary_name+"' class='noBotton'>";
		    	  		if(0<options[j].isChildren)
		    	  			kk=options[j].dictionary_id;
				 }else{
		    	  		html+="<input type='button' ppid='"+data[i].parentId+"' pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"' op='"+options[j].isChildren+"' onclick='checkButton(this)' value='"+options[j].dictionary_name+"' class='yesBotton'>";
		    	  		
				 }
				 if(kk){
					 kkflag=kk;
				 }
			 }
			 html+=" </div>";
		 }else if(3==data[i].dictionary_type){
			 html+="<p class='status' >"+data[i].dictionary_name+"</p>   <div class='homeStatus'>";
			 for(var j=0;j<options.length;j++){
				 html+="<div class='homeStatusBox'><ul onclick='checkUi(this)'>";
				 if(1==options[j].selected){
		    	  		html+="<li class='homeStatusPic'><img pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"'  src='/wxService/resources/images/web/u11.png'/></li>";
		    	  	}else{
		    	  		html+="<li class='homeStatusPic'><img pid='"+data[i].dictionary_id+"'   tid='"+options[j].dictionary_id+"' src='/wxService/resources/images/web/u10.png'/></li>";
		    	  	}
				 	html+="<li class='homeStatusFont'>"+options[j].dictionary_name+"</li></ul></div>";
			 }
			 html+="</div>";	
		 }
	}
	 if(null!=id){
		 html+="</div>";
	 }
	return html;
}

	function checkButton(obj){
		fuckflag=false;
		var buttons=$(obj).parent().find("input[type=button]");
		for(var i=0;i<buttons.length;i++){
			$(buttons[i]).attr("class","yesBotton");
			var id=$(buttons[i]).attr("tid");
			$("#"+id).remove();
		}
		
		$(obj).attr("class","noBotton");
		var id=$(obj).attr("tid");
		var children=$(obj).attr("op");
		if(0<children){
			inde($("#pageCode").val(),true,id);
		}
		//加载完成把children变成0不去重复去加载
	}
	
	function checkUi(obj){
		var img=$(obj).find("img").attr("src");
		if(img.indexOf("10")!=-1){
			fuckflag=false;
			$(obj).find("img").attr("src",img.replace("10","11"));
		}if(img.indexOf("11")!=-1){
			$(obj).find("img").attr("src",img.replace("11","10"));
			fuckflag=true;
		}
	}
	function checkReaUi(obj){
		fuckflag=false;
		var imgs=$(obj).parent().parent().find("img");
		for(var i=0;i<imgs.length;i++){
			$(imgs[i]).attr("src",$(imgs[i]).attr("src").replace("11","10"));
		}
		$(obj).find("img").attr("src",$(obj).find("img").attr("src").replace("10","11"));
		
	}