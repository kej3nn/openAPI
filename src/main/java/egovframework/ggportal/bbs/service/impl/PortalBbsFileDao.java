/*
 * @(#)PortalBbsFileDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 첨부파일을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalBbsFileDao")
public class PortalBbsFileDao extends BaseDao {
    /**
     * 게시판 첨부파일을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsFile(Params params) {
        // 게시판 첨부파일을 검색한다.
        return search("PortalBbsFileDao.searchBbsFile", params);
    }
    
    /**
     * 게시판 첨부파일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsFile(Params params) {
        // 게시판 첨부파일을 조회한다.
        return (Record) select("PortalBbsFileDao.selectBbsFile", params);
    }
    
    /**
     * 게시판 첨부파일을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertBbsFile(Params params) {
        // 게시판 첨부파일을 등록한다.
        return insert("PortalBbsFileDao.insertBbsFile", params);
    }
    
    /**
     * 게시판 첨부파일 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsFileViewCnt(Params params) {
        // 게시판 첨부파일 조회수를 수정한다.
        return delete("PortalBbsFileDao.updateBbsFileViewCnt", params);
    }
    
    /**
     * 게시판 첨부파일을 삭제한다.
     * 
     * @param params 파라메터
     * @return 삭제결과
     */
    public int deleteBbsFile(Params params) {
        // 게시판 첨부파일을 삭제한다.
        return delete("PortalBbsFileDao.deleteBbsFile", params);
    }
}