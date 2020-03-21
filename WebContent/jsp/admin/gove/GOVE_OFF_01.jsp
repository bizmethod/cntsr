<%--
  - Author      : 김현우
  - Date        : 2014-07-16
  - Description : 정부3.0 > 사전정보공표목록 > 1depth 등록수정
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
	<input type="hidden" name="seq" id="seq" value="${seq}"/>
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
		<th class="th_first">구분</th>
		<td>
			<span>
				<select name="sel_typ" id="sel_typ" class="sel_basic">
					<c:forEach var="list" items="${gubunList}">
						<option value="${list.CODE}" <c:if test="${map.INLI_TYP == list.CODE}" >selected="selected"</c:if>>${list.CODE_NM}</option>
					</c:forEach>
				</select>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">사전정보 공개내용</th>
		<td colspan="3">
			<span>
				<input type="text" class="input_text" id="title" name="title" style="width:80%;" value="${map.TITLE}" maxlength="150"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">담당부서</th>
		<td colspan="3">
			<span>
				<input type="text" class="input_text" id="dept" name="dept" style="width:80%;" value="${map.DEPT}" maxlength="50"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">공개주기</th>
		<td colspan="3">
			<span>
				<input type="text" class="input_text" id="p_period" name="p_period" style="width:80%;" value="${map.P_PERIOD}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">공개시기</th>
		<td colspan="3">
			<span>
				<input type="text" class="input_text" id="p_time" name="p_time" style="width:80%;" value="${map.P_TIME}" maxlength="25"/>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">공표메채</th>
		<td colspan="3">
			<span> 
		   		<input type="radio" name="link_typ" id="link_typ1" value="UR" <c:if test="${map.get('LINK_TYP') == 'UR' || map.get('LINK_TYP') == null}">checked="checked"</c:if>><label for="link_typ1"> 홈페이지링크</label>
		   		<input type="radio" name="link_typ" id="link_typ2" value="BO" <c:if test="${map.get('LINK_TYP') == 'BO'}">checked="checked"</c:if>><label for="link_typ2"> 게시판</label>
		    </span>
		</td>
	</tr>
	<tr>
		<th class="th_first">URL</th>
		<td colspan="3">
			<span>
				<input type="text" class="input_text" id="url" name="url" style="width:80%;" value="${map.URL}" />
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
		<c:if test="${IU == 'I'}">
			<li><a href="#" onclick="RegData('I')">등록</a></li>
		</c:if>
		<c:if test="${IU != 'I'}">
			<li><a href="#" onclick="RegData('U')">수정</a></li>
			<li><a href="#" onclick="DelPreInfom()">삭제</a></li>
		</c:if>
	</ul>
</div>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/GOVE_OFF_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

//삭제
function DelData(){
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	GetAjaxXml('${pageContext.request.contextPath}/admin/GOVE_OFF_01/DelData', $("#frmPage").serialize(), success_function);
}

function getRadioValue( radioField ) { 
    for (var i =0; i<radioField.length; i++) { 
        if( radioField[i].checked == true ) { 
            return radioField[i].value; 
        } 
    } 
}

function RegData(IU){
	var link_typ = getRadioValue(document.frmPage.link_typ); 
	var data = {
			seq : $("#seq").val(),
			sel_typ : $("#sel_typ").val(),
			title : $("#title").val(),
			dept : $("#dept").val(),
			p_period : $("#p_period").val(),
			p_time : $("#p_time").val(),
			link_typ : link_typ,
			url : $("#url").val(),
			reg_id : $("#user_id").val(),
			IU:IU
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/GOVE_OFF_01/RegData', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/GOVE_OFF_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>