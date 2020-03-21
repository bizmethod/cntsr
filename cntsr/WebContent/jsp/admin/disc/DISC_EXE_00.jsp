<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 
  - Description : 경영공시 > 경영현황 > 임원현황 > 리스트
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

<div>
	<table style="margin-bottom: 30px; width: 1000px;">
		<colgroup>
			<col style="width:5%" />
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:33%" />
			<col style="width:17%" />
		</colgroup>
		<tr height="70">
			<td colspan="2">
				<span>
					<select name="lang_typ" id="lang_typ" class="sel_basic" onchange="PageReload()">
					<c:forEach var="list" items="${lang_list}">
						<option value="${list.CODE}" <c:if test="${lang_typ == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
					</c:forEach>
					</select>
				</span>
			</td>
			<td align="center">
				<select name="sel_typ" id="sel_typ" class="sel_basic">
					<c:forEach var="list" items="${gList}">
						<option value="${list.CODE}"><c:if test="${lang_typ == 'KR' || lang_typ == null}" >${list.CODE_NM}</c:if><c:if test="${lang_typ != 'KR'}" >${list.CODE_DESC}</c:if></option>
					</c:forEach>
				</select>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="executive_nm" name="executive_nm" style="text-align: center; width: 80%;" maxlength="20"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="start_term" name="cont_cost" style="text-align: center; width: 80%;" maxlength="20"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="end_term" name="enterprise" style="text-align: center; width: 80%;" maxlength="20"/>
			</td>
			<td align="center">
			<textarea id="career" name="career" style="width: 90%; height: 100px;" maxlength="1000"></textarea>
			</td>
			<td align="center"><a class="btn_s_wh" id="btn_save_data" onclick="RegInfo()">등록</a></td>
		</tr>
	</table>
</div>

<div class="wrap_table" >
<div class="top_area" style="width: 1000px;">
	<ul style="margin-right: 15px;">
		<li><a class="btn_s_wh" id="btn_cancel" onclick="success_function()">취소</a></li>
		<li><a class="btn_s_wh" id="btn_save" onclick="sortUpdate()">순서저장</a></li>
	</ul>
</div>
	<table class="table_list" style="width: 1000px;">
		<caption></caption>
		<colgroup>
			<col style="width:5%" />
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:33%" />
			<col style="width:17%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>No</th>
			<th>직책</th>
			<th>이름</th>
			<th>임기시작일</th>
			<th>임기종료일</th>
			<th>주요경력</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${exe_info.size() == 0}">
		<tr>
			<td colspan="8" align="center" >등록된 임원현황이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${exe_info}">
		<tr height="50" class="tr_list" seq="<c:out value="${list.SEQ_EXECUTIVE_CONT}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><c:out value="${list.SORT_NO}"/></td>
			<td>
				<select name="sel_typ${list.SEQ_EXECUTIVE_CONT}" id="sel_typ${list.SEQ_EXECUTIVE_CONT}" class="sel_basic">
					<c:forEach var="glist" items="${gList}">
						<option value="${glist.CODE}" <c:if test="${list.POSITION_TYP==glist.CODE}">selected="selected"</c:if>><c:if test="${lang_typ == 'KR' || lang_typ == null}" >${glist.CODE_NM}</c:if><c:if test="${lang_typ != 'KR'}" >${glist.CODE_DESC}</c:if></option>
					</c:forEach>
				</select>
			</td>
			<td><input type="text" class="input_text" id="executive_nm${list.SEQ_EXECUTIVE_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.EXECUTIVE_NM}" />" maxlength="20"/></td>
			<td><input type="text" class="input_text" id="start_term${list.SEQ_EXECUTIVE_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.START_TERM}" />" maxlength="20"/></td>
			<td><input type="text" class="input_text" id="end_term${list.SEQ_EXECUTIVE_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.END_TERM}" />" maxlength="20"/></td>
			<td><textarea id="career${list.SEQ_EXECUTIVE_CONT}" name="career" style="width: 90%; height: 100px;" maxlength="1000">${list.CAREER}</textarea></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdInfo('${list.SEQ_EXECUTIVE_CONT}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelInfo('${list.SEQ_EXECUTIVE_CONT}')">삭제</a>
			</td>
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
	var url = "${pageContext.request.contextPath}/admin/DISC_EXE_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//row위치 변경
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
	var url = "${pageContext.request.contextPath}/admin/DISC_EXE_00/sortUpdate";
	var data = $("#frmPage").serialize();
	GetAjaxXml(url, data, success_function, true);	
}

var success_function = function(xmlData) {
	GoPage("${pageContext.request.contextPath}/admin/DISC_EXE_00/default", $("#frmPage").serialize(), '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//등록
function RegInfo(){
	if($('#executive_nm').val() == ""){
		alert('이름을 입력해주세요.');
		return;
	}else if($('#start_term').val() == ""){
		alert('임기시작일을 입력해주세요.');
		return;
	}else if($('#end_term').val() == ""){
		alert("임기종료일을 입력해주세요.");
		return;
	}else if($('#career').val() == ""){
		alert("주요경력을 입력해주세요.");
		return;
	}
	
	var data = {
			lang_typ:$("#lang_typ").val(),
			sel_typ:$("#sel_typ").val(),
			executive_nm:$("#executive_nm").val(),
			start_term:$("#start_term").val(),
			end_term:$("#end_term").val(),
			career:$("#career").val(),
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_EXE_00/RegInfo', data, success_function);
}

//수정
function UpdInfo(seq){
	if (!confirm('수정하시겠습니까?')) {
		return;
	}
	var data = {
		lang_typ:$("#lang_typ"+seq).val(),
		sel_typ:$("#sel_typ"+seq).val(),
		executive_nm:$("#executive_nm"+seq).val(),
		start_term:$("#start_term"+seq).val(),
		end_term:$("#end_term"+seq).val(),
		career:$("#career"+seq).val(),
		seq:seq,
		reg_id:$("#user_id").val()
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_EXE_00/UpdInfo', data, success_function);
}

//삭제
function DelInfo(seq){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	var data = {
		seq:seq,
		reg_id:$("#user_id").val()
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_EXE_00/DelInfo', data, success_function);
}

</script>
