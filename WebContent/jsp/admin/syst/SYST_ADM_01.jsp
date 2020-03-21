<%--
  - Author      : 김현우
  - Date        : 2014-06-26
  - Description : 시스템관리 > 관리자관리 > 상세
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
	<input type="hidden" name="IU" id="IU" value="${IU}"/>
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
		<th class="th_first">이름</th>
		<td>
			<span>
				<input type="text" class="input_text" id="admin_nm" name="admin_nm" style="width:300px;" value="${map.NAME}" onkeyup="textByteCheck('admin_nm','admin_nm_byte',30)"/>
				<em class="byte">(<b id="admin_nm_byte">0</b>/<em id="admin_nm_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">아이디</th>
		<td>
			<span>
				<input type="text" class="input_text" id="admin_id" name="admin_id" style="width:300px;" value="${map.ADMIN_ID}" onkeyup="textByteCheck('admin_id','admin_id_byte',30)"/>
				<em class="byte">(<b id="admin_id_byte">0</b>/<em id="admin_id_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">비밀번호</th>
		<td>
			<span>
				<input type="text" class="input_text" id="password" name="password" style="width:300px;" value="${map.PASSWD}" onkeyup="textByteCheck('password','password_byte',30)"/>
				<em class="byte">(<b id="password_byte">0</b>/<em id="password_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">이메일</th>
		<td>
			<span>
				<input type="text" class="input_text" id="email" name="email" style="width:300px;" value="${map.EMAIL}" onkeyup="textByteCheck('email','email_byte',30)"/>
				<em class="byte">(<b id="email_byte">0</b>/<em id="email_byte_cnt">30</em> byte)</em>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">지점</th>
		<td>
			<span>
				<c:forEach var="list" items="${bList}" varStatus="status">
					<li style="float: left; width: 80px;"><input type="radio" name="ghlc" id="ghlc${status.count}" value="${list.CODE}" <c:if test="${IU == 'I' && status.count == '1'}">checked="checked"</c:if><c:if test="${list.CODE == map.GHLC_TYP}">checked="checked"</c:if>><label for="ghlc${status.count}">${list.CODE_NM}</label></li>
				</c:forEach>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">부서</th>
		<td>
			<span>
			<select name="sel_dept" id="sel_dept" class="sel_basic">
				<c:forEach var="list" items="${dList}">
				 <option value="${list.CODE}" <c:if test="${list.CODE == map.DEPT_TYP}" >selected="selected"</c:if>>${list.CODE_NM}</option>
				</c:forEach>
			</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">메뉴권한</th>
		<td>
			<span>
				<c:forEach var="list" items="${auth}" varStatus="status">
					<li style="float: left;width: 80px;"><input type="checkbox" name="auth" id="auth${status.count}" value="${list.MENU_ID}" <c:if test="${list.MENU_AUTH == 'Y'}">checked="checked"</c:if>><label for="auth${status.count}">${list.MENU_NM}</label></li>
				</c:forEach>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">사용여부</th>
		<td>
			<span>
				<select name="sel_recode" id="sel_recode" class="sel_basic">
					 <option value="A" <c:if test="${map.RECODE_ST =='A'}" >selected="selected"</c:if>>사용</option>
				<option value="I" <c:if test="${map.RECODE_ST =='I'}" >selected="selected"</c:if>>미사용</option>
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
			<li><a href="#" onclick="RegAdmin()">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegAdmin()">수정</a></li>
		</c:if>
	</ul>
</div>
<input type="hidden" name="array" id="array" />
</form>
<jsp:include page="/jsp/common/incBottom.jsp" /> 
<script>

function goList(){
	var url = "${pageContext.request.contextPath}/admin/SYST_ADM_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function textByteCheck(id, byte_id, limit){
	CheckByte(id,byte_id,limit);
}

function RegAdmin(){
	
	if (!confirm('저장하시겠습니까?')) {
		return;
	}
	
	if($('#admin_nm').val() == ""){
		alert('이름을 입력해주세요.');
		return;
	}else if($('#admin_id').val() == ""){
		alert("아이디를 입력해주세요.");
		return;
	}else if($('#password').val() == ""){
		alert("비밀번호를 입력해주세요.");
		return;
	}else if($('#email').val() == ""){
		alert("이메일을 입력해주세요.");
		return;
	}
	
	var ghlc_typ;
	var radio = $("input[name='ghlc']");
	for(var i = 0; i < radio.length; i++){
		if(radio[i].checked == true){
			ghlc_typ = radio[i].value;
		}
	}
	
	var array = "";
	$('input:checkbox[name=auth]').each(function (i) {
		if(array.indexOf(this.value) < 0){
			array += this.value + "," + this.checked + ".";
		}
	});
	
	$('#array').val(array.substring(0, array.length-1));
	
	var data = {
			reg_id : $("#user_id").val(),
			admin_id : $("#admin_id").val(),
			admin_nm : $("#admin_nm").val(),
			password : $("#password").val(),
			email : $("#email").val(),
			ghlc_typ : ghlc_typ,
			sel_dept : $("#sel_dept").val(),
			sel_recode : $("#sel_recode").val(),
			array : $("#array").val(),
			IU : $("#IU").val()
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_ADM_01/RegAdmin', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/SYST_ADM_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>