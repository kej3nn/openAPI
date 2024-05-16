package egovframework.portal.infs.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.lang.StringUtils;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;

/**
 * 정보공개 목록 일괄 다운로드 클래스
 * 
 * @author	jhkim
 * @version 1.0
 * @since   2020/05/14
 */
public class PortalInfsListDownload {
	
	private static final String FILE_EXT = ".zip";
	String fileName = "";
	
	private static void createZip(HttpServletResponse response, Params params, List<Record> dsList) {
		FileInputStream fis = null;
		ZipArchiveOutputStream zos = null;
		BufferedInputStream bis = null;
		
		int size = 1024;
		byte[] buf = new byte[size];
		
		try {
			OutputStream out = response.getOutputStream();
			zos = new ZipArchiveOutputStream(out);
			
			String downDir = "/apps/iopen/attach/multidown";
			File zipDir = new File(downDir);
			String files[] = zipDir.list();
			
			for ( Record dataset : dsList ) {
				String infaId = dataset.getString("infaId");
				String infaNm = dataset.getString("infaNm");
				infaNm = infaNm.replaceAll("/", "");
				String opentyTagNm = dataset.getString("opentyTagNm");
				
				for (int i = 0; i < files.length; i++) {
					String fileName = "";
					String name = files[i];
					
					// 해당 폴더안에 다른 폴더가 있다면 지나간다.
					if (new File(downDir + "/" + name).isDirectory()) {
						continue;
					}
					
					String __infaId = name.substring(0, name.lastIndexOf("."));

					if ( infaId.equals(__infaId) ) {
						fileName = opentyTagNm + "_" + infaNm + ".xlsx";
					}
					
					if ( fileName.equals("") )	{
						continue;
					}
					
					// encoding 설정
					zos.setEncoding("UTF-8");
					
					fis = new FileInputStream(downDir + File.separator + name);
					bis = new BufferedInputStream(fis, size);

					// zip에 넣을 다음 entry 를 가져온다.
					zos.putArchiveEntry(new ZipArchiveEntry(fileName));
					
					// 준비된 버퍼에서 집출력스트림으로 write 한다.
					int len;
					while ((len = bis.read(buf, 0, size)) != -1) {
						zos.write(buf, 0, len);
					}

					bis.close();
					fis.close();
					zos.closeArchiveEntry();
				}
				
			}
			
			zos.close();
			out.flush();
		} catch (FileNotFoundException e) {
			EgovWebUtil.exLogging(e);
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			if (zos != null) {
				try {
					zos.close(); 
				} catch(Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}

			if (fis != null) {
				try { 
						fis.close(); 
					} catch(Exception e) {
						EgovWebUtil.exLogging(e);
					}
			}

			if (bis != null) {
				try { 
					bis.close(); 
					} catch(Exception e) {
						EgovWebUtil.exLogging(e);
					}
			}
		}
		
	}

	public static void download(HttpServletResponse response, HttpServletRequest request, 
			Params params, List<Record> dsList) {
		
		ServletOutputStream out = null;
		
		StringBuffer fileName = new StringBuffer();
		String sysdate = new SimpleDateFormat("yyyyMMdd").format(new Date());
		
		try {
			fileName.append("download_");
			fileName.append(sysdate);
			fileName.append(FILE_EXT);
			params.put("fileName", fileName.toString());
			
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setContentType("application/zip; charset=utf-8");
			response.setHeader("set-cookie", "fileDownload=true; path=/");
			response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, StringUtils.defaultIfEmpty(fileName.toString(), "file"+FILE_EXT)));
			
			// ZIP 파일 생성
			createZip(response, params, dsList);
		} catch (UnsupportedEncodingException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Content-Type","text/html; charset=utf-8");
			OutputStream catchOut = null;
			try {
				
				catchOut = response.getOutputStream();
				byte[] data = new String("fail..").getBytes();
				catchOut.write(data, 0, data.length);
			} catch(IOException ee) {
				EgovWebUtil.exLogging(ee);
			} finally {
				if(out != null) try { out.close(); } 
				catch(Exception ee) {
					EgovWebUtil.exLogging(ee);  
				}
			}
		} finally {
			if ( out != null ) {
				try {
					out.close();
				} catch(IOException ioe){
					EgovWebUtil.exLogging(ioe);
				} catch(Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
		}
	}
}
