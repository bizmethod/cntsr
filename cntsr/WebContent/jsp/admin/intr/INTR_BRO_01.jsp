<%--
  - Author      : 김현우
  - Date        : 2014-07-01
  - Description : GKL소개 > PR > 브로셔 > 상세
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
	<input type="hidden" name="UUID" id="UUID" value="${UUID}"/>
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="thumb_name" id="thumb_name"/>
	<input type="hidden" name="thumb_org_nm" id="thumb_org_nm"/>
	<input type="hidden" name="thumb_change_yn" id="thumb_change_yn" value="N"/>
	<input type="hidden" name="pic_name" id="pic_name"/>
	<input type="hidden" name="pic_org_nm" id="pic_org_nm"/>
	<input type="hidden" name="pic_change_yn" id="pic_change_yn" value="N"/>

<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">이미지명</th>
		<td>
			<span>
				<input type="text" class="input_text" id="title" name="title" style="width:100%;" value="${map.TITLE}" onkeyup="textByteCheck('title','title_byte',30)"/>
				<em class="byte">(<b id="title_byte">0</b>/<em id="title_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">섬네일 이미지</th>
		<td>
			<span>
				<p id="thumb" style="width: 136px; height: 176px; border: 1px solid; float: left;">
				<c:if test="${IU != 'I'}">
					<img src="${pageContext.request.contextPath}/VIEWER/bro_thumb/${map.SEQ_BROCHURE}" alt="" width="136" height="176" onerror=""  />
				</c:if>
				</p>
				<div class="file_btn_area" style="padding-left: 10px;">
					<input type="button" class="btn_search_file" id="btn_thumb" value="파일찾기" style="float: right; margin-left: 10px;"/>
					<input type="file" id="thumb_img" name="thumb_img" class="btn_file_hidden" />
				</div>
				<label style="margin-left: 10px;">JPG, PNG, 136px*176px</label>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">원본 이미지</th>
		<td>
			<span>
				<p id="pic" style="width: 200px; height: 200px; border: 1px solid; float: left;">
				<c:if test="${IU != 'I'}">
					<img src="${pageContext.request.contextPath}/VIEWER/bro_img/${map.SEQ_BROCHURE}" alt="" width="200" height="200" onerror=""  />
				</c:if>
				</p>
				<div class="file_btn_area" style="padding-left: 10px;">
					<input type="button" class="btn_search_file" id="btn_img" value="파일찾기" style="float: right; margin-left: 10px;"/>
					<input type="file" id="pic_img" name="pic_img" class="btn_file_hidden" />
				</div>
				<label style="margin-left: 10px;">JPG, PNG</label>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">기간</th>
		<td>
			<span>
				<input type="text" class="input_text" id="term" name="term" style="width:100%;" value="${map.TERM}" onkeyup="textByteCheck('term','term_byte',20)"/>
				<em class="byte">(<b id="term_byte">0</b>/<em id="term_byte_cnt">20</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">설명</th>
		<td>
			<span>
				<textarea id="description" name="description" cols="90" rows="5"  onkeyup="textByteCheck('description','description_byte',1000)"><c:out value="${map.DESCRIPTION}" /></textarea>
			</span>
			<span>
				<em>* 1000자 이내로 입력하세요</em>
				<em class="byte">(<b id="description_byte">0</b>/<em id="description_byte_cnt">1000</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">ALT</th>
		<td>
			<span>
				<textarea id="alt" name="alt" cols="90" rows="5"  onkeyup="textByteCheck('alt','alt_byte',1000)"><c:out value="${map.ALT}" /></textarea>
			</span>
			<span>
				<em>* 1000자 이내로 입력하세요</em>
				<em class="byte">(<b id="alt_byte">0</b>/<em id="alt_byte_cnt">1000</em> byte)</em>
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
		<li><a href="#" onclick="goList()">취소</a></li>
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegBrochure()">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="UpdBrochure()">수정</a></li>
			<li><a href="#" onclick="DelBrochure()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

//이전페이지
function goList(){
	var url = "${pageContext.request.contextPath}/admin/INTR_BRO_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//섬네일 이미지 등록
$('#thumb_img').change(function() {
	$("#thumb_change_yn").val("Y");
	if($("#thumb_img").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/INTR_BRO_01/RegThumbImage", null, thumb_success_function, true, null, 'thumb_img', 'png, jpg');
	}
});
//섬네일 등록 성공시
var thumb_success_function = function(xmlData) {
	$('#thumb').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"176\" width=\"136\"/>");
	$('#thumb_name').val($(xmlData).find('smartq-xml > file_nm').text());
	$('#thumb_org_nm').val($(xmlData).find('smartq-xml > org_nm').text());
};

//원본 이미지 등록
$('#pic_img').change(function() {
	$("#pic_change_yn").val("Y");
	if($("#pic_img").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/INTR_BRO_01/RegImage", null, pic_success_function, true, null, 'pic_img', 'png, jpg');
	}
});
//이미지 등록 성공시
var pic_success_function = function(xmlData) {
	$('#pic').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"200\" width=\"200\"/>");
	$('#pic_name').val($(xmlData).find('smartq-xml > file_nm').text());
	$('#pic_org_nm').val($(xmlData).find('smartq-xml > org_nm').text());
};

//byte체크
function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

//브로셔 등록
function RegBrochure(){
	if($('#title').val() == ""){
		alert('이미지명을 입력해주세요.');
		return;
	}else if('${IU}' == "I" && $("#thumb_name").val() == ""){
		alert("섬네일을 등록해주세요.");
		return;
	}else if('${IU}' == "I" && $("#pic_name").val() == ""){
		alert("원본 이미지를 등록해주세요.");
		return;
	}else if($('#term').val() == ""){
		alert("기간을 입력해주세요.");
		return;
	}else if($('#description').val() == ""){
		alert("설명을 입력해주세요.");
		return;
	}else if($('#alt').val() == ""){
		alert("ALT를 입력해주세요.");
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_BRO_01/RegBrochure', $("#frmPage").serialize(), success_function);
}

//브로셔 수정
function UpdBrochure(){
	if($('#title').val() == ""){
		alert('이미지명을 입력해주세요.');
		return;
	}else if($('#term').val() == ""){
		alert("기간을 입력해주세요.");
		return;
	}else if($('#description').val() == ""){
		alert("설명을 입력해주세요.");
		return;
	}else if($('#alt').val() == ""){
		alert("ALT를 입력해주세요.");
		return;
	}
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_BRO_01/UpdBrochure', $("#frmPage").serialize(), success_function);
}

//브로셔 삭제
function DelBrochure(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_BRO_01/DelBrochure', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/INTR_BRO_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>