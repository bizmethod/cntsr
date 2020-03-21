package mcommercelab.cntsr.common;

import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.spring.web.servlet.view.JsonView;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mcommercelab.cntsr.dao.CommonDaoImpl;
import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;
import mcommercelab.cntsr.web.login.LoginService;
import mcommercelab.cntsr.web.login.SessionInfo;

/**
 * <pre>
 * squarenet.smartq.common
 * ParamCheck.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2012. 10. 24.
 * @Version	:	JDK 1.6.0
 * @Description	:	?��?��미터�? 체크?���? mvc 리턴???��?�� 결정?��?��.
 * 					Edited by osh, 12-11-06 - ?��?���? �??�� 기능 추�?
 */
public class MVController {
	
	CommonDaoImpl cd = null;
	
	private ModelAndView mv;
	protected static Log logger = LogFactory.getLog(AbstractAuthCheckInterceptor.class);
	
	private int PAGENUM = 1;
	
	public MVController() {}
	
	public MVController(CommonDaoImpl cd){
		this.cd = cd;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc 객체?��?��
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void setModelAndView(String url){
		mv = new ModelAndView(url);
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc 객체 json?���? ?��?��
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void setJsonModelAndView(){
		JsonView jv = new JsonView();
		jv.setContentType("text/html;charset=UTF-8");
		mv = new ModelAndView(jv);
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc addObject
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void setaddObject(Object attributeValue){
		mv.addObject(attributeValue);
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc getObject
	 * </pre>
	 * @Date	:	2014. 1. 9.	
	 * @Return	:	Object
	 */
	public Object getObject(String key){
		return mv.getModel().get(key);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void setaddObject(HashMap hmap) {
		String[] keys = (String[]) hmap.keySet().toArray(new String[0]);
		
		for (String key : keys) {
			Object value = hmap.get(key);
			mv.addObject(key, value);
		}
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc addObject
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	void
	 */
	public void setaddObject(String attributeName, Object attributeValue){
		mv.addObject(attributeName, attributeValue);
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : mvc return
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	ModelAndView
	 */
	public ModelAndView getModelAndView(){
		return mv;
	}
	
    /**
     * <pre>
     * 처리?��?�� : ?��?��미터�? 받아?�� 리턴
     * </pre>
     * @Date	:	2012. 10. 24.	
     * @Return	:	HashMap<String,String>
     */
    @SuppressWarnings("rawtypes")
	public HashMap<String, String> handleRequest (HttpServletRequest request) throws Exception, IllegalStateException {
		if (mv == null) {
			logger.debug("mv is null -----------------------------");
			mv = new ModelAndView("");
		}
    	HashMap<String, String> params = new HashMap<String, String>();
		String value = "";
		Enumeration enu = request.getParameterNames();
		while(enu.hasMoreElements()){
			String param =(String)enu.nextElement();
			if(request instanceof MultipartHttpServletRequest)
				value = StringRequest(new String(request.getParameter(param).getBytes("iso-8859-1"), "utf-8"));
			else{
				if(param.indexOf("ncprm")>=0){
					value = request.getParameter(param);
				}
				else
					value = StringRequest(request.getParameter(param),param);
			}
			if(value == null) value = "";
			logger.debug(param + "----" + value);
			params.put(param, value);
		}
		SessionInfo sessionInfo = LoginService.getSessionInfo(request);
		String userId = "";
		if (sessionInfo != null) {
			userId = StaticClass.isNull(sessionInfo.getUserId());
			params.put("USER_ID", StaticClass.isNull(sessionInfo.getUserId()));
			params.put("USER_NM", StaticClass.isNull(sessionInfo.getUserNm()));
						
			setaddObject("USER_ID", StaticClass.isNull(sessionInfo.getUserId()));
			setaddObject("USER_NM", StaticClass.isNull(sessionInfo.getUserNm()));

			logger.debug("USER_ID:" + StaticClass.isNull(sessionInfo.getUserId()));
			logger.debug("USER_NM:" + StaticClass.isNull(sessionInfo.getUserNm()));
		}
		setaddObject("GKLURL", StaticClass.isNull(CommonProperties.getConfigProperty("cntsr.url")));
		params.put("GKLURL", StaticClass.isNull(CommonProperties.getConfigProperty("cntsr.url")));
		if ((request.getHeader("ajax-call") != null && request.getHeader("ajax-call").toLowerCase().equals("true")) || 
				(request.getHeader("content-type") != null && request.getHeader("content-type").toLowerCase().indexOf("multipart/form-data") >= 0)) 
		{
			return params;
		}
		
		String sPageNum = params.get("PAGENUM");
		if(sPageNum == null || sPageNum.trim().length() == 0 || sPageNum.trim().equals("0")) {
			PAGENUM = 1;
		} else {
			PAGENUM = Integer.parseInt(sPageNum.trim());
		}
		
		List tMENU = cd.getListDao("menu.getMenu", params);
		setaddObject("tmenu", tMENU);

		List sMENU = cd.getListDao("menu.getSubMenu", params);
		setaddObject("smenu", sMENU);

		List sMENU2 = cd.getListDao("menu.getSubMenu2", params);
		setaddObject("smenu2", sMENU2);
		
		String sTopMenuId = StaticClass.isNull(params.get("TMENUID"));
		String sSubMenuId = StaticClass.isNull(params.get("SMENUID"));
		
		setaddObject("TMENUID", sTopMenuId);
		setaddObject("SMENUID", sSubMenuId);

		return params;
    }
    
    /**
     * <pre>
     * 처리?��?�� : ?��?���? 건수 
     * </pre>
     * @Date	:	2012. 11. 06.	
     * @Return	:	void
     */  
    public int getPageCount() throws Exception {
    	return Integer.parseInt(CommonProperties.getConfigProperty("page.page_size"));
    }
    
    /**
     * <pre>
     * 처리?��?�� : ?��?���? ?���? ?��?��
     * </pre>
     * @Date	:	2012. 11. 06.	
     * @Return	:	void
     */    
    public void setPageList(String tableNames, String fields, String order, String where) throws Exception {
		int nPageSize = Integer.parseInt(CommonProperties.getConfigProperty("page.page_size"));
		setPageList(tableNames, fields, order, where, nPageSize);
	}
    
    /**
     * <pre>
     * 처리?��?�� :  ?��?���? ?���? ?��?��
     * </pre>
     * @Date	:	2014. 1. 10.	
     * @Return	:	void
     */
	public void setPageList(String tableNames, String fields, String order, String where, String sPAGENUM) throws Exception {
		int nPageSize = Integer.parseInt(CommonProperties.getConfigProperty("page.page_size"));
		PAGENUM = Integer.parseInt(sPAGENUM);
		setPageList(tableNames, fields, order, where, nPageSize);
	}
    
    @SuppressWarnings("rawtypes")
	public void setPageList(String tableNames, String fields, String order, String where, int nPageSize) throws Exception {
		
		int PAGE_SIZE = nPageSize;
		int BLOCK_SIZE = Integer.parseInt(CommonProperties.getConfigProperty("page.block_size"));
		
		int nTotalCount = getTotalCount(tableNames, where);
		List lstPageList = getPageList(PAGENUM, PAGE_SIZE, tableNames, fields, order, where);
		
		if(nTotalCount<=0) {
			PAGENUM = 1;
		}
		setaddObject("PAGE_PAGENUM", PAGENUM);
		setaddObject("PAGE_PAGESIZE", PAGE_SIZE);
		setaddObject("PAGE_BLOCK_SIZE", BLOCK_SIZE);
		setaddObject("PAGE_TOTALCOUNT", nTotalCount);
		setaddObject("PAGE_LIST", lstPageList);
		logger.debug("PAGE_LIST_SIZE : " + lstPageList.size());
	}    

    /**
     * <pre>
     * 처리?��?�� : ?��?��미터 ?��?��?�� 처리
     * </pre>
     * @Date	:	2012. 10. 24.	
     * @Return	:	String
     */
    public String StringRequest(String Inputstr)
    {
		String str = "";
		if(Inputstr == null) Inputstr = "";

		str = Inputstr;
		
    	String temp = str;
    	temp = temp.replace("'", "");
        temp = temp.replace("\"", "");
        temp = temp.replaceAll("<", "&lt;");
        temp = temp.replaceAll(">", "&gt;");
//        temp = temp.replace("(", "");
//        temp = temp.replace(")", "");
        temp = temp.replace("`", "");
        temp = temp.replace(":", "");
        temp = temp.replace("/", "");
//        temp = temp.replace("%", "");
        temp = temp.replace("^", "");
        temp = temp.replace("$", "");
        temp = temp.replace("=", "");
        temp = temp.replace("--", "");
        temp = temp.replace(";", "");
        return temp;
    }
    
    /**
     * <pre>
     * 처리?��?�� : ?��?��미터 ?��?��?�� 처리
     * </pre>
     * @Date	:	2012. 10. 24.	
     * @Return	:	String
     */
    public String StringRequest(String Inputstr, String InputName)
    {
		String str = "";
		if(Inputstr == null) Inputstr = "";

		str = Inputstr;
		
		if (InputName.equals("tpl_content")) {
			str = str.replace("'", "&#39;");
			str = str.replace("\"", "&#92;");
			str = str.replace("<", "&#60;");
			str = str.replace(">", "&#62;");
			str = str.replace("(", "&#40;");	
			str = str.replace(")", "&#41;");
			str = str.replace("`", "&#96;");
			//str = str.replace(":", "&#58;");	
			str = str.replace("/", "&#47;");
			str = str.replace("%", "&#37;");
			str = str.replace("^", "&#94;");
			str = str.replace("$", "&#36;");
			str = str.replace("=", "&#61;");
			str = str.replace("-", "&#45;");	
			return str;
		}
		
    	String temp = str;
    	temp = temp.replace("'", "");
        temp = temp.replace("\"", "");
        temp = temp.replaceAll("<", "&lt;");
        temp = temp.replaceAll(">", "&gt;");
//        temp = temp.replace("(", "");
//        temp = temp.replace(")", "");
        temp = temp.replace("`", "");
        if(InputName.indexOf("url")<0)
        	temp = temp.replace("&", "");
        if(InputName.indexOf("url")<0)
        	temp = temp.replace("/", "");
//        temp = temp.replace("%", "");
        temp = temp.replace("^", "");
        temp = temp.replace("$", "");
        if(InputName.indexOf("url")<0)
        	temp = temp.replace("=", "");
        temp = temp.replace("--", "");
        temp = temp.replace(";", "");
        return temp;
    }
    
    /**
     * <pre>
     * 처리?��?�� : ?��?���? 리스?�� 쿼리�? ?��?��
     * </pre>
     * @Date	:	2012. 11. 06.	
     * @Return	:	void
     */  
    @SuppressWarnings("rawtypes")
	public List getPageList(int pageNum, int pageSize, String tableNames, String fields, String order, String where) throws Exception {
		
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("TABLE", tableNames);
		hm.put("FIELD", fields);
		hm.put("ORDER", order);
		hm.put("WHERE", where);
		hm.put("PAGENUM", Integer.toString(pageNum));
		hm.put("PAGESIZE", Integer.toString(pageSize));
		
		return cd.getListDao("page.getList", hm);
	}
	
    /**
     * <pre>
     * 처리?��?�� : ?��?���? 카운?�� 쿼리�? ?��?��
     * </pre>
     * @Date	:	2012. 11. 06.	
     * @Return	:	void
     */  
	public int getTotalCount(String tableNames, String where) throws Exception {
		
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("TABLE", tableNames);
		hm.put("WHERE", where);
		
		return cd.getIntDao("page.getTotalCount", hm);
	}    
    
	/**
	 * <pre>
	 * 처리?��?�� : 리스?�� 처리
	 * </pre>
	 * @Date	:	2013. 3. 7.	
	 * @Return	:	void
	 */
	@SuppressWarnings("rawtypes")
	public void setList(HttpServletRequest request, MVController mvc, HashMap hm) throws Exception{
		Class.forName(StaticClass.dbUse())
		.getMethod(request.getServletPath().replace("/", ""), new Class[]{MVController.class, HashMap.class})
		.invoke(Class.forName(StaticClass.dbUse()).newInstance(), new Object[]{mvc, hm});
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?�� 리스?�� 처리
	 * </pre>
	 * @Date	:	2013. 3. 7.	
	 * @Return	:	void
	 */
	@SuppressWarnings("rawtypes")
	public void setList(HttpServletRequest request, MVController mvc, HashMap hm, AjaxXml ax) throws Exception{
		Class.forName(StaticClass.dbUse())
		.getMethod(request.getServletPath().replace("/", ""), new Class[]{MVController.class, HashMap.class, AjaxXml.class})
		.invoke(Class.forName(StaticClass.dbUse()).newInstance(), new Object[]{mvc, hm, ax});
	}

	
}
