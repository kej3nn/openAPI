/*
 * @(#)PortalOpenInfCcolDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.data.service.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 공공데이터 차트 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfCcolDao")
public class PortalOpenInfCcolDao extends BaseDao {
    /**
     * 공공데이터 차트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfCcolMeta(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfCcolDao.selectOpenInfCcolMeta", params);
    }
    
    /**
     * 공공데이터 차트 서비스 차트유형을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolType(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 차트유형을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolType", params);
    }
    
    /**
     * 공공데이터 차트 서비스 X-축컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolXcol(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 X-축컬럼을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolXcol", params);
    }
    
    /**
     * 공공데이터 차트 서비스 Y-축컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolYcol(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 Y-축컬럼을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolYcol", params);
    }
    
    /**
     * 공공데이터 차트 서비스 조회필터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolFilt(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 조회필터를 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolFilt", params);
    }
    
    /**
     * 공공데이터 차트 서비스 테이블명을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfCcolTbNm(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 테이블명을 조회한다.
        return (Record) select("PortalOpenInfCcolDao.selectOpenInfCcolTbNm", params);
    }
    
    /**
     * 공공데이터 차트 서비스 조회컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolCols(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 조회컬럼을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolCols", params);
    }
    
    /**
     * 공공데이터 차트 서비스 조회조건을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolCond(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 조회조건을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolCond", params);
    }
    
    /**
     * 공공데이터 차트 서비스 정렬조건을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolSort(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 정렬조건을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolSort", params);
    }
    
    /**
     * 공공데이터 차트 서비스 다운컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolDown(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 다운컬럼을 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolDown", params);
    }
    
    /**
     * 공공데이터 차트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchOpenInfCcolData(Params params, int page, int rows) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 데이터를 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolData", params, page, rows, PAGING_MANUAL);
    }
    
    /**
     * 공공데이터 차트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfCcolData(Params params) throws DataAccessException, Exception {
        // 공공데이터 차트 서비스 데이터를 검색한다.
        return search("PortalOpenInfCcolDao.searchOpenInfCcolData", params);
    }
}