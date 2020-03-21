<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 윤리경영 > 사이버신고센터 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" method="get">
<input type="hidden" name="TMENUID" value="${TMENUID}"/>
<input type="hidden" name="SMENUID" value="${SMENUID}"/>
<input type="hidden" name="user_id"  id="user_id" value="${USER_ID}"/>
<input type="hidden" name="PAGENUM"/>

<div class="wrap_table" >
<div class="top_area">
	<ul>
	<li class="ml10">
			<select name="sel_appr" id="sel_appr" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_appr ==''}" >selected="selected"</c:if>>상태</option>
			<c:forEach var="list" items="${pList}">
				<option value="${list.CODE}" <c:if test="${sel_appr == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<input type="text" class="input_cal" name="start_d" id="start_d" value="${txt_start_d}" /> ~ <input type="text" class="input_cal" name="end_d" id="end_d" value="${txt_end_d}" />
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_search" onclick="PageReload()">검색</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:60%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>생년월일</th>
			<th>작성일</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="6" align="center" >등록된 신고가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_VOICE}')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.TITLE}"/></td>
			<td><c:out value="${list.REG_NM}" /></td>
			<td><c:out value="${list.REG_DT}" /></td>
			<td><c:out value="${list.PRGR_TYP_NM}" /></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="6" />
		</tr>
		</tbody>
	</table>
</div>
<div class="pageList">
	<!-- 페이지 네비게이션 출력  -->
	<c:out value="${PAGE_NAVI}" escapeXml="false"/>
	<!-- 페이지 네비게이션 출력  -->
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>

datepickerf('start_d', 'end_d', '', '');

function PageReload(){
	
	if($("#start_d").val() != null){
		var startD = $("#start_d").val().replace(/\//g,"");
		$("#start_d").val(startD);
	}
// 	alert($("#start_d").val());
	if($("#end_d").val() != null){
		var endD = $("#end_d").val().replace(/\//g,"");
		$("#end_d").val(endD);
	}
	var url = "${pageContext.request.contextPath}/admin/ETHI_CYB_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq){
	
	var url = "${pageContext.request.contextPath}/admin/ETHI_CYB_01/default";
	var param = {seq:seq,TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
