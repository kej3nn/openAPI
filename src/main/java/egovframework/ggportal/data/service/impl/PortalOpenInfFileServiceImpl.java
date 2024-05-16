/*
 * @(#)PortalOpenInfFileServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.FileDownloadView;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfFileService;

/**
 * 공공데이터 파일 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfFileService")
public class PortalOpenInfFileServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfFileService {
    /**
     * 공공데이터 파일 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfFileDao")
    private PortalOpenInfFileDao portalOpenInfFileDao;
    
    /**
     * 리소스 경로를 반환한다.
     * 
     * @param file 파일
     * @return 리소스 경로
     */
    private String getResourcePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(EgovProperties.getProperty("Globals.ConvertDir"));
        buffer.append(UtilString.getFolderPath(file.getInt("seq"), ""));
        buffer.append("/");
        
        return buffer.toString().replaceAll("\\\\", "/");
    }
    
    /**
     * 리소스 이름을 반환한다.
     * 
     * @param file 파일
     * @return 리소스 이름
     */
    private String getResourceName(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(file.getString("fileSeq"));
        buffer.append(".");
        buffer.append(file.getString("fileExt"));
        
        return buffer.toString();
    }
    
    /**
     * 파일 경로를 반환한다.
     * 
     * @param file 파일
     * @return 파일 경로
     */
    private String getFilePath(Record file) {
        StringBuffer buffer = new StringBuffer();
        
        buffer.append(UtilString.getDownloadFolder("S", file.getString("seq")));
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
     * 공공데이터 파일 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfFileMeta(Params params) {
        // 공공데이터 파일 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfFileDao.selectOpenInfFileMeta(params);
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000018", getMessage("portal.error.000018"));
	        }
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
			EgovWebUtil.exLogging(e);
        }
        return meta;
    }
    
    // /**
    //  * 공공데이터 파일 서비스 데이터를 검색한다.
    //  * 
    //  * @param params 파라메터
    //  * @return 검색결과
    //  */
    // public Paging searchOpenInfFileData(Params params) {
    //     // 공공데이터 파일 서비스 데이터를 검색한다.
    //     return portalOpenInfFileDao.searchOpenInfFileData(params, params.getPage(), params.getRows());
    // }
    /**
     * 공공데이터 파일 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfFileData(Params params) {
        // 공공데이터 파일 서비스 데이터를 검색한다.
        return portalOpenInfFileDao.searchOpenInfFileData(params);
    }
    
    /**
     * 공공데이터 파일 서비스 데이터를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfFileDataCUD(Params params) {
        // 공공데이터 파일 서비스 데이터를 조회한다.
        Record file = portalOpenInfFileDao.selectOpenInfFileData(params);
        try{
	        // 데이터가 없는 경우
	        if (file == null) {
	            throw new ServiceException("portal.error.000024", getMessage("portal.error.000024"));
	        }
	        
	        // 공공데이터 파일 서비스 조회이력을 등록한다.
	        portalOpenInfFileDao.insertOpenInfFileHist(params);
	        
	        // 공공데이터 파일 서비스 조회수를 수정한다.
	        portalOpenInfFileDao.updateOpenInfFileHits(params);
	        
	        file.put("rs", getResourcePath(file));
	        file.put("fn", getResourceName(file));
	        
	        file.put(FileDownloadView.FILE_PATH, getFilePath(file));
	        file.put(FileDownloadView.FILE_NAME, getFileName(file));
	        file.put(FileDownloadView.FILE_SIZE, getFileSize(file));
      
        } catch (DataAccessException dae) {
        	EgovWebUtil.exLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
			EgovWebUtil.exLogging(e);
        }
        
        return file;
    }
}