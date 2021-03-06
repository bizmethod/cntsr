package mcommercelab.cntsr.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;


public class DateUtils {
	/** 
     *  ??¬? μ§? κ°?? Έ?€κΈ?. κΈ°λ³Έ?¬λ§·μ ?©(yyyy/MM/dd)
     *  @return ??¬?Ό? yyyy/MM/dd??
     */
    public static String getToday() {        
        return getToday("yyyyMMdd");        
    }
     
    /** 
     * ?? ₯λ°μ? ??? λ§λ ??¬? μ§?(?κ°?) κ°?? Έ?€κΈ? 
     * @param fmt ? μ§ν?
     * @return ??¬?Ό?        
     */
    public static String getToday(String fmt) {        
        SimpleDateFormat sfmt = new SimpleDateFormat(fmt);        
        return  sfmt.format(new Date());        
    }
    
    /**
     * Date?? yyyy-MM-dd?? String?Όλ‘? λ³??.
     * @param date ? μ§? Date? 
     * @return ? μ§? String?. null?Ό κ²½μ° null return
     */     
    public static String dateToString(Date date) {        
        if( date != null )   
            return  dateToString(date, "yyyy/MM/dd");        
        else
            return  null;
    }
    
    /**
     * Date?? ??? ?¬λ§·μΌλ‘? λ³????¬ ?€?Έλ§μΌλ‘? ? ???€. 
     * @param date ? μ§? Date? 
     * @return ? μ§? String?. null?Ό κ²½μ° null return
     */     
    public static String dateToString(Date date, String fmt) {        
        if (date != null && fmt != null) {
            SimpleDateFormat sfmt = new SimpleDateFormat(fmt);        
            return  sfmt.format(date);        
        } else 
            return null;
    }    
    
    /**
     * ?Ή?  Format? String? Dateλ‘? λ³?? 
     * @param date ? μ§? String?
     * @param fmt ? μ§? String?? Format 
     * @return ? μ§? Date?. ? μ§? String?? ?€λ₯κ? ?? κ²½μ° null return
     */
    public  static java.util.Date stringToDate(String date, String fmt ) {
        
        if ( date != null && fmt != null ) {
            SimpleDateFormat sfmt = new SimpleDateFormat(fmt);                    
            try {
                return  sfmt.parse(date);                    
            } catch (ParseException pe) {                
                return null;
            }
        } else 
            return null;
    }
    /**
     * java.util.Dateλ₯? java.sql.Dateλ‘? λ³?? 
     */
    public static java.sql.Date dateToSqlDate(java.util.Date date ) {
        return new java.sql.Date(date.getTime());
    }
    

	public static String getTimeStamp() {
		return getTimeStamp(1);
	}

	public static String getTimeStamp(int iMode) {
		String sFormat;
		// if (iMode == 1) sFormat = "E MMM dd HH:mm:ss z yyyy";   // Wed Feb 03 15:26:32 GMT+09:00 1999
		if (iMode == 1) sFormat = "MMMM dd, yyyy HH:mm:ss z";   // Jun 03, 2001 15:26:32 GMT+09:00
		else if (iMode == 2) sFormat = "MM/dd/yyyy";// 02/15/1999
		else if (iMode == 3) sFormat = "yyyyMMdd";// 19990215
		else if (iMode == 4) sFormat = "HHmmss";// 121241
		else if (iMode == 5) sFormat = "dd MMM yyyy";// 15 Jan 1999
		else if (iMode == 6) sFormat = "yyyyMMddHHmm"; //200101011010
		else if (iMode == 7) sFormat = "yyyyMMddHHmmss"; //20010101101052
		else if (iMode == 8) sFormat = "HHmmss";
		else if (iMode == 9) sFormat = "yyyy/MM/dd"; //2010-11-05
		else if (iMode == 10) sFormat = "kk"; // 
		else if (iMode == 11) sFormat = "yyyy-MM-dd HH:mm"; //
		else if (iMode == 12) sFormat = "yyyy-MM-dd HH:mm:ss"; //
		else sFormat = "E MMM dd HH:mm:ss z yyyy";// Wed Feb 03 15:26:32 GMT+09:00 1999

		Locale locale = new Locale("en", "EN");
		// SimpleTimeZone timeZone = new SimpleTimeZone(32400000, "KST");
		SimpleDateFormat formatter = new SimpleDateFormat(sFormat, locale);
		// formatter.setTimeZone(timeZone);
		// SimpleDateFormat formatter = new SimpleDateFormat(sFormat);

		return formatter.format(new Date());
	}

