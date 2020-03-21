<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : 시스템관리 > 관리자관리 > 리스트
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
<input type="hidden" name="PAGENUM"/>

<div class="wrap_table" >
	<div class="top_area">
	<ul>
		<li class="ml10">
			<select name="sel_auth" id="sel_auth" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_auth ==''}" >selected="selected"</c:if>>메뉴권한</option>
			<c:forEach var="list" items="${tmenu}">
				<option value="${list.MENU_ID}" <c:if test="${sel_auth == list.MENU_ID}" >selected="selected"</c:if>>${list.MENU_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_branch" id="sel_branch" class="sel_basic" onchange="PageReload()" style="width: 100px;">
				<option value="" <c:if test="${sel_branch ==''}" >selected="selected"</c:if>>지점</option>
			<c:forEach var="list" items="${bList}">
				<option value="${list.CODE}" <c:if test="${sel_branch == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_dept" id="sel_dept" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_dept ==''}" >selected="selected"</c:if>>부서</option>
			<c:forEach var="list" items="${dList}">
				<option value="${list.CODE}" <c:if test="${sel_dept == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_recode ==''}" >selected="selected"</c:if>>상태</option>
			<c:forEach var="list" items="${rList}">
				<option value="${list.CODE}" <c:if test="${sel_recode == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="txt_search" id="txt_search" class="sel_basic" onchange="PageReload()">
				<option value="ALL" <c:if test="${txt_search =='ALL'}" >selected="selected"</c:if>>이름/아이디</option>
				<option value="01" <c:if test="${txt_search =='01'}" >selected="selected"</c:if>>이름</option>
				<option value="02" <c:if test="${txt_search =='02'}" >selected="selected"</c:if>>아이디</option>
			</select>
		</li>
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:100px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">관리자등록</a></li>
	</ul>
	</div>
	<table class="table_list">
	<caption></caption>
	<colgroup>
		<col style="width:10%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
	</colgroup>
	<thead>
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>아이디</th>
		<th>지점</th>
		<th>등록일</th>
		<th>부서</th>
		<th>상태</th>
	</tr>
	</thead>
	<tbody>
	<c:if test="${admin_list.size() == 0}">
	<tr>
		<td colspan="6" align="center" >등록된 관리자가 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${PAGE_LIST}">
	<tr style="cursor: pointer;" onclick="goDetail('${list.ADMIN_ID}','U')" >
		<td class="th_first"><c:out value="${list.ROWNUM}" /></td>
		<td><c:out value="${list.NAME}" /></td>
		<td><c:out value="${list.ADMIN_ID}"/></td>
		<td><c:out value="${list.GHLC_NM}" /></td>
		<td><c:out value="${list.REG_DT}" /></td>
		<td><c:out value="${list.DEPT_NM}" /></td>
		<td><c:out value="${list.STATUS}" /></td>
	</tr>
	</c:forEach>
	<tr class="last">
		<td colspan="7" />
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
function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/SYST_ADM_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(admin_id,IU){
	var url = "${pageContext.request.contextPath}/admin/SYST_ADM_01/default";
	var param = {admin_id:admin_id, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
