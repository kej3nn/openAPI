/*
 * @(#)PortalOpenInfMcolService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 지도 서비스를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOpenInfMcolService {
    /**
     * 공공데이터 지도 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfMcolMeta(Params params);
    
    /**
     * 공공데이터 지도 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Record searchOpenInfMcolData(Params params, boolean res);
    
    /**
     * map이 shape로 구성된것인지 체크
     * @param params
     * @return
     */
    public Record selectOpenInfIsShape(Params params);
}