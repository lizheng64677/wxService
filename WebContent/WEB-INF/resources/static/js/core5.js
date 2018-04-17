window.onerror = function (msg, url, l) {
    console.log('jserr');
    console.log(msg);
    console.log(url);
    console.log(l);
    return true;
};


$(function () {
    try {
        init();
    } catch (e) {
    }
});

function init() {
    formAjax('form:not(.no-ajax)');
    ueditorInit();
}

function ueditorInit() {
    if (typeof(ueditor) !== "undefined") {
        UE.getEditor(ueditor.form_name, {
            toolbars: ueditor.tool_bars,
            elementPathEnabled: false,
            wordCount: false,
            enableAutoSave: false,
            scaleEnabled: false,
            autoHeightEnabled: false
        });
        //插入图片按钮
        registerUeBtn('插入图片', 'background-position: -380px 0;', function () {
            uploadImages(ueditor.up_file_token_url, '', function (data) {
                UE.getEditor(ueditor.form_name).focus();
                UE.getEditor(ueditor.form_name).execCommand('insertHtml', '<img src="' + ueditor.up_file_url_start + data.data.key + '-vote2.content" style="width:300px;"/>');
            });
        });
        //插入外部图片按钮
        registerUeBtn('插入外部图片', 'background-position: -242px -40px;', function () {
            alertInput(function (val) {
                UE.getEditor(ueditor.form_name).focus();
                UE.getEditor(ueditor.form_name).execCommand('insertHtml', '<img src="' + val + '">');
                layer.closeAll();
            }, '插入图片地址', '', 2);
        });
        //插入视频按钮
        registerUeBtn('插入视频', 'background-position: -320px -20px;', function () {
            alertInput(function (val) {
                if (!/^<iframe(.*)<\/iframe>$/.test(val)) {
                    showMsg('代码格式错误', '视频代码格式不正确<br/><a style="color:#f00;" href="http://www.youtoupiao.com/article/detail/id/99b72312.html" target="_blank">点击查看正确的格式</a>');
                } else {
                    UE.getEditor(ueditor.form_name).focus();
                    UE.getEditor(ueditor.form_name).execCommand('insertHtml', val);
                    layer.closeAll();
                }
            }, '插入优酷/腾讯视频/爱奇艺的通用代码', '', 2);
        });
        //插入音频按钮
        registerUeBtn('插入音频', 'background-position: -16px -160px;', function () {
            alertInput(function (val) {
                var au = '<p>音频文件：</p><audio loop="loop" autoplay="autoplay" controls="controls" controlsList="nodownload" oncontextmenu="return false" src="' + val + '"></audio><p></p>';
                UE.getEditor(ueditor.form_name).focus();
                UE.getEditor(ueditor.form_name).execCommand('insertHtml', au);
                layer.closeAll();
            }, '插入音频地址', '', 2);
        });
    }
}

/**
 * 百度编辑器注册新功能按钮
 * @param btnName
 * @param cssRules
 * @param execCall
 */
function registerUeBtn(btnName, cssRules, execCall) {
    UE.registerUI(btnName, function (editor, uiName) {
        editor.registerCommand(uiName, {
            execCommand: function () {
                execCall();
            }
        });
        var btn = new UE.ui.Button({
            name: uiName,
            title: uiName,
            cssRules: cssRules,
            onclick: function () {
                editor.execCommand(uiName);
            }
        });
        editor.addListener('selectionchange', function () {
            var state = editor.queryCommandState(uiName);
            if (state === -1) {
                btn.setDisabled(true);
                btn.setChecked(false);
            } else {
                btn.setDisabled(false);
                btn.setChecked(state);
            }
        });
        return btn;
    });
}

function showQrcode(link, hideBtn) {
    var imgSrc1 = 'http://pan.baidu.com/share/qrcode?w=240&h=240&url=' + link;
    if (!hideBtn) {
        var imgSrc2 = 'http://pan.baidu.com/share/qrcode?w=300&h=300&url=' + link;
        var imgSrc3 = 'http://pan.baidu.com/share/qrcode?w=500&h=500&url=' + link;
        var imgSrc4 = 'http://pan.baidu.com/share/qrcode?w=800&h=800&url=' + link;
    }
    layer.open({
        title: '二维码',
        btn: '关闭',
        content: '<img src="' + imgSrc1 + '" style="width:240px;height:240px;">' + (!hideBtn ? '<br/><a class="btn btn-xs btn-success" href="' + imgSrc1 + '" target="_blank">240*240</a> <a class="btn btn-xs btn-success"  href="' + imgSrc2 + '" target="_blank">300*300</a> <a class="btn btn-xs btn-success"  href="' + imgSrc3 + '" target="_blank">500*500</a> <a class="btn btn-xs btn-success"  href="' + imgSrc4 + '" target="_blank">800*800</a>' : '')
    });
}

