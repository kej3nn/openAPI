/*
 * @(#)PortalBbsFileService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 첨부파일을 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalBbsFileService {
    /**
     * 게시판 첨부파일을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsFile(Params params);
    
    /**
     * 게시판 첨부파일을 다운로드한다.
     * 
     * @param params 파라메터
     * @return 다운로드결과
     */
    public Record downloadBbsFileCUD(Params params);
}