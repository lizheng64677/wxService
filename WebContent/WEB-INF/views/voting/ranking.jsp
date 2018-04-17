<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <meta content="telephone=no" name="format-detection"> 
  <title>${result.title}</title> 
  <link href="http://lib.baomitu.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" /> 
  <link href="http://lib.baomitu.com/twitter-bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" /> 
  <link href="http://lib.baomitu.com/layer/2.1/skin/layer.css" rel="stylesheet" /> 
  <link href="http://lib.baomitu.com/layer/2.1/skin/layer.ext.css" rel="stylesheet" /> 
  <link href="<c:url value='/resources/static/css/nifty.min.css'/>" rel="stylesheet" /> 
  <link href="<c:url value='/resources/static/css/vote_show.css'/>" rel="stylesheet" />
  <script src="http://lib.baomitu.com/jquery/2.2.4/jquery.min.js"></script> 
  <script src="http://lib.baomitu.com/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script> 
  <script src="http://apps.bdimg.com/libs/jquery.cookie/1.4.1/jquery.cookie.min.js"></script> 
  <script src="http://lib.baomitu.com/layer/2.3/layer.js"></script> 
  <script src="https://cdn.bootcss.com/jquery.pjax/2.0.1/jquery.pjax.min.js"></script> 
  <script src="http://lib.baomitu.com/jquery.form/3.46/jquery.form.min.js"></script> 
  <script src="http://apps.bdimg.com/libs/validform/5.3.2/validform.js"></script> 
  <link href="http://lib.baomitu.com/viewerjs/0.7.2/viewer.min.css" rel="stylesheet" /> 
  <script src="http://lib.baomitu.com/viewerjs/0.7.2/viewer.min.js"></script> 
  <script src="<c:url value='/resources/static/js/core5.js?v=5.07'/>"></script>
  <link rel="shortcut icon" href="/favicon.ico" /> 
  <style>
        .btn-vlabel {
            padding: 6px 0 !important;
            font-size:11px;
        }
   
    </style> 
 </head> 
 <body> 
  <div id="pjax-box"> 
   <div id="page-content"> 
    <div class="row"> 
     <div class="col-sm-12"> 
      <div class="text-lg mar-btm text-center">
        ${result.title}
      </div> 
     </div> 
    </div> 
    
    <div class="row vote-label-box"> 
     <div class="col-xs-4"> 
     <input type="hidden" id="type" value="${type}">
      <a href="<c:url value='/voting/toRanking.html?type=-1'/>" class="btn btn-default btn-block 
       <c:choose>
		<c:when test="${type== -1 }">
		btn-danger 
		</c:when></c:choose>btn-vlabel" style="margin-bottom:15px;">全部分类</a> 
     </div> 
     <div class="col-xs-4"> 
      <a href="<c:url value='/voting/toRanking.html?type=0'/>" class="btn btn-default<c:choose>
		<c:when test="${type== 0 }">
		btn-danger 
		</c:when></c:choose> btn-block  btn-vlabel" style="margin-bottom:15px;">红门之家</a> 
     </div> 
     <div class="col-xs-4"> 
      <a href="<c:url value='/voting/toRanking.html?type=1'/>" class="btn btn-default<c:choose>
		<c:when test="${type== 1 }">
		btn-danger 
		</c:when></c:choose> btn-block  btn-vlabel" style="margin-bottom:15px;">靓丽警嫂</a> 
     </div> 
    </div> 
    <input id="cid" type="hidden" value="${result.id}">
    <!-- <div class="row vote-label-box"> 
     <div class="col-xs-4"> 
      <a href="javascript:;" class="btn btn-default btn-block btn-danger btn-vlabel" style="margin-bottom:15px;">全部分类</a> 
     </div> 
     <div class="col-xs-4"> 
      <a href="javascript:;" class="btn btn-default btn-block  btn-vlabel" style="margin-bottom:15px;">强警标兵</a> 
     </div> 
     <div class="col-xs-4"> 
      <a href="javascript:;" class="btn btn-default btn-block  btn-vlabel" style="margin-bottom:15px;">最美警嫂</a> 
     </div> 
    </div>  -->
    <style>tr th, tr td:nth-child(1) { text-align: center;}tr th, tr td:nth-child(3) {text-align: center;}.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {vertical-align: middle;}</style> 
    <div class="row"> 
     <div class="col-sm-12"> 
      <table class="table table table-bordered table-striped table-hover"> 
       <thead> 
        <tr> 
         <th width="50">排名</th> 
         <th>姓名</th> 
         <th width="70">票数</th> 
        </tr> 
       </thead> 
       <tbody class="ranking">         
         
       </tbody> 
      </table> 
	     <div class="loading-box" name="show"> 
	     <img src="<c:url value='/resources/static/img/loading.gif'/>" />     
	     <p class="msg"></p> 
	    </div> 
 <!--      <ul class="pager">
       <li class="disabled"><span>共30条数据</span></li> 
       <li class="disabled"><span>上一页</span></li> 
       <li><a href="#">下一页</a></li>
      </ul> --> 
     </div> 
    </div> 
    <div class="text-center" style="margin-bottom:20px;"> 
     <p></p> 
     <p> <a href="javascript:;" target="_blank"></a> </p>       
    </div>   
   </div> 
   <div style="width:100%;margin-top:70px;"></div> 
   <div class="bottom-newbar"> 
    <ul> 
     <li style="width:33.3%"> <a class="btn-all bg-danger " href="<c:url value='/index/toIndex.html'/>"> <i class="fa fa-home"></i> <p>首页</p> </a> </li> 
     <li style="width:33.3%"> <a class="btn-all bg-danger" href="<c:url value='/voting/toActdetail.html'/>"> <i class="fa fa-gift"></i> <p>详情</p> </a> </li> 
     <li style="width:33.3%"> <a class="btn-all bg-danger" href="javascript:;"> <i class="fa fa-trophy"></i> <p>排名</p> </a> </li> 
     
    </ul> 
   </div> 
   <!--验证码--> 
   <div class="ver-code-box"> 
    <div class="form-group" style="padding:5px;"> 
     <div class="row"> 
      <div class="col-sm-12"> 
       <img class="verify-img not-js-style" src="" /> 
      </div> 
      <div class="col-sm-12"> 
       <input type="text" name="verify_code" placeholder="验证码" class="form-control input-lg" datatype="*" /> 
      </div> 
     </div> 
    </div> 
   </div> 
   <div class="so-box"> 
    <div class="form-group" style="padding:5px;margin-top:15px;"> 
     <div class="row"> 
      <div class="col-sm-12"> 
       <input type="text" name="keyword" placeholder="关键词" class="form-control input-lg" datatype="*" /> 
      </div> 
     </div> 
    </div> 
   </div> 
   <!--展示二维码--> 
   <div class="show-qrcode-box"> 
    <p class="sqb-h1"></p> 
    <img src="" class="not-js-style" /> 
    <p class="sqb-h2" style=""></p> 
   </div> 
   <!--背景音乐右上角标志--> 
   <div class="audio-box animation-rotate"> 
    <i class="fa fa-music"></i> 
   </div> 
   <!-- 漂浮物 --> 
   <div class="float-box"></div> 
   <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script> 
   <script src="<c:url value='/resources/static/js/vote_show.js?v=12.09'/>"></script> 
   <style>
    </style> 
   <script>
    var config = {
            img_tag_banner_case: '-vote2.top',
            img_tag_banner: '-vote2.top',
            img_tag_cover: '-vote2.cover',
            img_tag_cover_1: '-vote2.cover.1',
            img_tag_cover_2: '-vote2.cover.2',
            img_tag_cover_3: '-vote2.cover.3',
            img_tag_content: '-vote2.content',
            img_tag_share: '-vote2.share',
            loading: false,
            page: 1,
            done: false,
            is_login: 1,
            show_column: 4,
            ver_code: 0,
            cid: $("#cid").val(),
            url_get_type:$("#type").val(),
            url_get_vote_item: '/wxService/voting/findRanKingList',             
            url_err_img: '/wxService/resources/static/img/profile-photos/1.png',
            url_uploads_path: 'http://' + location.host + '/wxService/',
            url_search: '/wxService/voting/findKeyDetail',
            url_detail: '/wxService/voting/toDetail.html',   
            style: 'danger',
            btn_name: '点赞',
            unit_name: '票',
            item_name: '数据',
            hide_title: 0,
            hide_cover: 0,
            show_rule: 1,
            vote_success_img: '',
            number_plus_url:'/wxService/voting/numberplus',
            float_img:'',
            qrcode_in_show: 0,
            qrcode_vote_show: 4,
            sign_up_count: 3,
            hide_vote_count: 0,
            pm:0,
            hide_btn:0,
            audio: '',
            audio_iframe: '',
            share_img: 'http://' +location.host + '/wxService/resources/static/img/top.jpg',
            share_desc: '快来点赞吧！',
            share_title: '${result.title}',
            vote_label_id: '',
            has_follow:1
        };

    function ShowCountDown(diffTimeBox, allSecond, type) {
        diffTimeBox.attr('_ing', 1);
        var leftSecond = allSecond;
        var day1 = Math.floor(leftSecond / (60 * 60 * 24));
        var hour = Math.floor((leftSecond - day1 * 24 * 60 * 60) / 3600);
        var minute = Math.floor((leftSecond - day1 * 24 * 60 * 60 - hour * 3600) / 60);
        var second = Math.floor(leftSecond - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);
        diffTimeBox.find('.time-inner').html('<i class="fa fa-clock-o"></i> <span>' + type + '</span>倒计时<span>' + day1 + '</span>天<span>' + hour + '</span>时<span>' + minute + '</span>分<span>' + second + '</span>秒');
        allSecond--;
        if (allSecond <= 0){
            diffTimeBox.hide();
        }else{
            diffTimeBox.show();
        }
        return allSecond;
    }
