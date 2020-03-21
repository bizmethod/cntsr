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
<input type="hidden" name="PAGENUM">

<div class="wrap_table" >
<div class="top_area">
	<ul>
		<li class="ml10">
			<select name="sel_typ" id="sel_typ" class="sel_basic" onchange="PageReload()">
				<option value="" >전체</option>
				<option value="CM" <c:if test="${sel_typ =='CM'}" >selected="selected"</c:if>>CEO메세지</option>
				<option value="SL" <c:if test="${sel_typ =='SL'}" >selected="selected"</c:if>>CEO특강</option>
			</select>
		</li>
		<li class="ml10">
			<select name="txt_search" id="txt_search" class="sel_basic" onchange="PageReload()">
				<option value="01" <c:if test="${txt_search =='01'}" >selected="selected"</c:if>>제목</option>
				<option value="02" <c:if test="${txt_search =='02'}" >selected="selected"</c:if>>내용</option>
			</select>
		</li>
		<li class="ml10">
			<select name="sel_recode" id="sel_recode" class="sel_basic" onchange="PageReload()">
				<option value="" <c:if test="${sel_recode ==''}" >selected="selected"</c:if>>상태</option>
				<option value="A" <c:if test="${sel_recode =='A'}" >selected="selected"</c:if>>전시</option>
				<option value="I" <c:if test="${sel_recode =='I'}" >selected="selected"</c:if>>미전시</option>
			</select>
		</li>
		<li class="ml10">
			<span class="bg_input input_able"><input type="text" id="sTxt" name="sTxt" value="${sTxt}" style="width:160px;" /></span><a href="javascript:PageReload();" class="btn_s_default" id="search"><span>검색</span></a>
		</li>
		<li class="ml10"><a class="btn_s_wh" id="btn_reg" onclick="goDetail('','I')">등록</a></li>
		<li class="ml10"><a href="${pageContext.request.contextPath}/VIEWER/getExcelDown/INTR_02_02/CM" class="btn_s_wh_130" id="btn_excel" >공공누리 엑셀저장</a></li>
	</ul>
</div>
	<table class="table_list">
		<caption></caption>
		<colgroup>
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:40%" />
			<col style="width:20%" />
			<col style="width:8%" />
			<col style="width:12%" />
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>구분</th>
			<th>제목</th>
			<th>등록일</th>
			<th>조회수</th>
			<th>전시여부</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${PAGE_LIST.size() == 0}">
		<tr>
			<td colspan="6" align="center" >등록된 CEO활동이 없습니다.</td>
		</tr>
		</c:if>
		<c:forEach var="list" items="${PAGE_LIST}">
		<tr style="cursor: pointer;" onclick="javascript:goDetail('${list.SEQ_NOTICE}','U')">
			<td class="th_first"><c:out value="${PAGE_TOTALCOUNT + 1 - list.ROWNUM}" /></td>
			<td><c:out value="${list.NOTI_TYP_NM}"/></td>
			<td><c:out value="${list.TITLE}"/></td>
			<td><c:out value="${list.REG_DT}" /></td>
			<td><c:out value="${list.CLIC_NUM}" /></td>
			<td><c:if test="${list.RECODE_ST == 'A'}" >전시<c:if test="${list.LIMIT_YN == 'Y'}" ><p style="color: red;">(전시기간 아님)</p></c:if></c:if><c:if test="${list.RECODE_ST == 'I'}" >미전시</c:if></td>
		</tr>
		</c:forEach>
		<tr class="last">
			<td colspan="6" />
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
function PageReload(){
	var url = "${pageContext.request.contextPath}/admin/INTR_CEO_00/default";
	var param = $("#frmPage").serialize();
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function goDetail(seq,IU){
	
	var url = "${pageContext.request.contextPath}/admin/INTR_CEO_01/default";
	var param = {IU:IU,seq:seq,sel_typ:$("#sel_typ").val(),TMENUID:'${TMENUID}',SMENUID:'${SMENUID}'}
	GoPage(url, param, '${TMENUID}', '${SMENUID}', '${METYPE}');
}
</script>
