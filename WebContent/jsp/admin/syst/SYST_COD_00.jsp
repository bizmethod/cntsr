<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : 시스템관리 > 코드관리 > 리스트
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<style>
input,select {
	margin-left: 3px;
	margin-right: 4px;
	margin-bottom : 3px;
}
</style>
<h2 class="tit">코드관리</h2>

<div style="width: 1000px; height: 800px;">
	<div style="float: left; width: 35%; height: 98%;">
	<div class="wrap_table">
		<div class="list_search_num">CODESET</div>
	</div>
		<div class="wrap_tab"  style="width: 98%; height: 69%; overflow: auto; margin-bottom: 10px; margin-top: 0;">
			<table class="table_detail" id="codeList1" style="width: 94%;">
			<caption></caption>
			<colgroup>
				<col style="width:20%">
				<col style="width:60%">
				<col style="width:18%">
			</colgroup>
				<thead>
				<tr>
					<th>코드그룹</th>
					<th>코드설명</th>
					<th>상태</th>
				</tr>
				</thead>
			</table>
		</div>
		<form name="frm1" id="frm1" method="post">
		<span class="list_search_num">코드그룹</span><input type="text" class="input_text" maxlength="4" id="codeSet" name="codeSet"
						style="width: 80px;" /> <span class="list_search_num">코드설명</span><input type="text" id="codeDesc"
						class="input_text" name="codeDesc" style="width: 80px;" />
		<span class="list_search_num">사용여부</span><select id="cs_recode_st" name="cs_recode_st" class="sel_basic" style="width: 70px;">
					<option value="A">사용</option>
					<option value="I">미사용</option>
				</select>
		<ul class="btn_bottom mt10">
		<li btn="regBtn"><a href="#" onclick="setBtn('frm1','add')" id="regBtn">등록</a></li>
		<li btn="addBtn"><a href="#" onclick="codeInsert1()" id="addBtn">추가</a></li>
		<li btn="modBtn"><a href="#" onclick="codeUpdate1()" id="modBtn">수정</a></li>
<!-- 		<li btn="delBtn"><a href="#" onclick="codeDelete1()" id="delBtn">삭제</a></li> -->
	</ul>
	<label class="error" for="codeSet" generated="true"
						style="display: none; color: red;"></label>
	</form>
	</div>
	<div style="float: right; width: 62%; height: 98%;">
		<div class="wrap_table">
			<div class="list_search_num">CODE (CODESET :: <strong id="codeLabel">No Select CodeSet</strong>)</div>
		</div>
		<div class="wrap_tab"
			style="width: 98%; height: 69%; overflow: auto; margin-bottom: 10px; margin-top: 0;">
			<table class="table_detail" id="codeList2" style="width: 94%;">
			<caption></caption>
			<colgroup>
				<col style="width:16%">
				<col style="width:28%">
				<col style="width:34%">
				<col style="width:10%">
				<col style="width:10%">
			</colgroup>
				<tr>
					<th>코드</th>
					<th>코드명</th>
					<th>코드설명</th>
					<th>정렬순서</th>
					<th>사용여부</th>
				</tr>
			</table>
		</div>
		<form name="frm2" id="frm2" method="post">
		<span class="list_search_num">코드</span><input type="text" class="input_text" maxlength="6" id="code" name="code"
					style="width: 70px;" /><span class="list_search_num">코드명</span><input type="text" class="input_text" id="codeNm"
					name="codeNm" style="width: 70px;" /><span class="list_search_num">코드설명</span><input type="text" class="input_text"
					id="codeDesc" name="codeDesc" style="width: 290px;" /> <span class="list_search_num">정렬순서</span><input
					type="text" class="input_text" id="sortNo" name="sortNo" style="width: 70px;" />
				<span class="list_search_num">사용여부</span><select id="recode_st" name="recode_st" class="sel_basic" style="width: 70px;">
					<option value="A">사용</option>
					<option value="I">미사용</option>
				</select> <input type="hidden" id="codeSet" name="codeSet" />
		<label class="error" for="code" generated="true"
					style="display: none; color: red;"> </label> <label class="error"
					for="sortNo" generated="true" style="display: none; color: red;"></label>
		<ul class="btn_bottom mt10">
			<li btn="regBtn"><a href="#" onclick="setBtn('frm2','add')" id="regBtn">등록</a></li>
			<li btn="addBtn"><a href="#" onclick="codeInsert2()" id="addBtn">추가</a></li>
			<li btn="modBtn"><a href="#" onclick="codeUpdate2()" id="modBtn">수정</a></li>