</script> 
  <script src="http://lib.baomitu.com/masonry/4.2.0/masonry.pkgd.min.js"></script> 
    <script src="http://apps.bdimg.com/libs/imagesloaded/3.0.4/imagesloaded.pkgd.min.js"></script> 
    <link href="http://lib.baomitu.com/Swiper/3.4.2/css/swiper.min.css" rel="stylesheet" /> 
    <script src="http://lib.baomitu.com/Swiper/3.4.2/js/swiper.jquery.js"></script> 
       <script type="text/javascript" src="<c:url value='/resources/js/sea.js'/>"></script>
	<script type="text/javascript">
	 var shareData = {
			title : config.share_title,
			desc : config.share_desc,
			link : location.host + '/wxService/',
			imgUrl : config.share_img, 
			requrl : "<c:url value='/share/sharePrepare'></c:url>",
			param : location.href,
			posUrl:"<c:url value='/city/findCityInfoByName'/>"
		};
	 	seajs.use('index/wxpostion',function(wx) { 	 		
			wx.inintWx(shareData); 
	    }); 
</script>
    <script>
            if (!!(window.history && history.pushState)) {
                $(document).pjax('a:not(a[target="_blank"])', 'div[id="pjax-box"]', {fragment:'div[id="pjax-box"]', time:5000});
            }

            $(function () {  
            	 $('iframe').addClass('img-thumbnail').attr('width', '100%').attr('height', $(document).width() * 0.6 + 'px').css({
                     width: '100%',
                     height: $(document).width() * 0.6 + 'px'
                 });   
                getRankingItem();
            });

            $(document).scroll(function () {
                var docuT = $(document).scrollTop();
                var marquee = $('.marquee');
                var diff = docuT - 30;
                if (diff > 0) {
                    marquee.css({
                        position: 'fixed',
                        top: '0',
                        opacity: .7,
                        zIndex:19
                    });
                } else {
                    marquee.removeAttr('style');
                }

                if (docuT + 40 >= $(document).height() - $(window).height()) {
                	getRankingItem();
                }
            });
        </script> 
  </div>  
 </body>
</html>