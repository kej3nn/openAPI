/*
 * @(#)PortalOpenDsDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 데이터셋을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenDsDao")
public class PortalOpenDsDao extends BaseDao {
    /**
     * 공공데이터 데이터셋 인기순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsHits(Params params) {
        // 공공데이터 데이터셋 인기순위를 검색한다.
        return search("PortalOpenDsDao.searchOpenDsHits", params);
    }
    
    /**
     * 공공데이터 데이터셋 기간순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTerm(Params params) {
        // 공공데이터 데이터셋 기간순위를 검색한다.
        return search("PortalOpenDsDao.searchOpenDsTerm", params);
    }
    
    /**
     * 공공데이터 데이터셋 추천순위를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRcmd(Params params) {
        // 공공데이터 데이터셋 추천순위를 검색한다.
        return search("PortalOpenDsDao.searchOpenDsRcmd", params);
    }
    
    /**
     * 마인드맵 카테고리 정보를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsCate(Params params) {
        // 마인드맵 카테고리 정보를 검색한다.
        return search("PortalOpenDsDao.searchOpenDsCate", params);
    }
    
    /**
     * 공공데이터 데이터셋 인기태그를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsTags(Params params) {
        // 공공데이터 데이터셋 인기태그를 검색한다.
        return search("PortalOpenDsDao.searchOpenDsTags", params);
    }
    
    /**
     * 공공데이터 데이터셋 제공기관을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsOrgs(Params params) {
        // 공공데이터 데이터셋 제공기관을 검색한다.
        return search("PortalOpenDsDao.searchOpenDsOrgs", params);
    }
    
    /**
     * 공공데이터 데이터셋 전체목록을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param size 페이지 크기
     * @return 검색결과
     */
    public Paging searchOpenDsList(Params params, int page, int size) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return search("PortalOpenDsDao.searchOpenDsList", params, page, size, PAGING_MANUAL);
    }
    
    /**
     * 공공데이터 데이터셋 관련목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenDsRela(Params params) {
        // 공공데이터 데이터셋 관련목록을 검색한다.
        return search("PortalOpenDsDao.searchOpenDsRela", params);
    }
    
    /**
     * 공공데이터 데이터셋 썸네일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenDsTmnl(Params params) {
        // 공공데이터 데이터셋 썸네일을 조회한다.
        return (Record) select("PortalOpenDsDao.selectOpenDsTmnl", params);
    }
    
    ////////////////////////tema/////////////////
    
    /**
     * 테마데이터 데이터셋 전체목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchTemaDsList(Params params) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return search("PortalOpenDsDao.searchTemaDsList", params);
    }
    
    /**
     * 테마데이터 데이터셋 전체목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchTemaDetailDsList(Params params) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return search("PortalOpenDsDao.searchTemaDetailDsList", params);
    }
    
      /**
     * 시군목록을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchSigunList(Params params) {
        // 공공데이터 데이터셋 전체목록을 검색한다.
        return search("PortalOpenDsDao.searchSigunList", params);
    }
    
    /***************************************************************************************************/    
/*                                생애주기 시작                                                                                     */
/***************************************************************************************************/    
    /**
     * 생애주기 카테로기에 해당하는 리스트를 받아온다
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    @SuppressWarnings("unchecked")
	public List<Record> selectCategoryList() {
    	return (List<Record>)search("PortalOpenDsDao.selectCategoryList");
    }

     /**
     * 생애주기 카테고리 정보 받아온다
     * @param params 파라메터
     * @return 검색결과
     */
    @SuppressWarnings("unchecked")
	public List<Record> selectSubDataCategory() {
    	// 공공데이터 데이터셋 추천순위를 검색한다.
    	return (List<Record>)search("PortalOpenDsDao.selectCategory");
    }
/***************************************************************************************************/    
/*                                생애주기 끝                                                                                     */
/***************************************************************************************************/  
    
}