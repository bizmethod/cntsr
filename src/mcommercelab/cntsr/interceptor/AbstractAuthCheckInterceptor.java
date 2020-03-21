package mcommercelab.cntsr.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.UrlPathHelper;

import mcommercelab.cntsr.common.AjaxXml;
import mcommercelab.cntsr.common.ExceptionDiv;
import mcommercelab.cntsr.dao.CommonDaoImpl;
import mcommercelab.cntsr.web.login.LoginService;
import mcommercelab.cntsr.web.login.SessionInfo;

/**
 * <pre>
 * squarenet.smartq.interceptor
 * AbstractAuthCheckInterceptor.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2012. 10. 24.
 * @Version	:	JDK 1.6.0
 * @Description	:	url 호출시 항상 실행
 */
public class AbstractAuthCheckInterceptor extends HandlerInterceptorAdapter{
	protected static Log logger = LogFactory.getLog(AbstractAuthCheckInterceptor.class);
	
	@Resource(name = "commonDao")	
	protected CommonDaoImpl cd = null;
	
	/**
	 * <pre>
	 * 컨드롤러 실행 전 항상 실행
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	String
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.debug("AbstractAuthCheckInterceptor:preHandle-"+request.getServletPath());
		request.setCharacterEncoding("UTF-8");
				
		if (request.getServletPath().startsWith("/main")) {
			return true;
		} else if (request.getServletPath().startsWith("/login")) {
			return true;
		} else if (request.getServletPath().startsWith("/VIEWER/img")) {
			return true;
		} else if (request.getServletPath().startsWith("/VIEWER/file")) {
			return true;
		} else if (request.getServletPath().startsWith("/VIEWER/thumb")) {
			return true;
		} 

		logger.debug("----------------------------preHandel ---------------"); 

		//세션 정보 조회
		SessionInfo sessionInfo = LoginService.getSessionInfo(request);
		if (sessionInfo == null) {
			logger.debug("SESSION IS NULL--");
			UrlPathHelper urlPathHelper = new UrlPathHelper();
			String redirectUrl = urlPathHelper.getOriginatingRequestUri(request);
			
			if (request.getQueryString() != null) {
				redirectUrl += "?" + request.getQueryString();
			}
			throw new ModelAndViewDefiningException(new ModelAndView("redirect:/login"));
		}
	    response.addHeader("Cache-Control", "no-cache");
		response.addHeader("Pragma", "no-cache");
		
		return true;
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView handlerException(Exception ex, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("Exception Error.. load");
		ex.printStackTrace();
		ExceptionDiv ed = new ExceptionDiv(cd);

		AjaxXml ax = new AjaxXml();
		String errMsg = ed.getErrorMsg(ex, request);
		ed.inserDbException();
		ax.setResult(ed.getExCode());
		String sXml = ax.getResultXml();
		
		ModelAndView mv = null;
		
		if ((request.getHeader("ajax-call") != null && request.getHeader("ajax-call").toLowerCase().equals("true")) || 
				(request.getHeader("content-type") != null && request.getHeader("content-type").toLowerCase().indexOf("multipart/form-data") >= 0)) 
		{
			response.setContentType("application/xml");
			response.setCharacterEncoding("utf-8");
			response.setHeader("Cache-Control", "no-cache");
			response.setContentLength(sXml.getBytes("utf-8").length);
			response.getWriter().print(sXml);
			logger.debug("Ajax Exception Response------------------------------------");
			logger.debug(sXml);
		} else {
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("error_code", ed.getExCode());
			hm.put("error_msg", ed.getExAlertMsg());
			logger.debug("Page Exception Response------------------------------------");
			logger.debug("HASHMAP : "+hm);
			mv = new ModelAndView("common/error", "ERROR", hm);
		}
		return mv;
	}
}
