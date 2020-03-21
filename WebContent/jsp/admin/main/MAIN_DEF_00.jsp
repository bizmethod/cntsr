<%--
  - Author      : 김현우
  - Date        : 2014-08-08
  - Description : 메인관리 > 메인화면 > default
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incPageNavi.jsp" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GKL</title>
<link type="text/css" href="${pageContext.request.contextPath}/common/css/common.css" rel="stylesheet" />
<%-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/common/js/jquery/css/ui-lightness/jquery-ui-1.8.11.custom.css" /> --%>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/common/js/jquery/css/ui-flick/jquery-ui.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/validation-1.10.0/jquery.validate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/validation-1.10.0/messages_ko.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/common.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.8.9.custom.min.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/ui.datepicker-ko2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/css/ui-flick/jquery-ui.js"></script>

</head>
<body class="bg_body">
<div id="wrap">
	<div id ="header">
		<div class="gnb">
			<h1 class="logo"><a href="${pageContext.request.contextPath}/admin/MAIN_DEF_00/default"><img src="${pageContext.request.contextPath}/common/images/logo.gif" alt="GKL"/><span>GKL ADMIN</span></a></h1>
			<a href="${pageContext.request.contextPath}/logout" id="logout" class="btn_s_wh" style="float: right; margin-top: 30px;"><span>로그아웃</span></a>
		</div>
		<!-- // gnb -->
	
		<div>
			<ul class="lnb">
			<c:forEach var="tmenu" items="${tmenu}">
				<li<c:if test="${tmenu.MENU_ID == TMENUID}"> class="on"</c:if>><a href="#" onclick="GoMenuPage('${pageContext.request.contextPath}${tmenu.URL}', '${tmenu.MENU_ID}', '${tmenu.SMENU_ID}', '', '${tmenu.MENU_AUTH}')"><c:out value="${tmenu.MENU_NM}"/></a></li>
			</c:forEach>  
			</ul>
		</div>
		
	</div>
	<!-- // header -->
	
	<div id="container">	
		
		<div class="content">
<form name="frmPage" id="frmPage" method="get">
<input type="hidden" name="TMENUID" value="${TMENUID}">
<input type="hidden" name="SMENUID" value="${SMENUID}">

<div class="wrap_table" >
	<img src="${pageContext.request.contextPath}/common/images/welcome.jpg" alt="Welcome"/>
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />


