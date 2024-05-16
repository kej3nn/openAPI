/*
 * @(#)PortalBbsListApprService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 게시판 활용사례 평가점수를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalBbsListApprService {
    /**
     * 게시판 활용사례 평가점수를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Record insertBbsListApprCUD(Params params);
}