<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : GKL소개 > 사업분야 > 스포츠선수단
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

<div class="wrap_table" >
<div class="top_area">
	<ul>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="success_function()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="sortUpdate()">순서저장</a></li>
		<li><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
		<colgroup>
			<col style="width:10%" />
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:20%" />
			<col style="width:40%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>순서</th>
			<th>직책</th>
			<th>사진</th>
			<th>이름</th>
			<th>주요경력</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${squad_list.size() == 0}">
		<tr>
			<td colspan="6" align="center" >등록된 대회현황이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${squad_list}">
		<tr height="70" class="tr_list" style="cursor: pointer;" seq="<c:out value="${list.SEQ_PLAYER}" />" onclick="goDetail('<c:out value="${list.SEQ_PLAYER}" />','U')">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><span><c:out value="${list.SORT_NO}" /></span></td>
			<td><span><c:out value="${list.POSITION}" /></span></td>
			<td><img src="${pageContext.request.contextPath}/VIEWER/player_img/${list.SEQ_PLAYER}" alt="" onerror=""  /></td>
			<td><span><c:out value="${list.NAME}" /></span></td>
			<td style="text-align:left; padding: 10px 0px;"><span>${list.CAREER.replaceAll('\\n','<br/>')}</span></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="6" />
		</tr>
		</tbody>
	</table>
</div>
<input type="hidden" name="array" id="array" />
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
$(".MOVEUP,.MOVEDOWN").click(function(i) {
    var row = $(this).parents(".tr_list");
    if ($(this).is(".MOVEUP")) {
    	if(row.get(0).rowIndex != 1)
    		row.insertBefore(row.prev());
    } else {
    	if(row.get(0).rowIndex < row.parents("table tbody").children(".tr_list").size())
    		row.insertAfter(row.next());
    };
});
	//정렬 순서 변경
	function sortUpdate(){
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		var array = "";
		$('.tr_list').each(function(i){
			array += $(this).attr("seq") + "," + (i+1) + ".";
		});
		$('#array').val(array.substring(0, array.length-1));
		var url = "${pageContext.request.contextPath}/admin/INTR_SQU_00/sortUpdate";
		var data = $("#frmPage").serialize();
		GetAjaxXml(url, data, success_function, true);	
	}
	
	var success_function = function(xmlData) {
		GoPage("${pageContext.request.contextPath}/admin/INTR_SQU_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
	};

	//상세페이지
	function goDetail(seq,IU){
		
		var url = "${pageContext.request.contextPath}/admin/INTR_SQU_01/default";
		var param = {IU:IU, seq:seq, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}
</script>