function reloadPages() {
    location.reload()
}

function backPages(def) {
    if (document.referrer === '') {
        if (def) goUrl(def);
    } else {
        window.history.back();
    }
}

function keypress13() {
    $(document).keypress(function (event) {
        var keyCode = (event.keyCode ? event.keyCode : event.which);
        if (keyCode === 13) $('.layui-layer-btn0').click();
    });
}

/**
 * 弹出覆层
 * @param title
 * @param url
 * @param w
 * @param h
 * @param noshade
 */
function showIframe(title, url, w, h, noshade) {
    w = w ? w + "px" : '';
    h = h ? h + "px" : '';
    if (!isPc() || ((!w || w == '') && (!h || h == ''))) {
        w = '90%';
        h = '90%';
    }
    return layer.open({
        type: 2,
        title: title,
        content: url,
        area: [w, h],
        closeBtn: 1,
        moveOut: false,
        fix: true,
        scrollbar: false,
        maxmin: true,
        shadeClose: false,
        shade: noshade ? 0 : [0.8, '#000'],
        success: function (layero) {
            layer.setTop(layero);
        }
    });
}

/**
 * 请求操作提示
 * @param title
 * @param url
 * @param callback
 */
function askRequestUrl(title, url, callback) {
    layer.confirm(title, function (index) {
        layer.close(index);
        requestUrl(url, callback);
    });
    keypress13();
}

/**
 * ajax提交表单
 * @param formObj
 */
function formAjax(formdom) {
    $(formdom).Validform({
        label: 'label',
        ignoreHidden: true,
        tiptype: function (msg, o, cssctl) {
            if (o.type === 3) {
                tipsObj(msg, o.obj)
            }
        },
        callback: function (form) {
            var layars = layer.load(0, {shade: [0.8, '#fff']});
            form.ajaxSubmit({
                url: form.attr('action'),
                type: 'post',
                enctype: 'multipart/form-data',
                success: function (data) {
                    layer.close(layars);
                    runAjaxResSuccess(data);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(layars);
                    runAjaxResError(XMLHttpRequest, textStatus, errorThrown);
                }
            });
            return false;
        }
    });
}

/**
 * 跳转url
 * @param url
 * @param obj
 */
function goUrl(url, obj) {
    obj = obj ? obj : self;
    obj.location = url;
}

/**
 * ajax提交
 * */
function requestUrl(url, callback) {
    requestUrlHasData(url, {}, callback);
}

