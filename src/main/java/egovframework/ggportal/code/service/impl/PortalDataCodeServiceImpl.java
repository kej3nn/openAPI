/*
 * @(#)PortalDataCodeServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Params;
import egovframework.common.base.service.CodeService;
import egovframework.ggportal.code.service.PortalDataCodeService;

/**
 * 데이터 코드를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalDataCodeService")
public class PortalDataCodeServiceImpl extends CodeService implements PortalDataCodeService {
    /**
     * 데이터 코드를 관리하는 DAO
     */
    @Resource(name="ggportalDataCodeDao")
    private PortalDataCodeDao portalDataCodeDao;
    
    /**
     * 데이터 코드를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchDataCode(Params params) {
        // 데이터 코드를 검색한다.
        List<?> data = portalDataCodeDao.searchDataCode(params);
        
        // 디폴트 코드를 추가한다.
        addDefaultCode(data, params);
        
        return data;
    }
    
    /**
     * 데이터 코드를TB_DATA_CODE 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchDataCodeTB(Params params) {
        // 데이터 코드를 검색한다.
        List<?> data = portalDataCodeDao.searchDataCodeTB(params);
        
        // 디폴트 코드를 추가한다.
        addDefaultCode(data, params);
        
        return data;
    }
}