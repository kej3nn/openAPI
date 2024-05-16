<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.common.util.SFTPSyncManager"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@page import="java.io.*" %>
<%@page import="java.util.UUID" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="org.apache.commons.io.FilenameUtils" %>
<%@page import="egovframework.com.cmm.EgovWebUtil" %>
<%
	//파일정보
	String sFileInfo = "";
	//파일명을 받는다 - 일반 원본파일명
	String filename = request.getHeader("file-name");
	//파일 확장자
	String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	//확장자를소문자로 변경
	filename_ext = filename_ext.toLowerCase();

	//이미지 검증 배열변수
	String[] allow_file = {"jpg","png","bmp","gif"};

	// URL 체크
	String allowURL[] = {"/portal/bbs/selectBbsThumbnail.do"};

	//돌리면서 확장자가 이미지인지
	int cnt = 0;
	for(int i=0; i<allow_file.length; i++) {
		if(filename_ext.equals(allow_file[i])){
			cnt++;
		}
	}

	//이미지가 아님
	if(cnt == 0) {
		sFileInfo = "NOTALLOW_"+filename;
	} else {
		//이미지이므로 신규 파일로 디렉토리 설정 및 업로드
		//파일 기본경로
		//String dftFilePath = request.getServletContext().getRealPath("/");
   		String dftFilePath = EgovProperties.getProperty("Globals.BodyAttImgPath");
   		dftFilePath = EgovWebUtil.folderPathReplaceAll(dftFilePath);

		//파일 기본경로 _ 상세경로
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
		String todayDir = formatter.format(new java.util.Date());
		String filePath = dftFilePath + File.separator + todayDir + File.separator;
		filePath = EgovWebUtil.folderPathReplaceAll(filePath);

		File file = new File(filePath);
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
		//realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
		realFileNm = today+UUID.randomUUID().toString();
		String fileExt = FilenameUtils.getExtension(filename);
		String rlFileNm = filePath + realFileNm + "." + fileExt;

		///////////////// 서버에 파일쓰기 /////////////////
		FileOutputStream os = null;
		InputStream is = request.getInputStream();
		try {
			os = new FileOutputStream(rlFileNm);
			int numRead;
			int fileSize = Integer.parseInt(request.getHeader("file-size"));
			if (fileSize < 0) {
				throw new Exception("Integer overflow");
			}
			byte b[] = new byte[fileSize];
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
		String returnUrl = "";
		String bodyAttImgUrl = EgovProperties.getProperty("Globals.BodyAttImgUrl");

		// 정보 출력
		sFileInfo += "&bNewLine=true";
		//sFileInfo += "&sFileName="+ realFileNm;;
		// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
		sFileInfo += "&sFileName="+ filename;
		//sFileInfo += "&sFileURL="+EgovProperties.getProperty("Globals.BodyAttImgDir") + todayDir + "/" + realFileNm;
		//sFileInfo += "&sFileURL="+EgovProperties.getProperty("Globals.BodyAttImgUrl") + "?todayDir=" + todayDir + "&fileNm=" + realFileNm;
		//sFileInfo += "&sFileURL="+EgovProperties.getProperty("Globals.BodyAttImgUrl") + "/" + todayDir + "/" + realFileNm + "/" + fileExt;
		//sFileInfo += "&sFileDir=" + todayDir + File.separator + realFileNm + "/" + fileExt;
		
		sFileInfo += "&sFileDir=" + todayDir + "/" + realFileNm + "/" + fileExt;

		// 시큐어 코딩 URL 체크
		for ( int i=0; i < allowURL.length; i++ ) {

    		if ( bodyAttImgUrl.equals(allowURL[i]) ) {
    			returnUrl = allowURL[i];
    			break;
    		}
		}
		sFileInfo += "&sFileURL="+returnUrl;

		///////////////// 미러 서버에 sftp 전송 /////////////
// 		if(EgovProperties.getProperty("sftp.option").equals("on")){
// 			SFTPSyncManager sftp = new SFTPSyncManager();
// 			sftp.runsftp("U", filePath, filePath);
// 		}
		///////////////////////////////////////////////////

	}
%>
<%=sFileInfo%>