<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 정부3.0 > 관련법령 및 서식 > 상세
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
		<th class="th_first">구분</th>
		<td>
			<span>
				<select name="sel_typ" id="sel_typ" class="sel_basic">
					<c:forEach var="list" items="${gubunList}">
						<option value="${list.CODE}" <c:if test="${map.RLAW_TYP == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
					</c:forEach>
				</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">제목</th>
		<td>
			<span>
				<input type="text" class="input_text" id="title" name="title" style="width:100%;" value="${map.TITLE}" maxlength="50"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">링크구분</th>
		<td>
			<span>
				<select name="link_typ" id="link_typ" class="sel_basic">
					<c:forEach var="list" items="${linkList}">
						<option value="${list.CODE}" <c:if test="${map.LINK_TYP == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
					</c:forEach>
				</select>
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
	<tr>
		<th class="th_first">URL</th>
		<td>
			<span>
				<input type="text" class="input_text" id="url" name="url" style="width:100%;" value="${map.URL}" maxlength="100"/>
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
			<li><a href="#" onclick="DelLawData()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/GOVE_LAW_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelLawData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/GOVE_LAW_01/DelLawData', $("#frmPage").serialize(), success_function);
}

//첨부파일 등록
$('#attach_file').change(function() {
	$("#fileYn").val("Y");
	if($("#attach_file").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/GOVE_LAW_01/RegAttachFile", null, file_success_function, true, null, 'attach_file', 'ppt, pptx, xsl, xlsx, doc, docx, pdf, hwp, jpg, png, mp3, mp4, zip, avi', true);
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
			link_typ : $("#link_typ").val(),
			url : $("#url").val(),
			title : $("#title").val(),
			reg_id : $("#user_id").val(),
			fileYn : $("#fileYn").val(),
			file_size : $("#file_size").val(),
			file_name : $("#file_name").val(),
			file_org_nm : $("#file_org_nm").val(),
			IU:IU
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/GOVE_LAW_01/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/GOVE_LAW_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>