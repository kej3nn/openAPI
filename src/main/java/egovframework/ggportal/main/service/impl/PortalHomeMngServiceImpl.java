/*
 * @(#)PortalHomeMngServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.main.service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.common.base.view.ImageView;
import egovframework.ggportal.data.service.impl.PortalOpenDsDao;
import egovframework.ggportal.main.service.PortalHomeMngService;

/**
 * 홈페이지 설정을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("gmportalHomeMngService")
public class PortalHomeMngServiceImpl extends BaseService implements PortalHomeMngService {
    /**
     * 홈페이지 설정을 관리하는 DAO
     */
    @Resource(name="gmportalHomeMngDao")
    private PortalHomeMngDao portalHomeMngDao;
    
    /**
     * 공공데이터 데이터셋을 관리하는 DAO
     */
    @Resource(name="ggportalOpenDsDao")
    private PortalOpenDsDao portalOpenDsDao;
    
    /**
     * 배너 경로를 반환한다.
     * 
     * @param data 데이터
     * @return 썸네일 경로
     */
    private String getBannerPath(Record data) {
        StringBuffer buffer = new StringBuffer();
        
        // 배너 배경 이미지 파일이 있는 경우
        if (!"".equals(data.getString("subSaveFileNm"))) {
            buffer.append(EgovProperties.getProperty("Globals.MainMngImgFilePath"));
            buffer.append(File.separator);
            buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("subSaveFileNm")));
        }
        // 배너 이미지 파일이 있는 경우
        else if (!"".equals(data.getString("saveFileNm"))) {
            buffer.append(EgovProperties.getProperty("Globals.MainMngImgFilePath"));
            buffer.append(File.separator);
            buffer.append(EgovWebUtil.filePathReplaceAll(data.getString("saveFileNm")));
        }
        
        return buffer.toString();
    }
    
    /**
     * 배너 이름을 반환한다.
     * 
     * @param data 데이터
     * @return 썸네일 이름
     */
    private String getBannerName(Record data) {
        String name = "";
        
        // 배너 배경 이미지 파일이 있는 경우
        if (!"".equals(data.getString("subSaveFileNm"))) {
            name = data.getString("subSaveFileNm");
        }
        // 배너 이미지 파일이 있는 경우
        else if (!"".equals(data.getString("saveFileNm"))) {
            name = data.getString("saveFileNm");
        }
        
        return name;
    }
    
    /**
     * 홈페이지 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSettings(Params params) {
        Record data = new Record();
        
        // 홈페이지 설정을 검색한다.
        data.put("config", searchHomeMng(params));
        
        // 공공데이터 데이터셋 카테고리를 검색한다.
        data.put("categories", portalOpenDsDao.searchOpenDsCate(params));
        
        return data;
    }
    
    /**
     * 홈페이지 설정을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchHomeMng(Params params) {
        // 홈페이지 설정을 검색한다.
        List<?> data = portalHomeMngDao.searchHomeMng(params);
        
        for (int i = 0; i < data.size(); i++) {
            Record config = (Record) data.get(i);
            
            String url = config.getString("linkUrl");
            
            int index = url.indexOf("?");
            
            if (index >= 0) {
                String uri = url.substring(0, index);
                
                String query = url.substring(index + 1);
                
                if (!"".equals(query)) {
                    try {
                        String[] pairs = query.split("&");
                        
                        StringBuffer buffer = new StringBuffer();
                        
                        for (int n = 0; n < pairs.length; n++) {
                            String[] tokens = pairs[n].split("=");
                            
                            buffer.append(tokens[0]);
                            buffer.append("=");
                            buffer.append(URLEncoder.encode(tokens[1], "UTF-8"));
                        }
                        
                        config.put("linkUrl", uri + "?" + buffer.toString());
                    }
                    catch (UnsupportedEncodingException uee) {
                    	EgovWebUtil.exLogging(uee);
                    }
                }
            }
        }
        
        return data;
    }
    
    /**
     * 홈페이지 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectHomeMng(Params params) {
        // // 홈페이지 설정을 조회한다.
        // Record config = portalHomeMngDao.selectHomeMng(params);
        // 
        // config.put(ImageView.FILE_PATH, getBannerPath(config));
        // config.put(ImageView.FILE_NAME, getBannerName(config));
        Record config = new Record();
        
        // 배너 배경 이미지 파일이 있는 경우
        if (params.containsKey("subSaveFileNm")) {
            config.put("subSaveFileNm", params.getString("subSaveFileNm"));
        }
        // 배너 배경 이미지 파일이 없는 경우
        else {
            config.put("saveFileNm",    params.getString("saveFileNm"));
        }
        
        config.put(ImageView.FILE_PATH, getBannerPath(config));
        config.put(ImageView.FILE_NAME, getBannerName(config));
        
        return config;
    }

    /**
     * 홈페이지 메인관리 이미지 파일을 불러온다
     */
	@Override
	public Record selectHomeImgFile(Params params) {
		Record config = portalHomeMngDao.selectHomeMng(params);
		config.put(ImageView.FILE_PATH, getBannerPath(config));
        config.put(ImageView.FILE_NAME, getBannerName(config));
        return config;
	}
}