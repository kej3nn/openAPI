/*
 * @(#)PortalOpenInfScolDao.java 1.0 2015/06/15
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
 * 공공데이터 시트 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfScolDao")
public class PortalOpenInfScolDao extends BaseDao {
    /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfScolMeta(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfScolDao.selectOpenInfScolMeta", params);
    }
    
    /**
     * 공공데이터 시트 서비스 컬럼속성을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolProp(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 컬럼속성을 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolProp", params);
    }
    
    /**
     * 공공데이터 시트 서비스 조회필터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolFilt(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 조회필터를 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolFilt", params);
    }
    
    /**
     * 공공데이터 시트 서비스 테이블명을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfScolTbNm(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 테이블명을 조회한다.
        return (Record) select("PortalOpenInfScolDao.selectOpenInfScolTbNm", params);
    }
    
    /**
     * 공공데이터 시트 서비스 조회컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolCols(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 조회컬럼을 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolCols", params);
    }
    
    /**
     * 공공데이터 시트 서비스 조회조건을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolCond(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 조회조건을 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolCond", params);
    }
    
    /**
     * 공공데이터 시트 서비스 정렬조건을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolSort(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 정렬조건을 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolSort", params);
    }
    
    /**
     * 공공데이터 시트 서비스 다운컬럼을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchOpenInfScolDown(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 다운컬럼을 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolDown", params);
    }
    
    /**
     * 공공데이터 시트 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchOpenInfScolData(Params params, int page, int rows) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 데이터를 검색한다.
        return search("PortalOpenInfScolDao.searchOpenInfScolData", params, page, rows, PAGING_MANUAL);
    }
    
     /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public List<?> selectRecommandDataSet(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 메타정보를 조회한다.
        return search("PortalOpenInfScolDao.selectRecommandDataSet", params);
    }
    
     /**
     * 공공데이터 시트 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectInfNm(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfScolDao.selectInfNm", params);
    }
    
    /**
     * 공공데이터 태그 정보를 조회한다.
     * @param params
     * @return
     */
    public List<?> searchOpenInfScolColTag(Params params) throws DataAccessException, Exception {
    	return list("PortalOpenInfScolDao.searchOpenInfScolColTag", params);
    }
    
    /**
     * 공통코드 조회
     */
    public List<?> selectCommCodeGrpCd(Params params) throws DataAccessException, Exception {
    	return list("PortalOpenInfScolDao.selectCommCodeGrpCd", params);
    }
    
    /**
     * 유저 파일다운로드 데이터 조회
     */
    List<?>	searchUsrDefFileData(Params params) {
    	return list("PortalOpenInfScolDao.searchUsrDefFileData", params);
    }

	public Record searchUsrDefFileOneData(Params params) {
		return (Record) select("PortalOpenInfScolDao.searchUsrDefFileOneData", params);
	}

	public int updatUesrDefFileHits(Params params) {
		// 유저 파일 서비스 조회수를 수정
		return update("PortalOpenInfScolDao.updateUsrDefFileFileHits", params);
	}
	
	/**
     * 유저 파일 다운로드시 서비스 테이블명을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfScolDownTbNm(Params params) throws DataAccessException, Exception {
        // 공공데이터 시트 서비스 테이블명을 조회한다.
        return (Record) select("PortalOpenInfScolDao.selectOpenInfScolDownTbNm", params);
    }
    
}