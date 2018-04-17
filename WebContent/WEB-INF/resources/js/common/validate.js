

// 删除字符串两端的空格
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
/**
 * 判断一个输入是否能够表示钱，钱只能是数字，而且如果有小数点，小数点后面最多两位。
 */
String.prototype.isMoney = function() {
	var p = /^[0-9]+(\.[0-9]{1,2})?$/gi;
	return p.test(this.trim());
};

/**
 * 判断一个输入是否是中文
 */
String.prototype.isChinese=function(){
	var p=/^[\u4E00-\u9FA5]$/gi;
	return p.test(this.trim());
};


String.prototype.isPattern=function(p){
	return p.test(this);
};

String.prototype.isZeroMoney=function(){
	var p=/^[0]+(.[0]+)?$/gi;
	return p.test(this.trim());
};

String.prototype.isBigMoney=function(){
	var p=/^[1-9][0-9]{7,}(\.[0-9]{1,2})?$/gi;
	return this.isMoney()&&p.test(this.trim());
};

String.prototype.isNumber = function() {
	var p = /^[0-9]+$/gi;
	return p.test(this.trim());
};


String.prototype.isEmpty = function(){
	return this.trim().length==0;
};

//是否是电话号码
String.prototype.isTel=function(){
	var p=/^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/gi;
	return p.test(this.trim());
}

//是否是邮箱
String.prototype.isEmail=function(){
	var p=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/gi;
	return p.test(this.trim());
}


// 由字符串变成JSON
parseJso = JSON.parse;

Array.prototype.remove = function(b) {
	var i = 0;
	for (; i < this.length; i++) {
		if (b == this[i])
			break;
	}
	var a = i;
	if (a >= 0) {
		this.splice(a, 1);
		return true;
	}
	return false;
};

/**
 * wzf 日期格式化
 */
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"H+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
}

//如果d1在后面，返回值小于0
Date.prototype.compare=function(d1){
	return this.getTime()-d1.getTime();
}




//当浏览器没有console，但是偏偏程序中写了console没有删除时，造一个console出来用
if(!console){
	var console={
			info:function(){},
			log:function(){}
	};
}
