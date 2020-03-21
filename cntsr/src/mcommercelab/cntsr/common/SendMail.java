package mcommercelab.cntsr.common;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import mcommercelab.cntsr.dao.CommonDaoImpl;
import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;


/**
 * <pre>
 * squarenet.gkl.common
 * SendMail.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2014. 6. 26.
 * @Version	:	JDK 1.6.0
 * @Description	:	Î©îÏùº Î∞úÏÜ°
 */
public class SendMail {
	
	protected CommonDaoImpl cd;
	protected static Log logger = LogFactory.getLog(AbstractAuthCheckInterceptor.class);
	
	private Session mailSession = null;
	private Transport transport = null;
	private String SEND_ADDR = "";
	private String SMTP_TLS = "";
	private String SMTP_SERVERIP = "";
	private String SMTP_PORT = "";
	private String SMTP_AUTH = "";
	private String SMTP_ID = "";
	private String SMTP_PWD = "";
	
	private String RECV_ADDR = "";

	/**
	 * @param cd
	 * @throws Exception
	 */
	public SendMail(CommonDaoImpl cd) throws Exception 
	{
		super();
		this.cd = cd;
		readConfiguration();	//Properties READ
	}


	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : Ïª®ÌîºÍ∑∏Í∞í ?Öã?åÖ
	 * </pre>
	 * @Date	:	2014. 6. 26.	
	 * @Return	:	boolean
	 */
	private boolean readConfiguration() {
		try {
			this.SMTP_AUTH = CommonProperties.getConfigProperty("mail.smtp_auth").toLowerCase();
		    this.SEND_ADDR = CommonProperties.getConfigProperty("mail.send_addr");
		    this.SMTP_TLS = CommonProperties.getConfigProperty("mail.smtp_tls").toLowerCase();
		    this.SMTP_SERVERIP = CommonProperties.getConfigProperty("mail.smtp_server");
		    this.SMTP_PORT = CommonProperties.getConfigProperty("mail.smtp_port");
		    this.SMTP_ID = CommonProperties.getConfigProperty("mail.smtp_id");
		    this.SMTP_PWD = CommonProperties.getConfigProperty("mail.smtp_pwd");
		    this.RECV_ADDR = CommonProperties.getConfigProperty("mail.recv_addr");
		    
			return true;
		} catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : Î©îÏùº ?ò§?îà
	 * </pre>
	 * @Date	:	2014. 6. 26.	
	 * @Return	:	boolean
	 */
	public boolean mailOpen() 
	{
		boolean bRet = true;
		try{
			Properties properties = new Properties();

			properties.put("mail.smtp.auth" , this.SMTP_AUTH);
			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.smtp.starttls.enable", this.SMTP_TLS);

			mailSession = Session.getInstance(properties, null);
			  
			if(this.SMTP_AUTH.equals("true")) {
				transport = mailSession.getTransport("smtp");
				transport.connect(this.SMTP_SERVERIP, this.SMTP_ID, this.SMTP_PWD);
			} else {
				properties.put("mail.smtp.host", this.SMTP_SERVERIP);
				properties.put("mail.smtp.port", this.SMTP_PORT);
			}

			logger.debug("E-mail successfully Open!");

		} catch (AddressException e) {
			bRet = false;
			e.printStackTrace();
			logger.info("AddressException : " + e);
		} catch (Exception e) {
			bRet = false;
			e.printStackTrace();
			logger.info("Exception : " + e);
		}
		return bRet;
	}
	
	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : Î©îÏùº ?Å¥Î°úÏ¶à
	 * </pre>
	 * @Date	:	2014. 6. 26.	
	 * @Return	:	void
	 */
	public void mailClose() 
	{
		try{
			if(this.SMTP_AUTH.equals("true")) {
				transport.close();
			}
			logger.debug("E-mail successfully Close!");
		} catch (AddressException e) {
			e.printStackTrace();
			logger.debug("AddressException : " + e);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("MessagingException : " + e);
		}
	}

	/**
	 * <pre>
	 * Ï≤òÎ¶¨?Ç¥?ö© : Î©îÏùº Î∞úÏÜ°
	 * </pre>
	 * @Date	:	2014. 6. 26.	
	 * @Return	:	void
	 */
	public void mailSend(HashMap<String, String> amm) throws Exception {
		
    	boolean bMailSend = true;
		String RECV_ADDR 	= amm.get("RECV_ADDR");
		String SEND_TITLE 	= amm.get("SEND_TITLE");
		String SEND_CONTENT = amm.get("SEND_CONTENT");
		String SEND_ADDR_ 	= amm.get("SEND_ADDR");
		
    	try {
			if(!SEND_ADDR_.isEmpty()) this.SEND_ADDR = 	SEND_ADDR_;
			
			SEND_CONTENT.replace(" ", "");

		    SEND_CONTENT = SEND_CONTENT.replace("&#39;", "'");
		    SEND_CONTENT = SEND_CONTENT.replace("&#92;", "\"");
		    SEND_CONTENT = SEND_CONTENT.replace("&#60;", "<");
		    SEND_CONTENT = SEND_CONTENT.replace("&#62;", ">");
		    SEND_CONTENT = SEND_CONTENT.replace("&#40;", "(");
		    SEND_CONTENT = SEND_CONTENT.replace("&#41;", ")");
		    SEND_CONTENT = SEND_CONTENT.replace("&#96;", "`");
		    SEND_CONTENT = SEND_CONTENT.replace("&#58;", ":");
		    SEND_CONTENT = SEND_CONTENT.replace("&#47;", "/");
		    SEND_CONTENT = SEND_CONTENT.replace("&#37;", "%");
		    SEND_CONTENT = SEND_CONTENT.replace("&#94;", "^");
		    SEND_CONTENT = SEND_CONTENT.replace("&#36;", "$");
		    SEND_CONTENT = SEND_CONTENT.replace("&#61;", "=");
		    SEND_CONTENT = SEND_CONTENT.replace("&#45;", "-");
		    
		    if(SEND_CONTENT != null && SEND_TITLE != null)
			{
		    	logger.debug("============================");
		    	logger.debug("RECV_ADDR:" + RECV_ADDR);

				Message message = null;
				message = new MimeMessage(mailSession);

				message.setFrom(new InternetAddress(this.SEND_ADDR));
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(RECV_ADDR));
				message.setContent(SEND_CONTENT, "text/html;charset=utf-8;");
				message.setSentDate(new Date());
				message.setSubject(MimeUtility.encodeText(SEND_TITLE, "UTF-8", "B"));

				if (this.SMTP_AUTH.equals("true")) {
					transport.sendMessage(message, message.getAllRecipients());
				} else {
					Transport.send(message);
				}
			} else {
				bMailSend = false;
			}
		    
    	} catch (Exception e) {
    		bMailSend = false;
    	}
    	
    	//Î∞úÏÜ°Î©îÏùº ?ûà?ä§?Ü†Î¶? ?ûÖ?†•
    	HashMap<String,String> hmSendEnd = new HashMap<String,String>();
    	hmSendEnd.put("mail_addr", RECV_ADDR);
		hmSendEnd.put("title", SEND_TITLE);
		hmSendEnd.put("memo", SEND_CONTENT);
		hmSendEnd.put("mail_typ", amm.get("MAIL_TYP"));
    	if (bMailSend)
    		hmSendEnd.put("recode_st", "A");
    	else
    		hmSendEnd.put("recode_st", "I");
    	
    	cd.insertDao("sendMsgJob.endSendMail", hmSendEnd);
	}
}
