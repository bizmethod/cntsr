<%--
  - Author      : 김현우
  - Date        : 2014-08-07
  - Description : 경영공시 > 이사회개최현황 > 상세
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" method="post" enctype="multipart/form-data">
<div class="wrap_table" >
	<table class="table_detail">
		<caption></caption>
		<colgroup>
			<col style="width:15%" />
			<col style="width:35%" />
			<col style="width:15%" />
			<col style="width:35%" />
		</colgroup>
		<thead>
		<tr>
			<th class="th_first"><span>제목</span></th>
			<td colspan="3"><span><input type="text" class="input_text" id="title" name="title" style="width: 80%;" value="${map.get('TITLE')}" maxlength="100"/></span></td>
		</tr>
		<tr>
			<th class="th_first"><span>전시여부</span></th>
			<td>
				<span>
				<input type="radio" name="recode_st" value="A" id="r1" <c:if test="${map.get('RECODE_ST') == 'A' || IU == 'I'}">checked="checked"</c:if>> <label for="r1"> 전시</label></input>
				<input type="radio" name="recode_st" value="I" id="r2" <c:if test="${map.get('RECODE_ST') == 'I'}">checked="checked"</c:if>> <label for="r2" > 미전시</label></input>
				</span>
			</td>
			<th class="th_first">파일등록</th>
			<td>
				<span>
					<span class="file_btn_area" style="margin-right: 15px;">
						<input type="button" class="btn_search_file" value="파일찾기" />
						<b><input type="file" class="btn_file_hidden" id="attach_file" name="attach_file" onchange="file_onchange();" /></b>
					</span>
				</span>
			</td>
		</tr>
		<tr>
		<th class="th_first"><span>첨부파일</span></th>
			<td colspan="3">
				<span class="attach_screen_area">
					<div class="screen_imgs" id="ul_file">
						<c:forEach var="list" items="${attachList}">
							<div>
							<li class="attach_li">
								<a href="${pageContext.request.contextPath}/VIEWER/file/${list.SEQ_FILE}">
									<p>${list.ORG_FILE_NM} <b>다운로드</b> <a href="#" onclick="javascript:del_file(this,'file_id')"> <strong>삭제</strong></a></p>
									<input type="hidden" name="fileMetaData" value="${list.FILE_NM}|${list.FILE_SIZE}|${list.ORG_FILE_NM}|0" />
								</a>
							</li>
							</div>
						</c:forEach>
					</div>
				</span>
			</td>
		</tr>
		<tr>
			<th class="th_first"><span>내용</span></th>
			<td colspan="3">
				<textarea id="description" name="description" cols="100" rows="20" style="width:90%;">${map.get('DESCRIPTION')}</textarea>
			</td>
		</tr>
		</thead>
		<tbody>
		<tr class="last">
			<td colspan="4" />
		</tr>
		</tbody>
	</table>
</div>

<!-- 공공누리 -->
<%-- <jsp:include page="/jsp/common/kogl.jsp" /> --%>


<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegNotice('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegNotice('U')">수정</a></li>
		</c:if>
	</ul>
</div>

	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}" />
	<input type="hidden" name="seq" id="seq" value="${seq}" />
	<input type="hidden" name="UUID" id="UUID" value="${UUID}" />
	<input type="hidden" name="IU" id="IU" value="${IU}" />
	<input type="hidden" name="fileMetaDataAll" id="fileMetaDataAll" />

</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
//목록으로
function GoList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_BOS_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function getRadioValue( radioField ) { 
    for (var i =0; i<radioField.length; i++) { 
        if( radioField[i].checked == true ) { 
            return radioField[i].value; 
        } 
    } 
}

//등록 및 수정
function RegNotice(IU){
	
	//value 체크
	if($('#title').val() == ""){
		alert('타이틀을 입력하세요.');
		return;
	}
	
	var recode_st = getRadioValue(document.frmPage.recode_st);

  
  var desc = "";
	for(var i = 0; i<$('#ul_file li').length; i++){
		desc += $('#ul_file li:eq('+i+') input').val() + ",";
	}
	desc = desc.substring(0, desc.length -1);
  
	var data = {
			UUID : $("#UUID").val(),
			seq : $("#seq").val(),
			title : $("#title").val(),
			recode_st : recode_st,
			ncprm_description : $("#description").val(),
			fileMetaDataAll : desc,
			//게시판 타입
			noti_typ : "BO",
			reg_id : $("#user_id").val(),
			IU:IU
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/NOTI_NEW_01/RegNotice2', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_BOS_00/default', null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//파일등록
function file_onchange(){
	if($("#attach_file").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/NOTI_NEW_01/registrationFile", {attach_file : $("#attach_file").val()}, file_success_function, true, file_error_function, 'attach_file', 'ppt, pptx, xsl, xlsx, doc, docx, pdf, hwp, jpg, png, mp3, mp4, zip, gif, avi', true);
	}
}
//파일등록 성공시
var file_success_function = function(xmlData) {
	$('#ul_file').append("<div><li class=\"attach_li\"><p>"+$(xmlData).find('smartq-xml > orgFileName').text()+"<a href=\"#\" onclick=\"javascript:del_file(this,'file_id')\"><strong> 삭제</strong></a></p><input type=\"hidden\" name=\"fileMetaData\" value=\""+$(xmlData).find('smartq-xml > savedFileName').text() + "|" + $(xmlData).find('smartq-xml > savedFileSize').text() + "|" + $(xmlData).find('smartq-xml > orgFileName').text()+"|"+"1\" /></li></div>");
};
//파일등록 실패시
var file_error_function = function(xmlData) {
	alert($(xmlData).find('smartq-xml > result-msg').text());
	var file = $("input[name='attach_file']");
	file.wrap('<b />');
	file.parents("b").html(file.parents("b").html());
};

//파일 삭제
function del_file(obj, id){
	$(obj).parents('li').remove();
}

</script>
