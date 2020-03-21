package mcommercelab.cntsr.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;

/**
 * <pre>
 * squarenet.gklc.common
 * FileViewerController.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2014. 5. 8.
 * @Version	:	JDK 1.6.0
 * @Description	: ?��?��보기 �? ?��?��로드
 */
@Controller
@RequestMapping("VIEWER")
public class FileViewerController extends AbstractAuthCheckInterceptor {
	
		/**
		 * <pre>
		 * 처리?��?�� : 메인 ?��미�? 보기
		 * </pre>
		 * @Date	:	2014. 06. 26.	
		 * @Return	:	String
		 */
		@RequestMapping(value = "/main_img/{id}/{lang_typ}")
		public void main_img(@PathVariable("id") String id, @PathVariable("lang_typ") String lang_typ, HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.debug("VIEWER/main_img.. load");
			MVController mvc = new MVController(cd);
			id = mvc.StringRequest(id);
			lang_typ = mvc.StringRequest(lang_typ);
			
			HashMap<String, String> hm = new HashMap<String, String>();
			hm.put("main_img_id", id);
			hm.put("lang_typ", lang_typ);
			Map map = cd.getMapDao("viewer.main_img", hm);
			String file_path = map.get("FILE_PATH").toString();
			String file_nm = map.get("FILE_NM").toString();
			
			response.setContentType("application/octet-stream;charset=euc-kr");
			response.setContentType("application/xml;charset=EUC-KR");
			
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
			byte[] data = new byte[1024 * 1024];
			BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+file_path+file_nm)));  
			BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
			
			int count = 0;
			while((count = fis.read(data,0,data.length)) != -1){
				fos.write(data,0,count);
			}
			  
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}

		/**
		 * <pre>
		 * 처리?��?�� : ?��?��?�� ?��미�? 보기
		 * </pre>
		 * @Date	:	2012. 11. 29.	
		 * @Return	:	String
		 */
		@RequestMapping(value = "/player_img/{id}")
		public void player_img(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.debug("VIEWER/player_img.. load");
			MVController mvc = new MVController(cd);
			id = mvc.StringRequest(id);
			
			Map map = cd.getMapDao("viewer.player_img", id);
			String file_path = map.get("IMG_DIR").toString();
			String file_nm = map.get("IMG_NM").toString();
			
			response.setContentType("application/octet-stream;charset=euc-kr");
			response.setContentType("application/xml;charset=EUC-KR");
			
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
			byte[] data = new byte[1024 * 1024];
			BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+file_path+file_nm))); 
			BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
			
			int count = 0;
			while((count = fis.read(data,0,data.length)) != -1){
				fos.write(data,0,count);
			}
			
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
		
		/**
		 * <pre>
		 * 처리?��?�� : 브로?�� ?��미�? 보기
		 * </pre>
		 * @Date	:	2012. 11. 29.	
		 * @Return	:	String
		 */
		@RequestMapping(value = "/bro_img/{id}")
		public void bro_img(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.debug("VIEWER/bro_img.. load");
			MVController mvc = new MVController(cd);
			id = mvc.StringRequest(id);
			
			Map map = cd.getMapDao("viewer.bro_img", id);
			String file_path = map.get("IMG_DIR").toString();
			String file_nm = map.get("IMG_NM").toString();
			
			response.setContentType("application/octet-stream;charset=euc-kr");
			response.setContentType("application/xml;charset=EUC-KR");
			
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
			byte[] data = new byte[1024 * 1024];
			BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+file_path+file_nm))); 
			BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
			
			int count = 0;
			while((count = fis.read(data,0,data.length)) != -1){
				fos.write(data,0,count);
			}
			  
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
		
		/**
		 * <pre>
		 * 처리?��?�� : 브로?�� ?��?��?�� 보기
		 * </pre>
		 * @Date	:	2012. 11. 29.	
		 * @Return	:	String
		 */
		@RequestMapping(value = "/bro_thumb/{id}")
		public void bro_thumb(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
			logger.debug("VIEWER/bro_thumb.. load");
			MVController mvc = new MVController(cd);
			id = mvc.StringRequest(id);
			
			Map map = cd.getMapDao("viewer.bro_thumb", id);
			String file_path = map.get("IMG_DIR").toString();
			String file_nm = map.get("IMG_NM").toString();
			
			response.setContentType("application/octet-stream;charset=euc-kr");
			response.setContentType("application/xml;charset=EUC-KR");
			
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
			byte[] data = new byte[1024 * 1024];
			BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+file_path+file_nm))); 
			BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
			
			int count = 0;
			while((count = fis.read(data,0,data.length)) != -1){
				fos.write(data,0,count);
			}
			
			if(fis != null) fis.close();
			if(fos != null) fos.close();
		}
	
	/**
	 * <pre>
	 * 처리?��?�� : 첨�??��?�� ?��?��로드
	 * </pre>
	 * @Date	:	2013. 2. 28.	
	 * @Return	:	void
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/file/{id}")
	public void file(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("VIEWER/file.. load");
		
		MVController mvc = new MVController(cd);
		id = mvc.StringRequest(id);
		
		Map map = cd.getMapDao("viewer.file", id);
		String seq = map.get("TABLE_SEQ").toString();
		String file_path = map.get("FILE_DIR").toString();
		String file_nm = map.get("FILE_NM").toString();
		
		response.setContentType("application/octet-stream;charset=euc-kr");
		response.addHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode((String)map.get("ORG_FILE_NM"),"UTF-8"));
		response.setContentType("application/xml;charset=EUC-KR");
		
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		
		byte[] data = new byte[1024 * 1024];
//		BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("gklf.url")+(String)map.get("FILE_DIR")+"/"+(String)map.get("ORG_FILE_NM")))); 
		BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+file_path+"/"+seq+"/"+file_nm)));
		BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
		
		int count = 0;
		while((count = fis.read(data,0,data.length)) != -1){
			fos.write(data,0,count);
		}
		  
		if(fis != null) fis.close();
		if(fos != null) fos.close();
	}

	/**
	 * <pre>
	 * 처리?��?�� : 브로?�� ?��?�� ?��?��로드
	 * </pre>
	 * @Date	:	2013. 2. 28.	
	 * @Return	:	void
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/bro_file/{id}")
	public void bro_file(@PathVariable("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("VIEWER/bro_file.. load");
		
		MVController mvc = new MVController(cd);
		id = mvc.StringRequest(id);
		
		Map map = cd.getMapDao("viewer.bro_file", id);
		String seq = map.get("TABLE_SEQ").toString();
		
		response.setContentType("application/octet-stream;charset=euc-kr");
		response.addHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode((String)map.get("ORG_IMG_NM"),"UTF-8"));
		response.setContentType("application/xml;charset=EUC-KR");
		
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		
		byte[] data = new byte[1024 * 1024];
//		BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("gklf.url")+"/brochure/image/"+(String)map.get("ORG_IMG_NM")))); 
		BufferedInputStream fis = new BufferedInputStream(new FileInputStream(new File(CommonProperties.getConfigProperty("file.upload_path")+"/brochure/image/"+(String)map.get("IMG_NM")))); 
		BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
		
		int count = 0;
		while((count = fis.read(data,0,data.length)) != -1){
			fos.write(data,0,count);
		}
		
		if(fis != null) fis.close();
		if(fos != null) fos.close();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : 공공?���? ?��?? ?��?��로드
	 * </pre>
	 * @Date	:	2013. 2. 28.	
	 * @Return	:	void
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getExcelDown/{url}/{typ}")
	public void icExcelCoup(@PathVariable("url") String url, @PathVariable("typ") String typ, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("VIEWER/icExcelCoup.. load");
		
		MVController mvc = new MVController(cd);
		HashMap<String, String> hm = mvc.handleRequest(request);
		// ?��?? ?��?��
		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet();
		// ?��???��?��?��?��
		XSSFRow rh = sheet.createRow(0);
		rh.createCell(0).setCellValue("�?리번?��");
		rh.createCell(1).setCellValue("???��물형?��");
		rh.createCell(2).setCellValue("카테고리");
		rh.createCell(3).setCellValue("?���?");
		rh.createCell(4).setCellValue("?���?");
		rh.createCell(5).setCellValue("???��?��");
		rh.createCell(6).setCellValue("???��권자");
		rh.createCell(7).setCellValue("???��물URL");
		rh.createCell(8).setCellValue("공공기�??��?��?��URL");
		rh.createCell(9).setCellValue("?��?��?��?�� ?��?��");
		
		if(typ.equals("CM")){
			hm.put("noti_typ2", "SL");
		}else if(typ.equals("NO")){
			hm.put("noti_typ2", "NU");
		}
		
		hm.put("noti_typ1", typ);
		
		List list = cd.getListDao("COMM_SOC_00.getExcelDown", hm);
		String path = CommonProperties.getConfigProperty("cntsr.url")+url;
		// ?��???�� ?�� ?��?��?�� ?��?��
		for (int i=0;i<list.size();i++) {
			Map map = (HashMap)list.get(i);
			
			XSSFRow r = sheet.createRow(i+1);
			r.createCell(0).setCellValue(i+1);
			r.createCell(1).setCellValue("?��?��?��/?���?");
			r.createCell(2).setCellValue("기�?");
			r.createCell(3).setCellValue((String)map.get("TITLE"));
			r.createCell(4).setCellValue((String)map.get("TITLE")+"?�� ???�� 보도?���?");
			r.createCell(5).setCellValue("?��그랜?��코리?��?��??");
			r.createCell(6).setCellValue("?��그랜?��코리?��?��??");
			r.createCell(7).setCellValue(path+"/detail?seq="+String.valueOf(map.get("SEQ_NOTICE")));
			r.createCell(8).setCellValue("http://grandkorea.com");
			r.createCell(9).setCellValue((String)map.get("KOGL_OPEN_YN")+"+"+(String)map.get("KOGL_B_YN")+"+"+(String)map.get("KOGL_M_YN"));
		}
		String FileName="kogl_list.xlsx";
		
		response.setHeader("Content-Disposition", "attachment; filename=\""	+ FileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		wb.write(response.getOutputStream());
	}
	
}
