/*
 * @(#)PortalHomeMngService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.main.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 홈페이지 설정을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalHomeMngService {
    /**
     * 홈페이지 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSettings(Params params);
    
    /**
     * 홈페이지 설정을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchHomeMng(Params params);
    
    /**
     * 홈페이지 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectHomeMng(Params params);
    
    /**
     * 홈페이지 메인관리 이미지 파일을 불러온다
     */
    public Record selectHomeImgFile(Params params);
}