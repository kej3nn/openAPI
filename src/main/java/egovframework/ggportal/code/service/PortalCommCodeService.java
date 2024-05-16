/*
 * @(#)PortalCommCodeService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.code.service;

import java.util.List;

import egovframework.common.base.model.Params;

/**
 * 공통 코드를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalCommCodeService {
    /**
     * 공통 코드를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchCommCode(Params params);
}