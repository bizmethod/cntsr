<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 경영공시 > 재무현황 > 포괄손익계산서 > 상세
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
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:30%">
		<col style="width:20%">
		<col style="width:30%">
	</colgroup>
	<tbody>
	<tr>
		<th>국문 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_kr" name="title_kr" style="width:80%;" value="${map.TITLE_KR}"/></span></td>
		<th>국문 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_kr_base" name="title_kr_base" style="width:80%;" value="${map.TITLE_KR_BASE}"/></span></td>
	</tr>
	<tr>
		<th>영문 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_en" name="title_en" style="width:80%;" value="${map.TITLE_EN}"/></span></td>
		<th>영문 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_en_base" name="title_en_base" style="width:80%;" value="${map.TITLE_EN_BASE}"/></span></td>
	</tr>
	<tr>
		<th>일문 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_jp" name="title_jp" style="width:80%;" value="${map.TITLE_JP}"/></span></td>
		<th>일문 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_jp_base" name="title_jp_base" style="width:80%;" value="${map.TITLE_JP_BASE}"/></span></td>
	</tr>
	<tr>
		<th>중국어 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_cn" name="title_cn" style="width:80%;" value="${map.TITLE_CN}"/></span></td>
		<th>중국어 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_cn_base" name="title_cn_base" style="width:80%;" value="${map.TITLE_CN_BASE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">수익(매출액)</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="revenue" name="revenue" style="width:80%;" value="${map.REVENUE}"/></span></td>
		<th class="th_first">매출원가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cost_sales" name="cost_sales" style="width:80%;" value="${map.COST_SALES}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">매출총이익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="gross_profit" name="gross_profit" style="width:80%;" value="${map.GROSS_PROFIT}"/></span></td>
		<th class="th_first">판매비와관리비</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="sell_expense" name="sell_expense" style="width:80%;" value="${map.SELL_EXPENSE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">영업이익(손실)</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="opr_income_loss" name="opr_income_loss" style="width:80%;" value="${map.OPR_INCOME_LOSS}"/></span></td>
		<th class="th_first">영업외수익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_opr_income" name="non_opr_income" style="width:80%;" value="${map.NON_OPR_INCOME}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">영업외비용</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_opr_expense" name="non_opr_expense" style="width:80%;" value="${map.NON_OPR_EXPENSE}"/></span></td>
		<th class="th_first">금융수익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="fi_income" name="fi_income" style="width:80%;" value="${map.FI_INCOME}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">금융원가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="fi_cost" name="fi_cost" style="width:80%;" value="${map.FI_COST}"/></span></td>
		<th class="th_first">법인세비용차감전순이익(손실)</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="income_before_tax" name="income_before_tax" style="width:80%;" value="${map.INCOME_BEFORE_TAX}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">법인세비용</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="income_tax_expense" name="income_tax_expense" style="width:80%;" value="${map.INCOME_TAX_EXPENSE}"/></span></td>
		<th class="th_first">당기순이익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="net_income" name="net_income" style="width:80%;" value="${map.NET_INCOME}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타포괄손익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_comp_income" name="other_comp_income" style="width:80%;" value="${map.OTHER_COMP_INCOME}"/></span></td>
		<th class="th_first">매도가능금융자산평가이익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="fi_ass_available_sale" name="fi_ass_available_sale" style="width:80%;" value="${map.FI_ASS_AVAILABLE_SALE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">보험수리적손익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="income_repair" name="income_repair" style="width:80%;" value="${map.INCOME_REPAIR}"/></span></td>
		<th class="th_first">총포괄손익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tot_comp_income" name="tot_comp_income" style="width:80%;" value="${map.TOT_COMP_INCOME}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">주당이익</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="ear_per_share" name="ear_per_share" style="width:80%;" value="${map.EAR_PER_SHARE}"/></span></td>
		<th class="th_first">기본주당이익(손실)</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="ear_per_share_loss" name="ear_per_share_loss" style="width:80%;" value="${map.EAR_PER_SHARE_LOSS}"/></span></td>
	</tr>
	</table>
</div>

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegIncData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegIncData('U')">수정</a></li>
<!-- 			<li><a href="#" onclick="DelData()">삭제</a></li> -->
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_INC_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_INC_01/DelData', $("#frmPage").serialize(), success_function);
}

function RegIncData(IU){
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_INC_01/RegIncData', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_INC_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
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