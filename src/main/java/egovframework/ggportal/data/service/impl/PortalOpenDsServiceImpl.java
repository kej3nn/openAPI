/*
 * @(#)PortalOpenDsServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;
import egovframework.common.util.UtilString;
import egovframework.ggportal.data.service.PortalOpenDsService;

/**
 * 공공데이터 데이터셋을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalOpenDsService")
public class PortalOpenDsServiceImpl extends BaseService implements PortalOpenDsService {
    /**
     * 공공데이터 데이터셋을 관리하는 DAO
     */
    @Resource(name="ggportalOpenDsDao")
    private PortalOpenDsDao portalOpenDsDao;
    
    /**
     * 검색 기간을 설정한다.
     * 
     * @param params 파라메터
     */
    private void setSearchTerm(Params params) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        
        Calendar calendar = Calendar.getInstance();
        
        if ("W".equals(params.getString("term"))) {
            calendar.set(Calendar.DAY_OF_WEEK, calendar.getFirstDayOfWeek());
            
            calendar.add(Calendar.DAY_OF_MONTH, -1);
            
            params.put("toDate", format.format(calendar.getTime()));
            
            calendar.add(Calendar.DAY_OF_MONTH, -6);
            
            params.put("fromDate", format.format(calendar.getTime()));
        }
        else if ("M".equals(params.getString("term"))) {
            calendar.add(Calendar.MONTH, -1);
            
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
            
            params.put("fromDate", format.format(calendar.getTime()));
            
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            
            params.put("toDate", format.format(calendar.getTime()));
        }
    }
    
    /**
     * 썸네일 경로를 반환한다.
     * 
     * @param data 데이터
     * @return 썸네일 경로
     */
    private String getThumbnailPath(Record data) {
        StringBuffer buffer = new StringBuffer();
        
        // 메타 이미지 파일이 있는 경우
        if (!"".equals(data.getString("metaImagFileNm"))) {
            buffer.append(UtilString.getDownloadFolder("S", data.getString("seq")));
            buffer.append(File.separator);
            buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("metaImagFileNm")));
        }
        // 카테고리 이미지 파일이 있는 경우
        else if (!"".equals(data.getString("cateSaveFileNm"))) {
            buffer.append(EgovProperties.getProperty("Globals.OpenCateFilePath"));
            buffer.append(File.separator);
            buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("cateSaveFileNm")));
        }
        
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
        
        // 메타 이미지 파일이 있는 경우
        if (!"".equals(data.getString("metaImagFileNm"))) {
            name = data.getString("metaImagFileNm");
        }
        // 카테고리 이미지 파일이 있는 경우
        else if (!"".equals(data.getString("cateSaveFileNm"))) {
            name = data.getString("cateSaveFileNm");
        }
        
        return name;
    }
    
    /**
     * 공공데이터 데이터셋 인기순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsHits(Params params) {
        // 공공데이터 데이터셋 인기순위를 검색한다.
        return portalOpenDsDao.searchOpenDsHits(params);
    }
    
    /**
     * 공공데이터 데이터셋 기간순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTerm(Params params) {
        // 검색 기간을 설정한다.
        setSearchTerm(params);
        
        // 공공데이터 데이터셋 기간순위를 검색한다.
        return portalOpenDsDao.searchOpenDsTerm(params);
    }
    
    /**
     * 공공데이터 데이터셋 추천순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRcmd(Params params) {
        // 공공데이터 데이터셋 추천순위를 검색한다.
        return portalOpenDsDao.searchOpenDsRcmd(params);
    }
    
    /**
     * 마인드맵 카테고리 정보를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsCate(Params params) {
        // 마인드맵 카테고리 정보를 검색한다.
        return portalOpenDsDao.searchOpenDsCate(params);
    }
    
    /**
     * 공공데이터 데이터셋 인기태그를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTags(Params params) {
        // 공공데이터 데이터셋 인기태그를 검색한다.
        return portalOpenDsDao.searchOpenDsTags(params);
    }
    
    /**
     * 공공데이터 데이터셋 제공기관을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsOrgs(Params params) {
        // 공공데이터 데이터셋 제공기관을 검색한다.
        return portalOpenDsDao.searchOpenDsOrgs(params);
    }
    
    /**
     * 공공데이터 데이터셋 전체목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenDsList(Params params) {
        params.put("orgCd",      params.getStringArray("orgCd"));
        params.put("cateId",     params.getStringArray("cateId"));
        params.put("srvCd",      params.getStringArray("srvCd"));
        params.put("infTag",     params.getStringArray("infTag"));
        params.put("searchWord", params.getString("searchWord"));
        
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return portalOpenDsDao.searchOpenDsList(params, params.getPage(), params.getRows());
    }
    
    /**
     * 공공데이터 데이터셋 관련목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRela(Params params) {
        // 공공데이터 데이터셋 관련목록을 검색한다.
        return portalOpenDsDao.searchOpenDsRela(params);
    }
    
    /**
     * 공공데이터 데이터셋 썸네일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenDsTmnl(Params params) {
        // // 공공데이터 데이터셋 썸네일을 조회한다.
        // Record thumbnail = portalOpenDsDao.selectOpenDsTmnl(params);
        // 
        // thumbnail.put(ImageView.FILE_PATH, getThumbnailPath(thumbnail));
        // thumbnail.put(ImageView.FILE_NAME, getThumbnailName(thumbnail));
        Record thumbnail = new Record();
        
        thumbnail.put("seq",            params.getString("seq"));
        thumbnail.put("metaImagFileNm", params.getString("metaImagFileNm"));
        thumbnail.put("cateSaveFileNm", params.getString("cateSaveFileNm"));
        
        thumbnail.put(ImageView.FILE_PATH, getThumbnailPath(thumbnail));
        thumbnail.put(ImageView.FILE_NAME, getThumbnailName(thumbnail));
        
        return thumbnail;
    }
}