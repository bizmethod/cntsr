package mcommercelab.cntsr.web.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mcommercelab.cntsr.common.CommonProperties;
import mcommercelab.cntsr.common.MVController;
import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;


/**
 * 
 * <pre>
 * LoginController.java
 * </pre>
 * @author	 :	 Jang
 * @Date	 :	 2012. 11. 6.
 * @Version	 :	 JDK 1.6.0
 * @Description	 : 
 */
@Controller
@RequestMapping("/")
public class LoginController extends AbstractAuthCheckInterceptor {

	@Resource(name = "loginService")
	LoginService loginService = null;
	
	/**
	 * 
	 * <pre>
	 * </pre>
	 * @Date	 :	 2012. 10. 26.	
	 * @Return	 :	 ModelAndView
	 *  method = {RequestMethod.GET, RequestMethod.POST})
	 */
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView login(@RequestParam(value = "redirectUrl", required = false) String redirectUrl,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("login.. load");
		MVController mvc = new MVController(cd);
		
		mvc.setModelAndView("common/login");
		mvc.setaddObject("pwdMng", CommonProperties.getConfigProperty("use.pwdMng"));
		mvc.setaddObject("redirectUrl", redirectUrl);
		
		return mvc.getModelAndView();
	}
	
	/**
	 * 
	 * <pre>
	 * </pre>
	 * @Date	 :	 2012. 10. 26.	
	 * @Return	 :	 String
	 */
	@RequestMapping(method=RequestMethod.POST,value="loginCheck")
	@ResponseBody
	public String loginCheck(@RequestParam(value="user_id", required=true) String userId, 
		    @RequestParam(value="passwd", required=true) String userPass,
		    HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("\n**********************\n * LoginController/loginCheck.. load \n**********************\n");

		String result = loginService.loginCheck(userId, userPass, request, response);

		logger.debug("---" + result);
		
		return result;
	}
	
	/**
	 * 
	 * <pre>
	 * </pre>
	 * @Date	 :	 2012. 10. 26.	
	 * @Return	 :	 String
	 */
	@RequestMapping(value = "logout")
	public ModelAndView logout(HttpSession session) throws Exception {
		
		logger.debug("\n**********************\n * LoginController/logout.. load \n**********************\n");
	    
		if (session != null) {
			session.invalidate();
		}

		return new ModelAndView("redirect:/login");
	}
}
