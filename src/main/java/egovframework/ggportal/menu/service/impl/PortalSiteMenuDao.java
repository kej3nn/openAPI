/*
 * @(#)PortalSiteMenuDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.menu.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 사이트 메뉴를 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalSiteMenuDao")
public class PortalSiteMenuDao extends BaseDao {
    /**
     * 사이트 메뉴를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSiteMenu(Params params) {
        // 사이트 메뉴를 조회한다.
        return (Record) select("PortalSiteMenuDao.selectSiteMenu", params);
    }
    
    /**
     * 사이트 메뉴를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchSiteMenu(Params params) {
        // 사이트 메뉴를 검색한다.
        return search("PortalSiteMenuDao.searchSiteMenu", params);
    }
}