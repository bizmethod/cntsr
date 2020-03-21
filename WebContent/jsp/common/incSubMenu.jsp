<%--
  - Author      : 김현우
  - Date        : 2014. 06. 24
  - Description : 페이징, ajax 호출등 샘플 페이지
  - Edited      :   
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		<div class="snb">
			<ul>
				<c:forEach var="smenu" items="${smenu}">
				<li<c:if test="${smenu.MENU_ID == SMENUID}"> class="on"</c:if> id="snb_li"><a href="#" onclick="GoMenuPage('${pageContext.request.contextPath}${smenu.URL}', '${TMENUID}', '${smenu.MENU_ID}', '', '')"><c:out value="${smenu.MENU_NM}"/></a></li>
					<c:forEach var="smenu2" items="${smenu2}">
						<c:if test="${smenu2.PARENT_ID == smenu.MENU_ID}">
							<li<c:if test="${smenu2.MENU_ID == SMENUID}"> class="on"</c:if> style="margin-left: 20px; font-size: 10px;"><a href="#" onclick="GoMenuPage('${pageContext.request.contextPath}${smenu2.URL}', '${TMENUID}', '${smenu2.MENU_ID}', '', '')"><c:out value="${smenu2.MENU_NM}"/></a></li>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
		<!-- // snb -->
		
