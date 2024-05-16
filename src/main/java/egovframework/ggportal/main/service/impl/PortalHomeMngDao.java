/*
 * @(#)PortalHomeMngDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.main.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 홈페이지 설정을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("gmportalHomeMngDao")
public class PortalHomeMngDao extends BaseDao {
    /**
     * 홈페이지 설정을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchHomeMng(Params params) {
        // 홈페이지 설정을 검색한다.
        return search("PortalHomeMngDao.searchHomeMng", params);
    }
    
    /**
     * 홈페이지 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Record selectHomeMng(Params params) {
        // 홈페이지 설정을 조회한다.
        return (Record) select("PortalHomeMngDao.selectHomeMng", params);
    }
}