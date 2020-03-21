<%--
  - Author      : 김현우
  - Date        : 2014-07-15
  - Description : 윤리경영 > 반부패청렴 > 예산낭비 신고센터 > 상세
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
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
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="user_id" id="user_nm" value="${USER_NM}"/>

<c:if test="${map.CVOC_TYP == 'BR'}">
	<div style="font-size: 20px; margin-bottom: 10px; height: 30px;"><strong>예산신고</strong></div>
</c:if>
<c:if test="${map.CVOC_TYP == 'BP'}">
	<div style="font-size: 20px; margin-bottom: 10px; height: 30px;"><strong>예산제안</strong></div>
</c:if>
<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">제목</th>
		<td><span><c:out value="${map.TITLE}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">내용</th>
		<td><span><c:out value="${map.INQUIRY}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">작성자</th>
		<td><span><c:out value="${map.REG_NM}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">작성일</th>
		<td><span><c:out value="${map.REG_DT}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">이메일</th>
		<td><span><c:out value="${map.EMAIL}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">첨부파일</th>
		<td><span><c:out value="${map.ORG_FILE_NM}"/><a href="${pageContext.request.contextPath}/VIEWER/file/${map.FILE_SEQ}" class="btn_s_wh">다운로드</a></span></td>
	</tr>
	<tr>
		<th class="th_first">아이피</th>
		<td><span><c:out value="${map.REALIP}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">진행사항</th>
		<td><span><c:out value="${map.PRGR_TYP_NM}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">진행방법</th>
		<td><span><c:out value="${map.PRNO_TYP_NM}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">답변내용</th>
		<td><span><c:out value="${map.ANSWER}"/></span></td>
	</tr>
	<tr class="last">
		<td colspan="2" />
	</tr>
</table>

<table class="table_detail" style="margin-top: 30px;">
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first"><span>진행상태</span></th>
		<td>
			<span>
			<select name="sel_appr" id="sel_appr" class="sel_basic">
			<c:forEach var="list" items="${pList}" varStatus="status">
				<option value="${list.CODE}" <c:if test="${map.PRGR_TYP==list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
			<font style="color:red">처리완료 이메일 등록시 작성자에게 답변내용 메일이 발송 됩니다.</font>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">답변내용</th>
		<td>
			<span>
				<input type="text" class="input_text" id="answer" name="answer" style="width:100%;" value="${map.ANSWER}"/>
			</span>
		</td>
	</tr>
	<tr class="last">
		<td colspan="2" />
	</tr>
	</tbody>
</table>
</div>

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<li><a href="#" onclick="UpdAppr()">수정</a></li>
	</ul>
</div>
<input type="hidden" id="sel_means" value="${map.ANSW_TYP}" />
<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/ETHI_CYB_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}



function UpdAppr(){
	
	if($('#answer').val() == ""){
		alert('답변을 입력하세요.');
		return;
	}

	var data = {
			//value 체크
			seq : $("#seq").val(),
			answer : $("#answer").val(),
			prgr_typ : $("#sel_appr").val(),
			answ_typ : $("#sel_means").val(),
			reg_id : $("#user_id").val(),
			reg_nm : $("#user_nm").val()
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/COMM_VOI_01/UpdAppr', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/ETHI_REP_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>