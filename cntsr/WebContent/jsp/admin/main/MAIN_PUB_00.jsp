<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : 메인관리 > 홍보배너 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 
<form name="frmPage" id="frmPage" method="get">
<input type="hidden" name="TMENUID" value="${TMENUID}">
<input type="hidden" name="SMENUID" value="${SMENUID}">
<input type="hidden" name="main_typ" value="${main_typ}">

<div class="wrap_table" >
	<div class="top_area">
	<ul>
		<li>
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_recode ==''}" >selected="selected"</c:if>>상태</option>
				<option value="A" <c:if test="${sel_recode =='A'}" >selected="selected"</c:if>>전시</option>
				<option value="I" <c:if test="${sel_recode =='I'}" >selected="selected"</c:if>>미전시</option>
			</select>
		</li>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="PageReload()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="goRegistration()">순서저장</a></li>
		<li><a class="btn_s_wh" id="btn_reg" onclick="goDetail('I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
	<caption></caption>
	<colgroup>
		<col style="width:10%" />
		<col style="width:10%" />
		<col style="width:20%" />
		<col style="width:10%" />
		<col style="width:40%" />
		<col style="width:10%" />
	</colgroup>
	<thead>
	<tr>
		<th>조정</th>
		<th>순서</th>
		<th>제목</th>
		<th>아이디</th>
		<th>URL</th>
		<th>상태</th>
	</tr>
	</thead>
	<tbody>
	<c:if test="${banner_list.size() == 0}">
	<tr>
		<td colspan="6" align="center" >등록된 홍보배너가 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${banner_list}">
	<tr style="cursor: pointer;" onclick="goDetail('${list.ID_MAIN_IMAGE}')" class="tr_list" seq="<c:out value="${list.ID_MAIN_IMAGE}" />">
		<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
		<td><c:out value="${list.ROWNUM}" /></td>
		<td><c:out value="${list.TITLE}"/></td>
		<td><c:out value="${list.ID_MAIN_IMAGE}" /></td>
		<td><c:out value="${list.URL}" /></td>
		<td><c:if test="${list.RECODE_ST == 'A'}" >전시</c:if><c:if test="${list.RECODE_ST == 'I'}" >미전시</c:if></td>
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
	function PageReload(){
		var url = "${pageContext.request.contextPath}/admin/MAIN_PUB_00/default";
		var param = {sel_recode:$("#sel_recode").val()}
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}
	
	$(".MOVEUP,.MOVEDOWN").click(function(i) {
	    var row = $(this).parents(".tr_list");
	    if ($(this).is(".MOVEUP")) {
	    	if(row.get(0).rowIndex != 1)
	    		row.insertBefore(row.prev());
	    } else {
	    	if(row.get(0).rowIndex < row.parents("table tbody").children(".tr_list").size())
	    		row.insertAfter(row.next());
	    }
	});
	
	function goRegistration(){
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		var array = "";
		$('.tr_list').each(function(i){
			array += $(this).attr("seq") + "," + (i+1) + ".";
		});
		$('#array').val(array.substring(0, array.length-1));
		var url = "${pageContext.request.contextPath}/admin/MAIN_BAN_00/sortUpdate";
		var data = $("#frmPage").serialize();
		GetAjaxXml(url, data, success_function, true);	
	}
	var success_function = function(xmlData) {
		GoPage("${pageContext.request.contextPath}/admin/MAIN_PUB_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
	};
	
	function goDetail(img_id){
		var url = "${pageContext.request.contextPath}/admin/MAIN_PUB_01/default";
		var param = {img_id:img_id, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}
</script>

