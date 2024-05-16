/*
 * @(#)PortalBbsListDao.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.common.base.dao.BaseDao;
import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 내용을 관리하는 DAO 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Repository("ggportalBbsListDao")
public class PortalBbsListDao extends BaseDao {
    /**
     * 게시판 내용을 검색한다.
     * 
     * @param params 파라메터
     * @param page 페이지 번호
     * @param rows 페이지 크기
     * @return 검색결과
     */
    public Paging searchBbsList(Params params, int page, int rows) {
        // 게시판 내용을 검색한다.
        return search("PortalBbsListDao.searchBbsList", params, page, rows, PAGING_MANUAL, true);
    }
    
    /**
     * 사용자 비밀번호를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectUserPw(Params params) {
        // 사용자 비밀번호를 조회한다.
        return (Record) select("PortalBbsListDao.selectUserPw", params);
    }
    
    /**
     * 비밀글 여부를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSecretYn(Params params) {
        // 비밀글 여부를 조회한다.
        return (Record) select("PortalBbsListDao.selectSecretYn", params);
    }
    
    /**
     * 게시판 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsList(Params params) {
        // 게시판 내용을 조회한다.
        return (Record) select("PortalBbsListDao.selectBbsList", params);
    }
    
    /**
     * 게시판 댓글을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsListByPSeq(Params params) {
        // 게시판 댓글을 검색한다.
        return search("PortalBbsListDao.searchBbsListByPSeq", params);
    }
    
    /**
     * 게시판 내용을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Object insertBbsList(Params params) {
        // 게시판 내용을 등록한다.
        return insert("PortalBbsListDao.insertBbsList", params);
    }
    
    /**
     * 게시판 내용을 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsList(Params params) {
        // 게시판 내용을 수정한다.
        return update("PortalBbsListDao.updateBbsList", params);
    }
    
    /**
     * 게시판 내용 조회수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsListViewCnt(Params params) {
        // 게시판 내용 조회수를 수정한다.
        return update("PortalBbsListDao.updateBbsListViewCnt", params);
    }
    
    /**
     * 게시판 내용 첨부파일수를 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsListFileCnt(Params params) {
        // 게시판 내용 첨부파일수를 수정한다.
        return update("PortalBbsListDao.updateBbsListFileCnt", params);
    }
    
    /**
     * 게시판 내용을 삭제한다.
     * 
     * @param params 파라메터
     * @return 삭제결과
     */
    public int deleteBbsList(Params params) {
        // 게시판 내용을 삭제한다.
        return delete("PortalBbsListDao.deleteBbsList", params);
    }
    
    /**
     * 게시판 내용 링크 수를 수정한다.
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsListLinkCnt(Params params) {
        // 게시판 내용 첨부파일수를 수정한다.
        return update("PortalBbsListDao.updateBbsListLinkCnt", params);
    }

	
	/**
     * 게시판 내용 공공데이터 수를 수정한다.
     * @param params 파라메터
     * @return 수정결과
     */
    public int updateBbsListInfCnt(Params params) {
        // 게시판 내용 첨부파일수를 수정한다.
        return update("PortalBbsListDao.updateBbsListInfCnt", params);
    }
    
    // 공공게시판 데이터 테이블에 추가
    public Object insertBbsInf(Params params) {
    	return insert("PortalBbsListDao.insertBbsInf", params);
    	
    }
    /**
     * 공공 게시판 내용을 삭제한다.
     * 
     * @param params 파라메터
     * @return 삭제결과
     */
    public int deleteBbsInf(Params params) {
        // 게시판 내용을 삭제한다.
        return delete("PortalBbsListDao.deleteBbsInf", params);
    }

	public List<?> searchBbsDvp(Params params) {
		return search("PortalBbsListDao.searchBbsDvp", params);
	}
	
	/**
	 * 참여형 플랫폼 > 활용가이드 엑셀다운로드
	 * @param params
	 * @return
	 */
	public List<?> excelBbsList(Params params) {
        // 게시판 내용을 검색한다.
        return search("PortalBbsListDao.searchBbsList", params);
    }
	
}