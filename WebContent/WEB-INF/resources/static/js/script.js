$(function() {
    initTopNews();
    initBackTop();
});
function isPc() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}
function initIndexImg() {
    $('.powerful-content-group').on('mouseenter',
    function(e) {
        var index = $(e.currentTarget).index() - 6;
        $($('.powerful-content-img')[index]).addClass('active').siblings().removeClass('active');
    });
    $('.business-total-group').on('mouseenter',
    function(e) {
        var index = $(e.currentTarget).index();
        $($('.business-total-group')[index]).find('.business-total-border').addClass('active').parent().siblings().find('.business-total-border').removeClass('active');
        $($('.business-total-context')[index]).addClass('active').siblings().removeClass('active');
    });
}
function showLogin(loginUrl) {
    $.ajax({
        url: loginUrl,
        success: function(data) {
            if (data.code === 1) {
                goUrl(loginUrl);
            } else {
                layer.open({
                    type: 2,
                    title: false,
                    anim: 1,
                    shadeClose: false,
                    shade: 0.8,
                    area: ['1000px', '477px'],
                    skin: 'layui-layer-rim',
                    content: [loginUrl, 'no']
                });
            }
        }
    });
}
function goUrl(url, obj) {
    obj = obj ? obj: self;
    obj.location = url;
}
function initTopNews() {
    var timer = setInterval(AutoScroll, 3000);
    $('#notice-list').hover(function() {
        clearInterval(timer);
        $('#notice-list').find("li:first").stop();
        $('#notice-list a').css({
            'text-decoration': 'underline'
        });
    },
    function() {
        timer = setInterval(AutoScroll, 3000);
        AutoScroll();
        $('#notice-list a').css({
            'text-decoration': 'none'
        });
    });
    $('.scrollNotice-img > img').on('click',
    function() {
        $('.scrollNotice').addClass('active');
        $.cookie("display", "1", {
            expires: 1,
            path: '/'
        });
    });
    if ($.cookie("display")) {
        $(".scrollNotice").css("display", "none");
    } else {
        $(".scrollNotice").removeClass('active');
    }
}
function AutoScroll() {
    $('#notice-list').find("li:first").animate({
        marginTop: "-30px"
    },
    1000, 'swing',
    function() {
        $(this).css({
            marginTop: ''
        }).appendTo($('#notice-list'))
    });
}
function initBackTop() {
    $('#top-back').hide();
    $(window).scroll(function() {
        if ($(this).scrollTop() > 350) {
            $("#top-back").fadeIn();
        } else {
            $("#top-back").fadeOut();
        }
    });
}
function topBack() {
    $('body,html').animate({
        scrollTop: 0
    },
    300);
}
function initIconMove() {
    var oWrap = document.getElementsByClassName("main-phone")[0];
    var items = oWrap.getElementsByClassName("main-phone-group");
    oWrap.onmousemove = function(evt) {
        var x = evt.clientX;
        var y = evt.clientY;
        var winWidth = window.innerWidth;
        var winHeight = window.innerHeight;
        var halfWidth = winWidth / 2;
        var halfHeight = winHeight / 2;
        var rx = x - halfWidth;
        var ry = halfHeight - y;
        var length = items.length;
        var max = 20;
        for (var i = 0; i < length; i++) {
            var dx = (items[i].getBoundingClientRect().width / max) * (rx / -halfWidth);
            var dy = (items[i].getBoundingClientRect().height / max) * (ry / halfHeight);
            items[i].style['transform'] = items[i].style['-webkit-transform'] = 'translate(' + dx + 'px,' + dy + 'px)';
        }
    }
}
function getStyle(obj, attr) {
    if (obj.currentStyle) {
        return obj.currentStyle[attr];
    }
    return getComputedStyle(obj)[attr];
}
function initSwiper() {
    var mySwiper = new Swiper('.swiper-container', {
        loop: true,
        pagination: '.swiper-pagination',
        autoplay: 3000,
        autoplayDisableOnInteraction: false,
        paginationClickable: true
    });
    $('.swiper-container').hover(function() {
        mySwiper.stopAutoplay();
    },
    function() {
        mySwiper.startAutoplay();
    });
}