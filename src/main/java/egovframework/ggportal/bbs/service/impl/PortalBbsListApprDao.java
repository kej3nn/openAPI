/*
 * @(#)PortalBbsListApprDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 활용사례 평가점수를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalBbsListApprDao")
public class PortalBbsListApprDao extends BaseDao {
    /**
     * 게시판 활용사례 평가점수를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsListAppr(Params params) {
        // 게시판 활용사례 평가점수를 조회한다.
        return (Record) select("PortalBbsListApprDao.selectBbsListAppr", params);
    }
    
    /**
     * 게시판 활용사례 평가점수를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertBbsListAppr(Params params) {
        // 게시판 활용사례 평가점수를 등록한다.
        return insert("PortalBbsListApprDao.insertBbsListAppr", params);
    }
}