<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 시스템관리 > 재무현황 > 포괄손익계산서 > 리스트
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
		<li><a class="btn_s_wh" id="btn_save" onclick="goSave()">저장</a></li>
		<li><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
	</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:70%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th></th>
			<th>제목</th>
			<th>등록자</th>
			<th>등록일</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${inc_list.size() == 0}">
		<tr>
			<td colspan="4" align="center" >등록된 포괄손익계산서가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${inc_list}">
		<tr style="cursor: pointer;" onclick="goDetail('${list.SEQ_INCLUSIVE_INCOME}','U')">
			<td class="th_first" onclick="event.cancelBubble = true;"><input type="checkbox" name="chk_bs" <c:if test="${list.DISP_YN == 'Y'}">checked="checked"</c:if> disp_seq="${list.SEQ_INCLUSIVE_INCOME}"></td>
			<td><c:out value="${list.TITLE_KR}" /></td>
			<td><c:out value="${list.REG_ID}"/></td>
			<td><c:out value="${list.REG_DT}" /></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="4" />
		</tr>
		</tbody>
	</table>
	<input type="hidden" name="array" id="array" />
</div>

</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/DISC_INC_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goSave(){
	
	var chk = $('input:checkbox[name=chk_bs]:checked').length;
	
	if(chk != 3){
		alert("체크박스를 3개 선택해주세요");
		return;
	}
	
	if (!confirm('저장하시겠습니까?')) {
		return;
	}
	
	var array = "";
	$('input:checkbox[name=chk_bs]').each(function (i) {
		if(array.indexOf(this.value) < 0){
			array += this.checked + "," + $(this).attr("disp_seq") + "|" ;
		}
	});
	
	$('#array').val(array.substring(0, array.length-1));
	
	var data = {
			user_id : $("#user_id").val(),
			array : $("#array").val(),
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_INC_00/goSave', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_INC_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

function goDetail(seq,IU){
	
	var url = "${pageContext.request.contextPath}/admin/DISC_INC_01/default";
	var param = {IU:IU, seq:seq, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

</script>
