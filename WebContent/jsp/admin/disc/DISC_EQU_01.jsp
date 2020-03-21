<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 경영공시 > 재무현황 > 자본변동표 > 상세
  - Edited      : 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage">
	<input type="hidden" name="TMENUID" value="${TMENUID}"/>
	<input type="hidden" name="SMENUID" value="${SMENUID}"/>
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
	<input type="hidden" name="IU" id="IU" value="${IU}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>

<div class="wrap_table" >
	<table class="table_detail" style="width: 1000px;"> 
	<caption></caption>
	<colgroup>
		<col style="width:5%">
		<col style="width:5%">
		<col style="width:10%">
		<col style="width:15%">
		<col style="width:15%">
		<col style="width:15%">
		<col style="width:15%">
		<col style="width:20%">
	</colgroup>
	<tbody>
	<tr>
		<th colspan="3">국문 제목</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="30" id="title_kr" name="title_kr" style="width:80%;" value="${map.TITLE_KR}"/></span></td>
		<th>국문 기간</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="100" id="title_kr_base" name="title_kr_base" style="width:80%;" value="${map.TITLE_KR_BASE}"/></span></td>
	</tr>
	<tr>
		<th colspan="3">영문 제목</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="30" id="title_en" name="title_en" style="width:80%;" value="${map.TITLE_EN}"/></span></td>
		<th>영문 기간</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="100" id="title_en_base" name="title_en_base" style="width:80%;" value="${map.TITLE_EN_BASE}"/></span></td>
	</tr>
	<tr>
		<th colspan="3">일문 제목</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="30" id="title_jp" name="title_jp" style="width:80%;" value="${map.TITLE_JP}"/></span></td>
		<th>일문 기간</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="100" id="title_jp_base" name="title_jp_base" style="width:80%;" value="${map.TITLE_JP_BASE}"/></span></td>
	</tr>
	<tr>
		<th colspan="3">중문 제목</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="30" id="title_cn" name="title_cn" style="width:80%;" value="${map.TITLE_CN}"/></span></td>
		<th>중문 기간</th>
		<td colspan="2"><span><input type="text" class="input_text" maxlength="100" id="title_cn_base" name="title_cn_base" style="width:80%;" value="${map.TITLE_CN_BASE}"/></span></td>
	</tr>
	<tr>
		<th rowspan="2" colspan="3">구분</th>
		<th colspan="5">자본</th>
	</tr>
	<tr>
		<th>자본금</th>
		<th>주식발행 초과금</th>
		<th>기타포괄 손익누계액</th>
		<th>이익잉여금</th>
		<th>자본 합계</th>
	</tr>
	<tr>
		<th>기초자본</th>
		<th colspan="2"><span><input type="text" class="input_text" maxlength="30"  id="beginning_cap" name="beginning_cap" style="width:80%;" value="${map.BEGINNING_CAP}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="beg_cap_stock" name="beg_cap_stock" style="width:80%;" value="${map.BEG_CAP_STOCK}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="beg_exc_per_val" name="beg_exc_per_val" style="width:80%;" value="${map.BEG_EXC_PER_VAL}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="beg_comp_inc" name="beg_comp_inc" style="width:80%;" value="${map.BEG_COMP_INC}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="beg_ret_ear" name="beg_ret_ear" style="width:80%;" value="${map.BEG_RET_EAR}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="beg_tot_stock" name="beg_tot_stock" style="width:80%;" value="${map.BEG_TOT_STOCK}"/></span></th>
	</tr>
	<tr>
		<th rowspan="6">자본의 변동</th>
		<th rowspan="4">매출원가</th>
		<th><span>당기순이익<p>(손실)</p></span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="net_ret_ear" name="net_ret_ear" style="width:80%;" value="${map.NET_RET_EAR}"/></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="net_tot_stock" name="net_tot_stock" style="width:80%;" value="${map.NET_TOT_STOCK}"/></span></td>
	</tr>
	<tr>
		<th><span>기타포괄손익</span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_comp_inc" name="other_comp_inc" style="width:80%;" value="${map.OTHER_COMP_INC}"/></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_comp_ret" name="other_comp_ret" style="width:80%;" value="${map.OTHER_COMP_RET}"/></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_comp_tot" name="other_comp_tot" style="width:80%;" value="${map.OTHER_COMP_TOT}"/></span></td>
	</tr>
	<tr>
		<th><span>매도가능<p>금융자산</p></span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="sale_fi_ass" name="sale_fi_ass" style="width:80%;" value="${map.SALE_FI_ASS}"/></span></td>
		<td><span></span></td>
		<td><span></span></td>
	</tr>
	<tr>
		<th><span>퇴직급여 채무에 <p>대한 보험수리적손익</p></span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="retire_ret" name="retire_ret" style="width:80%;" value="${map.RETIRE_RET}"/></span></td>
		<td><span></span></td>
	</tr>
	<tr>
		<th rowspan="2">소유주와의 거래</th>
		<th><span>배당</span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="devidend_ret" name="devidend_ret" style="width:80%;" value="${map.DEVIDEND_RET}"/></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="devidend_tot" name="devidend_tot" style="width:80%;" value="${map.DEVIDEND_TOT}"/></span></td>
	</tr>
	<tr>
		<th><span>소유주와의 <p>거래 총액</p></span></th>
		<td><span></span></td>
		<td><span></span></td>
		<td><span></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="owner_ret" name="owner_ret" style="width:80%;" value="${map.OWNER_RET}"/></span></td>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="owner_tot" name="owner_tot" style="width:80%;" value="${map.OWNER_TOT}"/></span></td>
	</tr>
	<tr>
		<th>기말자본</th>
		<th colspan="2"><span><input type="text" class="input_text" maxlength="30"  id="ending_cap" name="ending_cap" style="width:80%;" value="${map.ENDING_CAP}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="end_cap_stock" name="end_cap_stock" style="width:80%;" value="${map.END_CAP_STOCK}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="end_exc_per_val" name="end_exc_per_val" style="width:80%;" value="${map.END_EXC_PER_VAL}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="end_comp_inc" name="end_comp_inc" style="width:80%;" value="${map.END_COMP_INC}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="end_ret_ear" name="end_ret_ear" style="width:80%;" value="${map.END_RET_EAR}"/></span></th>
		<th><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="end_total_stock" name="end_total_stock" style="width:80%;" value="${map.END_TOTAL_STOCK}"/></span></th>
	</tr>
	</table>
</div>

<div class="wrap_btn" style="width: 1000px;">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegEqData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegEqData('U')">수정</a></li>
<!-- 			<li><a href="#" onclick="DelData()">삭제</a></li> -->
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_EQU_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_EQU_01/DelData', $("#frmPage").serialize(), success_function);
}

function RegEqData(IU){
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_EQU_01/RegEqData', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_EQU_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    
    return str.replace(/[^\d]+/g, '');
}

function input_check_num(obj) {
	obj.value = comma(uncomma(obj.value));
}

</script>