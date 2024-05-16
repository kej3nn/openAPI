/*
 * @(#)PortalCommCodeServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.service.CodeService;
import egovframework.ggportal.code.service.PortalCommCodeService;

/**
 * 공통 코드를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalCommCodeService")
public class PortalCommCodeServiceImpl extends CodeService implements PortalCommCodeService {
    /**
     * 공통 코드를 관리하는 DAO
     */
    @Resource(name="ggportalCommCodeDao")
    private PortalCommCodeDao portalCommCodeDao;
    
    /**
     * 공통 코드를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchCommCode(Params params) {
        // 공통 코드를 검색한다.
        List<?> data = portalCommCodeDao.searchCommCode(params);
        
        // 디폴트 코드를 추가한다.
        addDefaultCode(data, params);
        
        return data;
    }
}