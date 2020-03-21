<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
  <head>  
     <jsp:include page="head.jsp"></jsp:include>
     <title>${mainTitle}</title>
  </head>  	 
  <body>
  <jsp:include page="header.jsp"></jsp:include>
  <jsp:include page="body.jsp"></jsp:include>
  <jsp:include page="footer.jsp"></jsp:include>
  <jsp:include page="Bootstrap.jsp"></jsp:include>
  </body>
  
</html>