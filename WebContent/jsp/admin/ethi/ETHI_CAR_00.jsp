<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 윤리경영 > 반부패청렴 > 차량현황 > 리스트
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
			<col style="width:23%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:17%" />
		</colgroup>
		<tr height="70">
			<td></td>
			<td></td>
			<td align="center">
				<input type="text" class="input_text" id="car_typ" name="car_typ" style="text-align: center; width: 80%;" maxlength="100"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="buy_dt" name="buy_dt" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="return_dt" name="return_dt" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="buy_typ" name="buy_typ" style="text-align: center; width: 80%;" maxlength="25"/>
			</td>
			<td align="center">
				<input type="text" class="input_text" id="buy_cost" name="buy_cost" style="text-align: center; width: 80%;" maxlength="25"/>
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
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:12.5%" />
			<col style="width:17%" />
		</colgroup>
		<thead>
		<tr>
			<th>조정</th>
			<th>No</th>
			<th>차종(연식)</th>
			<th>구입일자</th>
			<th>반납일자</th>
			<th>매입구분</th>
			<th>매입가격</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${car_info.size() == 0}">
		<tr>
			<td colspan="8" align="center" >등록된 자료가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${car_info}">
		<tr height="50" class="tr_list" seq="<c:out value="${list.SEQ_CAR}" />">
			<td class="th_first" onclick="event.cancelBubble = true;"><span class="group_control"><a class="MOVEUP" style="cursor:pointer;">▲</a><a class="MOVEDOWN" style="cursor:pointer;">▼</a></span></td>
			<td><c:out value="${list.SORT_NO}"/></td>
			<td><input type="text" class="input_text" id="car_typ${list.SEQ_CAR}" style="text-align:center; width: 80%;" value="<c:out value="${list.CAR_TYP}" />" maxlength="100"/></td>
			<td><input type="text" class="input_text" id="buy_dt${list.SEQ_CAR}" style="text-align:center; width: 80%;" value="<c:out value="${list.BUY_DT}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="return_dt${list.SEQ_CAR}" style="text-align:center; width: 80%;" value="<c:out value="${list.RETURN_DT}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="buy_typ${list.SEQ_CAR}" style="text-align:center; width: 80%;" value="<c:out value="${list.BUY_TYP}" />" maxlength="25"/></td>
			<td><input type="text" class="input_text" id="buy_cost${list.SEQ_CAR}" style="text-align:center; width: 80%;" value="<c:out value="${list.BUY_COST}" />" maxlength="25"/></td>
			<td>
				<a class="btn_s_wh" id="btn_upd" onclick="UpdInfo('${list.SEQ_CAR}')">수정</a>
				<a class="btn_s_wh" id="btn_del" onclick="DelInfo('${list.SEQ_CAR}')">삭제</a>
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_CAR_00/default";
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
	var url = "${pageContext.request.contextPath}/admin/ETHI_CAR_00/sortUpdate";
	var data = $("#frmPage").serialize();
	GetAjaxXml(url, data, success_function, true);	
}

var success_function = function(xmlData) {
	GoPage("${pageContext.request.contextPath}/admin/ETHI_CAR_00/default", null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//등록
function RegInfo(){
	if($('#car_typ').val() == ""){
		alert('차종을 입력해주세요.');
		return;
	}else if($('#buy_dt').val() == ""){
		alert("구입일을 입력해주세요.");
		return;
	}else if($('#return_dt').val() == ""){
		alert("반납일을 입력해주세요.");
		return;
	}else if($('#buy_typ').val() == ""){
		alert("매입구분을 입력해주세요.");
		return;
	}else if($('#buy_cost').val() == ""){
		alert("매입가격을 입력해주세요.");
		return;
	}
	
	var data = {
			ncprm_car_typ:$("#car_typ").val(),
			buy_dt:$("#buy_dt").val(),
			return_dt:$("#return_dt").val(),
			ncprm_buy_typ:$("#buy_typ").val(),
			buy_cost:$("#buy_cost").val(),
			reg_id:$("#user_id").val()
		}
		GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_CAR_00/RegInfo', data, success_function);
}

//수정
function UpdInfo(seq){
	if (!confirm('수정하시겠습니까?')) {
		return;
	}
	var data = {
		ncprm_car_typ:$("#car_typ"+seq).val(),
		buy_dt:$("#buy_dt"+seq).val(),
		return_dt:$("#return_dt"+seq).val(),
		ncprm_buy_typ:$("#buy_typ"+seq).val(),
		buy_cost:$("#buy_cost"+seq).val(),
		seq:seq,
		reg_id:$("#user_id").val()
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_CAR_00/UpdInfo', data, success_function);
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
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_CAR_00/DelInfo', data, success_function);
}

</script>
