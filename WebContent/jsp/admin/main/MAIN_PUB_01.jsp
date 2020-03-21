<%--
  - Author      : 김현우
  - Date        : 2014-06-26
  - Description : 메인관리 > 홍보배너 > 상세
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
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>
	<input type="hidden" name="img_id" id="img_id" value="${IMG_ID}"/>
	<input type="hidden" name="banner_name" id="banner_name"/>
	<input type="hidden" name="banner_org_nm" id="banner_org_nm"/>
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
		<th class="th_first">배너명</th>
		<td>
			<span>
				<input type="text" class="input_text" id="title" name="title" style="width:300px;" value="${map.TITLE}" onkeyup="textByteCheck('title','title_byte',30)"/>
				<em class="byte">(<b id="title_byte">0</b>/<em id="title_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">URL</th>
		<td>
			<span>
				<input type="text" class="input_text" id="url" name="url" style="width:300px;" value="${map.URL}" onkeyup="textByteCheck('url','url_byte',150)"/>
				<em class="byte">(<b id="url_byte">0</b>/<em id="url_byte_cnt">150</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">이미지</th>
		<td>
			<span>
				<p id="main_banner" style="width: 150px; height: 100px; border: 1px solid; float: left;">
				<c:if test="${img_id != 'I'}">
					<img src="${pageContext.request.contextPath}/VIEWER/main_img/${map.ID_MAIN_IMAGE}/KR" alt="" width="150" height="100" onerror=""  />
				</c:if>
				</p>
				<div class="file_btn_area" style="padding-left: 10px;">
					<input type="button" class="btn_search_file" id="main_img" value="파일찾기" style="float: right; margin-left: 10px;"/>
					<input type="file" id="banner_img" name="banner_img" class="btn_file_hidden" />
				</div>
				<label style="margin-left: 10px;">PNG,JPG 242px*173px</label>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">설명</th>
		<td>
			<span>
				<textarea id="description" name="description" cols="90" rows="5"  onkeyup="textByteCheck('description','description_byte',2000)"><c:out value="${map.DESCRIPTION}" /></textarea>
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
				<textarea id="alt" name="alt" cols="90" rows="5" onkeyup="textByteCheck('alt','alt_byte',500)"><c:out value="${map.ALT}" /></textarea>
			</span>
			<span>
				<em>* 500자 이내로 입력하세요</em>
				<em class="byte">(<b id="alt_byte">0</b>/<em id="alt_byte_cnt">500</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">전시여부</th>
		<td>
			<span>
				<input type="radio" name="recode_st" value="A" id="r1" <c:if test="${map.get('RECODE_ST') == 'A' || img_id == 'I'}">checked="checked"</c:if>> <label for="r1"> 전시</label></input>
				<input type="radio" name="recode_st" value="I" id="r2" <c:if test="${map.get('RECODE_ST') == 'I'}">checked="checked"</c:if>> <label for="r2" > 미전시</label></input>
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
		<c:if test="${IMG_ID == 'I'}">
			<li><a href="#" onclick="RegMainBanner()">등록</a></li>
		</c:if>
		<c:if test="${IMG_ID != 'I'}">
			<li><a href="#" onclick="RegMainBanner()">수정</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>
<script>

function goList(){
	var url = "${pageContext.request.contextPath}/admin/MAIN_BAN_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

$('#banner_img').change(function() {
	$("#change_yn").val("Y");
	if($("#banner_img").val() != ""){
		GetAjaxXmlMultiPart("frmPage", "${pageContext.request.contextPath}/admin/MAIN_PUB_01/registrationBanner", null, banner_success_function, true, null, 'banner_img', 'png,jpg,gif,PNG,JPG,GIF');
	}
});
//파일등록 성공시
var banner_success_function = function(xmlData) {
	$('#main_banner').html("<img src=\"" + $(xmlData).find('smartq-xml > image').text() + "\" alt=\"\" height=\"100\" width=\"150\"/>");
	$('#banner_name').val($(xmlData).find('smartq-xml > file_nm').text());
	$('#banner_org_nm').val($(xmlData).find('smartq-xml > org_nm').text());
};

function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

function RegMainBanner(){
	var recode_st;
	var radio = $("input[name='recode_st']");
	for(var i = 0; i < radio.length; i++){
		if(radio[i].checked == true){
			recode_st = radio[i].value;
		}
	}
	
	var data = {
			UUID : $("#UUID").val(),
			user_id : $("#user_id").val(),
			img_id : $("#img_id").val(),
			title : $("#title").val(),
			banner_name : $("#banner_name").val(),
			banner_org_nm : $("#banner_org_nm").val(),
			change_yn : $("#change_yn").val(),
			recode_st : recode_st,
			description : $("#description").val(),
			alt : $("#alt").val(),
			url : $("#url").val(),
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/MAIN_PUB_01/RegMainBanner', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/MAIN_PUB_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>