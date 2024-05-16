/*
 * @(#)PortalBbsInfDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 게시판 공공데이터를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalBbsInfDao")
public class PortalBbsInfDao extends BaseDao {
    /**
     * 게시판 공공데이터를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsInf(Params params) {
        // 게시판 공공데이터를 검색한다.
        return search("PortalBbsInfDao.searchBbsInf", params);
    }
}