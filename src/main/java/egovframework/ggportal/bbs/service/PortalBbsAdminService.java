/*
 * @(#)PortalBbsAdminService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 설정을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalBbsAdminService {
    /**
     * 일반 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_BOARD = "G001";
    
    /**
     * 공지 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_NOTICE = "G002";
    
    /**
     * Q&A 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_QNA = "G003";
    
    /**
     * FAQ 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_FAQ = "G004";
    
    /**
     * 갤러리 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_GALLERY = "G005";
    
    /**
     * 블로그 게시판 유형 코드
     */
    public static final String BBS_TYPE_CODE_BLOG = "G006";
    
    /**
     * 이벤트 게시판 코드
     */
    public static final String BBS_CODE_EVENT = "EVENT";
 
    /**
     * 아이디어제안 게시판 코드
     */
    public static final String BBS_CODE_IDEA = "IDEA";
    
    /**
     * 게시판 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsAdmin(Params params);
    
    /**
     * 로그인 후 글쓰기 여부를 조회한다.
     * 
     * @param bbsCd 코드
     * @return 조회결과
     */
    public String selectLoginWtYn(String bbsCd);
}