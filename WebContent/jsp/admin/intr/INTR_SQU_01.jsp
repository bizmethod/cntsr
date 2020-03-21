<%--
  - Author      : 김현우
  - Date        : 2014-07-01
  - Description : GKL소개 > 사업분야 > 스포츠 선수단 > 상세
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" method="post" encType="multipart/form-data">
	<input type="hidden" name="TMENUID" value="${TMENUID}"/>
	<input type="hidden" name="SMENUID" value="${SMENUID}"/>
	<input type="hidden" name="UUID" id="UUID" value="${UUID}"/>
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="pic_name" id="pic_name"/>
	<input type="hidden" name="pic_org_nm" id="pic_org_nm"/>
	<input type="hidden" name="file_size" id="file_size"/>
	<input type="hidden" name="change_yn" id="change_yn" value="N"/>

<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">직책</th>
		<td>
			<span>
				<input type="text" class="input_text" id="position" name="position" style="width:300px;" value="${map.POSITION}" onkeyup="textByteCheck('position','position_byte',30)"/>
				<em class="byte">(<b id="position_byte">0</b>/<em id="position_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">이름</th>
		<td>
			<span>
				<input type="text" class="input_text" id="player_nm" name="player_nm" style="width:300px;" value="${map.NAME}" onkeyup="textByteCheck('player_nm','player_nm_byte',100)"/>
				<em class="byte">(<b id="player_nm_byte">0</b>/<em id="player_nm_byte_cnt">100</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">사진</th>
		<td>
			<span>
				<p id="pic" style="width: 95px; height: 113px; border: 1px solid; float: left;">
				<c:if test="${IU != 'I'}">
					<img src="${pageContext.request.contextPath}/VIEWER/player_img/${map.SEQ_PLAYER}" alt="" onerror=""  />
				</c:if>
				</p>
				<div class="file_btn_area" style="padding-left: 10px;">
					<input type="button" class="btn_search_file" id="btn_img" value="파일찾기" style="float: right; margin-left: 10px;"/>
					<input type="file" id="player_img" name="player_img" class="btn_file_hidden" />
				</div>
				<label style="margin-left: 10px;">JPG, PNG, GIF 95px*113px</label>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">주요경력</th>
		<td>
			<span>
				<textarea id="career" name="career" cols="90" rows="5"  onkeyup="textByteCheck('career','career_byte',500)"><c:out value="${map.CAREER}" /></textarea>
			</span>
			<span>
				<em>* 500자 이내로 입력하세요</em>
				<em class="byte">(<b id="career_byte">0</b>/<em id="career_byte_cnt">500</em> byte)</em>
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
			<li><a href="#" onclick="RegSquad()">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="UpdSquad()">수정</a></li>
			<li><a href="#" onclick="DelSquad()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

//이전페이지
function goList(){
	var url = "${pageContext.request.contextPath}/admin/INTR_SQU_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//파일찾기
$('#player_img').change(function() {
	$("#change_yn").val("Y");
	if($("#player_img").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/INTR_SQU_01/RegPlayerImage", null, img_success_function, true, null, 'player_img', 'png, jpg, gif');
	}
});
//파일등록 성공시
var img_success_function = function(xmlData) {
	$('#pic').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" />");
	$('#pic_name').val($(xmlData).find('smartq-xml > file_nm').text());
	$('#pic_org_nm').val($(xmlData).find('smartq-xml > org_nm').text());
	$('#file_size').val($(xmlData).find('smartq-xml > file_size').text());
};

//바이트 체크
function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

//선수단 등록
function RegSquad(){
	if($('#position').val() == ""){
		alert('직책을 입력해주세요.');
		return;
	}else if($('#player_nm').val() == ""){
		alert("이름을 입력해주세요.");
		return;
	}else if('${IU}' == "I" && $("#pic_name").val() == ""){
		alert("사진을 등록해주세요.");
		return;
	}else if($('#career').val() == ""){
		alert("경력을 입력해주세요.");
		return;
	}
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SQU_01/RegSquad', $("#frmPage").serialize(), success_function);
}

//선수단 수정
function UpdSquad(){
	if($('#position').val() == ""){
		alert('직책을 입력해주세요.');
		return;
	}else if($('#player_nm').val() == ""){
		alert("이름을 입력해주세요.");
		return;
	}else if($('#career').val() == ""){
		alert("경력을 입력해주세요.");
		return;
	}
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SQU_01/UpdSquad', $("#frmPage").serialize(), success_function);
}

//선수단 삭제
function DelSquad(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_SQU_01/DelSquad', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/INTR_SQU_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};


</script>