/*
 * @(#)PortalOpenInfFileDao.java 1.0 2015/06/15
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
 * 공공데이터 파일 서비스를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalOpenInfFileDao")
public class PortalOpenInfFileDao extends BaseDao {
    /**
     * 공공데이터 파일 서비스 메타정보를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfFileMeta(Params params) {
        // 공공데이터 파일 서비스 메타정보를 조회한다.
        return (Record) select("PortalOpenInfFileDao.selectOpenInfFileMeta", params);
    }
    
    // /**
    //  * 공공데이터 파일 서비스 데이터를 검색한다.
    //  * 
    //  * @param params 파라메터
    //  * @param page 페이지 번호
    //  * @param rows 페이지 크기
    //  * @return 검색결과
    //  */
    // public Paging searchOpenInfFileData(Params params, int page, int rows) {
    //     // 공공데이터 파일 서비스 데이터를 검색한다.
    //     return search("PortalOpenInfFileDao.searchOpenInfFileData", params, page, rows, PAGING_MANUAL);
    // }
    /**
     * 공공데이터 파일 서비스 데이터를 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public List<?> searchOpenInfFileData(Params params) {
        // 공공데이터 파일 서비스 데이터를 검색한다.
        return search("PortalOpenInfFileDao.searchOpenInfFileData", params);
    }
    
    /**
     * 공공데이터 파일 서비스 데이터를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectOpenInfFileData(Params params) {
        // 공공데이터 파일 서비스 데이터를 조회한다.
        return (Record) select("PortalOpenInfFileDao.selectOpenInfFileData", params);
    }
    
    /**
     * 공공데이터 파일 서비스 조회이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertOpenInfFileHist(Params params) {
        // 공공데이터 파일 서비스 조회이력을 등록한다.
        return insert("PortalOpenInfFileDao.insertOpenInfFileHist", params);
    }
    
    /**
     * 공공데이터 파일 서비스 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateOpenInfFileHits(Params params) {
        // 공공데이터 파일 서비스 조회수를 수정한다.
        return update("PortalOpenInfFileDao.updateOpenInfFileHits", params);
    }
}