function requestUrlBg(url, callback, errCallback) {
    $.ajax({
        url: url,
        dataType: 'json',
        scriptCharset: 'utf-8',
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        success: function (data) {
            if (data && data.code === 1) {
                if (callback) callback(data);
            } else {
                if (errCallback) errCallback(data);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (errCallback) errCallback();
        }
    });
}

function requestUrlHasData(url, data, callback) {
    var layars = layer.load(0, {shade: [0.8, '#fff']});
    $.ajax({
        url: url,
        data: data,
        success: function (data) {
            layer.close(layars);
            runAjaxResSuccess(data, callback);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.close(layars);
            runAjaxResError(XMLHttpRequest, textStatus, errorThrown);
        }
    });
}

function alertInput(callback, title, value, formType) {
    var isIOS = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    formType = formType ? formType : 0;
    var ly = layer.prompt({
        formType: formType,
        value: value ? value : '',
        title: title ? title : '请输入',
        fixed: !isIOS
    }, callback);
    if (isIOS) {
        layer.style(ly, {
            position: 'absolute'
        });
    }
    keypress13();
}

/**
 * 解析ajax请求成功时返回的数据
 * @param data
 * @param callback
 */
function runAjaxResSuccess(data, callback) {
    var verImg = $('.verify-img');
    if (verImg.length > 0) {
        verImg.attr('src', verImg.attr('src'));
    }
    if (data.code === 1) {
        layer.msg(data.msg, {
            icon: 1,
            time: 1000,
            shade: [0.8, '#fff']
        }, function (index) {
            layer.close(index);
            if (callback && typeof(callback) === 'function') {
                callback(data);
            } else {
                if (data.url) {
                    if (data.url.indexOf("noreload") >= 0) {
                        //不刷新
                    } else if (parent.layer.getFrameIndex(window.name) && data.url.indexOf('closeiframereload') >= 0) {
                        parent.reloadPages();
                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                    } else if (parent.layer.getFrameIndex(window.name) && data.url.indexOf('closeiframe') >= 0) {
                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                    } else {
                        goUrl(data.url);
                    }
                }
            }
        });
    } else if (data.code === 0) {
        layer.alert(data.msg, {
            title: '错误',
            icon: 2
        }, function (index) {
            layer.close(index);
            if (data.url) {
                if (data.url.indexOf("noreload") >= 0) {
                    //不刷新
                } else if (window.frames.length !== parent.frames.length && data.url.indexOf('closeiframereload') >= 0) {
                    parent.reloadPages();
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                } else if (parent.layer.getFrameIndex(window.name) && data.url.indexOf('closeiframe') >= 0) {
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                } else {
                    goUrl(data.url);
                }
            }
        });
    } else {
        layer.alert('请求异常，请刷新重试或联系管理员查看', {
            icon: 0,
            title: '异常'
        });
    }
}

function showAlert(msg, func) {
    layer.alert(msg, {
        title: '错误',
        icon: 2
    }, func);
}

function showMsg(title, msg, func) {
    layer.alert(msg, {
        title: title,
    }, func);
}

function showTips(msg, ttl) {
    ttl = ttl ? ttl : 600;
    layer.msg(msg, {time: ttl});
}

function tipsObj(msg, obj) {
    layer.tips(msg, obj, {
        tips: 3
    });
}

/**
 * table排序
 * @param obj
 */
function tableSort(obj) {
    var actionColumnIndex = $('thead th').length;
    if (!actionColumnIndex || actionColumnIndex < 1) {
        return;
    }
    obj.dataTable({
        "aaSorting": [[0, "desc"]],
        "bStateSave": false,
        "info": false,
        "paging": false,
        "searching": false,
        "aoColumnDefs": [
            {
                "orderable": false, "aTargets": [0, actionColumnIndex - 1]
            }
        ]
    });
}


/**
 * 解析ajax请求失败时返回的数据
 * @param XMLHttpRequest
 * @param textStatus
 * @param errorThrown
 */
function runAjaxResError(XMLHttpRequest, textStatus, errorThrown) {
    var errorInfo = $(XMLHttpRequest.responseText).find('content').text();
    layer.alert(errorInfo + '<br/>' + '请求异常，请刷新重试或联系管理员查看', {
        icon: 0,
        title: '异常'
    });
}

/**
 * 全选反选
 * @param thisObj
 * @param checkBox
 * @param type
 * 1反选
 * 2全选
 */
function checkAll(thisObj, checkBox, type) {
    switch (type) {
        case 1:
            checkBox.each(function (i) {
                var item = checkBox.eq(i);
                var isCheck = item.is(':checked');
                item.prop('checked', !isCheck);
            });
            break;
        case 2:
            checkBox.prop('checked', true);
            break;
        case 3:
            var isCheck = thisObj.is(':checked');
            checkBox.prop('checked', isCheck);
            break;
    }
}

/**
 * 获取选中项
 * @param itemDom
 * @returns {string}
 */
function getCheckIds(itemDom) {
    var checkboxs = $(itemDom);
    var ids = '';
    checkboxs.each(function (i) {
        var item = checkboxs.eq(i);
        var id = item.val();
        if (id) {
            if (item.is(':checked')) {
                if (checkboxs.eq(checkboxs.length - 1).val() != id) id += ',';
                ids += id;
            }
        }
    });
    return ids;
}

/**
 * 判断是否pc
 * @returns {boolean}
 */
function isPc() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
        "SymbianOS", "Windows Phone",
        "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}

/**
 * 遍历对象
 * @param obj
 */
function alertObj(obj) {
    // 用来保存所有的属性名称和值
    var props = "";
    // 开始遍历
    for (var p in obj) { // 方法
        if (typeof ( obj [p]) == " function ") {
            obj [p]();
        } else { // p 为属性名称，obj[p]为对应属性的值
            props += p + " = " + obj [p] + " \n ";
        }
    } // 最后显示所有的属性
    alert(props);
}
function showMsgAlert(text){
	layer.open({ 
		content:text ,
	    style: 'background-color:black; color:#fff; border:none;',
	    time: 2
	});
}
/**
 * 获取格式化的当前时间
 * @returns {string}
 */
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    return currentdate;
}

function date(format, time) {
    var dates = new Date();
    dates.setTime(time * 1000);
    return dates.format(format);
}

function createHtmlDom(domname, attr, html) {
    var box = $('<div class="_temp"></div>');
    var dom = $('<' + domname + '>');
    for (var i in attr) {
        dom.attr(i, attr[i]);
    }
    dom.html(html).appendTo(box);
    return box.html();
}

function createProgressBar(progress) {
    var progress2 = progress * 100 >= 100 ? 100 : progress * 100;
    return createHtmlDom('div', {class: 'progress'}, createHtmlDom('div', {
        'class': 'progress-bar progress-bar-success progress-bar-striped',
        'role': 'progressbar',
        'aria-valuenow': progress2,
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'style': 'width:' + progress2 + '%;color:#000;'
    }, createHtmlDom('span', {class: 'sr-only'}) + (parseInt(progress * 100)) + '%'));
}

