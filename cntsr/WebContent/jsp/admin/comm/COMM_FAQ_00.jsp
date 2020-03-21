<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 소통경영 > 자주묻는질문 > 리스트
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

<div class="wrap_table" >
	<div class="top_area">
	<ul>
		<li>
			<select name="faq_typ" id="faq_typ" class="sel_basic" onchange="PageReload()">
				<option value="01" <c:if test="${faq_typ =='01'}" >selected="selected"</c:if>>GKL 및 7LUCK 관련 질문</option>
				<option value="02" <c:if test="${faq_typ =='02'}" >selected="selected"</c:if>>채용 관련 질문</option>
			</select>
		</li>
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10">
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="">상태</option>
				<option value="A" <c:if test="${sel_recode =='A'}" >selected="selected"</c:if>>전시</option>
				<option value="I" <c:if test="${sel_recode =='I'}" >selected="selected"</c:if>>미전시</option>
			</select>
		</li>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="PageReload()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="goRegistration()">순서저장</a></li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list">
	<caption></caption>
	<colgroup>
		<col style="width:10%" />
		<col style="width:10%" />
		<col style="width:70%" />
		<col style="width:10%" />
	</colgroup>
	<thead>
	<tr>
		<th>조정</th>
		<th>순서</th>
		<th>질문</th>
		<th>상태</th>
	</tr>
	</thead>
	<tbody>
	<c:if test="${faq_list.size() == 0}">
	<tr>
		<td colspan="4" align="center" >등록된 FAQ가 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${faq_list}">
	<tr style="cursor: pointer;" onclick="goDetail('${list.SEQ_FAQ}','U')" class="tr_list" seq="<c:out value="${list.SEQ_FAQ}" />">
		<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
		<td><c:out value="${list.SORT_NO}" /></td>
		<td><c:out value="${list.INQUIRY}"/></td>
		<td><c:if test="${list.RECODE_ST == 'A'}" >전시</c:if><c:if test="${list.RECODE_ST == 'I'}" >미전시</c:if></td>
	</tr>
	</c:forEach>
	<tr class="last">
		<td colspan="4" />
	</tr>
	</tbody>
	</table>
</div>
<input type="hidden" name="array" id="array" />
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
	function PageReload(){
		var url = "${pageContext.request.contextPath}/admin/COMM_FAQ_00/default";
		var param = {sel_recode:$("#sel_recode").val(),faq_typ:$("#faq_typ").val(),sTxt:$("#sTxt").val()}
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
		var url = "${pageContext.request.contextPath}/admin/COMM_FAQ_00/sortUpdate";
		var data = $("#frmPage").serialize();
		GetAjaxXml(url, data, success_function, true);	
	}
	var success_function = function(xmlData) {
		GoPage("${pageContext.request.contextPath}/admin/COMM_FAQ_00/default", {sel_recode:$("#sel_recode").val(),faq_typ:$("#faq_typ").val()}, '${TMENUID}', '${SMENUID}', '${METYPE}');
	};
	
	function goDetail(seq,IU){
		var url = "${pageContext.request.contextPath}/admin/COMM_FAQ_01/default";
		var param = {seq:seq, IU:IU, faq_typ:$("#faq_typ").val(), TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}
</script>

