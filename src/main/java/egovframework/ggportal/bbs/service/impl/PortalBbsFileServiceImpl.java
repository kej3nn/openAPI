/*
 * @(#)PortalBbsFileServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.util.SFTPSyncManager;
import egovframework.common.util.UtilString;
import egovframework.ggportal.bbs.service.PortalBbsFileService;

/**
 * 게시판 첨부파일을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalBbsFileService")
public class PortalBbsFileServiceImpl extends BaseService implements PortalBbsFileService {
    /**
     * 게시판 첨부파일을 관리하는 DAO
     */
    @Resource(name="ggportalBbsFileDao")
    private PortalBbsFileDao portalBbsFileDao;
    
    /**
     * 게시판 첨부파일 다운로드 이력을 관리하는 DAO
     */
    @Resource(name="ggportalLogBbsFileDao")
    private PortalLogBbsFileDao portalLogBbsFileDao;
    
    /**
     * 원본 파일명을 반환한다.
     * 
     * @param file 파일
     * @return 원본 파일명
     */
    private String getOriginalFileName(MultipartFile file) {
        return file.getOriginalFilename();
    }
    
    /**
     * 표시 파일명을 반환한다.
     * 
     * @param file 파일
     * @return 표시 파일명
     */
    private String getDisplayFileName(MultipartFile file) {
        String name = file.getOriginalFilename();
        
        int index = name.lastIndexOf(".");
        
        if (index > 0) {
            return name.substring(0, index);
        }
        else {
            return name;
        }
    }
    
    /**
     * 파일 확장자를 반환한다.
     * 
     * @param file 파일
     * @return 파일 확장자
     */
    private String getFileExtension(MultipartFile file) {
        String name = file.getOriginalFilename();
        
        int index = name.lastIndexOf(".");
        
        if (index > 0) {
            return name.substring(index + 1).toLowerCase();
        }
        else {
            return "";
        }
    }
    
    /**
     * 파일 사이즈를 반환한다.
     * 
     * @param file 파일
     * @return 원본 사이즈
     */
    private long getFileSize(MultipartFile file) {
        return file.getSize();
    }
    
    /**
     * 폴더 경로를 반환한다.
     * 
     * @param params 파라메터
     * @return 폴더 경로
     */
    private String getFolderPath(Params params) {
        String path = EgovProperties.getProperty("Globals.BbsFilePath") + params.getString("bbsCd");
        
        return path + UtilString.getFolderPath(params.getInt("seq"), path);
    }
    
    /**
     * 파일 경로를 반환한다.
     * 
     * @param folder 폴더 경로
     * @param params 파라메터
     * @return 파일 경로
     */
    private File getFilePath(Params params, String folder) {
        String sequence  = params.getString("fileSeq");
        String extension = params.getString("fileExt");
        
        if (!"".equals(extension)) {
            extension = "." + extension;
        }
        
        return new File(folder + File.separator + sequence + extension);
    }
    
    /**
     * 파일 경로를 반환한다.
     * 
     * @param file 파일
     * @return 파일 경로
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.BbsFilePath"));
        buffer.append(file.getString("bbsCd"));
        buffer.append(UtilString.getFolderPath(file.getInt("seq"), buffer.toString()));
        buffer.append(File.separator);
        buffer.append(EgovWebUtil.filePathReplaceAll(file.getString("saveFileNm")));
        
        return buffer.toString();
    }
    
    /**
     * 파일 이름을 반환한다.
     * 
     * @param file 파일
     * @return 파일 이름
     */
    private String getFileName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("viewFileNm"));
        buffer.append(".");
        buffer.append(file.getString("fileExt"));
        
        return buffer.toString();
    }
    
    /**
     * 파일 크기를 반환한다.
     * 
     * @param file 파일
     * @return 파일 크기
     */
    private String getFileSize(Record file) {
        return file.getString("fileSize");
    }
    
    /**
     * 게시판 첨부파일을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsFile(Params params) {
        // 게시판 첨부파일을 검색한다.
        return portalBbsFileDao.searchBbsFile(params);
    }
    
    /**
     * 게시판 첨부파일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsFile(Params params) {
        // 게시판 첨부파일을 조회한다.
        Record file = portalBbsFileDao.selectBbsFile(params);
        
        file.put(FileDownloadView.FILE_PATH, getFilePath(file));
        file.put(FileDownloadView.FILE_NAME, getFileName(file));
        file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
        
        return file;
    }
    
    /**
     * 게시판 첨부파일을 다운로드한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record downloadBbsFileCUD(Params params) {
        // 게시판 첨부파일을 조회한다.
        Record file = selectBbsFile(params);
        
        // 게시판 첨부파일 조회수를 수정한다.
        portalBbsFileDao.updateBbsFileViewCnt(params);
        
        // 게시판 첨부파일 다운로드 이력을 등록한다.
        portalLogBbsFileDao.insertLogBbsFile(params);
        
        return file;
    }
    
    /**
     * 게시판 첨부파일을 등록한다.
     * 
     * @param params 파라메터
     * @param name 이름
     */
    public void insertBbsFile(Params params, String name) {
        try {
        	SFTPSyncManager sftp = new SFTPSyncManager();
            MultipartFile[] files = params.getFileArray(name);
            
            for (int i = 0; i < files.length; i++) {
                MultipartFile file =  files[i];
                
                if (file.isEmpty()) {
                    continue;
                }
                
                params.put("srcFileNm",  getOriginalFileName(file));
                params.put("viewFileNm", getDisplayFileName(file));
                params.put("fileExt",    getFileExtension(file));
                params.put("fileSize",   getFileSize(file));
                
                // 게시판 첨부파일을 등록한다.
                portalBbsFileDao.insertBbsFile(params);
                
                // 폴더 경로를 가져온다.
                String folder = getFolderPath(params);
                
                File directory = new File(folder);
                
                // 수정 : 권한 설정
                directory.setExecutable(true, true);
                directory.setReadable(true);
                directory.setWritable(true, true);
        		
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                
                // 파일 경로를 가져온다.
                File path = getFilePath(params, folder);
                
/*
                if (path.exists()) {
//                    throw new SystemException("portal.error.000015", getMessage("portal.error.000015", new String[] {
//                        path.getAbsolutePath()
//                    }));
                	path.delete();
                }
*/

                file.transferTo(path);
                
                //FTP
                if(EgovProperties.getProperty("sftp.option").equals("on")){
			    	sftp.runsftp("U", folder, folder);
			    }
            }
        }
        catch (IOException ioe) {
            error("Detected exception: ", ioe);
            
            throw new SystemException("portal.error.000003", getMessage("portal.error.000002"));
        }
    }
    
    /**
     * 게시판 첨부파일을 삭제한다.
     * 
     * @param params 파라메터
     * @param name 이름
     */
    public void deleteBbsFile(Params params, String name) {
        String[] keys = params.getStringArray(name);
        
        for (int i = 0; i < keys.length; i++) {
            params.put("fileSeq", keys[i]);
            
            // 게시판 첨부파일을 삭제한다.
            portalBbsFileDao.deleteBbsFile(params);
        }
    }
    
    /**
     * 게시판 첨부파일을 삭제한다.
     * 
     * @param params 파라메터
     */
    public void deleteBbsFile(Params params) {
        // 게시판 첨부파일을 삭제한다.
        portalBbsFileDao.deleteBbsFile(params);
    }
}