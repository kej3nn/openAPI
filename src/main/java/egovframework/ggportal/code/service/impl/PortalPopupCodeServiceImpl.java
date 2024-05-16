/*
 * @(#)PortalPopupCodeServiceImpl.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.base.model.Paging;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.service.CodeService;
import egovframework.common.util.UtilString;
import egovframework.ggportal.code.service.PortalPopupCodeService;

/**
 * 팝업 코드를 관리하는 서비스 클래스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
@Service("ggportalPopupCodeService")
public class PortalPopupCodeServiceImpl extends CodeService implements PortalPopupCodeService {
    /**
     * 팝업 코드를 관리하는 DAO
     */
    @Resource(name="ggportalPopupCodeDao")
    private PortalPopupCodeDao portalPopupCodeDao;
    
    /**
     * 팝업 코드를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public Paging searchPopupCode(Params params) {
        // 팝업 코드를 조회한다.
        Record data = portalPopupCodeDao.selectPopupCode(params);
        // sql 삽입 보안취약점
        params.put("tblId",     UtilString.SQLInjectionFilter2(data.getString("tblId")));
        params.put("colId",     UtilString.SQLInjectionFilter2(data.getString("colId")));
        params.put("colNm",     UtilString.SQLInjectionFilter2(data.getString("colNm")));
        params.put("condWhere", UtilString.SQLInjectionFilter2(data.getString("condWhere")));
        
        // 팝업 코드를 검색한다.
        return portalPopupCodeDao.searchPopupCode(params, params.getPage(), params.getRows());
    }
}