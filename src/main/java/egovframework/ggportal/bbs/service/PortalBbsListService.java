/*
 * @(#)PortalBbsListService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service;

import java.util.List;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

/**
 * 게시판 내용을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalBbsListService {
    /**
     * 게시판 내용을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchBbsList(Params params);
    
    /**
     * 사용자 비밀번호를 확인한다.
     * 
     * @param params 파라메터
     * @return 확인결과
     */
    public Result checkUserPw(Params params);
    
    /**
     * 비밀글 여부를 확인한다.
     * 
     * @param params 파라메터
     */
    public void checkSecretYn(Params params);
    
    /**
     * 사용자 코드를 확인한다.
     * 
     * @param params 파라메터
     */
    public void checkUserCd(Params params);
    
    /**
     * 게시판 내용을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsListCUD(Params params);
    
    /**
     * 게시판 댓글을 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchBbsListByPSeq(Params params);
    
    /**
     * 게시판 내용을 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Result insertBbsListCUD(Params params);
    
    /**
     * 게시판 내용을 수정한다.
     * 
     * @param params 파라메터
     * @return 수정결과
     */
    public Result updateBbsListCUD(Params params);
    
    /**
     * 게시판 내용을 삭제한다.
     * 
     * @param params 파라메터
     * @return 삭제결과
     */
    public Result deleteBbsListCUD(Params params);

	public List<?> searchBbsDvp(Params params);
	
	public List<?> excelBbsList(Params params);
}