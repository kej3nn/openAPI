<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.common.util.SFTPSyncManager"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.util.UUID" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.io.File" %>
<%@page import="org.apache.commons.fileupload.FileItem" %>
<%@page import="java.util.List" %>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.io.FilenameUtils" %>
<%@page import="egovframework.com.cmm.EgovWebUtil" %>

<%
if(request.getContentLength() > 10*1024*1024) {
%>
	<script type="text/javascript">
		alert("업로드 제한 용량(10MB)을 초과하였습니다.");
		history.back();
	</script>
<%
	return;
} else { 

	String return1="";
	String return2="";
	String return3="";
	//변경 title 태그에는 원본 파일명을 넣어주어야 하므로
	String name = "";
	String allowURL[] = {"/portal/bbs/selectBbsThumbnail.do"};
	
	if (ServletFileUpload.isMultipartContent(request)){
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		uploadHandler.setHeaderEncoding("UTF-8");
		List<FileItem> items = uploadHandler.parseRequest(request);
		for (FileItem item : items) {
			if(item.getFieldName().equals("callback")) {
				return1 = item.getString("UTF-8");
			} else if(item.getFieldName().equals("callback_func")) {
				return2 = "?callback_func="+item.getString("UTF-8");
			} else if(item.getFieldName().equals("Filedata")) {
				if(item.getSize() > 0) {
					//String name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
	                // 기존 상단 코드를 막고 하단코드를 이용
	                name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
					String filename_ext = name.substring(name.lastIndexOf(".")+1);
					filename_ext = filename_ext.toLowerCase();
				   	String[] allow_file = {"jpg","png","bmp","gif"};
				   	int cnt = 0;
				   	for(int i=0; i < allow_file.length; i++) {
				   		if(filename_ext.equals(allow_file[i])){
				   			cnt++;
				   		}
				   	}
				   	if(cnt == 0) {
				   		return3 = "&errstr="+name;
				   	} else {
				   		
				   		//파일 기본경로
			    		//String dftFilePath = request.getServletContext().getRealPath("/");
				   		String dftFilePath = EgovProperties.getProperty("Globals.BodyAttImgPath");
				   		dftFilePath = EgovWebUtil.folderPathReplaceAll(dftFilePath);
				   		
			    		//파일 기본경로 _ 상세경로
						SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
						String todayDir = formatter.format(new java.util.Date());
			    		String filePath = dftFilePath + todayDir + File.separator;
			    		filePath = EgovWebUtil.folderPathReplaceAll(filePath);
			    		
			    		File file = null;
			    		file = new File(filePath);
			    		// 수정 : 권한 설정
			            file.setExecutable(true, true);
			            file.setReadable(true);
			            file.setWritable(true, true);
			            
			    		if(!file.exists()) {
			    			file.mkdirs();
			    		}
			    		
			    		String realFileNm = "";
			    		formatter = new SimpleDateFormat("yyyyMMddHHmmss");
						String today= formatter.format(new java.util.Date());
						//realFileNm = today+UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
						realFileNm = today+UUID.randomUUID().toString();
						String fileExt = FilenameUtils.getExtension(name);
						
						String rlFileNm = filePath + realFileNm + "." + fileExt;
						
						///////////////// 서버에 파일쓰기 /////////////////
						InputStream is = item.getInputStream();
						FileOutputStream os = null;
						try {
							os = new FileOutputStream(rlFileNm);
							int numRead;
							byte b[] = new byte[(int)item.getSize()];
							while((numRead = is.read(b,0,b.length)) != -1){
								os.write(b,0,numRead);
							}
							
							os.flush();
						} catch(IOException ioe) {
							EgovWebUtil.exLogging(ioe);
						} catch(Exception e) {
							EgovWebUtil.exLogging(e);
						} finally {
							try {
								if(is != null) {
									is.close();
								}
				        		if ( os != null ) {
				        			os.close();
				        		}
				        	} catch(IOException e) {
				        		EgovWebUtil.exLogging(e);
				        	} catch(Exception e) {
				        		EgovWebUtil.exLogging(e);
				        	}
						}
						
						///////////////// 서버에 파일쓰기 /////////////////
						String bodyAttImgUrl = EgovProperties.getProperty("Globals.BodyAttImgUrl");
						String returnUrl = "";
						
			    		return3 += "&bNewLine=true";
			    		return3 += "&sFileName="+ name;
			    		//return3 += "&sFileURL="+EgovProperties.getProperty("Globals.BodyAttImgDir") + todayDir + "/" + realFileNm;
			    		//return3 += "&sFileURL="+EgovProperties.getProperty("Globals.BodyAttImgUrl") + "/" + todayDir + "/" + realFileNm + "/" + fileExt;
			    		return3 += "&sFileDir=" + todayDir + "/" + realFileNm + "/" + fileExt;
			    		
			    		// 시큐어 코딩 URL 체크
			    		for ( int i=0; i < allowURL.length; i++ ) {
			    			if ( bodyAttImgUrl.equals(allowURL[i]) ) {
				    			returnUrl = allowURL[i];
				    			break;
				    		}
			    		}
			    		return3 += "&sFileURL="+ returnUrl;

						///////////////// 미러 서버에 sftp 전송 /////////////
// 						if(EgovProperties.getProperty("sftp.option").equals("on")){
// 							SFTPSyncManager sftp = new SFTPSyncManager();
// 							sftp.runsftp("U", filePath, filePath);
// 						}
						///////////////////////////////////////////////////
						
				   	}
				}else {
					  return3 += "&errstr=error";
				}
			}
		}
	}
	response.sendRedirect(return1+return2+return3);
}
%>