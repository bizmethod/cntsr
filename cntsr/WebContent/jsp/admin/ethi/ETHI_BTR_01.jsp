<%--
  - Author      : 김현우
  - Date        : 2014-07-08
  - Description : 윤리경영 > 반부패청렴 > 임직원 해외출장정보 > 상세
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
	<input type="hidden" name="UUID" id="UUID" value="${UUID}" />
	<input type="hidden" name="IU" id="IU" value="${IU}" />
	<input type="hidden" name="fileYn" id="fileYn" value="N" />
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="file_org_nm" id="file_org_nm"/>
	<input type="hidden" name="file_name" id="file_name"/>
	<input type="hidden" name="file_size" id="file_size"/>

<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">임직원 구분</th>
		<td>
			<span>
				<select name="sel_typ" id="sel_typ" class="sel_basic">
					<option value="EX" <c:if test="${map.CODE_TYP == 'EX'}" >selected="selected"</c:if>>임원</option>
					<option value="EM" <c:if test="${map.CODE_TYP == 'EM'}" >selected="selected"</c:if>>직원</option>
				</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">출장호수</th>
		<td>
			<span>
				<input type="text" class="input_text" id="bt_no" name="bt_no" style="width:100%;" value="${map.BUSINESS_TRIP_NO}" maxlength="20"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">출장자</th>
		<td>
			<span>
				<input type="text" class="input_text" id="member_nm" name="member_nm" style="width:100%;" value="${map.MEMBER_NM}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">부서</th>
		<td>
			<span>
				<input type="text" class="input_text" id="org_nm" name="org_nm" style="width:100%;" value="${map.ORG_NM}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">직급</th>
		<td>
			<span>
				<input type="text" class="input_text" id="position_nm" name="position_nm" style="width:100%;" value="${map.POSITION_NM}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">출장기간</th>
		<td>
			<span>
				<input type="text" class="input_cal" name="start_d" id="start_d" value="${map.START_D}" /> ~ <input type="text" class="input_cal" name="end_d" id="end_d" value="${map.END_D}" />
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">출장지</th>
		<td>
			<span>
				<input type="text" class="input_text" id="place" name="place" style="width:100%;" value="${map.PLACE}" maxlength="100"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">출장목적</th>
		<td>
			<span>
				<textarea id="purpose" name="purpose" cols="100" rows="3" style="width:100%; " maxlength="600"><c:out value="${map.PURPOSE}" escapeXml="false"/></textarea>
<%-- 				<input type="text" class="input_text" id="purpose" name="purpose" style="width:100%;" value="${map.PURPOSE}" maxlength="100"/> --%>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">기안자</th>
		<td>
			<span>
				<input type="text" class="input_text" id="draft_nm" name="draft_nm" style="width:100%;" value="${map.DRAFT_NM}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">기안부서</th>
		<td>
			<span>
				<input type="text" class="input_text" id="draft_org_nm" name="draft_org_nm" style="width:100%;" value="${map.DRAFT_ORG_NM}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first"><span>첨부파일</span></th>
		<td>
			<div class="screen_imgs" id="ul_file" style="float: left; margin-left: 15px;"><c:out value="${map.ORG_FILE_NM}"/></div>
			<span class="file_btn_area" style="float: left; margin-left: 15px;">
				<input type="button" class="btn_search_file" value="파일찾기" />
				<b><input type="file" class="btn_file_hidden" id="attach_file" name="attach_file"/></b>
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
			<li><a href="#" onclick="RegData()">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegData()">수정</a></li>
			<li><a href="#" onclick="DelData()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

datepickerf('start_d', 'end_d', '', '');

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_BTR_01/DelData', $("#frmPage").serialize(), success_function);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/ETHI_BTR_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//첨부파일 등록
$('#attach_file').change(function() {
	$("#fileYn").val("Y");
	if($("#attach_file").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/ETHI_BTR_01/RegAttachFile", null, file_success_function, true, null, 'attach_file', 'gif, ppt, pptx, xsl, xlsx, doc, docx, pdf, hwp, jpg, png, mp3, mp4, zip, avi', true);
	}
});
//첨부파일 등록 성공시
var file_success_function = function(xmlData) {
	$('#file_size').val($(xmlData).find('smartq-xml > savedFileSize').text());
	$('#file_name').val($(xmlData).find('smartq-xml > savedFileName').text());
	$('#file_org_nm').val($(xmlData).find('smartq-xml > orgFileName').text());
	
	$('#ul_file').html($(xmlData).find('smartq-xml > orgFileName').text());
};
	
function RegData(){
	//value 체크
	if($('#start_d').val() == ""){
		alert('출장 시작일을 입력하세요.');
		return;
	}else if($('#end_d').val() == ""){
		alert('출장 종료일을 입력하세요.');
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_BTR_01/RegData', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/ETHI_BTR_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>