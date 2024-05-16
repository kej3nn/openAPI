/*
 * @(#)PortalOpenInfSrvService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 서비스를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOpenInfSrvService {
    /**
     * 시트 서비스 유형
     */
    public static final String SERVICE_TYPE_SHEET = "S";
    
    /**
     * 차트 서비스 유형
     */
    public static final String SERVICE_TYPE_CHART = "C";
    
    /**
     * 맵 서비스 유형
     */
    public static final String SERVICE_TYPE_MAP = "M";
    
    /**
     * 파일 서비스 유형
     */
    public static final String SERVICE_TYPE_FILE = "F";
    
    /**
     * 오픈API 서비스 유형
     */
    public static final String SERVICE_TYPE_OPENAPI = "A";
    
    /**
     * 링크 서비스 유형
     */
    public static final String SERVICE_TYPE_LINK = "L";

    /**
     * 시각화 서비스 유형
     */
    public static final String SERVICE_TYPE_VISUAL = "V";
    
    /**
     * 공공데이터 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfSrvMetaCUD(Params params);
    
    /**
     * 공공데이터 서비스 평가점수를 등록한다
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Record insertOpenInfSrvApprCUD(Params params);
    
    /**
     * 공공데이터 API 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfApiSrvMetaCUD(Params params);
}