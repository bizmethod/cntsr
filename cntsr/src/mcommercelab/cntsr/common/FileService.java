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
	
	private String UniqueId;				//(?��?��?�� get)
	private String FileDir;					//???�� ?��?��(get, set)
	private String OrgFileName;				//?���? ?��?���?(get)

	private String CallFileName;			//명명?�� ?��?���?(set)
	private String SaveFileName;			//???��?�� ?��?���?(get)
	
	private boolean AddUniqueId = false;			//?��?���? ?��?�� ?��?��?�� ?��?��?���? 붙일�? ?���? default=false(get, set)
	private boolean AddNumberIncrease = false;		//?��?��명이 ?��?��?��?�� ?���? 증�?값을 붙일�? ?���? false ?��경우 ?��?��?��?��. default=false(get, set)
	
	private String ThumbnailFileDir;			//?��?��?�� ???�� ?��?��(get, set)
	private String ThumbnailCallFileName;		//?��?��?�� 명명?�� ?��?���?(set)
	private String ThumbnailSaveFileName;		//?��?��?�� ???��?�� ?��?���?(get)
	
	private int FileWidth = 0;						//?��미�? ?��?��
	private int FileHeight = 0;						//?��미�? ?��?��
	private boolean oboveFileWidthHeight = false;	//?��미�? ?��?��???��?���? ?�� 맞게 (false), �? ?��?��(true) ?���? ?��?��
	private String AllowedExtention = "";
	private long FileSize = 0;						//받아?��?�� ?��?�� ?��?���?
