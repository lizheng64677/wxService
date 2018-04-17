//参数：提示信息，左边按钮链接，左边按钮，右边按钮，右边按钮
function showDialog(promtMsg, promtUrlCancel, cancelInfo, promtUrlOK, OKInfo) {

	$("#promtMsg").html(promtMsg);
	$("#promtUrlCancel").html(cancelInfo);
	$("#promtUrlOK").html(OKInfo);
	if (promtUrlCancel != "") {
		$("#promtCancel").attr("href", promtUrlCancel);
	} else {
		$("#promtCancel").attr("href", "javascript:hiddenDialog();");
	}
	if (promtUrlOK != "") {
		$("#promtOK").attr("href", promtUrlOK);
	} else {
		$("#promtOK").attr("href", "javascript:hiddenDialog();");
	}

	$("#dialog").show();
}

function hiddenDialog() {
	$("#dialog").hide();
}