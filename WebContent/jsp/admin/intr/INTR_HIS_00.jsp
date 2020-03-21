<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : GKL소개 > 연혁
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
	<table style="width: 753px; margin-bottom: 30px;">
		<colgroup>
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:65%" />
			<col style="width:10%" />
		</colgroup>
		<tr height="70">
			<td>
				<span>
					<select name="sel_typ" id="sel_typ" class="sel_basic" onchange="PageReload()">
					<c:forEach var="list" items="${lang_list}">
						<option value="${list.CODE}" <c:if test="${sel_typ == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
					</c:forEach>
					</select>
				</span>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="year" name="year" style="text-align: center; width: 80px;" maxlength="10" placeholder="연도"/>
			</td>
			<td>
				<textarea id="description" name="description" style="width: 90%; height: 100%; margin-left: 20px;" maxlength="500" placeholder="연혁"></textarea>
			</td>
			<td><a class="btn_s_wh" id="btn_reg" onclick="RegHistory()">등록</a></td>
		</tr>
	</table>
</div>
<div class="wrap_table" >
<div class="top_area">
	<ul>
		<li><a class="btn_s_wh" id="btn_cancel" onclick="success_function()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="sortUpdate()">순서저장</a></li>
	</ul>
</div>
	<table class="table_list">
		<colgroup>
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:65%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>연도</th>
			<th>연혁</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${history_list.size() == 0}">
		<tr>
			<td colspan="4" align="center" >등록된 연혁이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${history_list}">
		<tr height="70" class="tr_list" seq="<c:out value="${list.SEQ_HISTORY}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><input type="text" class="input_text" id="year${list.SEQ_HISTORY}" name="year${list.SEQ_HISTORY}" style="text-align:center; width: 80px;" value="<c:out value="${list.YEAR}" />" maxlength="10"/></td>
			<td><textarea id="description${list.SEQ_HISTORY}" name="description${list.SEQ_HISTORY}" style="width: 90%; height: 100%;" maxlength="250"><c:out value="${list.DESCRIPTION}" /></textarea></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdHistory('${list.SEQ_HISTORY}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelHistory('${list.SEQ_HISTORY}')">삭제</a>
			</td>
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
	//row위치 변경
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
	
	//정렬순서 변경
	function sortUpdate(){
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		var array = "";
		$('.tr_list').each(function(i){
			array += $(this).attr("seq") + "," + (i+1) + ".";
		});
		$('#array').val(array.substring(0, array.length-1));
		var url = "${pageContext.request.contextPath}/admin/INTR_HIS_00/sortUpdate";
		var data = $("#frmPage").serialize();
		GetAjaxXml(url, data, success_function, true);	
	}
	
	var success_function = function(xmlData) {
		GoPage("${pageContext.request.contextPath}/admin/INTR_HIS_00/default", {sel_typ:$("#sel_typ").val()}, '${TMENUID}', '${SMENUID}', '${METYPE}');
	};

	//연혁 등록
	function RegHistory(){
		if($('#year').val() == ""){
			alert('연도를 입력해주세요.');
			return;
		}else if($('#description').val() == ""){
			alert("내용을 입력해주세요.");
			return;
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_HIS_00/RegHistory', $("#frmPage").serialize(), success_function);
	}
	
	//연혁 수정
	function UpdHistory(seq){
		if (!confirm('수정하시겠습니까?')) {
			return;
		}
		var data = {
			year:$("#year"+seq).val(),
			description:$("#description"+seq).val(),
			sel_typ:$("#sel_typ").val(),
			seq:seq,
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_HIS_00/UpdHistory', data, success_function);
	}

	//연혁 삭제
	function DelHistory(seq){
		if (!confirm('삭제하시겠습니까?')) {
			return;
		}
		var data = {
			year:$("#year"+seq).val(),
			description:$("#description"+seq).val(),
			sel_typ:$("#sel_typ").val(),
			seq:seq,
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_HIS_00/DelHistory', data, success_function);
	}
	
	function PageReload(){
		var url = "${pageContext.request.contextPath}/admin/INTR_HIS_00/default";
		var param = {sel_typ:$("#sel_typ").val()};
		GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
	}

</script>
