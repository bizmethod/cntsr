/**
 * 
 */
package mcommercelab.cntsr.common;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mcommercelab.cntsr.interceptor.AbstractAuthCheckInterceptor;

/**
 * <pre>
 * squarenet.smartq.common
 * FileService.java
 * </pre>
 * @author	:	ckh
 * @Date	:	2012. 11. 1.
 * @Version	:	JDK 1.6.0
 * @Description	:	
 */
public class FileService {
	
	protected static Log logger = LogFactory.getLog(AbstractAuthCheckInterceptor.class);
	
	private String UniqueId;				//(?ƒ?„±? get)
	private String FileDir;					//???¥ ?´?”(get, set)
	private String OrgFileName;				//?›ë³? ?ŒŒ?¼ëª?(get)

	private String CallFileName;			//ëª…ëª…?•œ ?ŒŒ?¼ëª?(set)
	private String SaveFileName;			//???¥?œ ?ŒŒ?¼ëª?(get)
	
	private boolean AddUniqueId = false;			//?ŒŒ?¼ëª? ?’¤?— ?ƒ?„±?œ ?œ ?‹‰?‚¤ë¥? ë¶™ì¼ì§? ?—¬ë¶? default=false(get, set)
	private boolean AddNumberIncrease = false;		//?ŒŒ?¼ëª…ì´ ?™?¼?‹œ?— ?„˜ë²? ì¦ê?ê°’ì„ ë¶™ì¼ì§? ?—¬ë¶? false ?¼ê²½ìš° ?—…?–´?“´?‹¤. default=false(get, set)
	
	private String ThumbnailFileDir;			//?„¬?„¤?¼ ???¥ ?´?”(get, set)
	private String ThumbnailCallFileName;		//?„¬?„¤?¼ ëª…ëª…?•œ ?ŒŒ?¼ëª?(set)
	private String ThumbnailSaveFileName;		//?„¬?„¤?¼ ???¥?œ ?ŒŒ?¼ëª?(get)
	
	private int FileWidth = 0;						//?´ë¯¸ì? ?„“?´
	private int FileHeight = 0;						//?´ë¯¸ì? ?†’?´
	private boolean oboveFileWidthHeight = false;	//?´ë¯¸ì? ?„“?´???†’?´ë¥? ?”± ë§ê²Œ (false), ê·? ?´?ƒ(true) ?œ¼ë¡? ?…‹?Œ…
	private String AllowedExtention = "";
	private long FileSize = 0;						//ë°›ì•„?˜¤?Š” ?ŒŒ?¼ ?‚¬?´ì¦?
//	private long LimitFileSize = 0;					//ì§?? •?•˜?Š” ?ŒŒ?¼ ?‚¬?´ì¦?
	
	
//	/**
//	 * @param limitFileSize the limitFileSize to set
//	 */
//	public void setLimitFileSize(long limitFileSize) {
//		LimitFileSize = limitFileSize;
//	}

	/**
	 * @return the fileSize
	 */
	public long getFileSize() {
		return FileSize;
	}
	
	/**
	 * @return the fileWidth
	 */
	public int getFileWidth() {
		return FileWidth;
	}
	
	/**
	 * @return the fileHeight
	 */
	public int getFileHeight() {
		return FileHeight;
	}
	
	/**
	 * @param oboveFileWidthHeight the oboveFileWidthHeight to set
	 */
	public void setOboveFileWidthHeight(boolean oboveFileWidthHeight) {
		this.oboveFileWidthHeight = oboveFileWidthHeight;
	}
	
	/**
	 * @param fileWidth the fileWidth to set
	 */
	public void setFileWidth(int fileWidth) {
		FileWidth = fileWidth;
	}
	
	/**
	 * @param fileHeight the fileHeight to set
	 */
	public void setFileHeight(int fileHeight) {
		FileHeight = fileHeight;
	}
	
	/**
	 * @param allowedExtention the allowedExtention to set
	 */
	public void setAllowedExtention(String allowedExtention) {
		AllowedExtention = allowedExtention;
	}
	
