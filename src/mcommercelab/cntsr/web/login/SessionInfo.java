package mcommercelab.cntsr.web.login;

/**
 * 
 * <pre>
 * SessionInfo.java
 * </pre>
 * @author	 :	 Jang
 * @Date	 :	 2012. 11. 6.
 * @Version	 :	 JDK 1.6.0
 * @Description	 : 
 */
public class SessionInfo {
	private String userId;
	private String userNm;
	private String userCd;
	private String userDm;
	
	
	public String getUserId() {
		return userId;
	}
	public String getUserNm() {
		return userNm;
	}
	
	public String getUserCd() {
		return userCd;
	}	
	public String getUserDm() {
		return userDm;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public void setUserCd(String userCd) {
		this.userCd = userCd;
	}
	public void setUserDm(String userDm) {
		this.userDm = userDm;
	}
}
