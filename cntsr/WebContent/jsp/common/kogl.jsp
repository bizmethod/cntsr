<%--
  - Author      : 김현우
  - Date        : 2014. 07. 21
  - Description : 공공누리 include
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>  
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="table_detail">
 <!--  기존 게시물 입력 항목에 아래의 내용을 추가 합니다.  -->
 <!--  공공저작물 자유이용 처리  -->
	<colgroup>
		<col style="width:20%" />
		<col style="width:80%" />
	</colgroup>
 	<tr height="30"> 
	   	<td><span><b><a href="http://www.kogl.or.kr/open/info/kogl.do" target="_blank">공공저작물 자유이용</a></b></span></td>
	  	<td>
		   	<span> 
		   		<p><b>출처를 표시하시겠습니까?</b></p><br>
		   		<input type="radio" name="kogl_open" id="kogl_open1" value="Y" <c:if test="${map.get('KOGL_OPEN_YN') == 'Y' || map.get('KOGL_OPEN_YN') == null}">checked="checked"</c:if>><label for="kogl_open1"> 적용함</label>
		   		<input type="radio" name="kogl_open" id="kogl_open2" value="N" <c:if test="${map.get('KOGL_OPEN_YN') == 'N'}">checked="checked"</c:if>><label for="kogl_open2"> 적용안함</label>
		    </span>
	    </td>
	 </tr>
	 <tr height="30"> 
	   <td rowspan="2"><span><b><a href="http://www.kogl.or.kr/open/info/license.do" target="_blank">공공저작물 유형선택</a></b></span></td>
	   <td>
	   		<span>
	   		  	<p><b>상업적 이용표시를 허락하시겠습니까?</b></p><br>
		      	<input type="radio" name="kogl_B" id="kogl_B1" value="Y" <c:if test="${map.get('KOGL_B_YN') == 'Y'}">checked="checked"</c:if>><label for="kogl_B1"> 상업적, 비상업적 이용 가능 </label>
		      	<input type="radio" name="kogl_B" id="kogl_B2" value="N" <c:if test="${map.get('KOGL_B_YN') == 'N' || map.get('KOGL_B_YN') == null}">checked="checked"</c:if>><label for="kogl_B2"> 비상업적만 이용 가능 </label>
			</span>
	    </td>
	 </tr>
	 <tr height="30"> 
	    <td>
	    	<span>
	    		<p><b>변경을 허용하시겠습니까? </b></p><br>
		      	<input type="radio" name="kogl_M" id="kogl_M1" value="Y" <c:if test="${map.get('KOGL_M_YN') == 'Y'}">checked="checked"</c:if>><label for="kogl_M1"> 변형 등 2차적 저작물 작성이 가능 </label> 
		      	<input type="radio" name="kogl_M" id="kogl_M2" value="N" <c:if test="${map.get('KOGL_M_YN') == 'N' || map.get('KOGL_M_YN') == null}">checked="checked"</c:if>><label for="kogl_M2"> 변형 등 2차적 저작물 작성 금지 </label> 
	    	</span>
	    </td>
	 </tr>
	 <tr height="30"> 
	 	<td><span><b>공공누리 연계여부</b></span></td>
	    <td>
	    	<span>
		      	<input type="radio" name="kogl_con" id="kogl_C1" value="Y" <c:if test="${map.get('KOGL_CON_YN') == 'Y'}">checked="checked"</c:if>><label for="kogl_C1"> 연계 </label> 
		      	<input type="radio" name="kogl_con" id="kogl_C2" value="N" <c:if test="${map.get('KOGL_CON_YN') == 'N' || map.get('KOGL_CON_YN') == null}">checked="checked"</c:if>><label for="kogl_C2"> 미연계 </label> 
	    	</span>
	    </td>
	 </tr>
	<!-- 공공저작물 자유이용 처리 끝-->  
	 <tr class="last">
		<td colspan="2" />
	</tr>
</table> 
