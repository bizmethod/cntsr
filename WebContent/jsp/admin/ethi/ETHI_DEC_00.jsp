<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 윤리경영 > 반부패청렴 > 부패행위자 징계현황 > 리스트
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
			<col style="width:10%" />
			<col style="width:23%" />
			<col style="width:25%" />
			<col style="width:25%" />
			<col style="width:17%" />
		</colgroup>
		<tr height="70">
			<td></td>
			<td align="center">
				<input type="text" class="input_text" id="DEC_BODY" name="car_typ" style="text-align: center; width: 80%;" maxlength="100"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="DEC_TYP" name="buy_dt" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="DEC_DT" name="return_dt" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center"><a class="btn_s_wh" id="btn_save_car" onclick="RegInfo()">등록</a></td>
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
			<col style="width:23%" />
			<col style="width:25%" />
			<col style="width:25%" />
			<col style="width:17%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>No</th>
			<th>징계사유</th>
			<th>징계종류</th>
			<th>징계일자</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${dec_info.size() == 0}">
		<tr>
			<td colspan="8" align="center" >등록된 자료가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${dec_info}">
		<tr height="50" class="tr_list" seq="<c:out value="${list.SEQ_DEC}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><c:out value="${list.SORT_NO}"/></td>
			<td><input type="text" class="input_text" id="DEC_BODY${list.SEQ_DEC}" style="text-align:center; width: 80%;" value="<c:out value="${list.DEC_BODY}" />" maxlength="100"/></td>
			<td><input type="text" class="input_text" id="DEC_TYP${list.SEQ_DEC}" style="text-align:center; width: 80%;" value="<c:out value="${list.DEC_TYP}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="DEC_DT${list.SEQ_DEC}" style="text-align:center; width: 80%;" value="<c:out value="${list.DEC_DT}" />" maxlength="25"/></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdInfo('${list.SEQ_DEC}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelInfo('${list.SEQ_DEC}')">삭제</a>
			</td>
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_DEC_00/default";
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_DEC_00/sortUpdate";
	var data = $("#frmPage").serialize();
	GetAjaxXml(url, data, success_function, true);	
}

var success_function = function(xmlData) {
	GoPage("${pageContext.request.contextPath}/admin/ETHI_DEC_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//등록
function RegInfo(){
	if($('#DEC_BODY').val() == ""){
		alert('징계사유을 입력해주세요.');
		return;
	}else if($('#DEC_TYP').val() == ""){
		alert("징계종류을 입력해주세요.");
		return;
	}else if($('#DEC_DT').val() == ""){
		alert("징계일자을 입력해주세요.");
		return;
	}
	
	var data = {
			DEC_BODY:$("#DEC_BODY").val(),
			DEC_TYP:$("#DEC_TYP").val(),
			DEC_DT:$("#DEC_DT").val(),
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_DEC_00/RegInfo', data, success_function);
}

//수정
function UpdInfo(seq){
	if (!confirm('수정하시겠습니까?')) {
		return;
	}
	var data = {
		DEC_BODY:$("#DEC_BODY"+seq).val(),
		DEC_TYP:$("#DEC_TYP"+seq).val(),
		DEC_DT:$("#DEC_DT"+seq).val(),
		seq:seq,
		reg_id:$("#user_id").val()
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_DEC_00/UpdInfo', data, success_function);
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
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_DEC_00/DelInfo', data, success_function);
}

</script>