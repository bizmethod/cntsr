<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 반부패청렴 > 반부패 의지노력 > 상세
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" method="post" enctype="multipart/form-data">
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
		<th class="th_first">접수일</th>
		<td>
			<span>
				<input type="text" class="input_text" id="seq_dt" name="seq_dt" style="width:70px;" value="${map.REQ_DT}" readonly/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">제공받은 금품 등</th>
		<td>
			<span>
				<input type="text" class="input_text" id="app_rem" name="app_rem" style="width:100%;" value="${map.APP_REM}" maxlength="500"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">제공받은일</th>
		<td>
			<span>
				<input type="text" class="input_text" id="app_dt" name="app_dt" style="width:70px;" value="${map.APP_DT}" readonly/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">처리내용</th>
		<td>
			<span>
				<input type="text" class="input_text" id="exe_rem" name="exe_rem" style="width:100%;" value="${map.EXE_REM}" maxlength="500"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">처리완료일</th>
		<td>
			<span>
				<input type="text" class="input_text" id="exe_dt" name="exe_dt" style="width:70px;" value="${map.EXE_DT}" readonly/>
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
			<li><a href="#" onclick="RegData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegData('U')">수정</a></li>
			<li><a href="#" onclick="Del()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>
datepickerf('seq_dt', '');
datepickerf('app_dt', '');
datepickerf('exe_dt', '');

function Del(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_NON_01/Del', $("#frmPage").serialize(), success_function);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/ETHI_NON_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function RegData(IU){
	
	var data = {
			SEQ_NON_PAY : $("#seq").val(),
			REQ_DT : $("#seq_dt").val(),
			APP_REM : $("#app_rem").val(),
			APP_DT : $("#app_dt").val(),
			EXE_REM : $("#exe_rem").val(),
			EXE_DT : $("#exe_dt").val(),
			USER_ID : $("#user_id").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_NON_01/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/ETHI_NON_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>