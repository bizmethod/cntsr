<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 윤리경영 > 반부패청렴 > 임직원 해외출장정보 > 리스트
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
<input type="hidden" name="PAGENUM"/>

<div class="wrap_table" >
<div class="top_area" style="width: 900px;">
	<ul>
		<li class="ml10">
			<select name="sel_typ" id="sel_typ" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_typ ==''}" >selected="selected"</c:if>>전체</option>
			<c:forEach var="list" items="${gList}">
				<option value="${list.CODE}" <c:if test="${sel_typ == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<label>기간 </label>
			<input type="text" class="input_cal" name="start_d" id="start_d" value="${txt_start_d}" /> ~ <input type="text" class="input_cal" name="end_d" id="end_d" value="${txt_end_d}" />
		</li>
		<li class="ml10">
			<label>출장지 </label>
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
	</ul>
</div>
	<table class="table_list" style="width: 900px;">
		<caption></caption>
		<colgroup>
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:15%" />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>구분</th>
			<th>출장자</th>
			<th>출장기간</th>
			<th>출장지</th>
			<th>출장목적</th>
			<th>기안자</th>
			<th>기안부서</th>
			<th>보고서</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="9" align="center" >등록된 출장정보가 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_BUSINESS_TRIP}','U')">
			<td class="th_first"><c:out value="${list.ROWNUM}" /></td>
			<td><c:out value="${list.EMPL_TYP_NM}"/></td>
			<td><c:out value="${list.MEMBER_NM}"/></td>
			<td><p><c:out value="${list.START_D}" /> ~ </p><p><c:out value="${list.END_D}" /></p></td>
			<td><c:out value="${list.PLACE}" /></td>
			<td><c:out value="${list.PURPOSE}" /></td>
			<td><c:out value="${list.DRAFT_NM}" /></td>
			<td><c:out value="${list.DRAFT_ORG_NM}" /></td>
			<td>
				<c:if test="${list.SEQ_FILE != null}">
					<a href="${pageContext.request.contextPath}/VIEWER/file/${list.SEQ_FILE}"><img src="${pageContext.request.contextPath}/common/images/icon/icon_file2.gif" /></a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="9" />
		</tr>
		</tbody>
	</table>
</div>
<div class="pageList">
	<!-- 페이지 네비게이션 출력  -->
	<c:out value="${PAGE_NAVI}" escapeXml="false"/>
	<!-- 페이지 네비게이션 출력  -->
</div>
</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>

datepickerf('start_d', 'end_d', '', '');

function PageReload(){
	if($("#start_d").val() != null){
		var startD = $("#start_d").val().replace(/\//g,"");
		$("#start_d").val(startD);
	}
	if($("#end_d").val() != null){
		var endD = $("#end_d").val().replace(/\//g,"");
		$("#end_d").val(endD);
	}
	var url = "${pageContext.request.contextPath}/admin/ETHI_BTR_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	var url = "${pageContext.request.contextPath}/admin/ETHI_BTR_01/default";
	var param = {seq:seq, IU:IU, TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
