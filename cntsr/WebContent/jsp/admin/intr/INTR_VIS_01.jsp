<%--
  - Author      : 김현우
  - Date        : 2014-07-14
  - Description : GKL소개 > 견학안내 > 상세
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
		<th class="th_first">단체(학교)명</th>
		<td><span><c:out value="${map.GROUP_NM}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">신청자</th>
		<td><span><c:out value="${map.NAME}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">희망지점</th>
		<td>
			<span>	
				<c:forEach var="list" items="${GHLC_CODE}">
				<c:if test="${list.CODE != 'AL'}">
				<label for="branch_area${list.CODE}"><input type="radio" name="ghlc_typ" id="branch_area${list.CODE}" class="i_radio" value="${list.CODE}" <c:if test="${list.CODE == map.GHLC_TYP}">checked="checked"</c:if> onclick="changeGHLC('${list.CODE}')"> ${list.CODE_NM}</label>
				</c:if>
				</c:forEach>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">희망일</th>
		<td>
			<span>
				<input type="text" title="희망일 입력필드" id="hope_date" name="hope_date" style="width:128px" value="${map.HOPE_DATE}" readonly /> 
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">희망시간</th>
		<td>
			<span> 
				<div id="div_KA" <c:if test="${map.GHLC_TYP != 'CX'}">style="display:none;"</c:if>>
					<select title="희망시간 선택" name="hoti_typ_KA" id="hoti_typ_KA">
						<c:forEach var="list" items="${KAHT_CODE}">
						<option value="${list.CODE}" <c:if test="${map.HOTI_TYP == list.CODE}">selected="true"</c:if>>${list.CODE_NM}</option>
						</c:forEach>
					</select>
				</div>
				<div id="div_SH" <c:if test="${map.GHLC_TYP != 'HT'}">style="display:none;"</c:if>>
					<select title="희망시간 선택" name="hoti_typ_SH" id="hoti_typ_SH">
						<c:forEach var="list" items="${SHHT_CODE}">
						<option value="${list.CODE}" <c:if test="${map.HOTI_TYP == list.CODE}">selected="true"</c:if>>${list.CODE_NM}</option>
						</c:forEach>
					</select>
				</div>
				<div id="div_BL" <c:if test="${map.GHLC_TYP != 'LT'}">style="display:none;"</c:if>>
					<select title="희망시간 선택" name="hoti_typ_BL" id="hoti_typ_BL">
						<c:forEach var="list" items="${BLHT_CODE}">
						<option value="${list.CODE}" <c:if test="${map.HOTI_TYP == list.CODE}">selected="true"</c:if>>${list.CODE_NM}</option>
						</c:forEach>
					</select>
				</div>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first">참가인원</th>
		<td><span><c:out value="${map.PERSON_CNT}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">연락처</th>
		<td><span><c:out value="${map.TEL}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">이메일</th>
		<td><span><c:out value="${map.EMAIL}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">신청공문첨부</th>
		<td>
			<span>
				<div class="screen_imgs" id="ul_file">
						<c:forEach var="list" items="${attachList}">
							<div>
							<li class="attach_li">
								<a href="${pageContext.request.contextPath}/VIEWER/file/${list.SEQ_FILE}">
									<p>${list.ORG_FILE_NM} <b>다운로드</b></p>
								</a>
							</li>
							</div>
						</c:forEach>
					</div>
			</span>
		</td>
	</tr>
	<tr>
		<th class="th_first"><span>상태</span></th>
		<td>
			<span>
			<c:forEach var="list" items="${vList}" varStatus="status">
				<input type="radio" name="vist_typ" id="vist_typ${status.count}" value="${list.CODE}" <c:if test="${((status.count == '1') || (list.CODE == map.VIST_TYP))}" >checked="checked"</c:if>><label for="vist_typ${status.count}"> ${list.CODE_NM}</label></input>
			</c:forEach>
			<br/><br/>
			<font style="color:red"><strong>승인 또는 반려</strong> 등록시 신청자에게 메일이 발송 됩니다.</font>
			</span>
			
		</td>
	</tr>
	<tr>
		<th class="th_first">상태등록일</th>
		<td><span><c:out value="${map.UPD_DT}"/></span></td>
	</tr>
	<tr>
		<th class="th_first">사유</th>
		<td>
			<span>
				<textarea id="reason" name="reason" cols="90" rows="5"><c:out value="${map.REASON}" /></textarea>
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
		<li><a href="#" onclick="VisitAppr()">등록</a></li>
	</ul>
</div>

<input type="hidden" id="ghlc_typ" value="${map.GHLC_TYP}"/>

<jsp:include page="/jsp/common/incBottom.jsp" /> 

</form>

<script>

datepickerf('hope_date', '${yyyy}', '${mm}', '${de}');

//지점변경
function changeGHLC(val){
	$('#div_KA, #div_SH, #div_BL').hide();
	$('#div_' + val).show();
	$('#ghlc_typ').val(val);
}

function GoList(){
	var url = "${pageContext.request.contextPath}/admin/INTR_VIS_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}



var vist_typ;
function VisitAppr(){
	
	//value 체크
	if($('#question').val() == ""){
		alert('질문을 입력하세요.');
		return;
	}
	
	var radio1 = $("input[name='vist_typ']");
	for(var i = 0; i < radio1.length; i++){
		if(radio1[i].checked == true){
			vist_typ = radio1[i].value;
		}
	}

	var data = {
			seq : $("#seq").val(),
			vist_typ : vist_typ,
			reason : $("#reason").val(),
			reg_id : $("#user_id").val(),
			hope_date : $("#hope_date").val(),
			hoti_typ_CX : $("#hoti_typ_KA").val(),
			hoti_typ_HT : $("#hoti_typ_SH").val(),
			hoti_typ_LT : $("#hoti_typ_BL").val(),
			ghlc_typ : $("#ghlc_typ").val(),
	};
	
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_VIS_01/VisitAppr', data, success_function);
}

success_function = function(){
	GoPage('${pageContext.request.contextPath}/admin/INTR_VIS_00/default', null ,'${TMENUID}', '${SMENUID}', '${METYPE}');
};

</script>