/*
 * @(#)PortalPopupCodeDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 팝업 코드를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalPopupCodeDao")
public class PortalPopupCodeDao extends BaseDao {
    /**
     * 팝업 코드를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectPopupCode(Params params) {
        // 팝업 코드를 조회한다.
        return (Record) select("PortalPopupCodeDao.selectPopupCode", params);
    }
    
    /**
     * 팝업 코드를 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchPopupCode(Params params, int page, int rows) {
        // 팝업 코드를 검색한다.
        return search("PortalPopupCodeDao.searchPopupCode", params, page, rows, PAGING_MANUAL);
    }
}