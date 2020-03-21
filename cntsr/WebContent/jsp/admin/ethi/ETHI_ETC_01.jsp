<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 반부패청렴 > 기타현황 > 반부패청렴 협의회 & 교육자료 리스트
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
		<th class="th_first">직위</th>
		<td>
			<span>
				<input type="text" class="input_text" id="POSITION_NM" name="POSITION_NM" style="width:100%;" value="${map.POSITION_NM}" maxlength="20"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">소속</th>
		<td>
			<span>
				<input type="text" class="input_text" id="TEAM_NM" name="TEAM_NM" style="width:100%;" value="${map.TEAM_NM}" maxlength="20"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">직급</th>
		<td>
			<span>
				<input type="text" class="input_text" id="GRADE_NM" name="GRADE_NM" style="width:100%;" value="${map.GRADE_NM}" maxlength="100"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">이름</th>
		<td>
			<span>
				<input type="text" class="input_text" id="MEMBER_NM" name="MEMBER_NM" style="width:100%;" value="${map.MEMBER_NM}" maxlength="10"/>
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
			<li><a href="#" onclick="DelEtc()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

//삭제
function DelEtc(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_ETC_01/DelEtc', $("#frmPage").serialize(), success_function);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function RegData(IU){
	
	var data = {
			seq : $("#seq").val(),
			TEAM_NM : $("#TEAM_NM").val(),
			POSITION_NM : $("#POSITION_NM").val(),
			GRADE_NM : $("#GRADE_NM").val(),
			MEMBER_NM : $("#MEMBER_NM").val(),
			reg_id : $("#user_id").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_ETC_01/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/ETHI_ETC_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>