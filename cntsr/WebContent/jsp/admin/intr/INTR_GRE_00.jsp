<%--
  - Author      : 김현우
  - Date        : 2014-06-24
  - Description : GKL소개 > CEO소개
  - Edited      : 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/incTop.jsp" /> 

<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//네이버 스마트 에디터 사용
var oEditors1 = [];
var oEditors2 = [];
var oEditors3 = [];
var oEditors4 = [];

function editorInit1(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors1,
		elPlaceHolder: "description1",
		sSkinURI: "${pageContext.request.contextPath}/common/js/smartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
// 				alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
}
function editorInit2(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors2,
		elPlaceHolder: "description2",
		sSkinURI: "${pageContext.request.contextPath}/common/js/smartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
// 				alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
}
function editorInit3(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors3,
		elPlaceHolder: "description3",
		sSkinURI: "${pageContext.request.contextPath}/common/js/smartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
// 				alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
}
function editorInit4(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors4,
		elPlaceHolder: "description4",
		sSkinURI: "${pageContext.request.contextPath}/common/js/smartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
// 				alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
		},
		fCreator: "createSEditor2"
	});
}
</script>

<form name="frmPage" id="frmPage" method="post" enctype="multipart/form-data">

<div class="wrap_table" >
<div class="top_area">
<!-- 	<ul style="float: left;"> -->
<!-- 		<li class="ml10"> -->
<!-- 			<select name="lang_typ" id="lang_typ" class="sel_basic" onchange="changeEditor()"> -->
<!-- 				<option value="KR">한국어</option> -->
<!-- 				<option value="EN">영어</option> -->
<!-- 				<option value="JP" >일어</option> -->
<!-- 				<option value="CN" >중국어</option> -->
<!-- 			</select> -->
<!-- 		</li> -->
<!-- 	</ul> -->
</div>
	<table class="table_list">
		<thead>
		<tr>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<tr><td><strong>한국어 등록</strong></td></tr>
		<tr id="tr_kr">
			<td>
				<textarea id="description1" name="description1" cols="100" rows="20" style="width:100%; display: none;">
				<c:out value="${map.get('DESC_KR')}" escapeXml="false"/>
				</textarea>
			</td>
		</tr>
		<tr><td><strong>영어 등록</strong></td></tr>
		<tr id="tr_en">
			<td>
				<textarea id="description2" name="description2" cols="100" rows="20" style="width:100%; display: none;">
				<c:out value="${map.get('DESC_EN')}" escapeXml="false"/>
				</textarea>
			</td>
		</tr>
		<tr><td><strong>일어 등록</strong></td></tr>
		<tr id="tr_jp">
			<td>
				<textarea id="description3" name="description3" cols="100" rows="20" style="width:100%; display: none;">
				<c:out value="${map.get('DESC_JP')}" escapeXml="false"/>
				</textarea>
			</td>
		</tr>
		<tr><td><strong>중국어 등록</strong></td></tr>
		<tr id="tr_cn">
			<td>
				<textarea id="description4" name="description4" cols="100" rows="20" style="width:100%; display: none;">
				<c:out value="${map.get('DESC_CN')}" escapeXml="false"/>
				</textarea>
			</td>
		</tr>
		<tr class="last">
			<td>
		</tr>
		</tbody>
	</table>
</div>

<!-- 공공누리 -->
<jsp:include page="/jsp/common/kogl.jsp" />

<div class="wrap_btn">
	<ul class="btn_bottom mt10">
		<li><a href="#" onclick="UpdGreeting()">수정</a></li>
	</ul>
</div>

<input type="hidden" name="user_id" id="user_id" value="${USER_ID}" />
<input type="hidden" name="UUID" id="UUID" value="${UUID}" />

</form>
<jsp:include page="/jsp/common/incBottom.jsp" />

<script>
//목록으로
function GoList(){
	var url = "${pageContext.request.contextPath}/admin/NOTI_NEW_00/default";
	GoPage(url, null, '${TMENUID}', '${SMENUID}', '${METYPE}');
}

function getRadioValue( radioField ) { 
    for (var i =0; i<radioField.length; i++) { 
        if( radioField[i].checked == true ) { 
            return radioField[i].value; 
        } 
    } 
}


