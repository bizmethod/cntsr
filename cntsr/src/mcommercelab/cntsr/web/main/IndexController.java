package mcommercelab.cntsr.web.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;

import mcommercelab.cntsr.common.CommonProperties;
import mcommercelab.cntsr.common.MVController;
import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;

@Controller
@RequestMapping("/")
public class IndexController extends AbstractAuthCheckInterceptor {
	@RequestMapping(value = "main", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView index(@RequestParam(value = "redirectUrl", required = false) String redirectUrl,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("페이지 로딩 시작  ---> IndexController");
		MVController mvc = new MVController(cd);
		
		mvc.setModelAndView("main");
		mvc.setaddObject("mainTitle", CommonProperties.getConfigProperty("use.mainTitle"));
		mvc.setaddObject("description", CommonProperties.getConfigProperty("use.description"));
		mvc.setaddObject("subject", CommonProperties.getConfigProperty("use.subject"));
		mvc.setaddObject("classification", CommonProperties.getConfigProperty("use.classification"));
		mvc.setaddObject("keywords", CommonProperties.getConfigProperty("use.keywords"));
		mvc.setaddObject("robots", CommonProperties.getConfigProperty("use.robots"));
		
		return mvc.getModelAndView();
	}
	
}

