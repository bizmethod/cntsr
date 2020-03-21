<%--
  - Author      : 김현우
  - Date        : 2014-07-17
  - Description : 정부3.0 > 사전정보공표목록 > 1depth 리스트
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
			<select name="sel_typ" id="sel_typ" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_typ ==''}" >selected="selected"</c:if>>전체</option>
			<c:forEach var="list" items="${gList}">
				<option value="${list.CODE}" <c:if test="${sel_typ == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:5%" />
			<col style="width:15%" />
			<col style="width:30%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>분류</th>
			<th>사전정보 공개내용</th>
			<th>담당부서</th>
			<th>공개주기</th>
			<th>공개시기</th>
			<th>공표매체</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="7" align="center" >등록된 자료가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" <c:if test="${list.LINK_TYP_NM == '게시판'}"> onclick="go2depthList('${list.SEQ_PRE_INFOM_LST}')"</c:if><c:if test="${list.LINK_TYP_NM == '홈페이지링크'}"> onclick="window.open('${list.URL}');return false"</c:if>>
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.INLI_TYP_NM}" /></td>
			<td><c:out value="${list.TITLE}" /></td>
			<td><c:out value="${list.DEPT}" /></td>
			<td><c:out value="${list.P_PERIOD}" /></td>
			<td><c:out value="${list.P_TIME}" /></td>
			<td><c:out value="${list.LINK_TYP_NM}" /></td>
			<td onclick="event.cancelBubble = true;">
				<a class="btn_s_wh" id="btn_upd" onclick="goDetail('${list.SEQ_PRE_INFOM_LST}','U')">수정</a>
			</td>
			<td><c:out value="${list.MEMO}" /></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="8" />
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
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function go2depthList(parent_id){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_02/default";
	var param = {parent_id:parent_id, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_01/default";
	var param = {seq:seq, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>