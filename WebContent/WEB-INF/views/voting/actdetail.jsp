<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" /> 
  <title> ${result.title}</title> 
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
 </head> 
 <body> 
  <div id="pjax-box"> 
   <div id="page-content"> 
    <div class="row"> 
     <div class="col-sm-12"> 
      <div class="text-lg mar-btm text-center">
        ${result.title}
      </div> 
      <div class="panel"> 
       <div class="panel-body"> 
        <p> <i class="fa fa-clock-o"></i> 投票开始：${position.beginTime}</p> 
        <p> <i class="fa fa-clock-o"></i> 投票截止：${position.endTime} </p> 
        <p> <i class="fa fa-info-circle"></i> 投票规则：${position.votingRules} </p> 
       </div> 
      </div> 
      <div class="panel"> 
       <div class="panel-body" style="overflow:hidden;"> 
        <div class="text-content" style="margin-top:20px;overflow: hidden;"> 
         <p>　　${position.content}</p>
        </div> 
       </div> 
      </div> 
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
     <li style="width:33.3%"> <a class="btn-all bg-danger" href="<c:url value='/index/toIndex.html'/>"> <i class="fa fa-home"></i> <p>首页</p> </a> </li> 
     <li style="width:33.3%"> <a class="btn-all bg-danger" href="javascript:;"> <i class="fa fa-gift"></i> <p>详情</p> </a> </li> 
     <li style="width:33.3%"> <a class="btn-all bg-danger" href="<c:url value='/voting/toRanking.html'/>"> <i class="fa fa-trophy"></i> <p>排名</p> </a> </li> 
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
    var config2 = {
        url_vote: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/vote2/id/e8a02730.html',
        url_votedsf: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/vote2/id/e8a02730.html'
    };
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
        cid: 'e8a02730',
        url_get_vote_item: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/getVoteItem/id/e8a02730.html',
        url_err_img: '/static/img/profile-photos/1.png',
        url_uploads_path: 'http://img.static.youtoupiao.com/',
        url_search: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/search/id/e8a02730.html',
        url_vote: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/vote/id/e8a02730.html',
        url_votedsf: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/votedsf/id/e8a02730/v/1.html',
        url_detail: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/detail/id/e8a02730.html',
        url_ver: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/verify.html',
        url_review: 'http://www.youtoupiao.com/vote/review/id/e8a02730.html',
        url_share: 'http://maf3a7bd1.wxvote.youtoupiao.com/page/share/id/e8a02730.html',
        style: 'danger',
        btn_name: '点赞',
        unit_name: '票',
        item_name: '人',
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
        hide_btn:0,
        audio: '',
        audio_iframe: '',
        share_img: 'http://' +location.host + '/wxService/resources/static/img/top.jpg',
        share_desc: '快来点赞吧！',
        share_title: '${result.title}',
        vote_label_id: '',
                has_follow:1
    };

    var bomObjs = {
        ruleBox: $('.text-rule-box'),
        diffTimeBox: $('.diff-time-box'),
        audio: $(document).find('audio'),
        audioIcon: $('.audio-box')
    };

    $(function () {
        if (config.is_login === 0 && self === top && navigator.userAgent.toLowerCase().indexOf('mobile') < 0)
            goUrl(config.url_review);

        if (bomObjs.ruleBox.length > 0 && bomObjs.ruleBox.attr('_show') !== 'hide')
            if (config.show_rule === 1) showTextRule();

        if (config.vote_success_img && config.qrcode_in_show === 1){
            //showQrcode('长按识别二维码', '了解更多活动详情', null, true);
        }

        if (bomObjs.diffTimeBox.length > 0 && !bomObjs.diffTimeBox.attr('_ing')) {
            var allSecond = Number(bomObjs.diffTimeBox.attr('_diff'));
            if (!window.scd) window.scd = window.setInterval(function () {
                allSecond = ShowCountDown(bomObjs.diffTimeBox, allSecond, bomObjs.diffTimeBox.attr('_type'));
            }, 1000);
        }

        if (config.audio_iframe) {
            playAudio(config.audio);
        }

        if (config.float_img) {
            playFloatBox(config.float_img, 2);
        }
    });

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
  </div>  
 </body>
</html>