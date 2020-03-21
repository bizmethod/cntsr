<%--
  - Author      : 김현우
  - Date        : 2014-07-07
  - Description : 시스템관리 > 메뉴관리 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<style>
input,select {
	margin-left: 3px;
	margin-right: 4px;
	margin-bottom : 3px;
}
</style>
<h2 class="tit">사용자 메뉴관리</h2>
<form name="frm" id="frm" method="post">
<div class="wrap_table" >
	<div style="position: relative; float: left; margin-bottom: 15px;">
	<select name="lang_typ" id="lang_typ" class="sel_basic" onchange="PageReload()">
		<c:forEach var="list" items="${codeList}">
			<option value="${list.CODE}" <c:if test="${lang_typ == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
		</c:forEach>
	</select>
	</div>
	<div class="wrap_tab" >
		<table class="table_detail">
		<caption></caption>
		<colgroup>
		<col style="width:13%" />
		<col style="width:13%" />
		<col style="width:30%" />
		<col style="width:17%" />
		<col style="width:5%" />
		<col style="width:8%" />
		<col style="width:14%" />
		</colgroup>
			<thead>
			<tr>
				<th>메뉴ID</th>
				<th>메뉴명</th>
				<th>URL</th>
				<th>URL_JSP</th>
				<th>순서</th>
				<th>사용유무</th>
				<th>2Depth</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${depth1.size() == 0}">
			<tr>
				<td colspan="7" align="center" >등록된 1depth 메뉴가 없습니다.</td>
			</tr>
			</c:if>
			<c:forEach var="list" items="${depth1}">
			<tr style="cursor: pointer;" onclick="rowSelect('${list.MENU_ID}','${list.MENU_NM}','${list.SORT_NO}','${list.RECODE_ST}','${list.URL}','${list.URL_JSP}')">
				<td class="th_first"><span><c:out value="${list.MENU_ID}" /></span></td>
				<td><span><c:out value="${list.MENU_NM}" /></span></td>
				<td><span><c:out value="${list.URL}"/></span></td>
				<td><span><c:out value="${list.URL_JSP}"/></span></td>
				<td><span><c:out value="${list.SORT_NO}" /></span></td>
				<td><span><c:if test="${list.RECODE_ST == 'A'}">사용</c:if><c:if test="${list.RECODE_ST == 'I'}">미사용</c:if></span></td>
<%-- 				<td><span><c:if test="${list.DEPTH2_YN == 'Y'}"><a class="btn_s_wh" id="btn_2depth" onclick="goDetail('${list.MENU_ID}')" >2Depth</a></c:if></span></td> --%>
				<td><span><a class="btn_s_wh" id="btn_2depth" onclick="goDepth2('${list.MENU_ID}')" >2Depth</a></span></td>
			</tr>
			</c:forEach>
			<tr class="last">
				<td colspan="7" />
			</tr>
			</tbody>
		</table>
	</div>
	<div style="margin-top: 50px; width: 520px; float: right;">
		<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
		<span class="list_search_num">메뉴ID</span><input type="text" class="input_text" maxlength="17" id="menu_id" name="menu_id" style="width: 70px;" />
		<span class="list_search_num">메뉴명</span><input type="text" class="input_text" id="menu_nm" name="menu_nm" style="width: 70px;" />
		<span class="list_search_num">정렬순서</span><input type="text" class="input_text" id="sort_no" name="sort_no" style="width: 30px;" />
		<span class="list_search_num">사용여부</span>
			<select id="recode_st" name="recode_st" class="sel_basic" style="width: 70px;">
				<option value="A">전시</option>
				<option value="I">미전시</option>
			</select> <input type="hidden" id="codeSet" name="codeSet" />
		<span class="list_search_num">URL</span><input type="text" class="input_text" id="url" name="url" style="width: 400px; margin-left: 65px;" />
		<span class="list_search_num">URL_JSP</span><input type="text" class="input_text" id="url_jsp" name="url_jsp" style="width: 400px; margin-left: 40px;" />
		<ul class="btn_bottom mt10">
			<li btn="regBtn"><a href="#" onclick="PageReload()" id="regBtn">등록</a></li>
			<li btn="addBtn"><a href="#" onclick="add1depthMenu()" id="addBtn">추가</a></li>
			<li btn="modBtn"><a href="#" onclick="upd1depthMenu()" id="modBtn">수정</a></li>
<!-- 			<li btn="delBtn"><a href="#" onclick="del1depthMenu()" id="delBtn">삭제</a></li> -->
		</ul>
	</div>
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script type="text/javascript">

$(document).ready(function() {
	setBtn("frm", "add");
});

function goDepth2(menu_id){
	var url = "${pageContext.request.contextPath}/admin/SYST_UME_01/default";
	GoPage(url, {menu_id:menu_id, lang_typ:$("#lang_typ").val()}, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/SYST_UME_00/default";
	var param = {lang_typ:$("#lang_typ").val()}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function rowSelect(menu_id, menu_nm, sort_no, recode_st, url, url_jsp) {
	$("#frm [id='menu_id']").val(menu_id);
	$("#frm [id='menu_nm']").val(menu_nm);
	$("#frm [id='sort_no']").val(sort_no);
	$("#frm [id='recode_st'] option[value='" + recode_st + "']").attr("selected",
			"selected");
	$("#frm [id='url']").val(url);
	$("#frm [id='url_jsp']").val(url_jsp);
	setBtn("frm", "reg");
}

function setBtn(frmId, gubn) {
	if (gubn == "add") {
		$("#" + frmId + " [btn=regBtn]").hide();
		$("#" + frmId + " [btn=addBtn]").show();
		$("#" + frmId + " [btn=modBtn]").hide();
		$("#" + frmId + " [btn=delBtn]").hide();
		$("#" + frmId + " input[type='text']").val('');
		if ($("#" + frmId + "[id='recode_st']")) {
			$("#" + frmId + "[id='recode_st'] option[value='A']").attr(
					"selected", "selected");
		}
	} else if (gubn == "reg") {
		$("#" + frmId + " [btn=regBtn]").show();
		$("#" + frmId + " [btn=addBtn]").hide();
		$("#" + frmId + " [btn=modBtn]").show();
		$("#" + frmId + " [btn=delBtn]").show();
	}
}

function add1depthMenu() {
	GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_UME_00/add1depthMenu', $("#frm").serialize(), PageReload);
}

function upd1depthMenu() {
	GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_UME_00/upd1depthMenu', $("#frm").serialize(), PageReload);
}

function del1depthMenu() {
	GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_UME_00/del1depthMenu', {menu_id:$("#menu_id").val()}, PageReload);
}
</script>
