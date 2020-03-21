<%--
  - Author      : 김현우
  - Date        : 2014-07-24
  - Description : 경영공시 > 재무현황 > 재무상태표 > 상세
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

<div class="wrap_table" style="width: 900px;">
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
		<th>한국어 제목</th>
		<td><span><input type="text" class="input_text" maxlength="30" id="title_kr" name="title_kr" style="width:80%;" value="${map.TITLE_KR}"/></span></td>
		<th>한국어 기간</th>
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
		<th colspan="4"><span>자산</span></th>
	</tr>
	<tr>
		<th class="th_first">유동자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cur_ass" name="cur_ass" style="width:80%;" value="${map.CUR_ASS}"/></span></td>
		<th class="th_first">현금 및 현금성자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cash_ass" name="cash_ass" style="width:80%;" value="${map.CASH_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타금융자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_fi_ass" name="other_fi_ass" style="width:80%;" value="${map.OTHER_FI_ASS}"/></span></td>
		<th class="th_first">매출채권 및 기타유동채권</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="trade_recv" name="trade_recv" style="width:80%;" value="${map.TRADE_RECV}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">재고자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="inventory" name="inventory" style="width:80%;" value="${map.INVENTORY}"/></span></td>
		<th class="th_first">기타유동자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_cur_ass" name="other_cur_ass" style="width:80%;" value="${map.OTHER_CUR_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">매각예정자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="sell_sche_ass" name="sell_sche_ass" style="width:80%;" value="${map.SELL_SCHE_ASS}"/></span></td>
		<th class="th_first">비유동자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_cur_ass" name="non_cur_ass" style="width:80%;" value="${map.NON_CUR_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타비유동금융자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_non_fi_ass" name="other_non_fi_ass" style="width:80%;" value="${map.OTHER_NON_FI_ASS}"/></span></td>
		<th class="th_first"> 비유동매출채권 및 기타비 유동채권</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_trade_recv" name="non_trade_recv" style="width:80%;" value="${map.NON_TRADE_RECV}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">유형자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tangible_ass" name="tangible_ass" style="width:80%;" value="${map.TANGIBLE_ASS}"/></span></td>
		<th class="th_first">무형자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="intangible_ass" name="intangible_ass" style="width:80%;" value="${map.INTANGIBLE_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">이연법인세자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="def_tax_ass" name="def_tax_ass" style="width:80%;" value="${map.DEF_TAX_ASS}"/></span></td>
		<th class="th_first">기타비유동자산</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_non_cur_ass" name="other_non_cur_ass" style="width:80%;" value="${map.OTHER_NON_CUR_ASS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">자산총계</th>
		<td colspan="3"><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tot_ass" name="tot_ass" style="width:80%;" value="${map.TOT_ASS}"/></span></td>
	</tr>
	<tr><th colspan="4"><span>자본</span></th></tr>
	<tr>
		<th class="th_first">자본금</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="capital_stock" name="capital_stock" style="width:80%;" value="${map.CAPITAL_STOCK}"/></span></td>
		<th class="th_first">자본잉여금</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="capital_surplus" name="capital_surplus" style="width:80%;" value="${map.CAPITAL_SURPLUS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타포괄손익누계액</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_comp_income" name="other_comp_income" style="width:80%;" value="${map.OTHER_COMP_INCOME}"/></span></td>
		<th class="th_first">이익잉여금</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="earned_surplus" name="earned_surplus" style="width:80%;" value="${map.EARNED_SURPLUS}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">자본총계</th>
		<td colspan="3"><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tot_stock" name="tot_stock" style="width:80%;" value="${map.TOT_STOCK}"/></span></td>
	</tr>
	<tr><th colspan="4"><span>부채</span></th></tr>
	<tr>
		<th class="th_first">유동부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="cur_liab" name="cur_liab" style="width:80%;" value="${map.CUR_LIAB}"/></span></td>
		<th class="th_first">미지급금및기타채무</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_liab" name="other_liab" style="width:80%;" value="${map.OTHER_LIAB}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타금융부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_fi_liab" name="other_fi_liab" style="width:80%;" value="${map.OTHER_FI_LIAB}"/></span></td>
		<th class="th_first">미지급법인세</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="income_tax_pay" name="income_tax_pay" style="width:80%;" value="${map.INCOME_TAX_PAY}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타유동부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_cur_liab" name="other_cur_liab" style="width:80%;" value="${map.OTHER_CUR_LIAB}"/></span></td>
		<th class="th_first">비유동부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_cur_liab" name="non_cur_liab" style="width:80%;" value="${map.NON_CUR_LIAB}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">비유동금융부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="non_cur_fi_liab" name="non_cur_fi_liab" style="width:80%;" value="${map.NON_CUR_FI_LIAB}"/></span></td>
		<th class="th_first">퇴직급여채무</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="retire_liab" name="retire_liab" style="width:80%;" value="${map.RETIRE_LIAB}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">기타비유동부채</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="other_non_cur_liab" name="other_non_cur_liab" style="width:80%;" value="${map.OTHER_NON_CUR_LIAB}"/></span></td>
		<th class="th_first">부채총계</th>
		<td><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tot_liab" name="tot_liab" style="width:80%;" value="${map.TOT_LIAB}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">자본과부채총계</th>
		<td colspan="3"><span><input type="text" class="input_text" maxlength="30"  onkeyup="input_check_num(this)" id="tot_stock_equ_liab" name="tot_stock_equ_liab" style="width:80%;" value="${map.TOT_STOCK_EQU_LIAB}"/></span></td>
	</tr>
	<tr class="last">
		<td colspan="4" />
	</tr>
</table>
</div>

<div class="wrap_btn" style="width: 900px;">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegBsData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegBsData('U')">수정</a></li>
<!-- 			<li><a href="#" onclick="DelData()">삭제</a></li> -->
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_BAL_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_BAL_01/DelData', $("#frmPage").serialize(), success_function);
}

function RegBsData(IU){
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_BAL_01/RegBsData', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_BAL_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
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