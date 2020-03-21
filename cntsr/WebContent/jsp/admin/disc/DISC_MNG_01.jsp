<%--
  - Author      : 김현우
  - Date        : 2014-07-01
  - Description : 경영공시 > 경영현황 > 상세
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
	<input type="hidden" name="PID" value="${hm.PID}"/>
	<input type="hidden" name="seq"value="${seq}"/>
	<input type="hidden" name="user_id" id="user_id" value="${USER_ID}"/>

<div class="wrap_table" >
	<table class="table_detail">
	<caption></caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:80%">
	</colgroup>
	<tbody>
	<tr>
		<th class="th_first">소메뉴</th>
		<td>
			<span>
				<input type="text" class="input_text" id="url_nm" name="url_nm" style="width:100%;" value="${map.URL_NM}" onkeyup="textByteCheck('url_nm','url_nm_byte',30)"/>
				<em class="byte">(<b id="url_nm_byte">0</b>/<em id="url_nm_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">URL</th>
		<td>
			<span>
				<input type="text" class="input_text" id="url" name="url" style="width:100%;" value="${map.URL}" onkeyup="textByteCheck('url','url_byte',100)"/>
				<em class="byte">(<b id="url_byte">0</b>/<em id="url_byte_cnt">100</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">내부링크여부</th>
		<td>
			<span>
			<select name="sel_blank_yn" id="sel_blank_yn" class="sel_basic">
				 <option value="Y" <c:if test="${map.IN_URL_YN=='Y'}" >selected="selected"</c:if>>내부</option>
				 <option value="N" <c:if test="${map.IN_URL_YN=='N'}" >selected="selected"</c:if>>새창</option>
			</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">스케줄링</th>
		<td>
			<span>
			<select name="sel_sche" id="sel_sche" class="sel_basic">
				 <option value="Y" <c:if test="${map.CHECK_YN=='Y'}" >selected="selected"</c:if>>사용</option>
				 <option value="N" <c:if test="${map.CHECK_YN=='N'}" >selected="selected"</c:if>>미사용</option>
			</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">전시여부</th>
		<td>
			<span>
			<select name="sel_recode" id="sel_recode" class="sel_basic">
				 <option value="A" <c:if test="${map.RECODE_ST=='A'}" >selected="selected"</c:if>>전시</option>
				 <option value="I" <c:if test="${map.RECODE_ST=='I'}" >selected="selected"</c:if>>미전시</option>
			</select>
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
			<li><a href="#" onclick="RegAlioUrl()">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="UpdAlioUrl()">수정</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>
function goList(){
	var url = "${pageContext.request.contextPath}/admin/DISC_MNG_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

function RegAlioUrl(){
	if($('#url_nm').val() == ""){
		alert('소메뉴명을 입력해주세요.');
		return;
	}else if($('#url').val() == ""){
		alert("URL을 입력해주세요.");
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_MNG_01/RegAlioUrl', $("#frmPage").serialize(), success_function);
}

function UpdAlioUrl(){
	if($('#url_nm').val() == ""){
		alert('소메뉴명을 입력해주세요.');
		return;
	}else if($('#url').val() == ""){
		alert("URL을 입력해주세요.");
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_MNG_01/UpdAlioUrl', $("#frmPage").serialize(), success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_MNG_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>