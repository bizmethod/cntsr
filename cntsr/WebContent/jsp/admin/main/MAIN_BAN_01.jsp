<%--
  - Author      : 김현우
  - Date        : 2014-06-26
  - Description : 메인관리 > 메인배너 > 상세
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
	<input type="hidden" name="img_id" id="img_id" value="${img_id}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	
	<input type="hidden" name="lang_typ" id="lang_typ"/>

<div class="wrap_table" >
	<div id="tabs">
	  <ul>
		  <c:forEach var="list" items="${div_lang}">
		    <li><a href="#tabs-${list.CODE}">${list.CODE_NM}</a></li>
		  </c:forEach>
	  </ul>
	  <c:forEach var="list" items="${div_lang}">
		  <div id="tabs-${list.CODE}">
		    <table class="table_detail">
				<caption></caption>
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tbody>
				<tr>
					<th class="th_first">언어사용</th>
					<td>
						<span>
							<input type="radio" name="lang_use_${list.CODE}" id="lang_use_${list.CODE}Y" value="Y" <c:if test="${list.LANG_USE_YN == 'Y'}">checked="checked"</c:if>/><label for="lang_use_${list.CODE}Y">사용</label>    
							<input type="radio" name="lang_use_${list.CODE}" id="lang_use_${list.CODE}N" value="N" <c:if test="${list.LANG_USE_YN == 'N' || list.LANG_USE_YN == null || img_id == 'I'}">checked="checked"</c:if>/><label for="lang_use_${list.CODE}N">미사용</label>
						</span>
					</td>
				</tr>
				<tr>
					<th class="th_first">배너명</th>
					<td>
						<span>
							<input type="text" class="input_text" id="title_${list.CODE}" name="title_${list.CODE}" style="width:300px;" value="${list.TITLE}" onkeyup="textByteCheck('title_${list.CODE}','title_byte_${list.CODE}',30)"/>
							<em class="byte">(<b id="title_byte_${list.CODE}">0</b>/<em id="title_byte_cnt_${list.CODE}">30</em> byte)</em>
						</span>
					</td>
				</tr>
				<tr>
					<th class="th_first">URL</th>
					<td>
						<span>
							<input type="text" class="input_text" id="url_${list.CODE}" name="url_${list.CODE}" style="width:300px;" value="${list.URL}" onkeyup="textByteCheck('url_${list.CODE}','url_byte_${list.CODE}',150)"/>
							<em class="byte">(<b id="url_byte_${list.CODE}">0</b>/<em id="url_byte_cnt_${list.CODE}">150</em> byte)</em>
							<c:if test="${list.CODE == 'KR'}">
							<p style="padding-top:10px;"><input type="checkbox" id="url_check" name="url_check" /><label for="url_check">모든 언어 공통사용</label></p>
							</c:if>
						</span>
					</td>
				</tr>
				<tr>
					<th class="th_first">이미지</th>
					<td>
						<span>
							<p id="main_banner_${list.CODE}" style="width: 300px; height: 100px; border: 1px solid; float: left;">
							<c:if test="${list.LANG_USE_YN == 'Y'}">
								<img src="${pageContext.request.contextPath}/VIEWER/main_img/${list.ID_MAIN_IMAGE}/${list.LANG_TYP}" alt="" width="300" height="100" onerror=""  />
							</c:if>
							</p>
							<div class="file_btn_area" style="padding-left: 10px;">
								<input type="button" class="btn_search_file" id="main_img_${list.CODE}" value="파일찾기" style="float: right; margin-left: 10px;"/>
								<input type="file" id="banner_img_${list.CODE}" name="banner_img_${list.CODE}" class="btn_file_hidden" />
							</div>
							<label style="margin-left: 10px;">PNG,JPG 1300px*417px</label>
						</span>
						<c:if test="${list.CODE == 'KR'}">
						<span>
							<p style="padding-top:10px;"><input type="checkbox" id="main_img_check" name="main_img_check" /><label for="main_img_check">모든 언어 공통사용</label></p>
						</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th class="th_first">설명</th>
					<td>
						<span>
							<textarea id="description_${list.CODE}" name="description_${list.CODE}" cols="75" rows="5"  onkeyup="textByteCheck('description_${list.CODE}','description_byte_${list.CODE}',1000)"><c:out value="${list.DESCRIPTION}" /></textarea>
						</span>
						<span>
							<em>* 1000자 이내로 입력하세요</em>
							<em class="byte">(<b id="description_byte_${list.CODE}">0</b>/<em id="description_byte_cnt_${list.CODE}">1000</em> byte)</em>
						</span>
					</td>
				</tr>
				<tr>
					<th class="th_first">ALT</th>
					<td>
						<span>
							<textarea id="alt_${list.CODE}" name="alt_${list.CODE}" cols="75" rows="5" onkeyup="textByteCheck('alt_${list.CODE}','alt_byte_${list.CODE}',500)"><c:out value="${list.ALT}" /></textarea>
						</span>
						<span>
							<em>* 1000자 이내로 입력하세요</em>
							<em class="byte">(<b id="alt_byte_${list.CODE}">0</b>/<em id="alt_byte_cnt_${list.CODE}">5000</em> byte)</em>
						</span>
					</td>
				</tr>
				<tr class="last">
					<td colspan="2" />
				</tr>
			</table>
		  </div>
		  
		  <input type="hidden" name="banner_name_${list.CODE}" id="banner_name_${list.CODE}" value="${list.FILE_NM}"/>
		  <input type="hidden" name="change_yn_${list.CODE}" id="change_yn_${list.CODE}" value="N"/>
	
	  </c:forEach>
	</div>
