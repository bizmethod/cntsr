<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 정부3.0 > 사전정보공표목록 > 상세
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//네이버 스마트 에디터 사용
var oEditors = [];

function editorInit(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "description",
		sSkinURI: "${pageContext.request.contextPath}/common/js/smartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
// 				alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
}
</script>

<form name="frmPage" id="frmPage" method="post" enctype="multipart/form-data">
	<input type="hidden" name="TMENUID" value="${TMENUID}"/>
	<input type="hidden" name="SMENUID" value="${SMENUID}"/>
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
	<input type="hidden" name="parent_id"  id="parent_id" value="${parent_id}"/>
	<input type="hidden" name="inli_typ"  id="inli_typ" value="${inli_typ}"/>
	<input type="hidden" name="UUID" id="UUID" value="${UUID}" />
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="GKLURL" id="GKLURL" value="${GKLURL}" />
	<input type="hidden" name="fileMetaDataAll" id="fileMetaDataAll" />
	
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
		<th class="th_first"><span>제목</span></th>
		<td colspan='3'><span><input type="text" class="input_text" id="title" name="title" style="width: 80%;" value="${map.get('TITLE')}" maxlength="100"/></span></td>
	</tr>
	<tr>
		<th class="th_first"><span>전시여부</span></th>
		<td >
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
		<td colspan='3'>
			<textarea id="description" name="description" cols="100" rows="20" style="width:100%; display: none;">
			<c:out value="${map.get('DESCRIPTION')}" escapeXml="false"/>
			</textarea>
		</td>
	</tr>
	<tr class="last">
		<td colspan="4" />
	</tr>
</table>
</div>

<!-- 공공누리 -->
<jsp:include page="/jsp/common/kogl.jsp" />

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="GoList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegData('U')">수정</a></li>
			<li><a href="#" onclick="DelPreInfom()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

//textArea에 이미지 첨부
function pasteHTML(filepath){
	var sHTML = '<img src="${GKLURL}/file/img/pic/'+filepath+'" style="max-width: 700px; height: auto;">';
    oEditors.getById["description"].exec("PASTE_HTML", [sHTML]);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_02/default";
	GoPage(url, {parent_id:$("#parent_id").val()}, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function getRadioValue( radioField ) { 
    for (var i =0; i<radioField.length; i++) { 
        if( radioField[i].checked == true ) { 
            return radioField[i].value; 
        } 
    } 
}

function RegData(IU){

	if(!$("input[name='kogl_open']").is(":checked")){
		alert("공공저작물 자유이용 여부를 선택해주세요");
		return;
	}else if(!$("input[name='kogl_B']").is(":checked")){
		alert("공공저작물 상업적 이용표시 유형을 선택해주세요");
		return;
	}else if(!$("input[name='kogl_M']").is(":checked")){
		alert("공공저작물 변경허용 여부를 선택해주세요");
		return;
	}
	
	var recode_st = getRadioValue(document.frmPage.recode_st);
	var kogl_open = getRadioValue(document.frmPage.kogl_open); 
	var kogl_B = getRadioValue(document.frmPage.kogl_B); 
	var kogl_M = getRadioValue(document.frmPage.kogl_M); 
	var kogl_con = getRadioValue(document.frmPage.kogl_con); 

	//네이버 스마트 에디터의 알수없는 공백 제거
	var ct = oEditors.getById["description"].getIR();
	ct = escape(ct); 
	while(ct.indexOf("%u200B") > 0){ 
	  ct = ct.replace("%u200B", ""); 
	} 
  	ct = unescape(ct); 
  	
  	var desc = "";
	for(var i = 0; i<$('#ul_file li').length; i++){
		desc += $('#ul_file li:eq('+i+') input').val() + ",";
	}
	desc = desc.substring(0, desc.length -1);
	
	var data = {
			UUID : $("#UUID").val(),
			seq : $("#seq").val(),
			title : $("#title").val(),
			parent_id : $("#parent_id").val(),
			sel_typ : $("#inli_typ").val(),
			recode_st : recode_st,
			ncprm_description : ct,
			fileMetaDataAll : desc,
			//공공누리 관련
			kogl_open : kogl_open,
			kogl_B : kogl_B,
			kogl_M : kogl_M,
			kogl_con : kogl_con,
			reg_id : $("#user_id").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/GOVE_OFF_03/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/GOVE_OFF_02/default', {parent_id:$("#parent_id").val()} ,'${TMENUID}', '${SMENUID}', '${METYPE}');
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

$(document).ready(function (){
	editorInit();
});

</script>