/*
 * @(#)PortalBbsListApprServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.bbs.service.PortalBbsListApprService;

/**
 * 게시판 활용사례 평가점수를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalBbsListApprService")
public class PortalBbsListApprServiceImpl extends BaseService implements PortalBbsListApprService {
    /**
     * 게시판 활용사례 평가점수를 관리하는 DAO
     */
    @Resource(name="ggportalBbsListApprDao")
    private PortalBbsListApprDao portalBbsListApprDao;
    
    /**
     * 게시판 활용사례 평가점수를 등록한다.
     * 
     * @param params 파라메터
     * @return 등록결과
     */
    public Record insertBbsListApprCUD(Params params) {
        // 게시판 활용사례 평가점수를 등록한다.
        portalBbsListApprDao.insertBbsListAppr(params);
        
        // 게시판 활용사례 평가점수를 조회한다.
        return portalBbsListApprDao.selectBbsListAppr(params);
    }
}