function uploadImages(submitUrl, upUrl, callback) {
    var form = $('<form style="display: none;" action="' + submitUrl + '"><input type="file" name="file"/><input type="submit"></form>');
    form.appendTo('body');
    var fileInput = form.find('input[name="file"]');
    fileInput.bind('change', function () {
        var path = fileInput.val();
        var ext = path.substring(path.lastIndexOf('.'), path.length).toUpperCase();
        if (ext != ".PNG" && ext != ".JPG" && ext != ".JPEG") {
            showAlert('图片限于png/jpg格式');
            return false;
        }
        var layars = layer.load(0, {shade: [0.8, '#fff']});
        form.ajaxSubmit({
            url: form.attr('action'),
            type: 'post',
            enctype: 'multipart/form-data',
            success: function (data) {
                layer.close(layars);
                data = $.parseJSON(data);
                if (data.code != 1) {
                    showAlert(data.msg);
                    return;
                }
                if (typeof callback == 'function') {
                    callback(data);
                } else {
                    requestUrl(upUrl + '?hash=' + data.data.hash + '&key=' + data.data.key);
                }
            },
            error: function (data) {
                layer.close(layars);
                showAlert('上传出错，请联系管理员');
                return false;
            }
        });
    });
    fileInput.click();
}



function uploadImages2(submitUrl, upUrl, callback) {
    var form = $('<form style="display: none;" action="' + submitUrl + '"><input type="file" name="file"/><input type="submit"></form>');
    form.appendTo('body');
    var fileInput = form.find('input[name="file"]');
    fileInput.bind('change', function () {
        var path = fileInput.val();
        var ext = path.substring(path.lastIndexOf('.'), path.length).toUpperCase();
        if (ext !== ".PNG" && ext !== ".JPG" && ext !== ".JPEG") {
            showAlert('图片限于png/jpg格式');
            return false;
        }
        var p = window.URL.createObjectURL(fileInput[0].files[0]);
        dealImage(p, {width: 600}, function (base64) {
            //$('<img src="' + base64 + '"/>').appendTo('body');
            //console.log(base64);
            var blob = dataURItoBlob(base64);
            var fd = new FormData(document.forms[0]);
            fd.append("file", blob);
            var layars = layer.load(0, {shade: [0.8, '#fff']});
            $.ajax({
                url: form.attr('action'),
                method: 'POST',
                processData: false, // 必须
                contentType: false, // 必须
                // dataType: 'json',
                data: fd,
                success: function (data) {
                    form.remove();
                    layer.close(layars);
                    data = $.parseJSON(data);
                    if (data.code !== 1) {
                        showAlert(data.msg);
                        return;
                    }
                    if (typeof callback === 'function') {
                        callback(data);
                    } else {
                        requestUrl(upUrl + '?hash=' + data.data.hash + '&key=' + data.data.key);
                    }
                },
                error: function (data) {
                    form.remove();
                    layer.close(layars);
                    showAlert('上传出错，请联系管理员');
                    return false;
                }
            });
        });
    });
    fileInput.click();
}

//将base64转换成二进制图片（Blob）
function dataURItoBlob(base64Data) {
    var byteString;
    if (base64Data.split(',')[0].indexOf('base64') >= 0) byteString = atob(base64Data.split(',')[1]); else byteString = unescape(base64Data.split(',')[1]);
    var mimeString = base64Data.split(',')[0].split(':')[1].split(';')[0];
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }
    return new Blob([ia], {type: mimeString});
}



/**
 * 图片压缩，默认同比例压缩
 * @param {Object} path
 *   pc端传入的路径可以为相对路径，但是在移动端上必须传入的路径是照相图片储存的绝对路径
 * @param {Object} obj
 *   obj 对象 有 width， height， quality(0-1)
 * @param {Object} callback
 *   回调函数有一个参数，base64的字符串数据
 */
function dealImage(path, obj, callback){
    var img = new Image();
    img.src = path;
    img.onload = function(){
        var that = this;
        // 默认按比例压缩
        var w = that.width,
            h = that.height,
            scale = w / h;
        w = obj.width || w;
        h = obj.height || (w / scale);
        var quality = 0.7;  // 默认图片质量为0.7
        //生成canvas
        var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
        // 创建属性节点
        var anw = document.createAttribute("width");
        anw.nodeValue = w;
        var anh = document.createAttribute("height");
        anh.nodeValue = h;
        canvas.setAttributeNode(anw);
        canvas.setAttributeNode(anh);
        ctx.drawImage(that, 0, 0, w, h);
        // 图像质量
        if(obj.quality && obj.quality <= 1 && obj.quality > 0){
            quality = obj.quality;
        }
        // quality值越小，所绘制出的图像越模糊
        var base64 = canvas.toDataURL('image/jpeg', quality);
        // 回调函数返回base64的值
        if(typeof callback === 'function') callback(base64);
    }
}

Date.prototype.format = function (format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
};