package mcommercelab.cntsr.common;

/**
 * <pre>
 * squarenet.gkl.common
 * SmartQException.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2014. 6. 26.
 * @Version	:	JDK 1.6.0
 * @Description	:	?òà?ô∏Î∞úÏÉù ?Å¥?ûò?ä§
 */
public class SmartQException extends Exception{
	static final long serialVersionUID = 6904023443807996576L;
    private String exCode = "";
    private String impoTyp = "";
    
    public String getExCode(){
    	if(exCode.equals(null))
    		exCode = "";
        return exCode;
    }
    
	public String getImpoTyp() {
		return impoTyp;
	}
	
    public SmartQException(String exCode){
        super(exCode);
        this.exCode = exCode;
    }
    
    public SmartQException(String exCode, String impoTyp){
        super(exCode);
        this.exCode = exCode;
        this.impoTyp = impoTyp;
    }
}
