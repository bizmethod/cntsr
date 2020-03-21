<%--
  - Author      : 김현우
  - Date        : 2014. 06. 24
  - Description : Jsp 페이지 하단 include
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>  
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		</div>
		<!-- // content -->

		<div id="footer">
			<address>${FOOTER1}</address>
			<p class="policy">${FOOTER2}</p>
			<p class="policy">익스플로러 8이상, 크롬 브라우저에서 정상작동합니다.</p>
		</div>
		<!-- // footer -->
		
	</div>
	<!-- // container -->
</div>
</body>
</html>

<div id="CommonMaskLayer" style="display: none; width: 100%; height: 100%; position:absolute; left:0; top:0; z-index:15000; background-color:white;" >
	<div id="CommonMaskLayerImg" style="top: 50%; left: 50%" ><img src="${pageContext.request.contextPath}/common/images/ajax-loader.gif" alt="" /></div>
</div>

<!-- popup_alert -->
<div id="mask"></div>
<div id="layer_alert" class="popup_alert">
	<div><img src="${pageContext.request.contextPath}/common/images/btn/close.png" style="height:16px; width:16px; cursor:pointer; float:right; padding-right:15px; padding-top:15px;" alt="close" id="close_layer_alert"/></div>
	<div class="wrap_popup_alert">
		<p class="con_alert" id='CommonAlertLayerMessage'></p>
		<div class="footer_alert">
		  <a id='CommonAlertLayerBtnConfirm' class="btn_alert first" style="cursor:pointer">확인</a>
		</div>
	</div>
	<!-- // wrap_popup_alert -->
</div>
<div id="layer_confirm" class="popup_alert">
	<div class="wrap_popup_alert">
		<div><img src="${pageContext.request.contextPath}/common/images/btn/close.png" style="height:16px; width:16px; cursor:pointer; float:right; padding-right:10px; padding-top:10px;" alt="close" id="close_layer_confirm"/></div>
		<p class="con_alert" id='CommonConfirmLayerMessage'></p>
		<div class="footer_alert">
		  <a id='CommonConfirmLayerBtnConfirm' class="btn_alert first" style="cursor:pointer">확인</a>
		  <a id='CommonConfirmLayerBtnCancel' class="btn_alert close" style="cursor:pointer">취소</a>
		</div>
	</div>
	<!-- // wrap_popup_alert -->
</div>
<!-- // popup_alert -->
<script>
//새로고침시 메인으로 이동하지 않고 현재 페이지 새로고침
document.onkeydown = function(e) {
	var evtK = (e) ? e.which : window.event.keyCode;
	var isCtrl = ((typeof isCtrl != 'undefiend' && isCtrl) || ((e && evtK == 17) || (!e && event.ctrlKey))) ? true : false;
	
	if((isCtrl && evtK == 82) || evtK == 116) {
		if(e) { evtK = 505; } else { event.keyCode = evtK = 505; }
	}
	
	if(evtK == 505) {
	 // 자바스크립트에서 현재 경로는 받아내는 메소드로 대치.
		location.reload(location.href);
		return false;
	}
}
</script>