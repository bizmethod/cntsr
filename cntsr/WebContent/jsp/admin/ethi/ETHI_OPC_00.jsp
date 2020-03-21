<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 윤리경영 > 반부패청렴 > 수의계약현황 > 리스트
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
			<col style="width:12.5%" />
			<col style="width:23%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:17%" />
		</colgroup>
		<tr height="70">
			<td></td>
			<td></td>
			<td align="center">
				<input type="text" class="input_text" id="cont_dt" name="cont_dt" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="title" name="title" style="text-align: center; width: 80%;" maxlength="100"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="cont_cost" name="cont_cost" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="enterprise" name="enterprise" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="order_org_nm" name="order_org_nm" style="text-align: center; width: 80%;" maxlength="25"/>
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
			<col style="width:12.5%" />
			<col style="width:23%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:17%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>No</th>
			<th>계약일</th>
			<th>건명</th>
			<th>금액</th>
			<th>업체</th>
			<th>발주팀</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${opc_info.size() == 0}">
		<tr>
			<td colspan="8" align="center" >등록된 계약내용이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${opc_info}">
		<tr height="50" class="tr_list" seq="<c:out value="${list.SEQ_OPTIONAL_CONT}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><c:out value="${list.SORT_NO}"/></td>
			<td><input type="text" class="input_text" id="cont_dt${list.SEQ_OPTIONAL_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.CONT_DT}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="title${list.SEQ_OPTIONAL_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.TITLE}" />" maxlength="100"/></td>
			<td><input type="text" class="input_text" id="cont_cost${list.SEQ_OPTIONAL_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.CONT_COST}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="enterprise${list.SEQ_OPTIONAL_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.ENTERPRISE}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="order_org_nm${list.SEQ_OPTIONAL_CONT}" style="text-align:center; width: 80%;" value="<c:out value="${list.ORDER_ORG_NM}" />" maxlength="25"/></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdInfo('${list.SEQ_OPTIONAL_CONT}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelInfo('${list.SEQ_OPTIONAL_CONT}')">삭제</a>
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_OPC_00/default";
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_OPC_00/sortUpdate";
	var data = $("#frmPage").serialize();
	GetAjaxXml(url, data, success_function, true);	
}

var success_function = function(xmlData) {
	GoPage("${pageContext.request.contextPath}/admin/ETHI_OPC_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//등록
function RegInfo(){
	if($('#cont_dt').val() == ""){
		alert('계약일을 입력해주세요.');
		return;
	}else if($('#title').val() == ""){
		alert('계약건명을 입력해주세요.');
		return;
	}else if($('#cont_cost').val() == ""){
		alert("금액을 입력해주세요.");
		return;
	}else if($('#enterprise').val() == ""){
		alert("업체를 입력해주세요.");
		return;
	}else if($('#order_org_nm').val() == ""){
		alert("발주팀을 입력해주세요.");
		return;
	}
	
	var data = {
			cont_dt:$("#cont_dt").val(),
			title:$("#title").val(),
			cont_cost:$("#cont_cost").val(),
			enterprise:$("#enterprise").val(),
			order_org_nm:$("#order_org_nm").val(),
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_OPC_00/RegInfo', data, success_function);
}

//수정
function UpdInfo(seq){
	if (!confirm('수정하시겠습니까?')) {
		return;
	}
	var data = {
		cont_dt:$("#cont_dt"+seq).val(),
		title:$("#title"+seq).val(),
		cont_cost:$("#cont_cost"+seq).val(),
		enterprise:$("#enterprise"+seq).val(),
		order_org_nm:$("#order_org_nm"+seq).val(),
		seq:seq,
		reg_id:$("#user_id").val()
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_OPC_00/UpdInfo', data, success_function);
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
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_OPC_00/DelInfo', data, success_function);
}

</script>
