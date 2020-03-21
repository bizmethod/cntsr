package mcommercelab.cntsr.common;

import java.util.List;
import java.util.HashMap;



/**
 * <pre>
 * squarenet.smartq.common
 * AjaxXml.java
 * </pre>
 * @author	:	osh
 * @Date	:	2012. 10. 26.
 * @Version	:	JDK 1.6.0
 * @Description	:	Ajax Xml ?���? 리턴�?  
 */

public class AjaxXml {

	private static String xmlHeader = "\n<smartq-xml version=\"1.0\">";
	private static String xmlFooter = "\n</smartq-xml>";
	private static String xmlResult = "\n\t<result>$result</result>";
	private static String xmlResultMsg = "\n\t<result-msg>$result-msg</result-msg>";
	
	private String strResult = "";
	private String strResultNm = "";
	private String strResultMsg = "";
	private StringBuffer sbXml = null;
	
	public AjaxXml() {
		strResult = "";
		strResultNm = "";
		strResultMsg = "";
		sbXml = new StringBuffer();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : CommonDao ?�� updateDao 결과값을 setting
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	void
	 */		
	public void setUpdateResult(int nRet) {
		if (nRet > 0) {
			setResult("0");	//?���?
		} else {
			setResult("100");	//update ?��?��
		}
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : CommonDao ?�� InsertDao 결과값을 setting
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	void
	 */			
	public void setInsertResult(String sRet) {
		if (sRet == null || sRet.trim().equals("")) {
			setResult("200");	//insert ?��?��
		} else {
			setResult("0");	//?���?
		}
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : CommonDao?�� 처리결과 ?��?�� 별도?�� 로직?�� ???�� 처리결과�? 코드값으�? setting ?��?�� ?��?�� 
	 * ?��?��?�� 결과코드?? 메세�?�? 추�??��?���? ?��?��. 
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	void
	 */			
	public void setResult(String  strErrCode) {
		
		try {
			strResult = strErrCode;
			strResultNm = CommonProperties.getXmlProperty("error", strResult);
			strResultMsg = CommonProperties.getXmlProperty("error", strResult + "_msg");
		} catch (Exception e) {
			strResult = strErrCode;
			strResultNm = "Undefined";
			strResultMsg = "UnDefined Message";
		}
		
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?�� 결과코드�? 리턴
	 * </pre>
	 * @Date	:	2012. 11. 12.	
	 * @Return	:	String
	 */		
	public String getResult() {
		return strResult;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?�� 결과명을 리턴
	 * </pre>
	 * @Date	:	2012. 12. 03.	
	 * @Return	:	String
	 */		
	public String getResultNm() {
		return strResultNm;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?�� 결과메세�?�? 리턴
	 * </pre>
	 * @Date	:	2012. 12. 03.	
	 * @Return	:	String
	 */		
	public String getResultMsg() {
		return strResultMsg;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : Xml 리스?���? 리턴받기 ?��?�� ?��?��
	 * queryId?�� List �? ?��?��개일?�� 각각?�� List�? 구분?���? ?��?�� ?��?��
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	void
	 */		
	public void setList(String queryId, List<Object> list) {
		if (strResult.trim().equals("")) {
			setResult("0");		//?���?
		}		
		sbXml.append(convertXML(queryId, list));		
	}
	
	public void setList(String sXml) {
		if (sXml == null || sXml.isEmpty()) {
			return;
		}
		if (strResult.trim().equals("")) {
			setResult("0");		//?���?
		}
		sbXml.append(sXml);
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ajax ?��출에 ???�� ?��?�� xml?�� 리턴
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	String
	 */		
	public String getResultXml() {
		StringBuffer xml = new StringBuffer();
		xml.append(xmlHeader);
		xml.append(xmlResult.replace("$result", strResult));
		xml.append(xmlResultMsg.replace("$result-msg", strResultMsg));
		
		if(sbXml.length() > 0) {
			xml.append(sbXml);
		}
		
		xml.append(xmlFooter);
		return xml.toString();		
	}
	
	
	/**
	 * <pre>
	 * 처리?��?�� : List�? Xml�? �??��
	 * </pre>
	 * @Date	:	2012. 10. 29.	
	 * @Return	:	String
	 */		
	public String convertXML(String queryId, List<Object> list) {
		StringBuffer sb = new StringBuffer();
		sb.append("\n\t<item-list qid='"+queryId+"' size='"+list.size()+"'>");
		
		for (int i = 0; i < list.size(); i++) {
			@SuppressWarnings("unchecked")
			HashMap<String, Object> item = (HashMap<String, Object>) list.get(i);

			String[] keys = item.keySet().toArray(new String[0]);
			
			sb.append("\n\t\t<item>");	
			
			for (String key : keys) {
				Object value = item.get(key);
				if(key.isEmpty())key="unknown";
				if (value == null)
					sb.append("\n\t\t\t<" + key + "/>");
				else if (value instanceof String)
					sb.append("\n\t\t\t<" + key + "><![CDATA[" + value.toString() + "]]></" + key + ">");
				else
					sb.append("\n\t\t\t<" + key + ">" + value.toString() + "</" + key + ">");
			}
			
			sb.append("\n\t\t</item>");
		}
		
		sb.append("\n\t");
		sb.append("</item-list>");
		return sb.toString();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : xml parameter 추�?
	 * </pre>
	 * @Date	:	2012. 11. 26.	
	 * @Return	:	String
	 */		
	public void setParameter(String key, String value) {
		if (strResult.trim().equals("")) {
			setResult("0");		//?���?
		}
		value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		sbXml.append("\n\t<"+key+"><![CDATA["+ value + "]]></" + key + ">");
	}
}
