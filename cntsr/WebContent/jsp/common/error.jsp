<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>에러 메세지</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>

<body topmargin="100">

<DIV id="wrap" style="padding-top:100px;"> 
<table cellpadding="0" cellspacing="0" width="954" border="0" class="text" bgcolor="FFFFFF">
	<tr>
		<td ALIGN="CENTER">
			<table cellpadding="0" cellspacing="0"  class="text"  border="0"  bgcolor="FFFFFF">
				<tr>
					<td width="50%"></td>
					<td></td>
					<td width="50%"></td>
				</tr>
				<tr>
					<td height="51"></td>
					<td  rowspan="3"  height="165" valign="top" ></td>
					<td></td>
				</tr>
            <tr>
            	<td height="51" bgcolor="F0F0F0"></td>
            	<td bgcolor="F0F0F0"></td>
            </tr>
            <tr>
            	<td height="64"></td>
            	<td></td>
            </tr>
            <tr>
           <td></td>
           <td  height="1" bgcolor="CCCCCC"></td>
           <td></td>
           </tr>
              <tr>
            <td height="168"></td>
            <td style="padding:10px;"  valign="top"  width="474" style="padding-top:10px">
			
			<c:out value="${ERROR.error_msg}"></c:out>

            </td>
            <td></td>
           </tr>
        </table>     
 </td>
</tr>

<tr>
<td>
<!--bottom 시작 -->

<!--bottom  끝 -->
</td>
</tr>
</table>
</DIV>
</body>
</html>
