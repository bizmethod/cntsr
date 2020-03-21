package mcommercelab.cntsr.common;

import java.io.IOException;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.net.util.Base64;


public class Encryptor {

	private static byte[] key = {0x48,0x63, 0x7a, 0x59, 0x0f, 0x56, 0x23, 0x72, 0x50, 0x0c, 0x18, 0x70, 0x61, 0x69, 0x65, 0x1e};
	
	public static byte[] encrypt(String plainText) {
		try {
			SecretKeySpec spec = new SecretKeySpec(key, "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, spec);
			
			byte[] encrypted = cipher.doFinal(plainText.getBytes());
			
			return encrypted;
		} catch(Exception ex) {
			
		}		

		return null;
	}
	
	public static String encryptString(String plainText) {
		byte[] encrypted = encrypt(plainText);
		
		if (null != encrypted) {
			return Base64.encodeBase64String(encrypted).replaceAll("\r\n", "");
		}

		return null;
	}
	
	public static String decrypt(byte[] encrypted) {
		try {
			SecretKeySpec spec = new SecretKeySpec(key, "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, spec);
			
			byte[] decripyed = cipher.doFinal(encrypted);
			
			return new String(decripyed);
		} catch(Exception ex) {
			
		}
		
		return null;
	}
	
	public static String decryptString(String encrypted) {
		return decrypt(Base64.decodeBase64(encrypted));
	}
	
	/**
     * MD5(Message Digest algorithm 5)<br>
     * ?ùºÎ∞©Ìñ• ?ï¥?ãú ?ï®?àòÎ°úÏÑú ?ûÑ?ùò Î©îÏãúÏß?Î•? ?ïïÏ∂?,<br>
     * Í≥†Ï†ï Í∏∏Ïù¥ ?ï¥?ãúÍ∞íÏùò ?êò?èåÎ¶? Ï≤òÎ¶¨?äî 32ÎπÑÌä∏ ?ã®?úÑÎ°? ?ïú?ã§.<br>
     * <br>
     * ex) "1111" ==> "b59c67bf196a4758191e42f76670ceba"
     *
     * @param param Î≥?Í≤ΩÎê† Í∞?
     * @return String MD5Î°? ?Éù?Ñ±?êú Í∞?
	 * @throws IOException 
     * @see java.security.MessageDigest#digest(byte[])
     * @exception java.security.NoSuchAlgorithmException
     */
     public static String makeMD5(String param) throws IOException {
         StringBuffer md5 = new StringBuffer();
         if(CommonProperties.getConfigProperty("version.makeMD5").toLowerCase().equals("true")) {
	         try { 
	             byte[] digest = java.security.MessageDigest.getInstance("MD5").digest(param.getBytes());
	             for (int i = 0; i < digest.length; i++) {
	                 md5.append(Integer.toString((digest[i] & 0xf0) >> 4, 16));
	                 md5.append(Integer.toString(digest[i] & 0x0f, 16));
	             }
	         } catch(java.security.NoSuchAlgorithmException ne) {
	             ne.printStackTrace();
	         }
         }
         else{
        	 md5.append(param);
         }
         return md5.toString();
     } 	
}
