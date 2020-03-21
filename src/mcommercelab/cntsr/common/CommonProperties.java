package mcommercelab.cntsr.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;

public class CommonProperties {

	protected static Log logger = LogFactory.getLog(AbstractAuthCheckInterceptor.class);
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : xml properties ?ùò Í∞íÏùÑ Î¶¨ÌÑ¥
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	String
	 */
	public static String getXmlProperty(String filename, String stringname) throws IOException{
		
		ClassLoader cl;
        cl = (Thread.currentThread()).getContextClassLoader();
        if( cl == null ) {
            cl = ClassLoader.getSystemClassLoader();
        }
        
        URL url = cl.getResource(filename + ".xml");
		Properties p = new Properties(); 
        FileInputStream in;
		try {
			in = new FileInputStream(url.getPath().replace("%20", " "));
			p.loadFromXML(in); 
	        in.close();
		} catch (FileNotFoundException e) {
			throw new FileNotFoundException();
		}
		return p.getProperty(stringname);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : xml properties ?ùò Í∞íÏùÑ Î¶¨ÌÑ¥
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	String
	 */
	public static String getConfigProperty(String propertyName) throws IOException {
		ClassLoader cl;
        cl = (Thread.currentThread()).getContextClassLoader();
        if( cl == null ) {
            cl = ClassLoader.getSystemClassLoader(); 
        }
		String sFilePath = cl.getResource("/").getPath().replace("%20", " ") + "/config.properties"; 
		Properties p = new Properties();
		FileInputStream in = new FileInputStream("/" + sFilePath);
		p.load(in);
		in.close();
		return p.getProperty(propertyName);
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : xml properties ?ùò Í∞íÏùÑ Î¶¨ÌÑ¥
	 * </pre>
	 * @Date	:	2012. 10. 24.	
	 * @Return	:	String
	 */
	public static String getDBProperty(String propertyName) throws IOException {
		ClassLoader cl;
        cl = (Thread.currentThread()).getContextClassLoader();
        if( cl == null ) {
            cl = ClassLoader.getSystemClassLoader(); 
        }
		String sFilePath = cl.getResource("/").getPath().replace("%20", " ") + "/jdbc.properties"; 
		Properties p = new Properties();
		FileInputStream in = new FileInputStream("/" + sFilePath);
		p.load(in);
		in.close();
		return p.getProperty(propertyName);
	}
}
