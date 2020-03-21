<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!--  -->
	<meta charset="utf-8" />
    <!-- 문자 코드의 종류 설정
    EUC-KR / ISO-2022-KR : 한국어 문자 인코딩
	EUC-JP / ISO-2022-JP : 일본어 문자 인코딩
	GB2312 : 중국어 문자 인코딩
	ISO-8859-1 : 북미, 서부유럽, 라틴 아메리카, 카리브해, 캐나다, 아프리카
	ISO-8859-2 : 동유럽
	ISO-8859-3 : 남동유럽, 에스페란토
	ISO-8859-4 : 스칸디나비아, 발트 연안국
	ISO-8859-5 : 불가리아어, 벨로루시어, 러시아어, 마케도니아
	ISO-8859-6 : 아랍문자
	ISO-8859-7 : 현대 그리스문자 언어뿐 만 아니라 수학 기호
	ISO-8859-8 : 히브리어 문자를 사용하는 언어
	ISO-8859-9 : 터키어
	ISO-8859-10 : 에스키모, 북유럽 언어
	UTF-8, UTF-16, UTF-32  : 모든 언어의 문자를 지원하는 인코딩
	브라우저 호환성을 지정  -->
    <meta 
    	http-equiv="X-UA-Compatible"
		content="IE=edge" />
	<!--  -->
    <meta
		name="viewport"
		content="width=device-width, initial-scale=1" />
	<!-- 검색 로봇 제어
	All(기본값) : 'index, follow' 를 지정한 것과 같습니다.
	None : 'noindex, nofollow' 를 지정한 것과 같습니다.
	Index : 그 페이지를 수집 대상으로 합니다.
	Follow : 그 페이지를 포함해 링크가 걸린 곳을 수집 대상으로 합니다.
	Noindex : 그 페이지를 수집대상에서 제외합니다.
	Nofollow : 그페이지를 포함해 링크가 걸린 곳을 수집 대상으로 하지 않습니다.
	-->
	<meta name="Robots" content="noindex, nofollow" />
	<!-- 검색 결과에 표시되는 문자를 지정합니다.  -->
    <meta name="description" content="" />
    <!-- 키워드 검색 엔진에 의해 검색되는 단어를 지정합니다. -->
    <meta name="Keywords" content="" />
    <!-- 날짜(제작일)  -->
    <meta name="Date" content="" />
	<!-- 홈페이지 주제를 지정  -->
	<meta http-equiv="Subject" content="" />
	<!--  페이지 제목을 지정  -->
	<meta http-equiv="Title" content="${mainTitle}" />
	<!-- 페이지를 작성한 제작자명  -->
	<meta http-equiv="Author" content="" />
	<!-- 제작사  -->
	<meta http-equiv="Publisher" content="" />
	<!-- 웹 책임자  -->
	<meta http-equiv="Other Agent" content="" />
	<!-- 제작 도구  -->
	<meta http-equiv="Generator" content="springframework" />
	<!-- 메일  -->
	<meta http-equiv="Reply-To" content="naver@naver.com" />
	<meta http-equiv="Email" content="naver@naver.com" />
	<!-- 파일 이름  -->
	<meta http-equiv="Filename" content="main.jsp" />
	<!-- 위치  -->
	<meta http-equiv="Location" content="" />
	<!-- 베포지 -->
	<meta http-equiv="Distribution" content="" />
	<!-- 저작권 // 메일주소 -->
	<meta http-equiv="Copyright" content="" />
	<!--  제작 년,월,일을 지정  -->
	<meta http-equiv="Build" content="" />
	<!--  최종 수정일  -->
	<meta http-equiv="Last-Modified" content="Mon,20 Jul 2016 19:30:30" />
	<!--  그림 위에 마우스 오버시 이미지 관련 툴바를 생기지 않도록 하기 위해 지정  -->
	<meta http-equiv="imagetoolbar" content="no" />
	<!-- 캐쉬가 되지 않도록 하기 위해 정의  -->
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<!-- 캐쉬 만료일을 정의 -->
	<meta http-equiv="Expires" content="Mon, 08 Sep 2016 10:10:10 GMT" />
	<!-- 60초마다 새로고침을 정의  -->
	<meta http-equiv="Refresh" content="60" />
	<!-- 입력한 주소로 5초후 이동하는 것을 정의  -->
	<meta http-equiv="Refresh" content="5;url=주소" />
	<!-- 페이지 들어갈 때 장면 전환 효과
	Box out : 네모난 박스가 안쪽에서 바깥쪽으로
	Circle in : 원이 바깥에서 안쪽으로
	Circle out : 원이 안쪽에서 바깥쪽으로
	Wipe up : 이미지의 아래에서 위쪽으로 수직 이동
	Wipe down : 이미지의 위에서 아래쪽으로 수직 이동
	Wipe right : 이미지의 왼쪽에서 오른쪽으로 수평 이동
	Wipe left : 이미지의 오른쪽에서 왼쪽으로 수평 이동
	Vertical blinds : 수직 블라인드가 쳐지는 형태로 변환
	Horizontal blinds : 수평 블라인드가 쳐지는 형태로 변환
	Checkerboard across : 바둑판 형태의 격자가 왼쪽에서 오른쪽으로 생성
	Checkerboard down : 바둑판 형태의 격자가 위에서 아래로 생성
	Random dissove : 안개와 비슷한 형태로 전환
	Split vertical in : 왼쪽과 오른쪽 끝에서 중앙으로 수직 이동
	Split vertical out : 중앙에서 양쪽 끝으로 수직 이동
	Split Horizontal in : 양쪽에서 중앙으로 수평 이동
	Split Horizontal out : 중앙에서 양쪽끝으로 수직이동
	Strips left down : 대각선 형태로 오른쪽 상단에서 왼쪽 하단으로 이동
	Strips left up : 대각선 형태로 오른쪽 하단에서 왼쪽 상단으로 이동
	Strips right down : 대각선 형태로 왼쪽 상단에서 오른쪽 하단으로 이동
	Strips right up : 대각선 형태로 왼쪽 하단에서 오른쪽 상단으로 이동
	Random bars horizontal : 수평선이 무작위로 생성
	Random bars vertical : 수직선이 무작위로 생성
	Random : 임의로 생성
	-->
	<meta http-equiv="Page-Enter" content="revealtrans(Duration=1,Transition=12)" />