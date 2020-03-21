<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GKL ADMIN</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery.form.js"></script>

<link href="${pageContext.request.contextPath}/common/css/common.css" rel="stylesheet" type="text/css" />
<script>
function initPage() {
	var form = document.forms['form_login'];
	var user_id = getCookie('user_id');
	if (user_id && user_id != "undefined") {
		form.user_id.value = user_id;
		form.passwd.focus();
		form.id_save.checked = true;
	} else {
		form.user_id.focus();
	}
}

function getCookie(name) {
	var cookie = document.cookie.split('; ');
	for (var i=0; i<cookie.length; i++) {
		var pair = cookie[i].split('=');
		if (pair[0] == name) {
			return unescape(pair[1]);			
		}
	}
	return null;
}

//쿠키에 아이디 저장
function setCookie(name, value, expiredays)//쿠키 저장 함수
{
	var todayDate= new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function login() 
{
	var form = document.forms['form_login'];
	if (form.user_id.value.split(' ').join('') == '') {
		alert('ID를 입력하세요.');
		form.user_id.focus();
		return false;
	}
	if (form.passwd.value.split(' ').join('') == '') {
		alert('비밀번호를 입력하세요.');
		form.passwd.focus();
		return false;		
	}
	
	if(form.id_save.checked == true) {
		setCookie("user_id", form.user_id.value, 7); //쿠키이름을 user_id로 7일동안 저장
	} else {
		setCookie("user_id", form.user_id.value, 0); //날짜를 0으로 저장하여 쿠키 삭제
	}
	
	var url = "${pageContext.request.contextPath}/loginCheck";
	GetAjaxXml(url, $("#form_login").serialize(), LoginResult);
}

function LoginResult(xmlData) {
	if ($(xmlData).find('smartq-xml > result').text() == "000") {
		var form = document.forms['form_login'];
		var redirectUrl = form.redirectUrl.value;
		if (redirectUrl == "") {
			redirectUrl = "${pageContext.request.contextPath}/admin/MAIN_DEF_00/default";
		}
		form.action = redirectUrl;
		form.user_id.value = "";
		form.passwd.value = "";
		form.submit();
	}	
}

function onIdSave() {
	var form = document.forms['form_login'];
	if(form.id_save.checked == true) {
		setCookie("user_id", form.user_id.value, 7); //쿠키이름을 user_id로 7일동안 저장
	} else {
		setCookie("user_id", form.user_id.value, 0); //날짜를 0으로 저장하여 쿠키 삭제
	}
}



</script>
</head>
<body class="bg_login" onload="initPage()" style="background-color:#F5F5F5;">
<div id="wrap" style="width:980px; margin:0 auto;">
  <div class="login_gkl">
    <form id="form_login" name="form_login">
		<fieldset>
		<legend>로그인 폼</legend>
		<div class="group_login">
			<input type="hidden" name="redirectUrl" value="${redirectUrl}"/>
			<p class="first"><label for="id">아이디</label><input type="text" title="아이디 입력" maxlength="50" tabindex="1" name="user_id" id="user_id"></p>
			<p><label for="inputPwd" >비밀번호</label><input type="password" title="비밀번호 입력" maxlength="32" tabindex="2" name="passwd" id="passwd" onkeydown="if(event.keyCode==13) login();"></p>
			<div class="sid"><input type="checkbox" title="아이디 저장" tabindex="3" id="id_save" onclick="onIdSave()"><label for="id_save">아이디 저장</label></div>
			<button type="button" class="btn_login" title="로그인" tabindex="4" onclick="login()" style="cursor:pointer;"><span>로그인</span></button>
		</div>
		<!-- // group_login -->
		<ul class="user" <c:if test="${pwdMng=='false' }">style="display:none"</c:if>>
		</ul>
		</fieldset>
    </form>
  </div>
  <!-- // login_gkl -->
  <div id="footer">
  	<address>고객센터 TEL. 02-0000-00000 FAX. 02-0000-0000</address>
	<p class="policy">COPYRIGHT &copy; localhost ALL RIGHTS RESERVED.</p>
</div>
<!-- // footer -->
</div>
</body>
</html>
