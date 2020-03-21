<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 반부패청렴 > 기타현황 > (교육자료)리스트
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
	<ul style="float: left;">
		<li class="ml10 off"><a href="#" onclick="goPage('01')">반부패 청렴 지킴이 현황</a></li>
		<li class="ml10 on"><a href="#" onclick="goPage('02')">반부패 지킴이 활동 내역</a></li>
	</ul>
	<ul style="float: right;">
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:60%" />
			<col style="width:15%" />
			<col style="width:15%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>실시일</th>
			<th>첨부</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="4" align="center" >등록된 자료가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_ETC}','U')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.TITLE}" /></td>
			<td><c:out value="${list.MEET_DT}" /></td>
			<td>
			<c:if test="${list.SEQ_FILE != null}">
				<a href="${pageContext.request.contextPath}/VIEWER/file/${list.SEQ_FILE}" class="btn_s_wh">다운로드</a>
			</c:if>
			</td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="4" />
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

function goPage(typ){
	if(typ == '01'){
		var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_00/default";
	}else{
		var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_04/default";
	}
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_05/default";
	var param = {seq:seq, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