</div>
<div style="height:10px;"></div>
<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:22%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first last">전시여부</th>
		<td>
			<span>
				<input type="radio" name="recode_st" id="r1" value="A" <c:if test="${recode_st == 'A'}">checked="checked"</c:if>><label for="r1">전시</label>
				<input type="radio" name="recode_st" id="r2" value="I" <c:if test="${recode_st != 'A' || img_id == 'I'}">checked="checked"</c:if>><label for="r2">미전시</label>
			</span>
		</td>
	</tr>
	<tr class="last">
		<td colspan="2" />
	</tr>
	</tbody>
</table>

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="goList()">취소</a></li>
		<c:if test="${img_id == 'I'}">
			<li><a href="javascript:RegMainBanner()">등록</a></li>
		</c:if>
		<c:if test="${img_id != 'I'}">
			<li><a href="javascript:RegMainBanner()">수정</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>
<script>

//****등록전
//각언어 배너명 커서 이동시 언어사용 사용으로 변경
$( "#title_KR" ).focus(function() {
  $('#lang_use_KRY').attr("checked", "true");
});
$( "#title_EN" ).focus(function() {
  $('#lang_use_ENY').attr("checked", "true");
});
$( "#title_CN" ).focus(function() {
  $('#lang_use_CNY').attr("checked", "true");
});
$( "#title_JP" ).focus(function() {
  $('#lang_use_JPY').attr("checked", "true");
});
//URL, 이미지 공통 사용시 표기하고 언어사용을 사용으로 변경
//URL체크
$("#url_check").bind("click",function(){

	if(this.checked){
		//url입력
		$('#url_EN').val($('#url_KR').val());
		$('#url_CN').val($('#url_KR').val());
		$('#url_JP').val($('#url_KR').val());
		
		//사용 표기
		$('#lang_use_KRY').attr("checked", "true");
		$('#lang_use_ENY').attr("checked", "true");
		$('#lang_use_CNY').attr("checked", "true");
		$('#lang_use_JPY').attr("checked", "true");
	}
	
});
//이미지체크
$("#main_img_check").bind("click",function(){
	if((this.checked) && ($('#main_banner_KR').html() == "")){
		alert("이미지를 등록하세요.");
		return;
	}
	if(this.checked){
		//이미지 정보 입력
		$('#main_banner_EN').html($('#main_banner_KR').html());
		$('#banner_name_EN').val($('#banner_name_KR').val());
		
		$('#main_banner_CN').html($('#main_banner_KR').html());
		$('#banner_name_CN').val($('#banner_name_KR').val());
		
		$('#main_banner_JP').html($('#main_banner_KR').html());
		$('#banner_name_JP').val($('#banner_name_KR').val());
		
		//사용 표기
		$('#lang_use_KRY').attr("checked", "true");
		$('#lang_use_ENY').attr("checked", "true");
		$('#lang_use_CNY').attr("checked", "true");
		$('#lang_use_JPY').attr("checked", "true");
	}
});

//****등록시 언어사용 사용으로 된 언어는 url을 제외하고 모든 것이 필수 값
function checkRegValues(){
	
	if(!($('#lang_use_KRY').is( ":checked" )) && !($('#lang_use_ENY').is( ":checked" )) && !($('#lang_use_CNY').is( ":checked" )) && !($('#lang_use_JPY').is( ":checked" ))){
		return false;
	}
	
	var lang_array = ["KR","EN","CN","JP"];
	
	for(var i = 0; i<lang_array.length; i++){
		if($('#lang_use_'+lang_array[i]+'Y').is( ":checked" )){
			if($('#title_'+lang_array[i]).val() == ""){
				if(lang_array[i] == "KR")
					alert("한국어 배너명을 입력하세요.");
				if(lang_array[i] == "EN")
					alert("영어 배너명을 입력하세요.");
				if(lang_array[i] == "CN")
					alert("중국어 배너명을 입력하세요.");
				if(lang_array[i] == "JP")
					alert("일본어 배너명을 입력하세요.");
				return false;
			}
			if(($('#main_banner_'+lang_array[i]).html() == "")){
				if(lang_array[i] == "KR")
					alert("한국어 이미지를 입력하세요.");
				if(lang_array[i] == "EM")
					alert("영어 이미지를 입력하세요.");
				if(lang_array[i] == "CN")
					alert("중국어 이미지를 입력하세요.");
				if(lang_array[i] == "JP")
					alert("일본어 이미지를 입력하세요.");
				return false;
			}
			if($('#description_'+lang_array[i]).val() == ""){
				if(lang_array[i] == "KR")
					alert("한국어 설명을 입력하세요.");
				if(lang_array[i] == "EN")
					alert("영어 설명을 입력하세요.");
				if(lang_array[i] == "CN")
					alert("중국어 설명을 입력하세요.");
				if(lang_array[i] == "JP")
					alert("일본어 설명을 입력하세요.");
				return false;
			}
			if($('#alt_'+lang_array[i]).val() == ""){
				if(lang_array[i] == "KL")
					alert("한국어 ALT를 입력하세요.");
				if(lang_array[i] == "EN")
					alert("영어 ALT를 입력하세요.");
				if(lang_array[i] == "CN")
					alert("중국어 ALT를 입력하세요.");
				if(lang_array[i] == "JP")
					alert("일본어 ALT를 입력하세요.");
				return false;
			}
		}
	}
	return true;
}

