

//ajax 호출 공통 함수
//ajax 호출과 xml 응답을 일괄통일
//data: $("#frm").serialize(), {"data": val}
//Edited by 오세현 2012.10.29
//Edited by 오세현 2012.12.06 
//	- error_function 추가
//Edited by 오세현 2013-01-21
//  - beforeSend 추가
function GetAjaxXml(url, data, success_function, loading, error_function) {

	if(loading) {
		AjaxLodingStart();
	}
	if(!window.console) {console = {log:function(){}};}
	$.ajax({
		asyn: false,
//		cache: true,
		type: "POST",
		dataType:"xml",
		data: data,
		url:  url, 
		beforeSend: function(xhr) {
			xhr.setRequestHeader("ajax-call", "true");
		},
		success : function(xmlData) {
//			console.log("XMLDATA:" + xmlData);
			if(xmlData == null || $(xmlData).text() == "") {
				return;
			}
			if ($(xmlData).find('smartq-xml > result').text() != "0" && $(xmlData).find('smartq-xml > result').text() != "000") {
				if (error_function != undefined  && error_function != null) {
					error_function(xmlData);
				} else {
					alert($(xmlData).find('smartq-xml > result-msg').text());
					//console.log($(xmlData).find('smartq-xml > result-msg').text());					
				}
			}else{
				if (success_function != undefined && success_function != null) {
					success_function(xmlData);
				}
			}
		},
		error: function(response, status) {
			//alert('GetAjaxXml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
			console.log('GetAjaxXml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
		},
		complete : function(jqXHR, textStatus) {
			if(loading) {
				AjaxLodingStop();
			}
		}
	});
}


//html을 리턴
function GetAjaxHtml(url, data, success_function, loading, error_function) {

	if(loading) {
		AjaxLodingStart();
	}
	if(!window.console) {console = {log:function(){}};}
	$.ajax({
		asyn: false,
		type: "POST",
		dataType:"html",
		data: data,
		url:  url, 
		beforeSend: function(xhr) {
			xhr.setRequestHeader("ajax-call", "true");
		},
		success : function(htmlData) {
			if (success_function != undefined && success_function != null) {
				success_function(htmlData);
			}
		},
		error: function(response, status) {
			//alert('GetAjaxXml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
			console.log('GetAjaxHtml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
		},
		complete : function(jqXHR, textStatus) {
			if(loading) {
				AjaxLodingStop();
			}
		}
	});
}


//ajax 호출 공통 함수
//ajax 호출과 xml 응답을 일괄통일
//data: $("#frm").serialize(), {"data": val}
//Edited by 최경환 2012.12.07
//Edited by 장명진 2013-01-07
//Edited by 오세현 2013-01-21
//Edited by 최경환 2013-02-01 (form_name, url, data, success_function, loading, error_function, file_name, extension)
//							(폼명, url, data, success_function, loading, error_function, 확장자체크파일명, 수용가능확장자(',jpg,avi'))
function GetAjaxXmlMultiPart(form_name, url, data, success_function, loading, error_function, file_name, extension, change_function) {
	if (file_name != undefined  && file_name != null) {
		if (extension != undefined  && extension != null) {
			var file = $("input[name="+file_name+"]");
			var file_extension = file.val().substring(file.val().lastIndexOf(".") + 1);
			if(extension.indexOf(file_extension.toLowerCase())<0){
				alert("파일 확장자 맞지 않음");
				if (change_function == true) {
					file.wrap('<b />');
					file.parents("b").html(file.parents("b").html());
				}
				return;
			}
		}
	}
	
//	if(!window.console) {console = {log:function(){}};}
	
	$('input[form="'+form_name+'"]').attr("enctype", "multipart/form-data");
	$('input[form="'+form_name+'"]').attr("method", "post");
	if(loading) {
		AjaxLodingStart();
	}
	$("#"+form_name+"").ajaxSubmit({
		asyn: true,
		type: 'POST',
		dataType:'xml',
		data: data,
		url:  url,
		success : function(xmlData, textStatus) {
			var xml = null;
			try {
				xml = $.parseXML($(xmlData).text());
			} catch (e) {
//				xml = $.parseXML(xmlData);
				xml = xmlData;
			}
			if ($(xml).find('smartq-xml > result').text() != "0" && 
					$(xml).find('smartq-xml > result').text() != "000") {
				if (error_function != undefined  && error_function != null) {
					error_function(xmlData);
				} else {
					alert($(xmlData).find('smartq-xml > result-msg').text());
				}
				//return false;
			}else{
				if (success_function != undefined && success_function != null) {
					success_function(xml);
				}
			}
		},
		error : function(response, status) {
			console.log('GetAjaxXml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
			//alert('GetAjaxXml ' + status + '\nCODE: ' + response.status + '\nMESSAGE: ' + response.responseText);
			if (file_name != undefined  && file_name != null) {
				$("input[name="+file_name+"]").wrap('<b/>');
				$("input[name="+file_name+"]").parents("b").html($("input[name="+file_name+"]").parents("b").html());
			}
			if (error_function != undefined  && error_function != null) {
				error_function(response);
			}
		},
		complete : function(xmlData, textStatus) {
			if(loading) {
				AjaxLodingStop();
			}
		}
	});
}




//페이징 페이지 이동 함수. incPageNavi.jsp에서 사용
//data: pageNum : 페이지 번호
//Edited by 오세현 2012.11.06
function GoPageNum(pageNum) {
	
	var url = window.location.pathname;
	var frm = document.frmPage;
	frm.method = "get";
	frm.action = url;
	
	frm.PAGENUM.value = pageNum;
	frm.submit();
}

//메뉴 이동 함수. incTopMenu.jsp에서 사용
//data: url : 메뉴url, menuid : 메뉴id, store_id : 스토어id, store_nm : 스토어 명
//Edited by 최경환 2012.12.26
function GoMenuPage(url, top_menuid, cur_menuid, menutype, menu_auth) {
	if(menu_auth=='N'){
		alert("메뉴 권한이 없습니다.");
		return;
	}
	
	GoPage(url, null, top_menuid, cur_menuid, menutype);
}

//페이지 이동 함수. 페이지 이동시 Post 방식으로 이동
//params : 전송 데이터 {'q':'a','s':'b','c':'d'...}으로 묶어서 배열 입력
//Edited by 오세현 2012.11.08
function GoPage(url, params, top_menuid, cur_menuid, menutype) {
	
	var frm = document.createElement("form");
	frm.setAttribute("method", "get");
	frm.setAttribute("action", url);
	
	if (typeof params == 'string') {
		var strJson = ToJsonString(params);
		if (strJson.length > 0) {
			params = JSON.parse(strJson);
		}
	}
	
	var inputTopMenuId = document.createElement("input");
	inputTopMenuId.setAttribute("type", "hidden");
	inputTopMenuId.setAttribute("name", "TMENUID");
	inputTopMenuId.setAttribute("value", top_menuid);
	frm.appendChild(inputTopMenuId);
	
	var inputCurMenuId = document.createElement("input");
	inputCurMenuId.setAttribute("type", "hidden");
	inputCurMenuId.setAttribute("name", "SMENUID");
	inputCurMenuId.setAttribute("value", cur_menuid);
	frm.appendChild(inputCurMenuId);
	
	for(var key in params) {
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", key);
		hiddenField.setAttribute("value", params[key]);
		frm.appendChild(hiddenField);
	}	
	
	document.body.appendChild(frm);
	frm.submit();
}

//url parameter 형식을 json string으로 변환
//string : 예) aaa=bbb&ccc=ddd
//Edited by 오세현 2012.11.30
function ToJsonString(string) {
	if (typeof string != 'string') {
		return;
	}
	var retStr = '';
	var arr1 = string.split("&");
	for(var i=0; i<arr1.length; i++) {
		var arr2 = arr1[i].split("=", 2);
		if (arr2.length == 2) {
			if (retStr.length > 0) {
				retStr += ',';
			}
			retStr = retStr + '"' + arr2[0] + '":"' + arr2[1] + '"'; 
		}
	}
	if (retStr.length > 0) {
		retStr = '{' + retStr + '}';
	}
	return retStr;
}

//table에 동적으로 row를 추가하는 함수
//tableid : table의 id
//params : {
//		'attr_1':'a',  <-- attr은 tr의 attribute로 a를 attribute명으로 xml의 a값을 value로 추가, xml이 없으면 attr_1을 attribute명으로 a를 value로 추가 
//		'attr_2':'b',  <-- 1, 2는 attr의 인덱스 새로운값이 있을때마다 하나씩 증가
//		'cols_1':'c',  <-- cols는 td안에 텍스트로 xml의 c값을 입력, xml이 없으면 c를 입력
//		'cols_2':'d',  <-- 1, 2는 td의 인덱스 
//		'html_1':'e',  <-- html은 td안에 html을 입력
//		'html_2':'f',  <-- 1,2는 td의 인덱스
//		'clas_1':'num; <-- 첫번째 td에 num 클래스 추가
//		'zz':'qq'	   <-- 위의 param 정의 외의 값은 tr의 attribute로 추가 하며, zz를 attribute명으로 qq를 value로 추가 
//		}
//click_event: tr 클릭시 클릭 이벤트 처리 함수
//			       없을시는 ClickTable을 호출한다. 
//			       이벤트 처리 함수를 사용시 함수내에서 ClickTable을 호출할것
//xml: xml의 item, null가능
//Edited by 오세현 2012.11.22
function AddTableXml(tableid, params, click_event, xml) {
	
	var isXml = true;
	var objTable = document.getElementById(tableid);
	var rowIndex = objTable.rows.length;
	var newRow = objTable.insertRow(rowIndex);
	var colLength = objTable.rows[0].cells.length;
	
	if (colLength <= 0) {
		return;
	}
	
	if (xml == undefined || xml == null) {
		isXml = false;
	}

	var clickFunc = click_event;
	if (click_event == undefined || click_event == null || click_event == '') {
		clickFunc = ClickTable;	
	} 
	
	if (window.attachEvent) {
		newRow.attachEvent("onclick", clickFunc);
	} else if(newRow.addEventListener) {
		newRow.addEventListener('click', clickFunc, false);
	}
	newRow.style.cursor = "pointer";
	
	for(var i=0; i<colLength; i++) {
		newRow.insertCell(0);
	}	
	
	if (typeof params == 'string') {
		var strJson = ToJsonString(params);
		if (strJson.length > 0) {
			params = JSON.parse(strJson);
		}
	}
	
	for(var key in params) {
		
		var keyword = key.substring(0, 4);
		var colsIndex = key.substring(5,key.length) - 1;
		switch (keyword) {
			case "attr":
				if (isXml) {
					var newAttr = document.createAttribute(params[key]);
    				newAttr.nodeValue = xml.find(params[key]).text();
    				newRow.setAttributeNode(newAttr);
				} else {
					var newAttr = document.createAttribute(key);
					newAttr.nodeValue = params[key];
					newRow.setAttributeNode(newAttr);
				}
				break;
				
			case "cols":
				if (newRow.cells[colsIndex] == undefined) {
					break;
				}
				if (isXml) {
					newRow.cells[colsIndex].innerHTML = xml.find(params[key]).text();
				} else {
					newRow.cells[colsIndex].innerHTML = params[key];	
				}	
				break;
				
			case "clas":
				if (newRow.cells[colsIndex] == undefined) {
					break;
				}
				var newAttr = document.createAttribute("class");
				newAttr.nodeValue = params[key];
				newRow.cells[colsIndex].setAttributeNode(newAttr);
				break;
			
			case "html":
				if (newRow.cells[colsIndex] == undefined) {
					break;
				}
				newRow.cells[colsIndex].innerHTML = params[key];
				break;
				
			default:
				var newAttr = document.createAttribute(key);
				newAttr.nodeValue = params[key];
				newRow.setAttributeNode(newAttr);
				break;
		}
	}
}

//테이블 클릭시 클릭한 테이블의 row 색상 변경
//return 값으로 클릭한 row를 반환
//Edited by 오세현 2012.11.22
function ClickTable(e) {
	var e=e? e : window.event;
	var clickRow=e.target? e.target : e.srcElement;
	
	while (clickRow.tagName != "TR" && clickRow != undefined && clickRow != null) {
		clickRow = clickRow.parentElement;
	}
	if (clickRow == undefined || clickRow == null) {
		return null;
	}
	
	var tableObj = clickRow.parentElement;
	while (tableObj.tagName != "TABLE" && tableObj != undefined && tableObj != null) {
		tableObj = tableObj.parentElement;
	}
	for(var i=1; i<tableObj.rows.length; i++) {
		tableObj.rows[i].style.backgroundColor = "#ffffff";
	}
	clickRow.style.backgroundColor = "#f8cea0";
	return clickRow;
}

//table의 헤더를 제외한 row를 삭제
//tableid: table의 id
//Edited by 오세현 2012.11.22
function ClearTable(tableid) {
	var objTable = document.getElementById(tableid);
	var rowCount = objTable.rows.length;
	for(var i=1; i<rowCount; i++) {
		objTable.deleteRow(1);
	}
}

//table의 선택한 row를 삭제
//tableid: table의 id
//Edited by 오세현 2012.11.26
function DeleteTable(tableid) {
	var tableObj = document.getElementById(tableid);
	for(var i=1; i<tableObj.rows.length; i++) {
		if(tableObj.rows[i].style.backgroundColor == "rgb(51, 102, 153)") {
			tableObj.deleteRow(i);
		}
	}
}

//text의 byte 채크
//objID: byte 채크할 input id
//objTargetID: byte 길이를 표시할 태그 id
//intMaxBytes: byte 최대길이
//$('#file_url_url').keyup(function() {
//	CheckByte(this.id, 'file_url_url_byte', 1024);
//});
function CheckByte(objID, objTargetID, intMaxBytes, alert_yn)
{   
    var len = 0, j, i;
    var strCurrentText = document.getElementById(objID).value;
    for (i = 0, j = strCurrentText.length; i < j; i++) 
    {
    	if (strCurrentText.charCodeAt(i) != 13) {
    		len++;
    	}
    	
        if ((strCurrentText.charCodeAt(i) < 0) || (strCurrentText.charCodeAt(i) > 127) ||(strCurrentText.charCodeAt(i) == 10))
        {      
            len = len + 1;     
        }
        
        if (len > intMaxBytes) 
        {
        	if (alert_yn == undefined || alert_yn == null || alert_yn.toLowerCase() != "n") {
        		document.getElementById(objID).blur();
//        		LayerAlert(intMaxBytes + "Bytes 까지 입력가능합니다.");
        		document.getElementById(objID).value = strCurrentText.substring(0, i);
        		if ((strCurrentText.charCodeAt(i) < 0) || (strCurrentText.charCodeAt(i) > 127))
                    len = len - 2;     
        		else
        			len = len - 1;
        		$("#"+objTargetID).text(len);
                //document.getElementById(objID).readOnly = true;
                return;                
        	}
        }
//        document.getElementById(objTargetID).textContent = len + 1;
    }
    $("#"+objTargetID).text(len);
}


//ajax 호출시 로딩중 layer 호출
//Edited by 오세현 2012.11.22
function AjaxLodingStart(){
	var maskHeight = $(document).height(); 
    var maskWidth = $(document).width(); 
    maskHeightMar = maskHeight * 1 / 2;
    maskWidthMar = maskWidth * 1 / 2;
    maskHeightMar = maskHeightMar - 100;
    maskWidthMar = maskWidthMar - 100;
    $('#CommonMaskLayer').css({'width':maskWidth,'height':maskHeight});
    $('#CommonMaskLayerImg').css({'margin-left':maskWidthMar,'margin-top':maskHeightMar, 'padding':0});
    $('#CommonMaskLayer').fadeIn('fast');
    $('#CommonMaskLayer').fadeTo("fast", 0.6);
}

//로딩중 layer hidden
//Edited by 오세현 2012.11.22
function AjaxLodingStop(){
    $('#CommonMaskLayer').fadeOut('fast');
}

//Alert layer 호출
//message: alert message
//click_event: 확인시 호출 함수, null가능
//Edited by 오세현 2012.11.22
function LayerAlert(message, click_event)
{
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();    
	$('#mask').css({'width':maskWidth,'height':maskHeight});     
	$('#mask').fadeTo("fast",0.5);  
	
	var winH = $(window).height();
	var winW = $(window).width();
	$('#layer_alert').css('top',  winH/2-$('#layer_alert').height()/2);
	$('#layer_alert').css('left', winW/2-$('#layer_alert').width()/2);
	$('#layer_alert').fadeIn(2000);
	
	$('#CommonAlertLayerMessage').empty().append(message);
	$('#CommonAlertLayerBtnConfirm').focus();
	
	$('#mask').unbind('click');
	$('#CommonAlertLayerBtnConfirm').unbind('click');
	$("#close_layer_alert").unbind('click');
	
	$('#mask').bind('click', function() {
		$('#mask').hide();
		$('#layer_alert').hide();

		if(click_event != undefined && click_event != null) {
			click_event();
		}
	});
	$('#CommonAlertLayerBtnConfirm').bind('click', function() {
		$('#mask').hide();
		$('#layer_alert').hide();
		
		if(click_event != undefined && click_event != null) {
			click_event();
		}
	});
	$("#close_layer_alert").bind('click',function(){
		$('#mask, .popup_alert').hide();
	});
}

//Confirm layer 호출
//message: confirm message
//confirm_event: 확인시 호출 함수, null가능
//cancel_event: 취소시 호출 함수, null가능
//Edited by 오세현 2012.11.23
function LayerConfirm(message, confirm_event, cancel_event)
{
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();    
	$('#mask').css({'width':maskWidth,'height':maskHeight});     
	$('#mask').fadeTo("fast",0.5);  
	
	var winH = $(window).height();
	var winW = $(window).width();
	$('#layer_confirm').css('top',  winH/2-$('#layer_confirm').height()/2);
	$('#layer_confirm').css('left', winW/2-$('#layer_confirm').width()/2);
	$('#layer_confirm').fadeIn(2000);
	
	$('#CommonConfirmLayerMessage').empty().append(message);
	$('#CommonConfirmLayerBtnConfirm').focus();
	
	$('#mask').unbind('click');
	$('#CommonConfirmLayerBtnConfirm').unbind('click');
	$('#CommonConfirmLayerBtnCancel').unbind('click');
	$("#close_layer_confirm").unbind('click');
	
	$('#mask').bind('click', function() {
		$('#mask').hide();
		$('#layer_confirm').hide();

		if (cancel_event != undefined && cancel_event != null) {
			cancel_event();
		}
	});
	
	$('#CommonConfirmLayerBtnConfirm').bind('click', function() {
		$('#mask').hide();
		$('#layer_confirm').hide();
		
		if (confirm_event != undefined && confirm_event != null) {
			confirm_event();
		}
	});

	$('#CommonConfirmLayerBtnCancel').bind('click', function() {
		$('#mask').hide();
		$('#layer_confirm').hide();
		
		if (cancel_event != undefined && cancel_event != null) {
			cancel_event();
		}
	});
	$("#close_layer_confirm").bind('click',function(){
		$('#mask, .popup_alert').hide();
	});
}

//Layer Popup 호출 함수
//Edited by 오세현 2012.12.14
function OpenLayer(objid, close_function) {
	var id = '#' + objid;
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	//Set height and width to mask to fill up the whole screen
	
	$('#mask').css({'width':maskWidth,'height':maskHeight});
	
	//transition effect     
	//$('#mask').fadeIn(1000);    
	$('#mask').fadeTo("fast",0.5);  
	var winH = $(window).height();
	var winW = $(window).width();
	
	//Set the popup window to center
	$(id).css('top',  winH/2-$(id).height()/2);
	$(id).css('left', winW/2-$(id).width()/2);

	//transition effect
	$(id).fadeIn(2000); 	
	
	$('.popup_alert .close').unbind('click');
	$('#mask').unbind('click');
	$(id+"_layer").unbind('click');
	
	$('.popup_alert .close').bind('click', function() {
		$('#mask, .popup_alert').hide();
		if (close_function != undefined && close_function != null) {
			close_function();
		}
	});
	
	$('#mask').bind('click', function() {
		$('#mask, .popup_alert').hide();
		if (close_function != undefined && close_function != null) {
			close_function();
		}
	});
	
	$(id+"_layer").bind('click',function(){
		$('#mask, .popup_alert').hide();
	});
}

function CloseLayer() {
	$('#mask, .popup_alert').hide();
}
  


//YYYY-MM-DD 형식으로 날짜반환
//yy(년),mm(월),dd(일) int형 오늘날짜에서 변경된 날짜값 반환
function getDate(div,yy,mm,dd){
	if(div==null)div="";
	if(yy==null)yy=0;
	if(mm==null)mm=0;
	if(dd==null)dd=0;
	var cDate = new Date();
	var date = new Date(cDate.getFullYear()+yy,cDate.getMonth()+mm,cDate.getDate()+dd);
	var year = date.getFullYear();
	var month = (date.getMonth()+1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1);
	var day = date.getDate()<10?"0"+date.getDate():date.getDate();
	return year+div+month+div+day;
}


String.prototype.cut = function(len) {
    var str = this;
    var l = 0;
    for (var i=0; i<str.length; i++) {
            l += (str.charCodeAt(i) > 128) ? 2 : 1;
            if (l > len) return str.substring(0,i) + "..";
    }
    return str;
};

function getParam(form) {
	var param = {};
	var inputLen = form.elements.length;
	for(var i=0; i<inputLen; i++) {
		var obj = form.elements[i];
		var name = obj.getAttribute("name");
		var type = getString(obj.getAttribute("type")).toUpperCase();

		if (getString(name)!="") {
			if (type != 'RADIO' || (type == "RADIO" && obj.checked)) {
				param[name] = obj.value;
			}			
		}		
	}
	return param;	
}

function getString(value) {
	if(value == null || value == undefined) {
		return "";
	}	
	return $.trim(value);
}
