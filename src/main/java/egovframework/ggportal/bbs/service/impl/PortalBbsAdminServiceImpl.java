/*
 * @(#)PortalBbsAdminServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.bbs.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.SystemException;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.BaseService;
import egovframework.ggportal.bbs.service.PortalBbsAdminService;
import egovframework.ggportal.code.service.impl.PortalCommCodeDao;

/**
 * 게시판 설정을 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalBbsAdminService")
public class PortalBbsAdminServiceImpl extends BaseService implements PortalBbsAdminService {
    /**
     * 공통 코드를 관리하는 DAO
     */
    @Resource(name="ggportalCommCodeDao")
    private PortalCommCodeDao portalCommCodeDao;
    
    /**
     * 게시판 설정을 관리하는 DAO
     */
    @Resource(name="ggportalBbsAdminDao")
    private PortalBbsAdminDao portalBbsAdminDao;
    
    /**
     * 게시글 분류 옵션을 반환한다.
     * 
     * @param config 설정
     * @return 옵션
     */
    private List<?> getSectionOptions(String config) {
        Params params = new Params();
        
       	params.put("grpCd", config);
        
        // 공통 코드를 검색한다.
        return portalCommCodeDao.searchCommCode(params);
    }
    
    /**
     * 게시판 설정을 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectBbsAdmin(Params params) {
    	
        // 게시판 설정을 조회한다.
        Record config = portalBbsAdminDao.selectBbsAdmin(params);
        try{    
	        // 게시판 설정이 없는 경우
	        if (config == null) {
	            throw new SystemException("portal.error.000014", getMessage("portal.error.000014", new String[] {
	                params.getString("bbsCd").toUpperCase()
	            }));
	        }
	        
	        // 게시글 분류가 있는 경우
	        if (!"".equals(config.getString("listCd"))) {
	            // 게시글 분류 옵션을 가져온다.
	            config.put("sections", getSectionOptions(config.getString("listCd")));
	        }
	        // 게시글 분류1가 있는 경우
	        if (!"".equals(config.getString("list1Cd"))) {
	        	// 게시글 분류 옵션을 가져온다.
	        	config.put("sections1", getSectionOptions(config.getString("list1Cd")));
	        }
	        
	        
    	} catch (DataAccessException dae) {
    		EgovWebUtil.exLogging(dae);
    	} catch (Exception e) {
    		EgovWebUtil.exLogging(e);
		}
    	
        return config;
    }
    
    /**
     * 로그인 후 글쓰기 여부를 조회한다.
     * 
     * @param bbsCd 코드
     * @return 조회결과
     */
    public String selectLoginWtYn(String bbsCd) {
        // 로그인 후 글쓰기 여부를 조회한다.
        return portalBbsAdminDao.selectLoginWtYn(bbsCd);
    }
}