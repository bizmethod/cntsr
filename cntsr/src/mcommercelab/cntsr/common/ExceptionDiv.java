package mcommercelab.cntsr.common;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.BadSqlGrammarException;

import mcommercelab.cntsr.dao.CommonDaoImpl;

/**
 * <pre>
 * squarenet.gkl.common
 * ExceptionDiv.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2014. 6. 26.
 * @Version	:	JDK 1.6.0
 * @Description	:	?óê?ü¨Í¥?Î¶? ?Å¥?ûò?ä§
 */
public class ExceptionDiv {
	CommonDaoImpl cd = null;

	private String exCode;
	private String memo;
	private String impoTyp;
	private String url;
	private String exMessage;
	private String exAlertMsg;
	
	
	public ExceptionDiv(CommonDaoImpl cd){
		this.cd = cd;
	}
	
	public String getExCode() {
		return exCode;
	}
	public void setExCode(String exCode) {
		this.exCode = exCode;
	}

	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public String getImpoTyp() {
		return impoTyp;
	}
	public void setImpoTyp(String impoTyp) {
		this.impoTyp = impoTyp;
	}

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getExAlertMsg() {
		return exAlertMsg;
	}
	public void setExAlertMsg(String exAlertMsg) {
		this.exAlertMsg = exAlertMsg;
	}

	public String getExMessage() {
		return exMessage;
	}

	public void setExMessage(String exMessage) {
		this.exMessage = exMessage;
	}
	
	public void setExData(String exCode, String impoTyp, String memo){
		this.exCode = exCode;
		this.impoTyp = impoTyp;
		this.memo = memo;
	}
	
	public String getErrorMsg(Exception ex, HttpServletRequest request){
		
		if(ex instanceof BadSqlGrammarException){
			setExData("500", "IE", ex.toString());
		}
		else if(ex instanceof IllegalThreadStateException){
			setExData("501", "IE", ex.toString());
		}
		else if(ex instanceof NullPointerException){
			setExData("502", "IE", ex.toString());
		}
		else if(ex instanceof NumberFormatException){
			setExData("503", "IE", ex.toString());
		}
		else if(ex instanceof SmartQException){
			setExData(((SmartQException) ex).getExCode(), ((SmartQException) ex).getImpoTyp(), ex.toString());
		}
		else{
			setExData("1000", "IE", ex.toString());
		}
		
		try{
			setExMessage(CommonProperties.getXmlProperty("error", exCode));
			setExAlertMsg(CommonProperties.getXmlProperty("error", exCode+"_msg"));
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		if(request != null)
			this.setUrl(request.getRequestURI());
		else
			this.setUrl("-");
		this.setExAlertMsg(exAlertMsg);
		
		return getExCode()+"\n"+getMemo()+"\n"+ex.getClass().getName()+"\n"+getUrl();
	}
	
	/**
	 * 
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : db?óê ExceptionÍ∏∞Î°ù ???û• 
	 * </pre>
	 * @Date	 :	 2012. 10. 29.	
	 * @Return	 :	 void
	 */
	public void inserDbException(){
		HashMap<String, String> hmap = new HashMap<String, String>();
		
		if(getImpoTyp().equals(null) || getImpoTyp().equals(""))
			setImpoTyp("SE");
		try{
			hmap.put("exCode", getExCode());
			hmap.put("exUrl", getUrl());
			hmap.put("impoTyp", getImpoTyp());
			hmap.put("memo", getMemo());
			if(cd!=null){
				cd.updateDao("exception.exlogInsert", hmap);
			}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
