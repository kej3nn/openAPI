/*
 * @(#)PortalOpenDsService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 데이터셋을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalOpenDsService {
    /**
     * 공공데이터 데이터셋 인기순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsHits(Params params);
    
    /**
     * 공공데이터 데이터셋 기간순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTerm(Params params);
    
    /**
     * 공공데이터 데이터셋 추천순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRcmd(Params params);
    
    /**
     * 공공데이터 데이터셋 카테고리를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsCate(Params params);
    
    /**
     * 공공데이터 데이터셋 인기태그를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTags(Params params);
    
    /**
     * 공공데이터 데이터셋 제공기관을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsOrgs(Params params);
    
    /**
     * 공공데이터 데이터셋 전체목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchOpenDsList(Params params);
    
    /**
     * 공공데이터 데이터셋 관련목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRela(Params params);
    
    /**
     * 공공데이터 데이터셋 썸네일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenDsTmnl(Params params);
}