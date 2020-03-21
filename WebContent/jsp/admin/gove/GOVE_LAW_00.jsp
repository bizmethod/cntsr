<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 정부3.0 > 관련법령 및 서식 > 리스트
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
<input type="hidden" name="PAGENUM">

<div class="wrap_table" >
<div class="top_area">
	<ul>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:70%" />
			<col style="width:20%" />
		</colgroup>
		<thead>
		<tr>
			<th colspan="3">관련법령 및 서식안내</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${map.CNT1 != 0}">
			<c:forEach var="list1" items="${list1}" varStatus="st1">
				<tr>
					<c:if test="${st1.count==1}" >
					<th class="th_first2" rowspan="${map.CNT1}">관련법령</th>
					</c:if>
					<td style="cursor: pointer;" onclick="goDetail('${list1.SEQ_LAW}','U')"><c:out value="${list1.TITLE}" /></td>
					<td onclick="event.cancelBubble = true;">
						<c:if test="${list1.LINK_TYP == 'UR'}"><a href="${list1.URL}" target="_blank"><b style="color: blue;">바로가기</b></a></c:if>
						<c:if test="${list1.LINK_TYP == 'FI'}"><a href="${pageContext.request.contextPath}/VIEWER/file/${list1.SEQ_FILE}" class="btn_s_wh">다운로드</a></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${map.CNT2 != 0}">
			<c:forEach var="list2" items="${list2}" varStatus="st2">
				<tr>
					<c:if test="${st2.count==1}" >
					<th class="th_first2" rowspan="${map.CNT2}">관련서식</th>
					</c:if>
					<td style="cursor: pointer;" onclick="goDetail('${list2.SEQ_LAW}','U')"><c:out value="${list2.TITLE}" /></td>
					<td onclick="event.cancelBubble = true;">
						<c:if test="${list2.LINK_TYP == 'UR'}"><a href="${list2.URL}" target="_blank"><b style="color: blue;">바로가기</b></a></c:if>
						<c:if test="${list2.LINK_TYP == 'FI'}"><a href="${pageContext.request.contextPath}/VIEWER/file/${list2.SEQ_FILE}" class="btn_s_wh">다운로드</a></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${map.CNT3 != 0}">
			<c:forEach var="list3" items="${list3}" varStatus="st3">
				<tr>
					<c:if test="${st3.count==1}" >
					<th class="th_first2" rowspan="${map.CNT3}">관련지침</th>
					</c:if>
					<td style="cursor: pointer;" onclick="goDetail('${list3.SEQ_LAW}','U')"><c:out value="${list3.TITLE}" /></td>
					<td onclick="event.cancelBubble = true;">
						<c:if test="${list3.LINK_TYP == 'UR'}"><a href="${list3.URL}" target="_blank"><b style="color: blue;">바로가기</b></a></c:if>
						<c:if test="${list3.LINK_TYP == 'FI'}"><a href="${pageContext.request.contextPath}/VIEWER/file/${list3.SEQ_FILE}" class="btn_s_wh">다운로드</a></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${map.CNT4 != 0}">
			<c:forEach var="list4" items="${list4}" varStatus="st4">
				<tr>
					<c:if test="${st4.count==1}" >
					<th class="th_first2" rowspan="${map.CNT4}">연차보고서</th>
					</c:if>
					<td style="cursor: pointer;" onclick="goDetail('${list4.SEQ_LAW}','U')"><c:out value="${list4.TITLE}" /></td>
					<td onclick="event.cancelBubble = true;">
						<c:if test="${list4.LINK_TYP == 'UR'}"><a href="${list4.URL}" target="_blank"><b style="color: blue;">바로가기</b></a></c:if>
						<c:if test="${list4.LINK_TYP == 'FI'}"><a href="${pageContext.request.contextPath}/VIEWER/file/${list4.SEQ_FILE}" class="btn_s_wh">다운로드</a></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${map.CNT5 != 0}">
			<c:forEach var="list5" items="${list5}" varStatus="st5">
				<tr>
					<c:if test="${st5.count==1}" >
					<th class="th_first2" rowspan="${map.CNT5}">기타</th>
					</c:if>
					<td style="cursor: pointer;" onclick="goDetail('${list5.SEQ_LAW}','U')"><c:out value="${list5.TITLE}" /></td>
					<td onclick="event.cancelBubble = true;">
						<c:if test="${list5.LINK_TYP == 'UR'}"><a href="${list5.URL}" target="_blank"><b style="color: blue;">바로가기</b></a></c:if>
						<c:if test="${list5.LINK_TYP == 'FI'}"><a href="${pageContext.request.contextPath}/VIEWER/file/${list5.SEQ_FILE}" class="btn_s_wh">다운로드</a></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<tr class="last">
			<td colspan="3" />
		</tr>
		</tbody>
	</table>
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/GOVE_LAW_01/default";
	var param = {seq:seq, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