	public static String getDate() {
		// return getDate(0);
		return getTimeStamp(3);
	}

	/**
	 * ?€? ? μ§μ? μ§?? ? ? ?λ₯? κ³μ°? ? μ§? λ°ν
	 */
	public static String getDate(int i) {
		return getDate(1, null, i);
	}

	/**
	 * μ§?? ? ? μ§μ? μ§?? ? ? ?λ₯? κ³μ°? ? μ§? λ°ν
	 */
	public static String getDate(String sDate, int i) {
		return getDate(1, sDate, i);
	}

	/**
	 * μ§?? ? ? μ§μ? μ§?? ? ? ?λ₯? κ³μ°? ? μ§? λ°ν <br>
	 * @param iType ?/?€λ‘? κ³μ°?  ?¨? (1:?Ό ?¨?, 2:? ?¨?, 3:? ?¨?)
	 * @param sDate κΈ°μ??΄ ?? ? μ§? - null?Ό κ²½μ°, ?€? ? μ§λ?? κΈ°μ?
	 * @param i ?/?€λ‘? μ¦κ?/κ°μ ??¬ ?
	 */
	public static String getDate(int iType, String sDate, int i) {

		if (sDate == null) sDate = getTimeStamp(3);

		if (i == 0) return sDate;
		else {
			Calendar cal = Calendar.getInstance();
			if(sDate.length() == 8){
				cal.set(Integer.parseInt(sDate.substring(0, 4))
					, Integer.parseInt(sDate.substring(4, 6)) - 1
					, Integer.parseInt(sDate.substring(6, 8)));
			}else if(sDate.length() == 10){
				cal.set(Integer.parseInt(sDate.substring(0, 4))
					, Integer.parseInt(sDate.substring(5, 7)) - 1
					, Integer.parseInt(sDate.substring(8, 10)));
			}else if(sDate.length() == 6){
				cal.set(Integer.parseInt(sDate.substring(0, 4))
					, Integer.parseInt(sDate.substring(4, 6)) - 1
					, 1);
			}

			if (iType == 2) cal.add(Calendar.MONTH, i);			// ? ?¨?
			else if (iType == 3) cal.add(Calendar.YEAR, i);		// ? ?¨?
			else cal.add(Calendar.DATE, i);						// ?Ό ?¨?

			int iYear = cal.get(Calendar.YEAR);
			int iMonth = cal.get(Calendar.MONTH) + 1;
			int iDate = cal.get(Calendar.DATE);

			String sNewDate = "" + iYear;
			if (iMonth < 10) sNewDate += "0" + iMonth;
			else sNewDate += "" + iMonth;
			if (iDate < 10) sNewDate += "0" + iDate;
			else sNewDate += "" + iDate;

			return sNewDate;
		}
	}
	
