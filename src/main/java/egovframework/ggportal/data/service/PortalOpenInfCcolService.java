/*
 * @(#)PortalOpenInfCcolService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 차트 서비스 컬럼정보 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOpenInfCcolService {
    /**
     * 공공데이터 차트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfCcolMeta(Params params);
    
    /**
     * 공공데이터 차트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolData(Params params);
    
    /**
     * 공공데이터 차트 서비스 데이터를 다운로드한다.
     * 
     * @param request HTTP 요청
     * @param response HTTP 응답
     * @param params 파라메터
     * @throws Exception 발생오류
     */
    public void downloadOpenInfCcolDataCUD(HttpServletRequest request, HttpServletResponse response, Params params);
}