//등록 및 수정
function UpdGreeting(){
	
	//value 체크
	if($('#title').val() == ""){
		alert('제목을 입력하세요.');
		return;
	}else if(!$("input[name='kogl_open']").is(":checked")){
		alert("공공저작물 자유이용 여부를 선택해주세요");
		return;
	}else if(!$("input[name='kogl_B']").is(":checked")){
		alert("공공저작물 상업적 이용표시 유형을 선택해주세요");
		return;
	}else if(!$("input[name='kogl_M']").is(":checked")){
		alert("공공저작물 변경허용 여부를 선택해주세요");
		return;
	}
	
// 	var lang_typ = getRadioValue(document.frmPage.lang_typ);
	var kogl_open = getRadioValue(document.frmPage.kogl_open); 
	var kogl_B = getRadioValue(document.frmPage.kogl_B); 
	var kogl_M = getRadioValue(document.frmPage.kogl_M); 
	var kogl_con = getRadioValue(document.frmPage.kogl_con); 
	
	//네이버 스마트 에디터의 알수없는 공백 제거
	var ct1 = oEditors1.getById["description1"].getIR();
	  ct1 = escape(ct1); 
	while(ct1.indexOf("%u200B") > 0){ 
	  ct1 = ct1.replace("%u200B", ""); 
	} 
  	ct1 = unescape(ct1); 
	
	var ct2 = oEditors2.getById["description2"].getIR();
	  ct2 = escape(ct2); 
	while(ct2.indexOf("%u200B") > 0){ 
	  ct2 = ct2.replace("%u200B", ""); 
	} 
  	ct2 = unescape(ct2); 
	
	var ct3 = oEditors3.getById["description3"].getIR();
	  ct3 = escape(ct3); 
	while(ct3.indexOf("%u200B") > 0){ 
	  ct3 = ct3.replace("%u200B", ""); 
	} 
  	ct3 = unescape(ct3); 
	
	var ct4 = oEditors4.getById["description4"].getIR();
	  ct4 = escape(ct4); 
	while(ct4.indexOf("%u200B") > 0){ 
	  ct4 = ct4.replace("%u200B", ""); 
	} 
  	ct4 = unescape(ct4); 
	
	var data = {
			UUID : $("#UUID").val(),
			ncprm_description1 : ct1,
			ncprm_description2 : ct2,
			ncprm_description3 : ct3,
			ncprm_description4 : ct4,
			//구분값은 사회공헌 코드 고정 TE
// 			lang_typ : lang_typ,
			//공공누리 관련
			kogl_open : kogl_open,
			kogl_B : kogl_B,
			kogl_M : kogl_M,
			kogl_con : kogl_con,
			reg_id : $("#user_id").val()
	};
	GetAjaxXml('${pageContext.request.contextPath}/admin/INTR_GRE_00/UpdGreeting', data, success_function);
}

success_function = function(){
	alert("저장되었습니다!");
	GoPage('${pageContext.request.contextPath}/admin/INTR_GRE_00/default', null, '${TMENUID}', '${SMENUID}', '${METYPE}');
};

//textArea에 이미지 첨부
function pasteHTML(filepath){
	var sHTML = '<img src="${GKLURL}/file/img/pic/'+filepath+'">';
    
	var code=$("#lang_typ").val();
	
// 	var radio = $("input[name='lang_typ']");
// 	for(var i = 0; i < radio.length; i++){
// 		if(radio[i].checked == true){
// 			code = radio[i].value;
// 		}
// 	}
	
	if(code == "KR"){
		oEditors1.getById["description1"].exec("PASTE_HTML", [sHTML]);
    }else if(code == "EN"){
		oEditors2.getById["description2"].exec("PASTE_HTML", [sHTML]);
    }else if(code == "JP"){
		oEditors3.getById["description3"].exec("PASTE_HTML", [sHTML]);
    }else if(code == "CN"){
		oEditors4.getById["description4"].exec("PASTE_HTML", [sHTML]);
    }
}

	
	
$(document).ready(function (){
	editorInit1();
	editorInit2();
	editorInit3();
	editorInit4();
});

function changeEditor(){
	var typ = $("#lang_typ").val();
	if(typ=='KR'){
		$("#tr_kr").show();
		$("#tr_en").hide();
		$("#tr_jp").hide();
		$("#tr_cn").hide();
	}else if(typ=='EN' || typ == ''){
		$("#tr_en").show();
		$("#tr_kr").hide();
		$("#tr_jp").hide();
		$("#tr_cn").hide();
	}else if(typ=='JP'){
		$("#tr_jp").show();
		$("#tr_kr").hide();
		$("#tr_en").hide();
		$("#tr_cn").hide();
	}else if(typ=='CN'){
		$("#tr_cn").show();
		$("#tr_kr").hide();
		$("#tr_en").hide();
		$("#tr_jp").hide();
	}
}
</script>

