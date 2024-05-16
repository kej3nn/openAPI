/*
 * @(#)PortalLogBbsFileDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;

/**
 * 게시판 첨부파일 다운로드 이력을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalLogBbsFileDao")
public class PortalLogBbsFileDao extends BaseDao {
    /**
     * 게시판 첨부파일 다운로드 이력을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertLogBbsFile(Params params) {
        // 게시판 첨부파일 다운로드 이력을 등록한다.
        return insert("PortalLogBbsFileDao.insertLogBbsFile", params);
    }
}