/*
 * @(#)PortalBbsAdminDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 설정을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalBbsAdminDao")
public class PortalBbsAdminDao extends BaseDao {
    /**
     * 게시판 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsAdmin(Params params) {
        // 게시판 설정을 조회한다.
        return (Record) select("PortalBbsAdminDao.selectBbsAdmin", params);
    }
    
    /**
     * 로그인 후 글쓰기 여부를 조회한다.
     * 
     * @param bbsCd 코드
     * @return 조회결과
     */
    public String selectLoginWtYn(String bbsCd) {
        // 로그인 후 글쓰기 여부를 조회한다.
        return (String) select("PortalBbsAdminDao.selectLoginWtYn", bbsCd);
    }
}