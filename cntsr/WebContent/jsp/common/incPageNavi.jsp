<%--
  - Author      : 오세현
  - Date        : 2012. 11. 06
  - Description : 페이지 네비게이션 
  - Edited      : <다음 수정시 수정자와 수정일을 입력 ex)오세현 2012.10.19>  
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	StringBuffer sbPageNavi = new StringBuffer();

	Integer nTotalCount = (Integer)((request.getAttribute("PAGE_TOTALCOUNT") == null)? 0 : request.getAttribute("PAGE_TOTALCOUNT"));
	Integer nPageSize = (Integer)((request.getAttribute("PAGE_PAGESIZE") == null)? 0 : request.getAttribute("PAGE_PAGESIZE"));
	Integer nPageNum = (Integer)((request.getAttribute("PAGE_PAGENUM") == null)? 0 : request.getAttribute("PAGE_PAGENUM"));
	Integer nBlockSize = (Integer)((request.getAttribute("PAGE_BLOCK_SIZE") == null)? 0 : request.getAttribute("PAGE_BLOCK_SIZE"));
	

	Integer nTotalPageCount = 0;
	Integer nTotalBlockCount = 0;
	Integer nBlockNum = 1;
	Integer nFirstPage = 1;
	Integer nLastPage = 1;

	nTotalPageCount = (int)Math.ceil((double)nTotalCount / nPageSize);
	nTotalBlockCount = (int)Math.ceil((double)nTotalPageCount / nBlockSize);
	nBlockNum = (int)Math.ceil((double)nPageNum / nBlockSize);
	nFirstPage = (nBlockNum-1)*nBlockSize+1;
	nLastPage = nBlockNum*nBlockSize;

	if(nTotalBlockCount <= nBlockNum) {
		nLastPage = nTotalPageCount;
	}
	
	if(nBlockNum > 1) {
		sbPageNavi.append(" <a href=\"javascript:GoPageNum('" + (nFirstPage-1) + "');\" ><img src=\""+request.getContextPath()+"/common/images/btn/page_Beginning.gif\" alt=\"Beginning\" /></a> ");
	}
	
	if(nPageNum >= nFirstPage && nBlockNum > 1) {
		sbPageNavi.append(" <a href=\"javascript:GoPageNum('" + (nPageNum-1) + "');\" ><img src=\""+request.getContextPath()+"/common/images/btn/page_Prev.gif\" alt=\"Prev\" /></a> ");
	}
	
	for(int i=nFirstPage; i<=nLastPage; i++){
		//if(i>(nFirstPage)) {
		//	sbPageNavi.append(" ");
		//}
		if(i==nPageNum) {
			sbPageNavi.append(" <strong>" + i + "</strong> ");
		} else {
			sbPageNavi.append(" <a href=javascript:GoPageNum('" + i + "');>" + i + "</a> ");
		}
	}

	if(nPageNum <= nLastPage && nBlockNum < nTotalBlockCount) {
		sbPageNavi.append(" <a href=\"javascript:GoPageNum('" + (nPageNum+1) + "');\"><img src=\""+request.getContextPath()+"/common/images/btn/page_Next.gif\" alt=\"Next\" /></a> ");
	}
	
	if(nBlockNum < nTotalBlockCount) {
		sbPageNavi.append(" <a href=\"javascript:GoPageNum('" + (nLastPage+1) + "');\"><img src=\""+request.getContextPath()+"/common/images/btn/page_End.gif\" alt=\"End\" /></a> ");
	}
	
	request.setAttribute("PAGE_NAVI", sbPageNavi.toString());

%>		