//취소 버튼
function goList(){
	var url = "${pageContext.request.contextPath}/admin/MAIN_BAN_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//각각의 파일 등록
$('#banner_img_KR').change(function() {
	$('#lang_typ').val("KR");
	$("#change_yn_KR").val("Y");
	if($("#banner_img_KR").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/MAIN_BAN_01/registrationBanner", null, banner_success_function, false, null, 'banner_img_KR', 'png,jpg,gif,PNG,JPG,GIF');
	}
});
$('#banner_img_EN').change(function() {
	$('#lang_typ').val("EN");
	$("#change_yn_EN").val("Y");
	if($("#banner_img_EN").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/MAIN_BAN_01/registrationBanner", null, banner_success_function, false, null, 'banner_img_EN', 'png,jpg,gif,PNG,JPG,GIF');
	}
});
$('#banner_img_CN').change(function() {
	$('#lang_typ').val("CN");
	$("#change_yn_CN").val("Y");
	if($("#banner_img_CN").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/MAIN_BAN_01/registrationBanner", null, banner_success_function, false, null, 'banner_img_CN', 'png,jpg,gif,PNG,JPG,GIF');
	}
});
$('#banner_img_JP').change(function() {
	$('#lang_typ').val("JP");
	$("#change_yn_JP").val("Y");
	if($("#banner_img_JP").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/MAIN_BAN_01/registrationBanner", null, banner_success_function, false, null, 'banner_img_JP', 'png,jpg,gif,PNG,JPG,GIF');
	}
});

//파일등록 성공시
var banner_success_function = function(xmlData) {
	if($("#tabs").tabs( "option", "active" ) == 0){
		$('#main_banner_KR').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"100\" width=\"300\"/>");
		$('#banner_name_KR').val($(xmlData).find('smartq-xml > file_nm').text());
	}else if($("#tabs").tabs( "option", "active" ) == 1){
		$('#main_banner_EN').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"100\" width=\"300\"/>");
		$('#banner_name_EN').val($(xmlData).find('smartq-xml > file_nm').text());
	}else if($("#tabs").tabs( "option", "active" ) == 2){
		$('#main_banner_CN').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"100\" width=\"300\"/>");
		$('#banner_name_CN').val($(xmlData).find('smartq-xml > file_nm').text());
	}else if($("#tabs").tabs( "option", "active" ) == 3){
		$('#main_banner_JP').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"100\" width=\"300\"/>");
		$('#banner_name_JP').val($(xmlData).find('smartq-xml > file_nm').text());
	}	
};

function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

//등록
function RegMainBanner(){
	//체크
	if(!checkRegValues()){
		return;
	}
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/MAIN_BAN_01/RegMainBanner', $("#frmPage").serialize(), success_function);
}

success_function = function(xmlData){
	var result = "";
	if(($(xmlData).find('smartq-xml > lang_KR') != null && ($(xmlData).find('smartq-xml > lang_KR').text() == "1"))){
		result += "한국어 등록 성공\n";
	}
	if(($(xmlData).find('smartq-xml > lang_EN') != null && ($(xmlData).find('smartq-xml > lang_EN').text() == "1"))){
		result += "영어 등록 성공\n";
	}
	if(($(xmlData).find('smartq-xml > lang_CN') != null && ($(xmlData).find('smartq-xml > lang_CN').text() == "1"))){
		result += "중국어 등록 성공\n";
	}
	if(($(xmlData).find('smartq-xml > lang_JP') != null && ($(xmlData).find('smartq-xml > lang_JP').text() == "1"))){
		result += "일본어 등록 성공\n";
	}
	
	if(result != "")
		alert(result);
	else
		alert("등록된 내용이 없습니다.");
	
	var url = "${pageContext.request.contextPath}/admin/MAIN_BAN_01/default";
	GoPage(url, {img_id:($(xmlData).find('smartq-xml > img_id').text())}, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//탭
$(function() {
	$( "#tabs" ).tabs();
});

</script>