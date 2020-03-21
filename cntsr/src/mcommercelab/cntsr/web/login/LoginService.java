package mcommercelab.cntsr.web.login;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import mcommercelab.cntsr.common.AjaxXml;
import mcommercelab.cntsr.common.CommonProperties;
import mcommercelab.cntsr.common.Encryptor;
import mcommercelab.cntsr.dao.CommonDaoImpl;

/**
 * 
 * <pre>
 * LoginService.java
 * </pre>
 * @author	 :	 Jang
 * @Date	 :	 2012. 11. 6.
 * @Version	 :	 JDK 1.6.0
 * @Description	 : 로그?�� ?��공여�?�? 체크?��?��.
 */
@Service("loginService")
public class LoginService {

	private static final Log logger = LogFactory.getLog(LoginService.class);

	public static final String SESSION_USER = "USERINFO";
	
	@Resource(name = "commonDao")	
	CommonDaoImpl cd = null;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String loginCheck(String userId, String userPass, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		AjaxXml ax = new AjaxXml();
		
		try {			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("user_id", userId);
			map.put("passwd", userPass);
			
			
			if (cd.getIntDao("login.loginCheckPassWord", map).equals(0)){
				ax.setResult("020");	//비밀번호 불일치
				return ax.getResultXml();
			}
			
			
			List userList = cd.getListDao("login.loginCheck", map);
			
			if (userList == null || userList.size() <= 0) {
				ax.setResult("010");
				return ax.getResultXml();
			}
			
			HashMap<String, Object> userInfo = (HashMap<String, Object>) userList.get(0);
			if (userInfo.get("USER_ID") == null || ((String)userInfo.get("USER_ID")).trim().length() == 0) {
				ax.setResult("010");
				return ax.getResultXml();
			}
			
			String plainAuth = String.format("%s:%s:%s:%s:",
					userId,
					userInfo.get("USER_NM"),
					userInfo.get("USER_CD"),
					userInfo.get("USER_DM")
			);
			
			String encryptedAuth = plainAuth;
			
			HttpSession session = request.getSession(true);
			session.setAttribute(SESSION_USER, URLEncoder.encode(encryptedAuth, "UTF-8"));
			session.setMaxInactiveInterval(6*60*60);
			
			ax.setResult("000");
		} catch(Exception ex) {
			logger.error("Login Error", ex);
			ax.setResult("090");
		} finally {
			logger.debug("---------------------finnally");
		}
		
		return ax.getResultXml();
	}
	
	public static SessionInfo getSessionInfo(HttpServletRequest request) throws Exception
	{
		HttpSession httpSession = request.getSession(true);
		SessionInfo session = null;
		
		String encryptedAuth = (String)httpSession.getAttribute(SESSION_USER);
		
		if (encryptedAuth == null) {
			return null;
		}
		
		try {
			encryptedAuth = URLDecoder.decode(encryptedAuth, "UTF-8");
		} catch (UnsupportedEncodingException e) {

		}
		
		if (encryptedAuth.isEmpty()) {
			return null;
		}
		
		String plainAuth = encryptedAuth;
		
		String[] authTokens = plainAuth.split(":");
		
		session = new SessionInfo();
		session.setUserId(authTokens[0]);
		session.setUserNm(authTokens[1]);
		session.setUserCd(authTokens[2]);
		session.setUserDm(authTokens[3]);
		logger.debug("session===>" + session);

		return session;
	}

}
