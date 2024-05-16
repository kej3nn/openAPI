/*
 * @(#)PortalSiteMenuService.java 1.0 2015/06/15
 * 
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.ggportal.menu.service;

import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;

/**
 * 사이트 메뉴를 관리하는 서비스 인터페이스이다.
 * 
 * @author 김은삼
 * @version 1.0 2015/06/15
 */
public interface PortalSiteMenuService {
    /**
     * 사이트 메뉴를 조회한다.
     * 
     * @param params 파라메터
     * @return 조회결과
     */
    public Record selectSiteMenuCUD(Params params);
    
    /**
     * 사이트 메뉴를 검색한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> searchSiteMenu(Params params);
    
    /**
     * XML로 정의된 메뉴를 파싱한다.
     * 
     * @param params 파라메터
     * @return 검색결과
     */
    public List<?> parseSiteMenu(Params params);
}