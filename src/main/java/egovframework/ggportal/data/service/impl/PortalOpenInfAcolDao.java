/*
 * @(#)PortalOpenInfAcolDao.java 1.0 2015/06/15
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
 * 공공데이터 오픈API 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfAcolDao")
public class PortalOpenInfAcolDao extends BaseDao {
    /**
     * 공공데이터 오픈API 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfAcolMeta(Params params) {
        // 공공데이터 오픈API 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfAcolDao.selectOpenInfAcolMeta", params);
    }
    
    /**
     * 공공데이터 오픈API 서비스 요청변수를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfAcolVars(Params params) {
        // 공공데이터 오픈API 서비스 요청변수를 검색한다.
        return search("PortalOpenInfAcolDao.searchOpenInfAcolVars", params);
    }
    
    /**
     * 공공데이터 오픈API 서비스 응답컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfAcolCols(Params params) {
        // 공공데이터 오픈API 서비스 응답컬럼을 검색한다.
        return search("PortalOpenInfAcolDao.searchOpenInfAcolCols", params);
    }
    
    /**
     * 공공데이터 오픈API 서비스 예제주소를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfAcolUrls(Params params) {
        // 공공데이터 오픈API 서비스 예제주소를 검색한다.
        return search("PortalOpenInfAcolDao.searchOpenInfAcolUrls", params);
    }
    
    /**
     * 공공데이터 오픈API 서비스 조회필터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfAcolFilt(Params params) {
        // 공공데이터 오픈API 서비스 조회필터를 검색한다.
        return search("PortalOpenInfAcolDao.searchOpenInfAcolFilt", params);
    }
    
    /**
     * 공공데이터 오픈API 서비스 응답문자를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfAcolMsgs(Params params) {
        // 공공데이터 오픈API 서비스 응답문자를 검색한다.
        return search("PortalOpenInfAcolDao.searchOpenInfAcolMsgs", params);
    }
}