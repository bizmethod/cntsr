<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : GKL소개 > 사업분야 > 스포츠대회현황
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

<div>
	<table style="width: 753px;">
		<colgroup>
			<col style="width:50%" />
			<col style="width:35%" />
			<col style="width:15%" />
		</colgroup>
		<tr height="70">
			<td align="center">
				<input type="text" class="input_text" id="description" name="description" style="text-align: left; width: 380px;" maxlength="250"  placeholder="내용입력"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="term" name="term" style="text-align: left; width: 180px;" maxlength="100" placeholder="기간입력"/>
			</td>
			<td align="center"><a class="btn_s_wh" id="btn_reg" onclick="RegMatch()">추가</a></td>
		</tr>
	</table>
</div>
<div class="wrap_table" >
<div class="top_area" style="margin-right: 20px;">
	<ul>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="success_function()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="sortUpdate()">순서저장</a></li>
	</ul>
</div>
	<table class="table_list">
		<colgroup>
			<col style="width:10%" />
			<col style="width:5%" />
			<col style="width:35%" />
			<col style="width:25%" />
			<col style="width:25%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>순서</th>
			<th>내용</th>
			<th>기간</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${match_list.size() == 0}">
		<tr>
			<td colspan="5" align="center" >등록된 대회현황이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${match_list}">
		<tr height="70" class="tr_list" seq="<c:out value="${list.SEQ_MATCH}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><c:out value="${list.SORT_NO}" /></td>
			<td><input type="text" class="input_text" id="description${list.SEQ_MATCH}" name="description${list.SEQ_MATCH}" style="text-align: center; width: 230px;" maxlength="250" value="<c:out value="${list.DESCRIPTION}" />" /></td>
			<td><input type="text" class="input_text" id="term${list.SEQ_MATCH}" name="term${list.SEQ_MATCH}" style="text-align: center; width: 160px;" maxlength="100" value="<c:out value="${list.TERM}" />"/></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdMatch('${list.SEQ_MATCH}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelMatch('${list.SEQ_MATCH}')">삭제</a>
			</td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="5" />
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
	function sortUpdate(){
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		var array = "";
		$('.tr_list').each(function(i){
			array += $(this).attr("seq") + "," + (i+1) + ".";
		});
		$('#array').val(array.substring(0, array.length-1));
		var url = "${pageContext.request.contextPath}/admin/INTR_SPO_00/sortUpdate";
		var data = $("#frmPage").serialize();
		GetAjaxXml(url, data, success_function, true);	
	}
	
	var success_function = function(xmlData) {
		GoPage("${pageContext.request.contextPath}/admin/INTR_SPO_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
	};

	function RegMatch(){
		if($('#description').val() == ""){
			alert('내용을 입력해주세요.');
			return;
		}else if($('#term').val() == ""){
			alert("기간을 입력해주세요.");
			return;
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SPO_00/RegMatch', $("#frmPage").serialize(), success_function);
	}
	
	function UpdMatch(seq){
		if (!confirm('수정하시겠습니까?')) {
			return;
		}
		var data = {term:$("#term"+seq).val(),	description:$("#description"+seq).val(),seq:seq,reg_id:$("#user_id").val()}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SPO_00/UpdMatch', data, success_function);
	}

	function DelMatch(seq){
		if (!confirm('삭제하시겠습니까?')) {
			return;
		}
		var data = {term:$("#term"+seq).val(),	description:$("#description"+seq).val(),seq:seq,reg_id:$("#user_id").val()}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SPO_00/DelMatch', data, success_function);
	}
</script>