	public static String getDateTime(int iType, String sDate, int i) {

		if (sDate == null) sDate = getTimeStamp(7);

		if (i == 0) return sDate;
		else {
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(sDate.substring(0, 4))
				, Integer.parseInt(sDate.substring(4, 6)) - 1
				, Integer.parseInt(sDate.substring(6, 8))
				, Integer.parseInt(sDate.substring(8, 10))
				, Integer.parseInt(sDate.substring(10, 12))
				, Integer.parseInt(sDate.substring(12, 14)));


			if (iType == 1) {
				cal.add(Calendar.SECOND, i);		// μ΄λ¨?
			} else if (iType == 2) {
				cal.add(Calendar.MINUTE, i);		// λΆλ¨?
			} else if (iType == 3) {
				cal.add(Calendar.HOUR_OF_DAY, i);	// ?κ°λ¨?
			} else if (iType == 4) {
				cal.add(Calendar.DATE, i);			// ?Ό?¨?
			} else if (iType == 5) {
				cal.add(Calendar.DATE, (i*7));		// μ£Όλ¨?
			} else if (iType == 6) {
				cal.add(Calendar.MONTH, i);			// ??¨?
			} else if (iType == 7) {
				cal.add(Calendar.YEAR, i);			// ??¨?
			}

			int iYear = cal.get(Calendar.YEAR);
			int iMonth = cal.get(Calendar.MONTH) + 1;
			int iDate = cal.get(Calendar.DATE);
			int iHour = cal.get(Calendar.HOUR_OF_DAY);
			int iMinute = cal.get(Calendar.MINUTE);
			int iSecond = cal.get(Calendar.SECOND);

			String sNewDate = "" + iYear;
			if (iMonth < 10) {
				sNewDate += "0" + iMonth;
			} else {
				sNewDate += iMonth;
			}
			if (iDate < 10) {
				sNewDate += "0" + iDate;
			} else {
				sNewDate += iDate;
			}
			if (iHour < 10) {
				sNewDate += "0" + iHour;
			} else {
				sNewDate += iHour;
			}
			if (iMinute < 10) {
				sNewDate += "0" + iMinute;
			} else {
				sNewDate += iMinute;
			}
			if (iSecond < 10) {
				sNewDate += "0" + iSecond;
			} else {
				sNewDate += iSecond;
			}

			return sNewDate;
		}
	}

	/** 
	 * ?€? ? μ§λ³΄?€ ?Όμ£ΌμΌ ?  ? μ§λ?? λ°ν??€.
	 */
	public static String getPreviousWeek() {
		return getDate(1, null, -7);
	}

	/** 
	 * ?€? ? μ§λ³΄?€ ??¬ ?  ? μ§λ?? λ°ν??€.
	 */
	public static String getPreviousMonth() {
		return getDate(2, null, -1);
	}
	
	/**
	 * ??¬ ??λ₯? λ°ν / by sjm
	 */
	public static String getNowYear(){
		return getToday("yyyy"); 
		
	}
	
	/**
	 * ??¬ ?? λ°ν / by sjm
	 */
	public static String getNowMonth(){
		String monthToString = getToday("MM"); 
		return String.valueOf(Integer.parseInt(monthToString));
	}
	
	/**
	 * ??¬ ?Ό? λ°ν / by sjm
	 */
	public static String getNowDay(){
		String dayToString  = getToday("dd");
		return String.valueOf(Integer.parseInt(dayToString));
	}
	
	/**
	 * ??¬ ?κ°μ λ°ν / by sjm
	 */
	public static String getNowTime(){
		String timeToString = getToday("HH");
		return String.valueOf(Integer.parseInt(timeToString));
	}
	
	/**
	 * 1?¬?  ?? λ°ν / by sjm
	 */
	public static String getOneMonthBefore(){
	String OneMonthBefore = getDate(2, null, -1); //1?¬? 
	String OneMonthBeforeToString[] = OneMonthBefore.split("-"); 
	return String.valueOf(Integer.parseInt(OneMonthBeforeToString[1]));
	}
	
	/**
	 * 1?Ό ?΄?  ?Ό? λ°ν / by sjm
	 */
	public  static String getOneDayBefore(){
	String OneDayBefore = getDate(1, null, -1); //1?Ό? 
	String OneDayBeforeToString[] = OneDayBefore.split("-");
	return String.valueOf(Integer.parseInt(OneDayBeforeToString[2]));
	}
	
	/**
	 * 1?κ°? ?  ?κ°μ λ°ν / by sjm
	 */
	public static String getBeforeTime(){
		String nowTime = getNowTime();
		if(nowTime.equals("0")){
			return "23";
		} else {
			return String.valueOf(Integer.parseInt(nowTime)-1); 
		}
	}
	
	public static String getDateFileDir(String userId){
		return DateUtils.getNowYear() + "/" + DateUtils.getNowMonth() + "/" + DateUtils.getNowDay() + DateUtils.getTimeStamp(4) + "_" + userId + "_";
	}
	
	public static String getDateFile(String userId){
		return DateUtils.getTimeStamp(7) + "_" + userId + "_";
	}
	
	public static String getDateString(String Date){
		String returnValue = "";
		
		if(Date != null && Date != ""){
			if(Date.length()!=8)
				returnValue = Date;
			else{
				returnValue = Date.substring(0, 4) + "/" + Date.substring(4, 6) + "/" + Date.substring(6, 8);
			}
		}
		
		return returnValue.trim();
	}
}
