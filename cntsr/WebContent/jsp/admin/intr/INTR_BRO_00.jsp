<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : GKL소개 > PR > 브로셔 
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
		<li><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<colgroup>
			<col style="width:33%" />
			<col style="width:33%" />
			<col style="width:33%" />
		</colgroup>
		<thead>
		</thead>
		<tbody>
		<tr>
			<th colspan="3"></th>
		</tr>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="3" align="center" >등록된 지면광고가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}" varStatus="status">
			<c:if test="${list.ROWNUM%3 == 1}"><tr></c:if>
				<td onclick="javascript:goDetail('${list.SEQ_BROCHURE}','U')" style="cursor:pointer;">
					<div class="brochure_table">
						<dl>
							<dt><img src="${pageContext.request.contextPath}/VIEWER/bro_thumb/${list.SEQ_BROCHURE}" width="136" height="176" alt="" /></dt>
							<dd><a href="${pageContext.request.contextPath}/VIEWER/bro_file/${list.SEQ_BROCHURE}" class="btn_s_wh" style="margin-top: 10px;" id="btn_down">다운로드</a></dd>
						</dl>
					</div>
				</td>
				<c:if test="${list.ROWNUM%3 == 2 && status.last}">
				<td></td>
				</c:if>
			<c:if test="${list.ROWNUM%3 == 0}"></tr></c:if>
		</c:forEach>
		<tr class="last">
			<td colspan="3" />
		</tr>
		</tbody>
	</table>
</div>
<input type="hidden" name="array" id="array" />
<div class="pageList">
	<!-- 페이지 네비게이션 출력  -->
	<c:out value="${PAGE_NAVI}" escapeXml="false"/>
	<!-- 페이지 네비게이션 출력  -->
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
	function goDetail(seq,IU){
		
		var url = "${pageContext.request.contextPath}/admin/INTR_BRO_01/default";
		var param = {IU:IU, seq:seq, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}
</script>
