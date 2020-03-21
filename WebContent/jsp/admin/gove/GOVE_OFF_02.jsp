<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 정부3.0 > 사전정보공표목록 > 2depth리스트
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
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
<input type="hidden" name="parent_id"  id="parent_id" value="${parent_id}"/>
<input type="hidden" name="inli_typ"  id="inli_typ" value="${map.INLI_TYP}"/>
<input type="hidden" name="PAGENUM"/>

<div class="wrap_table" >
<div class="top_area">
	<ul style="float: left">
		<li class="ml10">
			<p style="font-size: 20px;"><strong>[${map.INLI_TYP_NM}] ${map.TITLE}</strong></p>
		</li>
	</ul>
	<ul style="float: right;">
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:60%" />
			<col style="width:20%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>전시여부</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="4" align="center" >등록된 자료가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="goDetail('${list.SEQ_PRE_INFOM}','U')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.TITLE}" /></td>
			<td><c:out value="${list.REG_DT}" /></td>
			<td><c:out value="${list.RECODE_ST}" /></td>
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

function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_02/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_03/default";
	var param = {seq:seq, IU:IU, parent_id:$("#parent_id").val(),inli_typ:$("#inli_typ").val(), TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>