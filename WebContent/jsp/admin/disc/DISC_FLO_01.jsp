<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 경영공시 > 재무현황 > 현금흐름표 > 상세
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
		<th>영어 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_en" name="title_en" style="width:80%;" value="${map.TITLE_EN}"/></span></td>
		<th>영어 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_en_base" name="title_en_base" style="width:80%;" value="${map.TITLE_EN_BASE}"/></span></td>
	</tr>
	<tr>
		<th>일본어 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_jp" name="title_jp" style="width:80%;" value="${map.TITLE_JP}"/></span></td>
		<th>일본어 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_jp_base" name="title_jp_base" style="width:80%;" value="${map.TITLE_JP_BASE}"/></span></td>
	</tr>
	<tr>
		<th>중국어 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_cn" name="title_cn" style="width:80%;" value="${map.TITLE_CN}"/></span></td>
		<th>중국어 기간</th>
		<td><span><input type="text" class="input_text" maxlength="100" id="title_cn_base" name="title_cn_base" style="width:80%;" value="${map.TITLE_CN_BASE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">영업활동 현금흐름</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_flow_opr" name="cash_flow_opr" style="width:80%;" value="${map.CASH_FLOW_OPR}"/></span></td>
		<th class="th_first">영업활동에서 창출된 현금</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_create_opr" name="cash_create_opr" style="width:80%;" value="${map.CASH_CREATE_OPR}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">이자수취</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="int_receipt" name="int_receipt" style="width:80%;" value="${map.INT_RECEIPT}"/></span></td>
		<th class="th_first">이자지급</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="int_pay" name="int_pay" style="width:80%;" value="${map.INT_PAY}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">법인세납부</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="income_tax_pay" name="income_tax_pay" style="width:80%;" value="${map.INCOME_TAX_PAY}"/></span></td>
		<th class="th_first">투자활동현금흐름</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_flow_inv" name="cash_flow_inv" style="width:80%;" value="${map.CASH_FLOW_INV}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">투자활동으로 인한 현금유입액</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_inflow_inv" name="cash_inflow_inv" style="width:80%;" value="${map.CASH_INFLOW_INV}"/></span></td>
		<th class="th_first">대여금의 회수</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="col_loans" name="col_loans" style="width:80%;" value="${map.COL_LOANS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타금융자산의 감소</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dec_other_fi_ass" name="dec_other_fi_ass" style="width:80%;" value="${map.DEC_OTHER_FI_ASS}"/></span></td>
		<th class="th_first">보증금의 감소</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dec_security_dep" name="dec_security_dep" style="width:80%;" value="${map.DEC_SECURITY_DEP}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타비유동금융자산의 감소</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dec_other_cur_fi_ass" name="dec_other_cur_fi_ass" style="width:80%;" value="${map.DEC_OTHER_CUR_FI_ASS}"/></span></td>
		<th class="th_first">매각예정자산의 처분</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dec_sales_sche_ass" name="dec_sales_sche_ass" style="width:80%;" value="${map.DEC_SALES_SCHE_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">유형자산의 처분</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dis_tangible_ass" name="dis_tangible_ass" style="width:80%;" value="${map.DIS_TANGIBLE_ASS}"/></span></td>
		<th class="th_first">무형자산의 처분</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="dis_intangible_ass" name="dis_intangible_ass" style="width:80%;" value="${map.DIS_INTANGIBLE_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">투자활동으로 인한 현금유출액</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_outflow_inv" name="cash_outflow_inv" style="width:80%;" value="${map.CASH_OUTFLOW_INV}"/></span></td>
		<th class="th_first">대여금의 증가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="inc_loans" name="inc_loans" style="width:80%;" value="${map.INC_LOANS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타금융자산의 증가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="inc_other_fi_ass" name="inc_other_fi_ass" style="width:80%;" value="${map.INC_OTHER_FI_ASS}"/></span></td>
		<th class="th_first">보증금 증가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="inc_security_dep" name="inc_security_dep" style="width:80%;" value="${map.INC_SECURITY_DEP}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타비유동금융자산의 증가</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="inc_other_non_fi_ass" name="inc_other_non_fi_ass" style="width:80%;" value="${map.INC_OTHER_NON_FI_ASS}"/></span></td>
		<th class="th_first">유형자산의 취득</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="acq_tangible_ass" name="acq_tangible_ass" style="width:80%;" value="${map.ACQ_TANGIBLE_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">무형자산의 취득</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="acq_intangible_ass" name="acq_intangible_ass" style="width:80%;" value="${map.ACQ_INTANGIBLE_ASS}"/></span></td>
		<th class="th_first">재무활동현금흐름</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_flow_fi_act" name="cash_flow_fi_act" style="width:80%;" value="${map.CASH_FLOW_FI_ACT}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">재무활동으로 인한 현금유입액</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_inflow_fi_act" name="cash_inflow_fi_act" style="width:80%;" value="${map.CASH_INFLOW_FI_ACT}"/></span></td>
		<th class="th_first">장기차입금의 차입</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="long_term_bor" name="long_term_bor" style="width:80%;" value="${map.LONG_TERM_BOR}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타금융부채의 차입</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="col_security_dep" name="col_security_dep" style="width:80%;" value="${map.COL_SECURITY_DEP}"/></span></td>
		<th class="th_first">보증금의 회수</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="col_dep" name="col_dep" style="width:80%;" value="${map.COL_DEP}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">재무활동으로 인한 현금유출액</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_outflow_fi_act" name="cash_outflow_fi_act" style="width:80%;" value="${map.CASH_OUTFLOW_FI_ACT}"/></span></td>
		<th class="th_first">유동성장기차입금의 상환</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cur_long_term_bor" name="cur_long_term_bor" style="width:80%;" value="${map.CUR_LONG_TERM_BOR}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">장기차입금의 상환</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="rep_long_term_bor" name="rep_long_term_bor" style="width:80%;" value="${map.REP_LONG_TERM_BOR}"/></span></td>
		<th class="th_first">배당금 지급</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="pay_div" name="pay_div" style="width:80%;" value="${map.PAY_DIV}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">외화표시현금및현금성자산에 대한 환율변동효과</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="exchange_rate" name="exchange_rate" style="width:80%;" value="${map.EXCHANGE_RATE}"/></span></td>
		<th class="th_first">현금및현금성자산의순증가(감소)</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="net_increase" name="net_increase" style="width:80%;" value="${map.NET_INCREASE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">당기초현금및현금성자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="biginning_cash" name="biginning_cash" style="width:80%;" value="${map.BIGINNING_CASH}"/></span></td>
		<th class="th_first">당기말현금및현금성자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="ending_cash" name="ending_cash" style="width:80%;" value="${map.ENDING_CASH}"/></span></td>
	</tr>
	</table>
</div>

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegFlowData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegFlowData('U')">수정</a></li>
<!-- 			<li><a href="#" onclick="DelData()">삭제</a></li> -->
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_FLO_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_FLO_01/DelData', $("#frmPage").serialize(), success_function);
}

function RegFlowData(IU){
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_FLO_01/RegFlowData', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_FLO_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
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