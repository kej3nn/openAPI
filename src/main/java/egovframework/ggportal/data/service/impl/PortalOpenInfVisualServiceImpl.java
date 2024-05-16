/*
 * @(#)PortalOpenInfVisualServiceImpl.java 1.0 2015/06/15
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
import egovframework.common.base.exception.ServiceException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.view.ImageView;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenInfVisualService;

/**
 * 공공데이터 시각화 서비스를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenInfVisualService")
public class PortalOpenInfVisualServiceImpl extends PortalOpenInfSrvServiceImpl implements PortalOpenInfVisualService {
    /**
     * 공공데이터 시각화 서비스를 관리하는 DAO
     */
    @Resource(name="ggportalOpenInfVisualDao")
    private PortalOpenInfVisualDao portalOpenInfVisualDao;
    
    /**
     * 썸네일 경로를 반환한다.
     * 
     * @param data 데이터
     * @return 썸네일 경로
     */
    private String getThumbnailPath(Record data) {
        StringBuffer buffer = new StringBuffer();
        
        // 썸네일 이미지 파일이 있는 경우
        if (!"".equals(data.getString("tmnlImgFile"))) {
            buffer.append(UtilString.getDownloadFolder("V", data.getString("seq")));
            buffer.append(File.separator);
            buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("tmnlImgFile")));
        }
        // // 메타 이미지 파일이 있는 경우
        // else if (!"".equals(data.getString("metaImagFileNm"))) {
        //     buffer.append(UtilString.getDownloadFolder("S", data.getString("seq")));
        //     buffer.append(File.separator);
        //     buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("metaImagFileNm")));
        // }
        // // 카테고리 이미지 파일이 있는 경우
        // else if (!"".equals(data.getString("cateSaveFileNm"))) {
        //     buffer.append(EgovProperties.getProperty("Globals.OpenCateFilePath"));
        //     buffer.append(File.separator);
        //     buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("cateSaveFileNm")));
        // }
        
        return buffer.toString();
    }
    
    /**
     * 썸네일 이름을 반환한다.
     * 
     * @param data 데이터
     * @return 썸네일 이름
     */
    private String getThumbnailName(Record data) {
        String name = "";
        
        // 썸네일 이미지 파일이 있는 경우
        if (!"".equals(data.getString("tmnlImgFile"))) {
            name = data.getString("tmnlImgFile");
        }
        // // 메타 이미지 파일이 있는 경우
        // else if (!"".equals(data.getString("metaImagFileNm"))) {
        //     name = data.getString("metaImagFileNm");
        // }
        // // 카테고리 이미지 파일이 있는 경우
        // else if (!"".equals(data.getString("cateSaveFileNm"))) {
        //     name = data.getString("cateSaveFileNm");
        // }
        
        return name;
    }
    
    /**
     * 공공데이터 시각화 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfVisualMeta(Params params) {
        // 공공데이터 시각화 서비스 메타정보를 조회한다.
        Record meta = portalOpenInfVisualDao.selectOpenInfVisualMeta(params);
        try{
	        // 메타정보가 없는 경우
	        if (meta == null) {
	            throw new ServiceException("portal.error.000019", getMessage("portal.error.000019"));
	        }
	        
        } catch (ServiceException sve) {
        	EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exLogging(e);
		}
        
        return meta;
    }
    
    /**
     * 공공데이터 시각화 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfVisualData(Params params) {
        // 공공데이터 시각화 서비스 데이터를 검색한다.
        return portalOpenInfVisualDao.searchOpenInfVisualData(params);
    }
    
    /**
     * 공공데이터 시각화 서비스 데이터를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfVisualDataCUD(Params params) {
        // 공공데이터 시각화 서비스 데이터를 조회한다.
        Record link = portalOpenInfVisualDao.selectOpenInfVisualData(params);
        try{
	        // 데이터가 없는 경우
	        if (link == null) {
	            throw new ServiceException("portal.error.000025", getMessage("portal.error.000025"));
	        }
	        
	        // 공공데이터 시각화 서비스 조회이력을 등록한다.
	        portalOpenInfVisualDao.insertOpenInfVisualHist(params);
	        
	        // 공공데이터 시각화 서비스 조회수를 수정한다.
	        portalOpenInfVisualDao.updateOpenInfVisualHits(params);
        } catch (DataAccessException dae) {
        	EgovWebUtil.exTransactionLogging(dae);
        } catch (ServiceException sve) {
        	EgovWebUtil.exTransactionLogging(sve);
        } catch (Exception e) {
        	EgovWebUtil.exTransactionLogging(e);
		}
        
        return link;
    }
    
    /**
     * 공공데이터 시각화 서비스 썸네일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfVisualTmnl(Params params) {
        // // 공공데이터 시각화 서비스 썸네일을 조회한다.
        // Record thumbnail = portalOpenInfVisualDao.selectOpenInfVisualTmnl(params);
        // 
        // thumbnail.put(ImageView.FILE_PATH, getThumbnailPath(thumbnail));
        // thumbnail.put(ImageView.FILE_NAME, getThumbnailName(thumbnail));
        Record thumbnail = new Record();
        
        thumbnail.put("seq",         params.getString("seq"));
        thumbnail.put("tmnlImgFile", params.getString("tmnlImgFile"));
        
        thumbnail.put(ImageView.FILE_PATH, getThumbnailPath(thumbnail));
        thumbnail.put(ImageView.FILE_NAME, getThumbnailName(thumbnail));
        
        return thumbnail;
    }
}