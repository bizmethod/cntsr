<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 소통경영 > 자주묻는질문 > 상세 및 등록
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" onsubmit="return false;">
	<input type="hidden" name="TMENUID" value="${TMENUID}"/>
	<input type="hidden" name="SMENUID" value="${SMENUID}"/>
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>

<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">질문</th>
		<td>
			<span>
				<input type="text" class="input_text" id="question" name="question" style="width: 100%;" value="${map.INQUIRY}" onkeyup="textByteCheck('question','question_byte',500)"/>
				<br/>
				<em class="byte">(<b id="question_byte">0</b>/<em id="question_byte_cnt">500</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">답변</th>
		<td>
			<span>
				<textarea id="answer" name="answer" cols="90" rows="5"  onkeyup="textByteCheck('answer','answer_byte',1000)"><c:out value="${map.ANSWER}" /></textarea>
				<br/>
				<em class="byte">(<b id="answer_byte">0</b>/<em id="answer_byte_cnt">1000</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first"><span>구분</span></th>
		<td colspan="3">
			<span>
			<input type="radio" name="gubun" value="01" id="gubun1" <c:if test="${map.get('FAQC_TYP') == '01' || faq_typ == '01' || IU == 'I'}">checked="checked"</c:if>> <label for="gubun1"> GKL 및 7LUCK 관련질문</label></input>
			<input type="radio" name="gubun" value="02" id="gubun2" <c:if test="${map.get('FAQC_TYP') == '02' || faq_typ == '02'}">checked="checked"</c:if>> <label for="gubun2"> 채용관련질문</label></input>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first"><span>전시여부</span></th>
		<td>
			<span>
			<input type="radio" name="recode_st" value="A" id="r1" <c:if test="${map.get('RECODE_ST') == 'A' || IU == 'I'}">checked="checked"</c:if>> <label for="r1"> 전시</label></input>
			<input type="radio" name="recode_st" value="I" id="r2" <c:if test="${map.get('RECODE_ST') == 'I'}">checked="checked"</c:if>> <label for="r2" > 미전시</label></input>
			</span>
		</td>
	</tr>
	<tr class="last">
		<td colspan="2" />
	</tr>
</table>
</div>

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegFaq('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegFaq('U')">수정</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/COMM_FAQ_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}


var gubun;
var recode_st;

function RegFaq(IU){
	
	//value 체크
	if($('#question').val() == ""){
		alert('질문을 입력하세요.');
		return;
	}
	
	var radio1 = $("input[name='recode_st']");
	for(var i = 0; i < radio1.length; i++){
		if(radio1[i].checked == true){
			recode_st = radio1[i].value;
		}
	}

	var radio2 = $("input[name='gubun']");
	for(var i = 0; i < radio2.length; i++){
		if(radio2[i].checked == true){
			gubun = radio2[i].value;
		}
	}
	
	var data = {
			seq : $("#seq").val(),
			question : $("#question").val(),
			answer : $("#answer").val(),
			recode_st : recode_st,
			gubun : gubun,
			reg_id : $("#user_id").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/COMM_FAQ_01/RegFaq', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/COMM_FAQ_00/default', {faq_typ:gubun} ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>