/*
 * @(#)PortalOpenInfLinkDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 링크 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfLinkDao")
public class PortalOpenInfLinkDao extends BaseDao {
    /**
     * 공공데이터 링크 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfLinkMeta(Params params) {
        // 공공데이터 링크 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfLinkDao.selectOpenInfLinkMeta", params);
    }
    
    /**
     * 공공데이터 링크 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfLinkData(Params params) {
        // 공공데이터 링크 서비스 데이터를 검색한다.
        return search("PortalOpenInfLinkDao.searchOpenInfLinkData", params);
    }
    
    /**
     * 공공데이터 링크 서비스 데이터를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfLinkData(Params params) {
        // 공공데이터 링크 서비스 데이터를 조회한다.
        return (Record) select("PortalOpenInfLinkDao.selectOpenInfLinkData", params);
    }
    
    /**
     * 공공데이터 링크 서비스 썸네일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfLinkTmnl(Params params) {
        // 공공데이터 링크 서비스 썸네일을 조회한다.
        return (Record) select("PortalOpenInfLinkDao.selectOpenInfLinkTmnl", params);
    }
    
    /**
     * 공공데이터 링크 서비스 조회이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertOpenInfLinkHist(Params params) {
        // 공공데이터 링크 서비스 조회이력을 등록한다.
        return insert("PortalOpenInfLinkDao.insertOpenInfLinkHist", params);
    }
    
    /**
     * 공공데이터 링크 서비스 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateOpenInfLinkHits(Params params) {
        // 공공데이터 링크 서비스 조회수를 수정한다.
        return update("PortalOpenInfLinkDao.updateOpenInfLinkHits", params);
    }
}