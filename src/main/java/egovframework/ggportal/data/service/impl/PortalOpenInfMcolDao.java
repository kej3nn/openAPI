/*
 * @(#)PortalOpenInfMcolDao.java 1.0 2015/06/15
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
 * 공공데이터 지도 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfMcolDao")
public class PortalOpenInfMcolDao extends BaseDao {
    /**
     * 공공데이터 지도 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfMcolMeta(Params params) {
        // 공공데이터 지도 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfMcolDao.selectOpenInfMcolMeta", params);
    }
    
    /**
     * 공공데이터 지도 서비스 항목정보를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfMcolInfo(Params params) {
        // 공공데이터 지도 서비스 항목정보를 검색한다.
        return search("PortalOpenInfMcolDao.searchOpenInfMcolInfo", params);
    }
    
    /**
     * 공공데이터 지도 서비스 테이블명을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfMcolTbNm(Params params) {
        // 공공데이터 지도 서비스 테이블명을 조회한다.
        return (Record) select("PortalOpenInfMcolDao.selectOpenInfMcolTbNm", params);
    }
    
    /**
     * 공공데이터 지도 서비스 조회컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfMcolCols(Params params) {
        // 공공데이터 지도 서비스 조회컬럼을 검색한다.
        return search("PortalOpenInfMcolDao.searchOpenInfMcolCols", params);
    }
    
    /**
     * 공공데이터 지도 서비스 조회조건을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfMcolCond(Params params) {
        // 공공데이터 지도 서비스 조회조건을 검색한다.
        return search("PortalOpenInfMcolDao.searchOpenInfMcolCond", params);
    }
    
    /**
     * 공공데이터 지도 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfMcolData(Params params) {
        // 공공데이터 지도 서비스 데이터를 검색한다.
        return search("PortalOpenInfMcolDao.searchOpenInfMcolData", params);
    }
    
    /**
     * 공공데이터 지도 서비스 조회필터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfMcolFilt(Params params) {
        //return search("PortalOpenInfScolDao.searchOpenInfScolFilt", params);
        return search("PortalOpenInfMcolDao.searchOpenInfMcolFilt", params);
    }
    
    /**
     * 공공데이터 지도 서비스 마커 구분 검색
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    @SuppressWarnings("unchecked")
	public List<String> searchOpenInfMcolMarkerCd(Params params) {
    	// 공공데이터 지도 서비스 항목정보를 검색한다.
    	return (List<String>) list("PortalOpenInfMcolDao.searchOpenInfMcolMarkerCd", params);
    }
    
    /**
     * MAP에서 shape 파일이 있는지 확인하고 리스트 조회한다.
     * @param params
     * @return
     */
    public Record selectOpenInfIsShape(Params params) {
        // MAP에서 shape 파일이 있는지 확인하고 리스트 조회한다.
        return (Record) select("PortalOpenInfMcolDao.selectOpenInfShapeFile", params);
    }
    
    
}