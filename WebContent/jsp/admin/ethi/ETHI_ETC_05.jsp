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
	<input type="hidden" name="UUID" id="UUID" value="${UUID}" />
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
		<th class="th_first">제목</th>
		<td>
			<span>
				<input type="text" class="input_text" id="title" name="title" style="width:100%;" value="${map.TITLE}" maxlength="20"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">실시일</th>
		<td>
			<span>
				<input type="text" class="input_text" id="date" name="date" style="width:100px;" value="${map.MEET_DT}" maxlength="10"/>
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
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_ETC_05/DelEtc', $("#frmPage").serialize(), success_function);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/ETHI_ETC_04/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//첨부파일 등록
$('#attach_file').change(function() {
	$("#fileYn").val("Y");
	if($("#attach_file").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/ETHI_ETC_05/RegAttachFile", null, file_success_function, true, null, 'attach_file', 'gif, ppt, pptx, xsl, xlsx, doc, docx, pdf, hwp, jpg, png, mp3, mp4, zip, avi', true);
	}
});
//첨부파일 등록 성공시
var file_success_function = function(xmlData) {
	$('#file_size').val($(xmlData).find('smartq-xml > savedFileSize').text());
	$('#file_name').val($(xmlData).find('smartq-xml > savedFileName').text());
	$('#file_org_nm').val($(xmlData).find('smartq-xml > orgFileName').text());
	
	$('#ul_file').html($(xmlData).find('smartq-xml > orgFileName').text());
};
	
function RegData(IU){
	
	var data = {
			seq : $("#seq").val(),
			UUID : $("#UUID").val(),
			sel_typ : $("#sel_typ").val(),
			org_nm : $("#org_nm").val(),
			title : $("#title").val(),
			date : $("#date").val(),
			reg_id : $("#user_id").val(),
			fileYn : $("#fileYn").val(),
			file_size : $("#file_size").val(),
			file_name : $("#file_name").val(),
			file_org_nm : $("#file_org_nm").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/ETHI_ETC_05/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/ETHI_ETC_04/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>