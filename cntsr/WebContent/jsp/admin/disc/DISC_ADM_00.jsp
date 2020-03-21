<%--
  - Author      : 김현우
  - Date        : 2014-07-01
  - Description : 시스템관리 > 관리자 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<form name="frmPage" id="frmPage" method="get">
<input type="hidden" name="TMENUID" value="${TMENUID}"/>
<input type="hidden" name="SMENUID" value="${SMENUID}"/>
<input type="hidden" name="user_id"  id="user_id" value="${USER_ID}"/>
<input type="hidden" name="PAGENUM">

<div class="wrap_table" >
	<div class="top_area">
		<ul>
			<li></li>
			<li></li>
		</ul>
	</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:15%" />
			<col style="width:15%" />
			<col style="width:40%" />
			<col style="width:15%" />
			<col style="width:15%" />
		</colgroup>
		<thead>
		<tr>
			<th>관리자명</th>
			<th>아이디</th>
			<th>EMAIL</th>
			<th>최종전송시간</th>
			<th>삭제</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${admin_list.size() == 0}">
		<tr>
			<td colspan="6" align="center" >등록된 관리자가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${admin_list}">
		<tr>
			<td class="th_first"><c:out value="${list.NAME}" /></td>
			<td><c:out value="${list.ADMIN_ID}" /></td>
			<td><c:out value="${list.EMAIL}"/></td>
			<td><c:out value="${list.SEND_DT}" /></td>
			<td><a class="btn_s_wh" id="btn_del" onclick="DelAdmin('${list.ADMIN_ID}')" >삭제</a></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="5" />
		</tr>
		</tbody>
	</table>
</div>
<div style="margin-top: 20px; margin-bottom: 60px;">
	<div style="padding:10px; margin:10px;">
		<span><strong>직접등록</strong></span>
		<span style="margin-left: 60px;">관리자명</span><input type="text" class="input_text" id="admin_nm" name="admin_nm" style="width: 70px;" maxlength="50"/>
		<span>e-mail</span><input type="text" class="input_text" id="email" name="email" style="width: 220px;" maxlength="25"/>
		<a class="btn_s_wh" id="btn_direct_reg" onclick="RegAdmin1()">등록</a>
	</div>
	<hr style="display: block;" color="#233D73" size="2">
</div>

<div class="wrap_table">
<div class="top_area">
	<ul>
		<li class="ml10">
			<select name="sel_branch" id="sel_branch" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_branch ==''}" >selected="selected"</c:if>>지점</option>
			<c:forEach var="list" items="${bList}">
				<option value="${list.CODE}" <c:if test="${sel_branch == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_dept" id="sel_dept" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_dept ==''}" >selected="selected"</c:if>>부서</option>
			<c:forEach var="list" items="${dList}">
				<option value="${list.CODE}" <c:if test="${sel_dept == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_recode ==''}" >selected="selected"</c:if>>상태</option>
			<c:forEach var="list" items="${rList}">
				<option value="${list.CODE}" <c:if test="${sel_recode == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="txt_search" id="txt_search" class="sel_basic" onchange="PageReload()">
				<option value="ALL" <c:if test="${txt_search =='ALL'}" >selected="selected"</c:if>>이름/아이디</option>
				<option value="01" <c:if test="${txt_search =='01'}" >selected="selected"</c:if>>이름</option>
				<option value="02" <c:if test="${txt_search =='02'}" >selected="selected"</c:if>>아이디</option>
			</select>
		</li>
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
	</ul>
</div>
	<table class="table_list">
	<caption></caption>
	<colgroup>
		<col style="width:10%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
		<col style="width:15%" />
	</colgroup>
	<thead>
	<tr>
		<th></th>
		<th>이름</th>
		<th>아이디</th>
		<th>지점</th>
		<th>등록일</th>
		<th>부서</th>
		<th>상태</th>
	</tr>
	</thead>
	<tbody>
	<c:if test="${PAGE_LIST.size() == 0}">
	<tr>
		<td colspan="6" align="center" >등록된 관리자가 없습니다.</td>
	</tr>
	</c:if>
	<c:forEach var="list" items="${PAGE_LIST}">
	<tr>
		<td class="th_first"><input type="checkbox" name="chk_admin" value="${list.ADMIN_ID}" adminNm="${list.NAME}" email="${list.EMAIL}" ></td>
		<td><c:out value="${list.NAME}" /></td>
		<td><c:out value="${list.ADMIN_ID}"/></td>
		<td><c:out value="${list.GHLC_NM}" /></td>
		<td><c:out value="${list.REG_DT}" /></td>
		<td><c:out value="${list.DEPT_NM}" /></td>
		<td><c:out value="${list.STATUS}" /></td>
	</tr>
	</c:forEach>
	<tr class="last">
		<td colspan="7" />
	</tr>
	</tbody>
	</table>
	<input type="hidden" name="array" id="array" />
</div>

<div class="pageList">
	<!-- 페이지 네비게이션 출력  -->
	<c:out value="${PAGE_NAVI}" escapeXml="false"/>
	<!-- 페이지 네비게이션 출력  -->
</div>
<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="RegAdmin2()">등록</a></li>
	</ul>
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/DISC_ADM_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function RegAdmin1(){
	if($('#admin_nm').val() == ""){
		alert('관리자명을 입력해주세요.');
		return;
	}else if($('#email').val() == ""){
		alert("이메일을 입력해주세요.");
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_ADM_00/RegAdmin1', $("#frmPage").serialize(), success_function);
}

function RegAdmin2(){
	
	var chk = $('input:checkbox[name=chk_admin]:checked').length;
	if(chk == 0){
		alert("사용자를 선택해주세요");
		return;
	}

	var array = "";
	$('input:checkbox[name=chk_admin]').each(function (i) {
		if(array.indexOf(this.value) < 0){
			array += this.value + "," + this.checked + "," + $(this).attr("adminNm") + "," + $(this).attr("email") + "|" ;
		}
	});
	
	$('#array').val(array.substring(0, array.length-1));
	
	var data = {
			user_id : $("#user_id").val(),
			array : $("#array").val(),
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_ADM_00/RegAdmin2', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/DISC_ADM_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

function DelAdmin(admin_id){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/DISC_ADM_00/DelAdmin', {admin_id:admin_id, reg_id:$("#user_id").val()}, success_function);
}
</script>