//	private long LimitFileSize = 0;					//�??��?��?�� ?��?�� ?��?���?
	
	
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
	 * 처리?��?�� : ?��?��린샷?�� ?��?��명을 ?��?��??�? �??��?��?��.
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
	 * 처리?��?�� : ?��?�� ???��
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
		
		//?��?�� ?��?��?�� 맞�? ?��?��?��
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
		
		
		//?��?�� ?���? 맞�? ?��?��?��
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
	 * 처리?��?�� : ?��?��?�� ?��?�� ???��
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
		
		File save = new File(this.ThumbnailFileDir+this.ThumbnailSaveFileName); // ?��?��?�� ?��미�? ?��?��
		if(!save.exists()){
			save.mkdirs();
		}
		FileInputStream fis = new FileInputStream(this.FileDir+this.SaveFileName);

		BufferedImage im = ImageIO.read(fis);
		BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // 메모리에 ?��미�? 공간?�� ?��?��
		Graphics2D g2 = thumb.createGraphics(); // BufferedImage�? �??�� Graphics2D객체�? ?��?��?��

		g2.drawImage(im, 0, 0, Width, Height, null); // 메모리의 ?��미�?공간?�� ?���? ?��미�?�? �?�? ?��로로 그린?��.
		
		ImageIO.write(thumb, this.SaveFileName.split("\\.")[1], save); // 메모리에 그린?��미�?�? ?��?���? ???��
		fis.close();
		return ThumbnailSaveFileName;
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?�� ?��?�� ???��
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	String
	 */
	public String makeThumbnailFile(int Height, int Width, HttpServletRequest request) throws IllegalStateException, IOException, Exception{
		//?��?�� ?��?��?�� 맞�? ?��?��?��
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
		
		
		File save = new File(this.ThumbnailFileDir+this.ThumbnailSaveFileName); // ?��?��?�� ?��미�? ?��?��
		if(!save.exists()){
			save.mkdirs();
		}
		InputStream is = getIs(request);
		BufferedImage im = ImageIO.read(is);
		BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // 메모리에 ?��미�? 공간?�� ?��?��
		Graphics2D g2 = thumb.createGraphics(); // BufferedImage�? �??�� Graphics2D객체�? ?��?��?��

		g2.drawImage(im, 0, 0, Width, Height, null); // 메모리의 ?��미�?공간?�� ?���? ?��미�?�? �?�? ?��로로 그린?��.
		
		ImageIO.write(thumb, getOrgFileName(request).split("\\.")[1], save); // 메모리에 그린?��미�?�? ?��?���? ???��
		is.close();
		return ThumbnailSaveFileName;
	}
	
	public boolean IsExists(String filePath) {
		File file = new File(filePath); 
		return file.exists();
	}
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��미�? �??�� ?��?�� ?��?��
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
			File save = new File(path); // ?��?��?�� ?��미�? ?��?��
			File saveFile = new File(savePath);
			if(!save.exists()){
				save.mkdirs();
			}
			
			FileInputStream fis = new FileInputStream(orgPath);
	
			BufferedImage im = ImageIO.read(fis);
			BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // 메모리에 ?��미�? 공간?�� ?��?��
			Graphics2D g2 = thumb.createGraphics(); // BufferedImage�? �??�� Graphics2D객체�? ?��?��?��
			g2.drawImage(im, 0, 0, Width, Height, null); // 메모리의 ?��미�?공간?�� ?���? ?��미�?�? �?�? ?��로로 그린?��.
			
			String sFileExt = savePath.substring(savePath.lastIndexOf(".")+1, savePath.length()) ;
			ImageIO.write(thumb, sFileExt, saveFile); // 메모리에 그린?��미�?�? ?��?���? ???��
			
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
			File save = new File(path); // ?��?��?�� ?��미�? ?��?��
			File saveFile = new File(savePath);
			if(!save.exists()){
				save.mkdirs();
			}
			
			FileInputStream fis = new FileInputStream(orgPath);
	
			BufferedImage im = ImageIO.read(fis);
			BufferedImage thumb = new BufferedImage(Width, Height, BufferedImage.TYPE_INT_ARGB); // 메모리에 ?��미�? 공간?�� ?��?��
			Graphics2D g2 = thumb.createGraphics(); // BufferedImage�? �??�� Graphics2D객체�? ?��?��?��
			g2.drawImage(im, 0, 0, Width, Height, bgcolor, null);

			
			String sFileExt = savePath.substring(savePath.lastIndexOf(".")+1, savePath.length()) ;
			ImageIO.write(thumb, sFileExt, saveFile); // 메모리에 그린?��미�?�? ?��?���? ???��
			
			fis.close();
		} catch (Exception e) {
			bResult = false;
		}
		
		return bResult;
	}

	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?��리의 경로�? 받아 ?���? 경로?�� ???��
	 * </pre>
	 * @Date	:	2012. 11. 19.	
	 * @Return	:	void
	 */
	public void copyDirectory(String tempdirectory , String targetdirectory) throws IOException {
		File tempFile = new File(tempdirectory);
		File targetFile = new File(targetdirectory);
        //?��?��?��리인 경우
        if (tempFile.isDirectory()) {         
        	
            //복사?�� Directory�? ?��?���? 만듭?��?��.
    		if (!targetFile.exists()) {
            	targetFile.mkdirs();
            }
            
            String[] children = tempFile.list();
            for (int i=0; i<children.length; i++) {
            	copyDirectory(tempdirectory+"/"+children[i], targetdirectory+"/"+children[i]);
            }
        } else {
            //?��?��?�� 경우
        	if(targetFile.exists())
        		targetFile.delete();
        	
        	copy(tempFile, targetFile);
        }
        	
    }
	
	/**
	 * <pre>
	 * 처리?��?�� : ?��?��?�� 경로�? 받아 ?���? 경로?�� ???��
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
	 * 처리?��?�� : ?��?��?���? ?��?�� ?��?�� ?��?��
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
	 * 처리?��?�� : ?��?��명을 받아?�� ?��?��?���? 리턴
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
	 * 처리?��?�� : ?��?�� 객체�? 받아?�� ?��?��?�� ?��?��명이 ?��?���? +1 ?��?�� ?��?���? ?��?��?��
	 * </pre>
	 * @Date	:	2012. 11. 5.	
	 * @Return	:	File
	 */
	public File rename(File f) {             //File f?�� ?���? ?��?��
		if (createNewFile(f)) return f;        //?��?��?�� f�? 중복?���? ?��?���? 리턴
	     
	    String name = f.getName();
	    String body = null;
	    String ext = null;
	 
	    int dot = name.lastIndexOf(".");
	    if (dot != -1) {                              //?��?��?���? ?��?��?��
	    	body = name.substring(0, dot);
	    	ext = name.substring(dot);
	    } else {                                     //?��?��?���? ?��?��?��
	    	body = name;
	    	ext = "";
	    }
	 
	    int count = 0;
	    //중복?�� ?��?��?�� ?��?��?��
	    //?��?��?��름뒤?�� a?��?��.?��?��?�� ?��?���? ?��?���?�? ?��?��?�� ?��?��?�� 9999까�? ?��?��.
	    while (!createNewFile(f) && count < 9999) {  
	    	count++;
	    	SaveFileName = body + count + ext;
	    	f = new File(f.getParent(), SaveFileName);
	    }
	    return f;
	  }
	
	private boolean createNewFile(File f) { 
		  try {
			  return f.createNewFile();                        //존재?��?�� ?��?��?�� ?��?���?
		  }catch (IOException ignored) {
			  return false;
		  }
	  }
	public InputStream getIs(HttpServletRequest request) throws Exception{
		return ((MultipartHttpServletRequest) request).getFile(OrgFileName).getInputStream();
	}
}