<!-- 			<li btn="delBtn"><a href="#" onclick="codeDelete2()" id="delBtn">삭제</a></li> -->
		</ul>
		</form>
	</div>
</div>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script type="text/javascript">
	$(document).ready(function() {
		getCodeList1();
		setBtn("frm1", "add");
		$("#frm1").validate({
			rules : {
				codeSet : {
					required : true
				}
			},
			messages : {
				codeSet : {
					required : "코드그룹은 반드시 입력해야 합니다.!"
				}
			}
		});
		$("#frm2").validate({
			rules : {
				code : {
					required : true
				},
				sortNo : {
					number : true
				}
			},
			messages : {
				code : {
					required : "코드는 반드시 입력해야 합니다."
				},
				sortNo : {
					number : "정렬순서는 숫자만 입력가능합니다."
				}
			}
		});
	});

	function getCodeList1() {
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeList1', null, makeTable1);
	}

	function getCodeList2(codeSet) {
		var data = {"codeSet" : codeSet};
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeList2', data, makeTable2);
	}

	function makeTable1(list) {
		var tblId = "codeList1";
		deleteTable(tblId);
		$("#" + tblId).append("<colgroup><col style='width:20%'><col style='width:60%'><col style='width:18%'>"+
			"</colgroup><tr><th>코드그룹</th><th>코드설명</th><th>상태</th></tr>");
		if (list != null) {
			$(list).find('smartq-xml > item-list > item').each(function(i) {
				$("#" + tblId).append(
						"<tr onclick='rowSelect1(\"" + $(this).find('CODESET').text()
								+ "\",\"" + $(this).find('CODE_DESC').text() + "\",\""
								+ $(this).find('RECODE_ST').text() + "\")'><td><span>"
								+ $(this).find('CODESET').text() + "</span></td><td><span>"
								+ $(this).find('CODE_DESC').text() + "</span></td><td><span>"
								+ $(this).find('RECODE_ST_NM').text() + "</span></td></tr>");
			});
			$("#" + tblId).append("<tr class=\"last\"><td colspan=\"3\" /></tr>");
		}
		$("table tr").css("cursor","pointer");
	}

	function makeTable2(list) {
		var tblId = "codeList2";
		deleteTable(tblId);
		$("#" + tblId)
				.append(
						"<colgroup><col style=\"width:16%\"><col style=\"width:28%\"><col style=\"width:34%\">"+
					"<col style=\"width:10%\"><col style=\"width:10%\"></colgroup>"+
					"<tr><th>코드</th><th>코드명</th><th>코드설명</th><th>정렬순서</th><th>사용여부</th></tr>");
		if (list != null) {
			$(list).find('smartq-xml > item-list > item').each(function(i) {
				$("#" + tblId).append(
						"<tr onclick='rowSelect2(\"" + $(this).find('CODE').text() + "\",\""
								+ $(this).find('CODE_NM').text() + "\",\"" + $(this).find('CODE_DESC').text()
								+ "\",\"" + $(this).find('SORT_NO').text() + "\",\""
								+ $(this).find('RECODE_ST').text() + "\")'><td><span>" + $(this).find('CODE').text()
								+ "</span></td><td><span>" + $(this).find('CODE_NM').text() + "</span></td><td><span>"
								+ $(this).find('CODE_DESC').text() + "</span></td><td><span>"
								+ $(this).find('SORT_NO').text() + "</span></td><td><span>"
								+ $(this).find('RECODE_ST_NM').text() + "</span></td></tr>");
			});
			$("#" + tblId).append("<tr class=\"last\"><td colspan=\"5\" /></tr>");
		}
		$("table tr").css("cursor","pointer");
	}

	function rowSelect1(codeSet, codeDesc, recode_st) {
		$("#frm1 [id='codeSet']").val(codeSet);
		$("#frm2 [id='codeSet']").val(codeSet);
		$("#frm1 [id='codeDesc']").val(codeDesc);
		$("#codeLabel").empty().append(codeSet);
		$("#frm1 [id='cs_recode_st'] option[value='" + recode_st + "']").attr("selected",
		"selected");
		setBtn("frm1", "reg");
		getCodeList2(codeSet);
	}

	function rowSelect2(code, codeNm, codeDesc, sortNo, recode_st) {
		$("#frm2 [id='code']").val(code);
		$("#frm2 [id='codeDesc']").val(codeDesc);
		$("#frm2 [id='codeNm']").val(codeNm);
		$("#frm2 [id='sortNo']").val(sortNo);
		$("#frm2 [id='recode_st'] option[value='" + recode_st + "']").attr("selected",
				"selected");
		setBtn("frm2", "reg");
	}

	function deleteTable(tblId) {
		$("#" + tblId).empty();
	}

	function setBtn(frmId, gubn) {
		if (gubn == "add") {
			$("#" + frmId + " [btn=regBtn]").hide();
			$("#" + frmId + " [btn=addBtn]").show();
			$("#" + frmId + " [btn=modBtn]").hide();
			$("#" + frmId + " [btn=delBtn]").hide();
			$("#" + frmId + " input[type='text']").val('');
			if ($("#" + frmId + "[id='recode_st']")) {
				$("#" + frmId + "[id='recode_st'] option[value='A']").attr(
						"selected", "selected");
			}
			$("#" + frmId + " [id=code]").attr("readonly", false);
			if (frmId == "frm1") {
				setBtn("frm2", "add");
				deleteTable("codeList2");
				makeTable2();
				$("#frm2 [btn=addBtn]").hide();
				$("#codeLabel").empty().append("No Select CodeSet");
			}
		} else if (gubn == "reg") {
			$("#" + frmId + " [btn=regBtn]").show();
			$("#" + frmId + " [btn=addBtn]").hide();
			$("#" + frmId + " [btn=modBtn]").show();
			$("#" + frmId + " [btn=delBtn]").show();
			$("#" + frmId + " [id=code]").attr("readonly", "readonly");
			if (frmId == "frm1") {
				setBtn("frm2", "add");
			}
		}
	}

	function codeInsert1() {
		if (!$("#frm1").valid())
			return;
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeInsert1', $("#frm1").serialize(), codeInsertSuccess1);
	}
	
	function codeInsertSuccess1(){
		getCodeList1();
		setBtn("frm1", "add");
	}

	function codeInsert2() {
		if (!$("#frm2").valid())
			return;
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeInsert2', $("#frm2").serialize(), codeInsertSuccess2);
	}
	
	function codeInsertSuccess2(){
		getCodeList2($("#frm2 [id='codeSet']").val());
		setBtn("frm2", "add");
	}

	function codeUpdate1() {
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeUpdate1', $("#frm1").serialize(), codeInsertSuccess1);
	}

	function codeUpdate2() {
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeUpdate2', $("#frm2").serialize(), codeInsertSuccess2);
	}

	function codeDelete1() {
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeDelete1', $("#frm1").serialize(), codeInsertSuccess1);
	}

	function codeDelete2() {
		GetAjaxXml('${pageContext.request.contextPath}/admin/SYST_COD_00/codeDelete2', $("#frm2").serialize(), codeInsertSuccess2);
	}
</script>
