package mcommercelab.cntsr.common;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;

/**
 * <pre>
 * squarenet.smartq.common
 * StaticClass.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2014. 5. 12.
 * @Version	:	JDK 1.6.0
 * @Description	:	공통?��?��?��
 */
public class StaticClass extends AbstractAuthCheckInterceptor {
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��미터 처리
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String getParamNames (HttpServletRequest request) throws IllegalStateException {
		StringBuffer sb = new StringBuffer();
		Enumeration<String> enu = request.getParameterNames();
		while(enu.hasMoreElements()){
			String param =(String)enu.nextElement();
			sb.append(param+" :: "+new MVController().StringRequest(request.getParameter(param))+"\n");
		}
		return sb.toString();
    }
	
	/**
	 * <pre>
	 * 처리?��?�� : UUID TODTJD
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String createUUID() {
		return UUID.randomUUID().toString();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : DB ?��?��
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String dbUse() throws IOException {
		if(CommonProperties.getConfigProperty("db.sql").equals("mysql"))
			return "mcommercelab.cntsr.DB.MYSQL";
		if(CommonProperties.getConfigProperty("db.sql").equals("mssql"))
			return "mcommercelab.cntsr.DB.MSSQL";
		if(CommonProperties.getConfigProperty("db.sql").equals("oracle"))
			return "mcommercelab.cntsr.DB.ORACLE";
		else
			return null;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : 바이?�� ?��르기
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String cutFirstStrInByte(String str, int endIndex, boolean point)
	{
		StringBuffer sbStr = new StringBuffer(endIndex);
		int iTotal=0;
		String lastStr = "";
		for(char c: str.toCharArray())
		{
			iTotal+=String.valueOf(c).getBytes().length;
			if(iTotal>endIndex){
				if(point)
					lastStr = "..";
				break;
			}	
			sbStr.append(c);
		}
		return sbStr.toString() + lastStr;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : UNESCAPE 처리
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String unescape(String src) {
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length());
		int lastPos = 0, pos = 0;
		char ch;
		while (lastPos < src.length()) {
			pos = src.indexOf("%", lastPos);
			if (pos == lastPos) {
				if (src.charAt(pos + 1) == 'u') {
					ch = (char) Integer.parseInt(src
							.substring(pos + 2, pos + 6), 16);
					tmp.append(ch);
					lastPos = pos + 6;
				} else {
					ch = (char) Integer.parseInt(src
							.substring(pos + 1, pos + 3), 16);
					tmp.append(ch);
					lastPos = pos + 3;
				}
			} else {
				if (pos == -1) {
					tmp.append(src.substring(lastPos));
					lastPos = src.length();
				} else {
					tmp.append(src.substring(lastPos, pos));
					lastPos = pos;
				}
			}
		}
		return tmp.toString();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ESCAPE 처리
	 * </pre>
	 * @Date	:	2014. 5. 12.	
	 * @Return	:	String
	 */
	public static String escape(String src) {
		int i;
		char j;
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length() * 6);
		for (i = 0; i < src.length(); i++) {
			j = src.charAt(i);
			if (Character.isDigit(j) || Character.isLowerCase(j)
					|| Character.isUpperCase(j))
				tmp.append(j);
			else if (j < 256) {
				tmp.append("%");
				if (j < 16)
					tmp.append("0");
				tmp.append(Integer.toString(j, 16));
			} else {
				tmp.append("%u");
				tmp.append(Integer.toString(j, 16));
			}
		}
		return tmp.toString();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : 금액?��?��
	 * </pre>
	 * @Date	:	2013. 10. 16.	
	 * @Return	:	String
	 */
	public static String setDecimalFormat(String str)
	{
		DecimalFormat df = new DecimalFormat("###,###");
		return df.format(Double.parseDouble(str));
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?���? ?���? 체크
	 * </pre>
	 * @Date	:	2013. 10. 22.	
	 * @Return	:	String
	 */
	public static String isNull(String str){
		if(str == null)
			return "";
		else
			return str.trim();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : error.xml ?��?�� 코드값으�? 메세�?값을 �??��?��
	 * </pre>
	 * @Date	:	2014. 6. 26.	
	 * @Return	:	String
	 */
	public static String getErrorMsg(String str) throws IOException{
		return CommonProperties.getXmlProperty("error", str + "_msg");
	}
}