	public FileService(){
		UniqueId = StaticClass.createUUID();
	}
	
	
	/**
	 * @return the addUniqueId
	 */
	public boolean isAddUniqueId() {
		return AddUniqueId;
	}

	/**
	 * @param addUniqueId the addUniqueId to set
	 */
	public void setAddUniqueId(boolean addUniqueId) {
		AddUniqueId = addUniqueId;
	}

	/**
	 * @return the addNumberIncrease
	 */
	public boolean isAddNumberIncrease() {
		return AddNumberIncrease;
	}

	/**
	 * @param addNumberIncrease the addNumberIncrease to set
	 */
	public void setAddNumberIncrease(boolean addNumberIncrease) {
		AddNumberIncrease = addNumberIncrease;
	}
	
	
	/**
	 * @return the fileDir
	 */
	public String getFileDir() {
		return FileDir;
	}


	/**
	 * @param fileDir the fileDir to set
	 */
	public void setFileDir(String fileDir) {
		FileDir = fileDir;
	}


	/**
	 * @return the sumnailFileDir
	 */
	public String getThumbnailFileDir() {
		return ThumbnailFileDir;
	}


	/**
	 * @param sumnailFileDir the sumnailFileDir to set
	 */
	public void setThumbnailFileDir(String thumbnailFileDir) {
		ThumbnailFileDir = thumbnailFileDir;
	}


	
	/**
	 * @param callFileName the orgFileName to set
	 */
	public void setOrgFileName(String orgFileName) {
		OrgFileName = orgFileName;
	}
	
	/**
	 * @return the orgFileName
	 * @throws UnsupportedEncodingException 
	 */
	public String getOrgFileName(HttpServletRequest request) throws UnsupportedEncodingException {
		return new String(((MultipartHttpServletRequest) request).getFile(OrgFileName).getOriginalFilename().getBytes("iso-8859-1"), "utf-8");
	}


	/**
	 * @param callFileName the callFileName to set
	 * @throws UnsupportedEncodingException 
	 */
	public void setCallFileName(String callFileName) throws UnsupportedEncodingException {
		CallFileName = callFileName;
	}


	/**
	 * @param sumnailCallFileName the sumnailCallFileName to set
	 */
	public void setThumbnailCallFileName(String thumbnailCallFileName) {
		ThumbnailCallFileName = thumbnailCallFileName;
	}


	/**
	 * @return the saveFileName
	 */
	public String getSaveFileName() {
		return SaveFileName;
	}


