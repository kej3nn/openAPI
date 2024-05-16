/*
 * @(#)PortalOpenInfScolService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 시트 서비스를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOpenInfScolService {
    /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfScolMeta(Params params);
    
    /**
     * 공공데이터 시트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenInfScolData(Params params);
    
    /**
     * 공공데이터 시트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    public void downloadOpenInfScolDataCUD(HttpServletRequest request, HttpServletResponse response, Params params);
    
    /**
     * 추천데이터셋을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public List<?> selectRecommandDataSet(Params params);
    
    public Record downloadBbsFileCUD(Params params);
    
    public List<Record> searchUsrDefFileData(Params params);

	public Record searchUsrDefFileOneData(Params params);
}