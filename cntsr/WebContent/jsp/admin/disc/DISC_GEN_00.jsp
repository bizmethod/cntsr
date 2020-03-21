<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : 경영공시 > 일반현황 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 
<input type="hidden" name="TMENUID" value="${TMENUID}"/>
<input type="hidden" name="SMENUID" value="${SMENUID}"/>
<input type="hidden" name="PID" id="PID" value="${hm.PID}"/>

<div class="wrap_table" >
	<div class="top_area">
	<ul>
		<li>
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_recode ==''}" >selected="selected"</c:if>>전체</option>
				<option value="A" <c:if test="${sel_recode =='A'}" >selected="selected"</c:if>>전시</option>
				<option value="I" <c:if test="${sel_recode =='I'}" >selected="selected"</c:if>>미전시</option>
			</select>
		</li>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="PageReload()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="goRegistration()">순서저장</a></li>
		<li><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
	<caption></caption>
	<colgroup>
		<col style="width:10%" />
		<col style="width:5%" />
		<col style="width:15%" />
		<col style="width:25%" />
		<col style="width:10%" />
		<col style="width:15%" />
		<col style="width:10%" />
		<col style="width:10%" />
	</colgroup>
	<thead>
	<tr>
		<th>조정</th>
		<th>순서</th>
		<th>소메뉴</th>
		<th>URL</th>
		<th>스케줄링</th>
		<th>점검시간</th>
		<th>점검상태</th>
		<th>전시</th>
	</tr>
	</thead>
	<tbody>
	<c:if test="${t_alio_list.size() == 0}">
	<tr>
		<td colspan="8" align="center" >등록된 ALIO URL이 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${urlList}">
	<tr style="cursor: pointer;" onclick="goDetail('${list.SEQ}','U')" class="tr_list" seq="<c:out value="${list.SEQ}" />">
		<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
		<td><c:out value="${list.SORT_NO}" /></td>
		<td><c:out value="${list.URL_NM}"/></td>
		<td><c:out value="${list.URL}" /></td>
		<td><c:if test="${list.CHECK_YN == 'Y'}" >사용</c:if><c:if test="${list.CHECK_YN == 'N'}" >미사용</c:if></td>
		<td><c:out value="${list.CHECK_DT}" /></td>
		<td><c:if test="${list.RESULT_CODE == '0'}" >성공</c:if><c:if test="${list.RESULT_CODE == null}" ></c:if><c:if test="${list.RESULT_CODE != '0' && list.RESULT_CODE != null}" >실패</c:if></td>
		<td><c:if test="${list.RECODE_ST == 'A'}" >전시</c:if><c:if test="${list.RECODE_ST == 'I'}" >미전시</c:if></td>
	</tr>
	</c:forEach>
	<tr class="last">
		<td colspan="8" />
	</tr>
	</tbody>
	</table>
</div>
<input type="hidden" name="array" id="array" />
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/DISC_GEN_00/default";
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

//정렬순서 저장
function goRegistration(){
	if (!confirm('저장하시겠습니까?')) {
		return;
	}
	
	var array = "";
	$('.tr_list').each(function(i){
		array += $(this).attr("seq") + "," + (i+1) + ".";
	});
	$('#array').val(array.substring(0, array.length-1));
	var url = "${pageContext.request.contextPath}/admin/DISC_MNG_00/sortUpdate";
	var data = $("#frmPage").serialize();
	GetAjaxXml(url, data, success_function, true);	
}
var success_function = function(xmlData) {
	GoPage("${pageContext.request.contextPath}/admin/DISC_GEN_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

function goDetail(seq,IU){
	
	var url = "${pageContext.request.contextPath}/admin/DISC_GEN_01/default";
	var param = {IU:IU, seq:seq, PID:$("#PID").val(), TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
