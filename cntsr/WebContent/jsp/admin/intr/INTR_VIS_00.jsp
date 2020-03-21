<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : GKL소개 > CEO활동
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
<input type="hidden" name="vist_typ" id="vist_typ" value="${sel_status}" />
<input type="hidden" name="ghlc_typ" id="ghlc_typ" value="${sel_loc}" />
<input type="hidden" name="startD_e" id="startD_e" value="${start_d}" />
<input type="hidden" name="endD_e" id="endD_e" value="${end_d}" />
<input type="hidden" name="PAGENUM"/>

<div class="wrap_table" >
<div class="top_area">
	<ul>
		<li class="ml10">
			<select name="sel_status" id="sel_status" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_status ==''}" >selected="selected"</c:if>>상태</option>
			<c:forEach var="list" items="${vList}">
				<option value="${list.CODE}" <c:if test="${sel_status == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_loc" id="sel_loc" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_loc ==''}" >selected="selected"</c:if>>지점</option>
			<c:forEach var="list" items="${gList}">
				<option value="${list.CODE}" <c:if test="${sel_loc == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
			</c:forEach>
			</select>
		</li>
		<li class="ml10">
			<input type="text" class="input_cal" name="start_d" id="start_d" value="${txt_start_d}" /> ~ <input type="text" class="input_cal" name="end_d" id="end_d" value="${txt_end_d}" />
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_search" onclick="PageReload()">검색</a></li>
		<li class="ml10"><a class="btn_s_wh" id="btn_excel" onclick="confirm_excel()">엑셀저장</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:20%" />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:5%" />
		</colgroup>
		<thead>
		<tr>
			<th>순서</th>
			<th>희망일</th>
			<th>신청일</th>
			<th>희망시간</th>
			<th>단체명</th>
			<th>희망지점</th>
			<th>신청자명</th>
			<th>전화번호</th>
			<th>상태</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="9" align="center" >견학일정 내역이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_VISIT}')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT-list.ROWNUM+1}" /></td>
			<td><c:out value="${list.HOPE_DATE}"/></td>
			<td><c:out value="${list.REG_DT}"/></td>
			<td><c:out value="${list.HOTI_TYP}"/></td>
			<td><c:out value="${list.GROUP_NM}"/></td>
			<td><c:out value="${list.GHLC_TYP_NM}" /></td>
			<td><c:out value="${list.NAME}" /></td>
			<td><c:out value="${list.TEL}" /></td>
			<td><c:out value="${list.VIST_TYP_NM}" /></td>
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
// 	alert($("#start_d").val());
	if($("#end_d").val() != null){
		var endD = $("#end_d").val().replace(/\//g,"");
		$("#end_d").val(endD);
	}
// 	alert($("#end_d").val());
	var url = "${pageContext.request.contextPath}/admin/INTR_VIS_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function confirm_excel(){
	var data = {
			vist_typ : $("#vist_typ").val(),
			ghlc_typ : $("#ghlc_typ").val(),
			startD : $("#startD_e").val(),
			endD : $("#endD_e").val()
	};
	GoPage("${pageContext.request.contextPath}/admin/INTR_VIS_00/getExcelDown", data, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	
	var url = "${pageContext.request.contextPath}/admin/INTR_VIS_01/default";
	var param = {IU:IU,seq:seq,TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