	/**
	 * @return the sumnailSaveFileName
	 */
	public String getThumbnailSaveFileName() {
		return ThumbnailSaveFileName;
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?Š¤?¬ë¦°ìƒ·?˜ ?ŒŒ?¼ëª…ì„ ?ˆœ?„œ??ë¡? ì§?? •?•œ?‹¤.
	 * </pre>
	 * @Date	:	2012. 12. 3.	
	 * @Return	:	String
	 */
//	public String findScreenFile(String number) throws IllegalStateException, IOException, SmartQException{
//		for(int i = 1; i<6; i++){
//			File mFile = new File(FileDir + "screenshot" + i + ".png");
//			logger.debug("mFile--" + mFile.getName());
//			if(!mFile.exists()){
//				
//				filename = "screenshot" + number;
//				logger.debug("filename--" + filename);
//				break;
//			}
//			if(i == 4)
//				throw new SmartQException("603");
//		}
//		
//		return filename;
//	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?ŒŒ?¼ ???¥
	 * </pre>
	 * @throws SmartQException 
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	String
	 */
	public String makeFile(HttpServletRequest request) throws IllegalStateException, IOException, SmartQException{
		
		if(((MultipartHttpServletRequest) request).getFile(OrgFileName).getSize() > 500000000)
			throw new SmartQException("604");
		FileSize = ((MultipartHttpServletRequest) request).getFile(OrgFileName).getSize();
		String Extension = ExtractionExtension(((MultipartHttpServletRequest) request).getFile(OrgFileName).getOriginalFilename());
		
		//?ŒŒ?¼ ?™•?¥? ë§ì? ?•Š?„?‹œ
		if(AllowedExtention != ""){
			//logger.debug("AllowedExtention--" + AllowedExtention + "___" + Extension);
			if(AllowedExtention.indexOf(Extension) < 0)
				throw new SmartQException("601");
		}
		 
		
		if(AddUniqueId)
			SaveFileName = CallFileName + "_" + UniqueId + Extension;
		else
			SaveFileName = CallFileName + Extension;
		
		File mFile = new File(FileDir + SaveFileName);
		
		
		//?ŒŒ?¼ ?¬ê¸? ë§ì? ?•Š?„?‹œ
		if(FileWidth != 0 && FileHeight != 0){
			BufferedImage bi = ImageIO.read(((MultipartHttpServletRequest) request).getFile(OrgFileName).getInputStream());
			
			if(oboveFileWidthHeight){
				if((bi.getHeight() < FileHeight) || (bi.getWidth() < FileWidth))
					throw new SmartQException("602");
			}
			else{
				if((bi.getHeight() != FileHeight) || (bi.getWidth() != FileWidth))
					throw new SmartQException("602");
			}
		}
		
		if(AddNumberIncrease)
			mFile = rename(mFile);

		if(!mFile.exists()){
			mFile.mkdirs();
		}
		((MultipartHttpServletRequest) request).getFile(OrgFileName).transferTo(mFile);
		
		return SaveFileName;
	}
	
	public boolean deleteFile(String tempdirectory) throws IOException {
		boolean result = false;
		File targetFile = new File(tempdirectory);
		if(new File(tempdirectory).exists())
			result = targetFile.delete();
		return result;
	}
	
	public boolean deleteFile(String directory, String filename) throws IOException {
		boolean result = false;
		File targetFile = new File(directory+"/"+filename);
		if(new File(directory+"/"+filename).exists()){
			result = targetFile.delete();
		}
		return result;
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?„¬?„¤?¼ ?ŒŒ?¼ ???¥
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	String
	 */
	public String makeThumbnailFile(int Height, int Width) throws IllegalStateException, IOException{
		if(this.ThumbnailFileDir==null||this.ThumbnailFileDir.equals("")){
			this.ThumbnailFileDir = this.FileDir;
		}
		if(this.ThumbnailCallFileName==null||this.ThumbnailCallFileName.equals("")){
			this.ThumbnailCallFileName = this.SaveFileName.split("\\.")[0] + "_thumbnail";
		}
		ThumbnailSaveFileName = ThumbnailCallFileName + ExtractionExtension(SaveFileName);
		
		File save = new File(this.ThumbnailFileDir+this.ThumbnailSaveFileName); // ?¸?„¤?¼ ?´ë¯¸ì? ?ŒŒ?¼
		if(!save.exists()){
			save.mkdirs();
		}
		FileInputStream fis = new FileInputStream(this.FileDir+this.SaveFileName);

		BufferedImage im = ImageIO.read(fis);
		BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // ë©”ëª¨ë¦¬ì— ?´ë¯¸ì? ê³µê°„?„ ?ƒ?„±
		Graphics2D g2 = thumb.createGraphics(); // BufferedImageë¡? ë¶??„° Graphics2Dê°ì²´ë¥? ?–»?–´?ƒ„

		g2.drawImage(im, 0, 0, Width, Height, null); // ë©”ëª¨ë¦¬ì˜ ?´ë¯¸ì?ê³µê°„?— ?›ë³? ?´ë¯¸ì?ë¥? ê°?ë¡? ?„¸ë¡œë¡œ ê·¸ë¦°?‹¤.
		
		ImageIO.write(thumb, this.SaveFileName.split("\\.")[1], save); // ë©”ëª¨ë¦¬ì— ê·¸ë¦°?´ë¯¸ì?ë¥? ?ŒŒ?¼ë¡? ???¥
		fis.close();
		return ThumbnailSaveFileName;
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?„¬?„¤?¼ ?ŒŒ?¼ ???¥
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	String
	 */
	public String makeThumbnailFile(int Height, int Width, HttpServletRequest request) throws IllegalStateException, IOException, Exception{
		//?ŒŒ?¼ ?™•?¥? ë§ì? ?•Š?„?‹œ
		if(AllowedExtention != ""){
			if(AllowedExtention.indexOf(ExtractionExtension(getOrgFileName(request))) < 0)
				throw new SmartQException("601");
		}
		
		if(this.ThumbnailFileDir==null||this.ThumbnailFileDir.equals("")){
			this.ThumbnailFileDir = this.FileDir;
		}
		if(this.ThumbnailCallFileName==null||this.ThumbnailCallFileName.equals("")){
			this.ThumbnailCallFileName = this.getOrgFileName(request).split("\\.")[0] + "_" + Height + "_" + Width;
		}
		ThumbnailSaveFileName = ThumbnailCallFileName + ExtractionExtension(getOrgFileName(request));
		
		
		File save = new File(this.ThumbnailFileDir+this.ThumbnailSaveFileName); // ?¸?„¤?¼ ?´ë¯¸ì? ?ŒŒ?¼
		if(!save.exists()){
			save.mkdirs();
		}
		InputStream is = getIs(request);
		BufferedImage im = ImageIO.read(is);
		BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // ë©”ëª¨ë¦¬ì— ?´ë¯¸ì? ê³µê°„?„ ?ƒ?„±
		Graphics2D g2 = thumb.createGraphics(); // BufferedImageë¡? ë¶??„° Graphics2Dê°ì²´ë¥? ?–»?–´?ƒ„

		g2.drawImage(im, 0, 0, Width, Height, null); // ë©”ëª¨ë¦¬ì˜ ?´ë¯¸ì?ê³µê°„?— ?›ë³? ?´ë¯¸ì?ë¥? ê°?ë¡? ?„¸ë¡œë¡œ ê·¸ë¦°?‹¤.
		
		ImageIO.write(thumb, getOrgFileName(request).split("\\.")[1], save); // ë©”ëª¨ë¦¬ì— ê·¸ë¦°?´ë¯¸ì?ë¥? ?ŒŒ?¼ë¡? ???¥
		is.close();
		return ThumbnailSaveFileName;
	}
	
	public boolean IsExists(String filePath) {
		File file = new File(filePath); 
		return file.exists();
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?´ë¯¸ì? ë³??™˜ ?ŒŒ?¼ ?ƒ?„±
	 * </pre>
	 * @Date	:	2013. 01. 15.	
	 * @Return	:	boolean
	 */
	public boolean makeImage(String orgPath, String savePath, int Height, int Width) throws IllegalStateException, IOException{
		
		boolean bResult = false;
		if (orgPath == null || orgPath.isEmpty()) {
			return bResult;
		}
		if (savePath == null || savePath.isEmpty()) {
			return bResult;
		}
		if (Height <= 0 || Width <= 0) {
			return bResult;
		}
		
		try {
			bResult = true;
			String path = savePath.substring(0,savePath.lastIndexOf("/"));
			File save = new File(path); // ?¸?„¤?¼ ?´ë¯¸ì? ?ŒŒ?¼
			File saveFile = new File(savePath);
			if(!save.exists()){
				save.mkdirs();
			}
			
			FileInputStream fis = new FileInputStream(orgPath);
	
			BufferedImage im = ImageIO.read(fis);
			BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // ë©”ëª¨ë¦¬ì— ?´ë¯¸ì? ê³µê°„?„ ?ƒ?„±
			Graphics2D g2 = thumb.createGraphics(); // BufferedImageë¡? ë¶??„° Graphics2Dê°ì²´ë¥? ?–»?–´?ƒ„
			g2.drawImage(im, 0, 0, Width, Height, null); // ë©”ëª¨ë¦¬ì˜ ?´ë¯¸ì?ê³µê°„?— ?›ë³? ?´ë¯¸ì?ë¥? ê°?ë¡? ?„¸ë¡œë¡œ ê·¸ë¦°?‹¤.
			
			String sFileExt = savePath.substring(savePath.lastIndexOf(".")+1, savePath.length()) ;
			ImageIO.write(thumb, sFileExt, saveFile); // ë©”ëª¨ë¦¬ì— ê·¸ë¦°?´ë¯¸ì?ë¥? ?ŒŒ?¼ë¡? ???¥
			
			fis.close();
		} catch (Exception e) {
			bResult = false;
		}
		
		return bResult;
	}
	
	public boolean makeImage(String orgPath, String savePath, int Height, int Width, Color bgcolor) throws IllegalStateException, IOException{
		
		boolean bResult = false;
		if (orgPath == null || orgPath.isEmpty()) {
			return bResult;
		}
		if (savePath == null || savePath.isEmpty()) {
			return bResult;
		}
		if (Height <= 0 || Width <= 0) {
			return bResult;
		}
		
		try {
			bResult = true;
			String path = savePath.substring(0,savePath.lastIndexOf("/"));
			File save = new File(path); // ?¸?„¤?¼ ?´ë¯¸ì? ?ŒŒ?¼
			File saveFile = new File(savePath);
			if(!save.exists()){
				save.mkdirs();
			}
			
			FileInputStream fis = new FileInputStream(orgPath);
	
			BufferedImage im = ImageIO.read(fis);
			BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // ë©”ëª¨ë¦¬ì— ?´ë¯¸ì? ê³µê°„?„ ?ƒ?„±
			Graphics2D g2 = thumb.createGraphics(); // BufferedImageë¡? ë¶??„° Graphics2Dê°ì²´ë¥? ?–»?–´?ƒ„
			g2.drawImage(im, 0, 0, Width, Height, bgcolor, null);

			
			String sFileExt = savePath.substring(savePath.lastIndexOf(".")+1, savePath.length()) ;
			ImageIO.write(thumb, sFileExt, saveFile); // ë©”ëª¨ë¦¬ì— ê·¸ë¦°?´ë¯¸ì?ë¥? ?ŒŒ?¼ë¡? ???¥
			
			fis.close();
		} catch (Exception e) {
			bResult = false;
		}
		
		return bResult;
	}

	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?””? ‰?† ë¦¬ì˜ ê²½ë¡œë¥? ë°›ì•„ ?‹¤ë¥? ê²½ë¡œ?— ???¥
	 * </pre>
	 * @Date	:	2012. 11. 19.	
	 * @Return	:	void
	 */
	public void copyDirectory(String tempdirectory , String targetdirectory) throws IOException {
		File tempFile = new File(tempdirectory);
		File targetFile = new File(targetdirectory);
        //?””? ‰?† ë¦¬ì¸ ê²½ìš°
        if (tempFile.isDirectory()) {         
        	
            //ë³µì‚¬?  Directoryê°? ?—†?œ¼ë©? ë§Œë“­?‹ˆ?‹¤.
    		if (!targetFile.exists()) {
            	targetFile.mkdirs();
            }
            
            String[] children = tempFile.list();
            for (int i=0; i<children.length; i++) {
            	copyDirectory(tempdirectory+"/"+children[i], targetdirectory+"/"+children[i]);
            }
        } else {
            //?ŒŒ?¼?¸ ê²½ìš°
        	if(targetFile.exists())
        		targetFile.delete();
        	
        	copy(tempFile, targetFile);
        }
        	
    }
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?ŒŒ?¼?˜ ê²½ë¡œë¥? ë°›ì•„ ?‹¤ë¥? ê²½ë¡œ?— ???¥
	 * </pre>
	 * @Date	:	2012. 12. 10.	
	 * @Return	:	void
	 */
	public void copyFile(String tempfile , String targetdir) throws IOException {
		
		File tempFile = new File(tempfile);
		File targetDir = new File(targetdir);
		
		if(targetDir.exists())
			targetDir.delete();
		if (!targetDir.exists())
			targetDir.mkdirs();
		
		copy(tempFile, new File(targetdir + "/" + tempFile.getName()));
    }
	
	public void copyFileName(String tempfile , String targetfile) throws IOException {
		
		File tempFile = new File(tempfile);
		String targetdir = targetfile.substring(0, targetfile.lastIndexOf("/"));
		logger.debug("--target_dir:"+targetdir);
		
		File targetDir = new File(targetdir);
		
		if (!targetDir.exists())
			targetDir.mkdirs();
		
		copy(tempFile, new File(targetfile));
    }	
	
	public void copy(File input, File output) throws IOException{
		
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(input));
		BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(output));
		int temp;
		while ((temp=in.read()) != -1) {
			out.write(temp);
		}
		in.close();
		out.flush();
		out.close();
	}
	
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?””? ‰?† ë¦? ?•ˆ?˜ ?ŒŒ?¼ ?‚­? œ
	 * </pre>
	 * @Date	:	2012. 12. 10.	
	 * @Return	:	void
	 */
	public void deleteFileInDirectory(String tempdirectory) throws IOException {
        String[] children = new File(tempdirectory).list();
        
        if(children != null){
        	for (int i=0; i<children.length; i++) {
            	File targetFile = new File(tempdirectory+"/"+children[i]);
            	targetFile.delete();
            }
        }
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?ŒŒ?¼ëª…ì„ ë°›ì•„?„œ ?™•?¥?ë¥? ë¦¬í„´
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	String
	 */
	public String ExtractionExtension(String str){
		String[] arrstr = str.split("\\.");
		String returnStr = "";
		if(arrstr.length > 1)
			returnStr = "." + arrstr[arrstr.length - 1];
		
		return returnStr.toLowerCase();
	}
	
	/**
	 * <pre>
	 * ì²˜ë¦¬?‚´?š© : ?ŒŒ?¼ ê°ì²´ë¥? ë°›ì•„?„œ ?™?¼?•œ ?ŒŒ?¼ëª…ì´ ?ˆ?œ¼ë©? +1 ?•˜?—¬ ?ŒŒ?¼ëª? ?¬? •?˜
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	File
	 */
	public File rename(File f) {             //File f?Š” ?›ë³? ?ŒŒ?¼
		if (createNewFile(f)) return f;        //?ƒ?„±?œ fê°? ì¤‘ë³µ?˜ì§? ?•Š?œ¼ë©? ë¦¬í„´
	     
	    String name = f.getName();
	    String body = null;
	    String ext = null;
	 
	    int dot = name.lastIndexOf(".");
	    if (dot != -1) {                              //?™•?¥?ê°? ?—†?„?•Œ
	    	body = name.substring(0, dot);
	    	ext = name.substring(dot);
	    } else {                                     //?™•?¥?ê°? ?ˆ?„?•Œ
	    	body = name;
	    	ext = "";
	    }
	 
	    int count = 0;
	    //ì¤‘ë³µ?œ ?ŒŒ?¼?´ ?ˆ?„?•Œ
	    //?ŒŒ?¼?´ë¦„ë’¤?— a?ˆ«?.?™•?¥? ?´? ‡ê²? ?“¤?–´ê°?ê²? ?˜?Š”?° ?ˆ«??Š” 9999ê¹Œì? ?œ?‹¤.
	    while (!createNewFile(f) && count < 9999) {  
	    	count++;
	    	SaveFileName = body + count + ext;
	    	f = new File(f.getParent(), SaveFileName);
	    }
	    return f;
	  }
	
	private boolean createNewFile(File f) { 
		  try {
			  return f.createNewFile();                        //ì¡´ì¬?•˜?Š” ?ŒŒ?¼?´ ?•„?‹ˆë©?
		  }catch (IOException ignored) {
			  return false;
		  }
	  }
	public InputStream getIs(HttpServletRequest request) throws Exception{
		return ((MultipartHttpServletRequest) request).getFile(OrgFileName).getInputStream();
	}
}
