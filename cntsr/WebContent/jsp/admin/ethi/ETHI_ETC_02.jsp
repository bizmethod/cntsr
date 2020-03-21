<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 반부패청렴 > 기타현황 > (소송 및 수임변호사 현황)리스트
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
	<ul style="float: right;">
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:20%" />
			<col style="width:5%" />
			<col style="width:40%" />
			<col style="width:15%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>소송종류</th>
			<th>건수</th>
			<th>수임현황</th>
			<th>첨부</th>
			<th>비고</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="6" align="center" >등록된 현황이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_ETC}','U')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.GUBN_NM}"/></td>
			<td><c:out value="${list.LAW_CNT}" /></td>
			<td><c:out value="${list.TITLE}" /></td>
			<td>
			<c:if test="${list.SEQ_FILE != null}">
				<a href="${pageContext.request.contextPath}/VIEWER/file/${list.SEQ_FILE}" class="btn_s_wh">다운로드</a>
			</c:if>
			</td>
			<td><c:out value="${list.NOTE}" /></td>
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

function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_03/default";
	var param = {seq:seq, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
